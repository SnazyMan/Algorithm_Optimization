$title AES

sets
       a   agents       / A1*A4 /
       j   job         / J1*J12 / ;

parameter
       assign(j)  assignment constraints
         / J1*J12  1 / ;

table  d(j,a)  execution delay matrix
                  A1          A2       A3        A4
    J1            8           16       16        32
    J2            8           16       16        32
    J3            8           16       16        32
    J4            8           16       16        32    
    J5            12          24       24        48
    J6            12          24       24        48
    J7            12          24       24        48
    J8            8           16       16        32
    J9            8           16       16        32
    J10           8           16       16        32
    J11           8           16       16        32            
    J12           1           2        2         4;

table c(j,a,a)   communication delay matrix in format (from)agenta.(to)agentb job j
                  A1          A2        A3        A4
    J1.A1         0           4         4         4 
    J1.A2         4           0         400       4 
    J1.A3         4           400       0         4 
    J1.A4         4           4         4         0
    J2.A1         0           4         4         4 
    J2.A2         4           0         400       4 
    J2.A3         4           400       0         4 
    J2.A4         4           4         4         0 
    J3.A1         0           4         4         4 
    J3.A2         4           0         400       4 
    J3.A3         4           400       0         4 
    J3.A4         4           4         4         0 
    J4.A1         0           4         4         4 
    J4.A2         4           0         400       4 
    J4.A3         4           400       0         4 
    J4.A4         4           4         4         0 
    J5.A1         0           4         4         4 
    J5.A2         4           0         400       4 
    J5.A3         4           400       0         4 
    J5.A4         4           4         4         0
    J6.A1         0           4         4         4 
    J6.A2         4           0         400       4 
    J6.A3         4           400       0         4 
    J6.A4         4           4         4         0
    J7.A1         0           4         4         4 
    J7.A2         4           0         400       4 
    J7.A3         4           400       0         4 
    J7.A4         4           4         4         0
    J8.A1         0           4         4         4 
    J8.A2         4           0         400       4 
    J8.A3         4           400       0         4 
    J8.A4         4           4         4         0
    J9.A1         0           4         4         4 
    J9.A2         4           0         400       4 
    J9.A3         4           400       0         4 
    J9.A4         4           4         4         0
    J10.A1        0           4         4         4 
    J10.A2        4           0         400       4 
    J10.A3        4           400       0         4 
    J10.A4        4           4         4         0
    J11.A1        0           4         4         4 
    J11.A2        4           0         400       4 
    J11.A3        4           400       0         4 
    J11.A4        4           4         4         0
    J12.A1        0           1         1         1 
    J12.A2        1           0         100       1 
    J12.A3        1           100       0         1 
    J12.A4        1           1         1         0;


table p(j,j) immediate job precedence graph
           J1     J2     J3     J4     J5    J6   J7    J8   J9    J10    J11    J12
    J1     0      0      0      0      1     1    1     0    0     0      0      0
    J2     0      0      0      0      1     1    1     0    0     0      0      0
    J3     0      0      0      0      1     1    1     0    0     0      0      0
    J4     0      0      0      0      1     1    1     0    0     0      0      0
    J5     0      0      0      0      0     0    0     1    1     1      1      0
    J6     0      0      0      0      0     0    0     1    1     1      1      0
    J7     0      0      0      0      0     0    0     1    1     1      1      0
    J8     0      0      0      0      0     0    0     0    0     0      0      1
    J9     0      0      0      0      0     0    0     0    0     0      0      1
    J10    0      0      0      0      0     0    0     0    0     0      0      1
    J11    0      0      0      0      0     0    0     0    0     0      0      1
    J12    0      0      0      0      0     0    0     0    0     0      0      0;


table q(j,j) full job precedence graph
           J1     J2     J3     J4     J5    J6   J7    J8   J9    J10    J11    J12
    J1     0      0      0      0      1     1    1     1    1     1      1      1
    J2     0      0      0      0      1     1    1     1    1     1      1      1
    J3     0      0      0      0      1     1    1     1    1     1      1      1
    J4     0      0      0      0      1     1    1     1    1     1      1      1
    J5     0      0      0      0      0     0    0     1    1     1      1      1
    J6     0      0      0      0      0     0    0     1    1     1      1      1
    J7     0      0      0      0      0     0    0     1    1     1      1      1
    J8     0      0      0      0      0     0    0     0    0     0      0      1
    J9     0      0      0      0      0     0    0     0    0     0      0      1
    J10    0      0      0      0      0     0    0     0    0     0      0      1
    J11    0      0      0      0      0     0    0     0    0     0      0      1
    J12    0      0      0      0      0     0    0     0    0     0      0      0;    


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

start2(j,j,a,a) ..      p(j,j)*S(j) =g= p(j,j)*(s(j) + (d(j,a) + c(j,a,a))*(x(j,a) + x(j,a) -1));
** start 2 constraint is only valid if p>0, when p = 0, constraint is triviallly 0>=0, degeneracy issue?

exec_overlap(j,j,a) ..  x(j,a) + x(j,a) + theta(j,j) + theta(j,j) =l= 3;

single_job(j,j) ..    -1*(q(j,j) -1)*s(j) - sum(a, d(j,a)*x(j,a)) - s(j) =g= -1*(q(j,j) -1)*(-M)*theta(j,j);
single_job2(j,j) ..   -1*(q(j,j) -1)*s(j) - sum(a, d(j,a)*x(j,a)) - s(j) =l= -1*(q(j,j) -1)*M*(1-theta(j,j));
** The -1*(q(j,k -1) term is needed because the single job constraint should occur only when q(j,k) = 0. since q(j,k) is binary -1*(q(j,k) -1) is equivalent to multiplying by 1 if q(j,k) is 0 and 0 if q(j,k) is 1. There may be a better to do this **



model aes /all/ ;
solve aes using MIP minimizing Z;

