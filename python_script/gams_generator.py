import pandas as pd
import numpy as np
num_job = 12
num_agent = 4
d = pd.read_csv('./d.csv', header = None).values[1:,1:].astype(np.int)
#print(d)
c = pd.read_csv('./c.csv', header = None).values[1:,1:].astype(np.int)
c = np.reshape(c,(num_job,num_agent,num_agent))
#print(c[0,:,:])
#print(c[1,:,:])
#print(c[2,:,:])
p = pd.read_csv('./p.csv', header = None).values[1:,1:].astype(np.int)
#print(p)
q = pd.read_csv('./q.csv', header = None).values[1:,1:].astype(np.int)
#print(q)


# to generate the conditional constraints
gams_script = open('aes.txt', 'w')
equations_declare = []
lines = []

equations_declare.append("equations\n")
equations_declare.append('     time                   "time to complete algorithm"\n')
equations_declare.append('     supply(j)              "each job is assigned to exactly one agent"\n')
equations_declare.append('     time_constraint(j,a)   "lower bound on time"\n')



lines.append('* start(j,j)             "job cannot start unless its predecessors are completed"\n')
for i in range(1,num_job+1):
	for j in range(1,num_job+1):
		if(p[i-1,j-1]==1 and i!=j):
			# start(j,j) $(p(j,j) and (not sameAs(j,j))) ..           s(j) =g= s(j);
			equations_declare.append('     start_%d_%d\n'%(i,j))
			constraint = "start_%d_%d..  s('J%d') =g= s('J%d');\n"%(i,j,j,i)
			lines.append(constraint)



lines.append('* start2(j,j)              "need to rename this lol ** P matrix (job order) applies here **"\n')
for i in range(1,num_job+1):
	for j in range(1,num_job+1):
		for a in range(1,num_agent+1):
			if(p[i-1,j-1]==1 and i!=j):
				# start2(j,j,a,a) $(p(j,j)>0 and (not sameAs(j,j))) ..      s(j) =g= (s(j) + (d(j,a) + c(j,a,a))*(x(j,a) + x(j,a) -1));
				equations_declare.append('     start2_%d_%d_%d\n'%(i,j,a))
				constraint = "start2_%d_%d_%d..  s('J%d') =g= (s('J%d') + (d('J%d','A%d') + c('J%d','A%d','A%d'))*(x('J%d','A%d') + x('J%d','A%d') -1));\n"%(i,j,a,j,i,i,a,i,a,a,i,a,i,a)
				lines.append(constraint)



lines.append('* exec_overlap(j,j,a)    "if two jobs are assigned to the same agent, execution times shouldnt overlap"\n')
for i in range(1,num_job+1):
	for j in range(1,num_job+1):
		for a in range(1,num_agent+1):
			# exec_overlap(j,j,a) ..  x(j,a) + x(j,a) + theta(j,j) + theta(j,j) =l= 3;
			equations_declare.append('     exec_overlap_%d_%d_%d\n'%(i,j,a))
			constraint = "exec_overlap_%d_%d_%d ..  x('J%d','A%d') + x('J%d','A%d') + theta('J%d','J%d') + theta('J%d','J%d') =l= 3;\n"%(i,j,a,i,a,j,a,i,j,j,i)
			lines.append(constraint)

lines.append('* single_job(j,j)        "an agent may process at most 1 job at a time"\n')
for i in range(1,num_job+1):
	for j in range(1,num_job+1):
		if(q[i-1,j-1]==0 and i!=j):
			# single_job(j,j) $(not q(j,j) and (not sameAs(j,j))) ..    s(j) - sum(a, d(j,a)*x(j,a)) - s(j) =g= (-M)*theta(j,j);
			equations_declare.append('     single_job_%d_%d\n'%(i,j))
			constraint = "single_job_%d_%d..  s('J%d') - sum(a, d('J%d',a)*x('J%d',a)) - s('J%d') =g= (-M)*theta('J%d','J%d');\n"%(i,j,j,i,i,i,i,j)
			lines.append(constraint)

lines.append('* single_job2(j,j)       "this also needs renamed"\n')
for i in range(1,num_job+1):
	for j in range(1,num_job+1):
		if(q[i-1,j-1]==0 and i!=j):
			# single_job2(j,j) $(not q(j,j) and (not sameAs(j,j))) ..   s(j) - sum(a, d(j,a)*x(j,a)) - s(j) =l= M*(1-theta(j,j));
			equations_declare.append('     single_job2_%d_%d\n'%(i,j))
			constraint = "single_job2_%d_%d..  s('J%d') - sum(a, d('J%d',a)*x('J%d',a)) - s('J%d') =l= M*(1-theta('J%d','J%d'));\n"%(i,j,j,i,i,i,i,j)
			lines.append(constraint)


equations_declare.append(';\n')
equations_declare.append('time ..                 Z =e= t;\n')
equations_declare.append('time_constraint(j,a) .. t =g= s(j) + d(j,a)*x(j,a);\n')
equations_declare.append('supply(j) ..            sum(a, x(j,a))  =e=  assign(j);\n')
lines = equations_declare+lines
#gams_script.writelines(equations_declare)
gams_script.writelines(lines)
gams_script.close()

