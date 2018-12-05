$title AES

sets
       a   agents       / A1, A2, A3, A4 /
       j   job         / J1, J2, J3, J4 / ;

parameter
       assign(j)  assignment constraints
         /    J1       1
              J2       1
	      J3       1
	      J4       1 / ;

table  d(j,a)  execution delay matrix
                  A1          A2       A3        A4
    J1            50          46       47        40
    J2            51          48       44        1000
    J3            3.2e-8      3.2e-8   3.2e-8    3.2e-8  
    J4            1.6e-8      1.6e-8   1.6e-8    1.6e-8;

table c(a,a,j)   communication delay matrix in format (from)agenta.(to)agentb job j
                  J1          J2        J3        J4
    A1.A1         1           1         1         1 
    A1.A2         1           1         1         1 
    A1.A3         1           1         1         1 
    A1.A4         1           1         1         1 
    A2.A1         1           1         1         1 
    A2.A2         1           1         1         1 
    A2.A3         1           1         1         1 
    A2.A4         1           1         1         1 
    A3.A1         1           1         1         1 
    A3.A2         1           1         1         1 
    A3.A3         1           1         1         1 
    A3.A4         1           1         1         1          
    A4.A1         1           1         1         1 
    A4.A2         1           1         1         1 
    A4.A3         1           1         1         1 
    A4.A4         1           1         1         1;


table p(j,j) immediate job precedence graph
              J1           J2        J3      J4
    J1        0            1         0       0
    J2        0            0         1       0
    J3        0            0         0       1
    J4        0            0         0       0;


table q(j,j) full job precedence graph 
              J1           J2        J3      J4
    J1        0            1         1       1
    J2        0            0         1       1
    J3        0            0         0       1
    J4        0            0         0       0;

    
binary variable x(j,a)       "allocation of jobs to agents" ;
positive variable s(j)       "schedules start time of job j" ;
binary variable theta(j,j)   "support variable used to determine whether jobs j and k overlap" ;
scalar M "upperbound on completion time, set very large by default" / 10000 / ;
positive variable t          "time to completion";
variable Z                   "objective function variable";


equations
     time                   "time to complete algorithm"
     supply(j)              "each job is assigned to exactly one agent"
     time_constraint(j,a)   "lower bound on time"
     start(j,j)             "job cannot start unless its predecessors are completed"
     start2(j,j,a,a)        "need to rename this lol ** P matrix (job order) applies here **"
     exec_overlap(j,j,a)    "if two jobs are assigned to the same agent, execution times shouldnt overlap"
     single_job(j,j)        "an agent may process at most 1 job at a time"
     single_job2(j,j)       "this also needs renamed"
;

time ..                 Z =e= t;

time_constraint(j,a) .. t =g= s(j) + d(j,a)*x(j,a);

supply(j) ..            sum(a, x(j,a))  =e=  assign(j);

start(j,j) ..           p(j,j)*s(j) =g= p(j,j)*s(j);

start2(j,j,a,a) ..      p(j,j)*S(j) =g= p(j,j)*(s(j) + (d(j,a) + c(a,a,j))*(x(j,a) + x(j,a) -1));
** start 2 constraint is only valid if p>0, when p = 0, constraint is triviallly 0>=0, degeneracy issue?

exec_overlap(j,j,a) ..  x(j,a) + x(j,a) + theta(j,j) + theta(j,j) =l= 3;

single_job(j,j) ..    -1*(q(j,j) -1)*s(j) - sum(a, d(j,a)*x(j,a)) - s(j) =g= -1*(q(j,j) -1)*(-M)*theta(j,j);
single_job2(j,j) ..   -1*(q(j,j) -1)*s(j) - sum(a, d(j,a)*x(j,a)) - s(j) =l= -1*(q(j,j) -1)*M*(1-theta(j,j));
** The -1*(q(j,k -1) term is needed because the single job constraint should occur only when q(j,k) = 0. since q(j,k) is binary -1*(q(j,k) -1) is equivalent to multiplying by 1 if q(j,k) is 0 and 0 if q(j,k) is 1. There may be a better to do this **



model aes /all/ ;
solve aes using MIP minimizing Z;

