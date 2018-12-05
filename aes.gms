$title AES

sets
       a   agents       / A1, A2, A3, A4 /
       j   job         / J1, J2, J3, J4 / ;

parameter
       assign(i)  assignment constraints
         /    A1       1
              A2       1
	      A3       1
	      A4       1 / ;

table  d(i,j)  execution delay matrix
                  A1          A2       A3        A4
    J1            50          46       47        40
    J2            51          48       44        1000
    J3            3.2e-8      3.2e-8   3.2e-8    3.2.6e-8  
    J4            1.6e-8      1.6e-8   1.6e-8    1.6e-8;

table c(j,a,a)   communication delay matrix in format (from)agentn.(to)agentn job j
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

    
binary variable x(j,a);       allocation of jobs to agents 
positive variable s(j);       schedules start time of job j
positive variable t(j,a);     time to completion: objective function


equations
     time                 time to complete algorothm
     supply(i)            each job is assigned to exactly one agent
     time_constraint(j,a)
     start(j,k)           job cannot start unless its predecessors are completed
     start2(j,k,a,b)      need to rename this lol ** P matrix (job order) applies here **
;

time ..                   Z =e= t;
time_constraint(j,a) ..   t =g= s(j) + d(j,a)*x(j,a);
supply(i) ..              sum(a, x(j,a))  =l=  assign(i);
start(j,k) ..             s(k) =g= s(j);
start2(j,k,a,b) ,,        S(k) =g= s(j) + (d(j,a) + c(j,a,b))*(x(j,a) + x(k,b) -1);

model aes /all/ ;
solve aes using MIP minimizing Z;

