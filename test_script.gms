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
     start_1_5
     start_1_6
     start_1_7
     start_2_5
     start_2_6
     start_2_7
     start_3_5
     start_3_6
     start_3_7
     start_4_5
     start_4_6
     start_4_7
     start_5_8
     start_5_9
     start_5_10
     start_5_11
     start_6_8
     start_6_9
     start_6_10
     start_6_11
     start_7_8
     start_7_9
     start_7_10
     start_7_11
     start_8_12
     start_9_12
     start_10_12
     start_11_12
     start2_1_5_1
     start2_1_5_2
     start2_1_5_3
     start2_1_5_4
     start2_1_6_1
     start2_1_6_2
     start2_1_6_3
     start2_1_6_4
     start2_1_7_1
     start2_1_7_2
     start2_1_7_3
     start2_1_7_4
     start2_2_5_1
     start2_2_5_2
     start2_2_5_3
     start2_2_5_4
     start2_2_6_1
     start2_2_6_2
     start2_2_6_3
     start2_2_6_4
     start2_2_7_1
     start2_2_7_2
     start2_2_7_3
     start2_2_7_4
     start2_3_5_1
     start2_3_5_2
     start2_3_5_3
     start2_3_5_4
     start2_3_6_1
     start2_3_6_2
     start2_3_6_3
     start2_3_6_4
     start2_3_7_1
     start2_3_7_2
     start2_3_7_3
     start2_3_7_4
     start2_4_5_1
     start2_4_5_2
     start2_4_5_3
     start2_4_5_4
     start2_4_6_1
     start2_4_6_2
     start2_4_6_3
     start2_4_6_4
     start2_4_7_1
     start2_4_7_2
     start2_4_7_3
     start2_4_7_4
     start2_5_8_1
     start2_5_8_2
     start2_5_8_3
     start2_5_8_4
     start2_5_9_1
     start2_5_9_2
     start2_5_9_3
     start2_5_9_4
     start2_5_10_1
     start2_5_10_2
     start2_5_10_3
     start2_5_10_4
     start2_5_11_1
     start2_5_11_2
     start2_5_11_3
     start2_5_11_4
     start2_6_8_1
     start2_6_8_2
     start2_6_8_3
     start2_6_8_4
     start2_6_9_1
     start2_6_9_2
     start2_6_9_3
     start2_6_9_4
     start2_6_10_1
     start2_6_10_2
     start2_6_10_3
     start2_6_10_4
     start2_6_11_1
     start2_6_11_2
     start2_6_11_3
     start2_6_11_4
     start2_7_8_1
     start2_7_8_2
     start2_7_8_3
     start2_7_8_4
     start2_7_9_1
     start2_7_9_2
     start2_7_9_3
     start2_7_9_4
     start2_7_10_1
     start2_7_10_2
     start2_7_10_3
     start2_7_10_4
     start2_7_11_1
     start2_7_11_2
     start2_7_11_3
     start2_7_11_4
     start2_8_12_1
     start2_8_12_2
     start2_8_12_3
     start2_8_12_4
     start2_9_12_1
     start2_9_12_2
     start2_9_12_3
     start2_9_12_4
     start2_10_12_1
     start2_10_12_2
     start2_10_12_3
     start2_10_12_4
     start2_11_12_1
     start2_11_12_2
     start2_11_12_3
     start2_11_12_4
     exec_overlap_1_1_1
     exec_overlap_1_1_2
     exec_overlap_1_1_3
     exec_overlap_1_1_4
     exec_overlap_1_2_1
     exec_overlap_1_2_2
     exec_overlap_1_2_3
     exec_overlap_1_2_4
     exec_overlap_1_3_1
     exec_overlap_1_3_2
     exec_overlap_1_3_3
     exec_overlap_1_3_4
     exec_overlap_1_4_1
     exec_overlap_1_4_2
     exec_overlap_1_4_3
     exec_overlap_1_4_4
     exec_overlap_1_5_1
     exec_overlap_1_5_2
     exec_overlap_1_5_3
     exec_overlap_1_5_4
     exec_overlap_1_6_1
     exec_overlap_1_6_2
     exec_overlap_1_6_3
     exec_overlap_1_6_4
     exec_overlap_1_7_1
     exec_overlap_1_7_2
     exec_overlap_1_7_3
     exec_overlap_1_7_4
     exec_overlap_1_8_1
     exec_overlap_1_8_2
     exec_overlap_1_8_3
     exec_overlap_1_8_4
     exec_overlap_1_9_1
     exec_overlap_1_9_2
     exec_overlap_1_9_3
     exec_overlap_1_9_4
     exec_overlap_1_10_1
     exec_overlap_1_10_2
     exec_overlap_1_10_3
     exec_overlap_1_10_4
     exec_overlap_1_11_1
     exec_overlap_1_11_2
     exec_overlap_1_11_3
     exec_overlap_1_11_4
     exec_overlap_1_12_1
     exec_overlap_1_12_2
     exec_overlap_1_12_3
     exec_overlap_1_12_4
     exec_overlap_2_1_1
     exec_overlap_2_1_2
     exec_overlap_2_1_3
     exec_overlap_2_1_4
     exec_overlap_2_2_1
     exec_overlap_2_2_2
     exec_overlap_2_2_3
     exec_overlap_2_2_4
     exec_overlap_2_3_1
     exec_overlap_2_3_2
     exec_overlap_2_3_3
     exec_overlap_2_3_4
     exec_overlap_2_4_1
     exec_overlap_2_4_2
     exec_overlap_2_4_3
     exec_overlap_2_4_4
     exec_overlap_2_5_1
     exec_overlap_2_5_2
     exec_overlap_2_5_3
     exec_overlap_2_5_4
     exec_overlap_2_6_1
     exec_overlap_2_6_2
     exec_overlap_2_6_3
     exec_overlap_2_6_4
     exec_overlap_2_7_1
     exec_overlap_2_7_2
     exec_overlap_2_7_3
     exec_overlap_2_7_4
     exec_overlap_2_8_1
     exec_overlap_2_8_2
     exec_overlap_2_8_3
     exec_overlap_2_8_4
     exec_overlap_2_9_1
     exec_overlap_2_9_2
     exec_overlap_2_9_3
     exec_overlap_2_9_4
     exec_overlap_2_10_1
     exec_overlap_2_10_2
     exec_overlap_2_10_3
     exec_overlap_2_10_4
     exec_overlap_2_11_1
     exec_overlap_2_11_2
     exec_overlap_2_11_3
     exec_overlap_2_11_4
     exec_overlap_2_12_1
     exec_overlap_2_12_2
     exec_overlap_2_12_3
     exec_overlap_2_12_4
     exec_overlap_3_1_1
     exec_overlap_3_1_2
     exec_overlap_3_1_3
     exec_overlap_3_1_4
     exec_overlap_3_2_1
     exec_overlap_3_2_2
     exec_overlap_3_2_3
     exec_overlap_3_2_4
     exec_overlap_3_3_1
     exec_overlap_3_3_2
     exec_overlap_3_3_3
     exec_overlap_3_3_4
     exec_overlap_3_4_1
     exec_overlap_3_4_2
     exec_overlap_3_4_3
     exec_overlap_3_4_4
     exec_overlap_3_5_1
     exec_overlap_3_5_2
     exec_overlap_3_5_3
     exec_overlap_3_5_4
     exec_overlap_3_6_1
     exec_overlap_3_6_2
     exec_overlap_3_6_3
     exec_overlap_3_6_4
     exec_overlap_3_7_1
     exec_overlap_3_7_2
     exec_overlap_3_7_3
     exec_overlap_3_7_4
     exec_overlap_3_8_1
     exec_overlap_3_8_2
     exec_overlap_3_8_3
     exec_overlap_3_8_4
     exec_overlap_3_9_1
     exec_overlap_3_9_2
     exec_overlap_3_9_3
     exec_overlap_3_9_4
     exec_overlap_3_10_1
     exec_overlap_3_10_2
     exec_overlap_3_10_3
     exec_overlap_3_10_4
     exec_overlap_3_11_1
     exec_overlap_3_11_2
     exec_overlap_3_11_3
     exec_overlap_3_11_4
     exec_overlap_3_12_1
     exec_overlap_3_12_2
     exec_overlap_3_12_3
     exec_overlap_3_12_4
     exec_overlap_4_1_1
     exec_overlap_4_1_2
     exec_overlap_4_1_3
     exec_overlap_4_1_4
     exec_overlap_4_2_1
     exec_overlap_4_2_2
     exec_overlap_4_2_3
     exec_overlap_4_2_4
     exec_overlap_4_3_1
     exec_overlap_4_3_2
     exec_overlap_4_3_3
     exec_overlap_4_3_4
     exec_overlap_4_4_1
     exec_overlap_4_4_2
     exec_overlap_4_4_3
     exec_overlap_4_4_4
     exec_overlap_4_5_1
     exec_overlap_4_5_2
     exec_overlap_4_5_3
     exec_overlap_4_5_4
     exec_overlap_4_6_1
     exec_overlap_4_6_2
     exec_overlap_4_6_3
     exec_overlap_4_6_4
     exec_overlap_4_7_1
     exec_overlap_4_7_2
     exec_overlap_4_7_3
     exec_overlap_4_7_4
     exec_overlap_4_8_1
     exec_overlap_4_8_2
     exec_overlap_4_8_3
     exec_overlap_4_8_4
     exec_overlap_4_9_1
     exec_overlap_4_9_2
     exec_overlap_4_9_3
     exec_overlap_4_9_4
     exec_overlap_4_10_1
     exec_overlap_4_10_2
     exec_overlap_4_10_3
     exec_overlap_4_10_4
     exec_overlap_4_11_1
     exec_overlap_4_11_2
     exec_overlap_4_11_3
     exec_overlap_4_11_4
     exec_overlap_4_12_1
     exec_overlap_4_12_2
     exec_overlap_4_12_3
     exec_overlap_4_12_4
     exec_overlap_5_1_1
     exec_overlap_5_1_2
     exec_overlap_5_1_3
     exec_overlap_5_1_4
     exec_overlap_5_2_1
     exec_overlap_5_2_2
     exec_overlap_5_2_3
     exec_overlap_5_2_4
     exec_overlap_5_3_1
     exec_overlap_5_3_2
     exec_overlap_5_3_3
     exec_overlap_5_3_4
     exec_overlap_5_4_1
     exec_overlap_5_4_2
     exec_overlap_5_4_3
     exec_overlap_5_4_4
     exec_overlap_5_5_1
     exec_overlap_5_5_2
     exec_overlap_5_5_3
     exec_overlap_5_5_4
     exec_overlap_5_6_1
     exec_overlap_5_6_2
     exec_overlap_5_6_3
     exec_overlap_5_6_4
     exec_overlap_5_7_1
     exec_overlap_5_7_2
     exec_overlap_5_7_3
     exec_overlap_5_7_4
     exec_overlap_5_8_1
     exec_overlap_5_8_2
     exec_overlap_5_8_3
     exec_overlap_5_8_4
     exec_overlap_5_9_1
     exec_overlap_5_9_2
     exec_overlap_5_9_3
     exec_overlap_5_9_4
     exec_overlap_5_10_1
     exec_overlap_5_10_2
     exec_overlap_5_10_3
     exec_overlap_5_10_4
     exec_overlap_5_11_1
     exec_overlap_5_11_2
     exec_overlap_5_11_3
     exec_overlap_5_11_4
     exec_overlap_5_12_1
     exec_overlap_5_12_2
     exec_overlap_5_12_3
     exec_overlap_5_12_4
     exec_overlap_6_1_1
     exec_overlap_6_1_2
     exec_overlap_6_1_3
     exec_overlap_6_1_4
     exec_overlap_6_2_1
     exec_overlap_6_2_2
     exec_overlap_6_2_3
     exec_overlap_6_2_4
     exec_overlap_6_3_1
     exec_overlap_6_3_2
     exec_overlap_6_3_3
     exec_overlap_6_3_4
     exec_overlap_6_4_1
     exec_overlap_6_4_2
     exec_overlap_6_4_3
     exec_overlap_6_4_4
     exec_overlap_6_5_1
     exec_overlap_6_5_2
     exec_overlap_6_5_3
     exec_overlap_6_5_4
     exec_overlap_6_6_1
     exec_overlap_6_6_2
     exec_overlap_6_6_3
     exec_overlap_6_6_4
     exec_overlap_6_7_1
     exec_overlap_6_7_2
     exec_overlap_6_7_3
     exec_overlap_6_7_4
     exec_overlap_6_8_1
     exec_overlap_6_8_2
     exec_overlap_6_8_3
     exec_overlap_6_8_4
     exec_overlap_6_9_1
     exec_overlap_6_9_2
     exec_overlap_6_9_3
     exec_overlap_6_9_4
     exec_overlap_6_10_1
     exec_overlap_6_10_2
     exec_overlap_6_10_3
     exec_overlap_6_10_4
     exec_overlap_6_11_1
     exec_overlap_6_11_2
     exec_overlap_6_11_3
     exec_overlap_6_11_4
     exec_overlap_6_12_1
     exec_overlap_6_12_2
     exec_overlap_6_12_3
     exec_overlap_6_12_4
     exec_overlap_7_1_1
     exec_overlap_7_1_2
     exec_overlap_7_1_3
     exec_overlap_7_1_4
     exec_overlap_7_2_1
     exec_overlap_7_2_2
     exec_overlap_7_2_3
     exec_overlap_7_2_4
     exec_overlap_7_3_1
     exec_overlap_7_3_2
     exec_overlap_7_3_3
     exec_overlap_7_3_4
     exec_overlap_7_4_1
     exec_overlap_7_4_2
     exec_overlap_7_4_3
     exec_overlap_7_4_4
     exec_overlap_7_5_1
     exec_overlap_7_5_2
     exec_overlap_7_5_3
     exec_overlap_7_5_4
     exec_overlap_7_6_1
     exec_overlap_7_6_2
     exec_overlap_7_6_3
     exec_overlap_7_6_4
     exec_overlap_7_7_1
     exec_overlap_7_7_2
     exec_overlap_7_7_3
     exec_overlap_7_7_4
     exec_overlap_7_8_1
     exec_overlap_7_8_2
     exec_overlap_7_8_3
     exec_overlap_7_8_4
     exec_overlap_7_9_1
     exec_overlap_7_9_2
     exec_overlap_7_9_3
     exec_overlap_7_9_4
     exec_overlap_7_10_1
     exec_overlap_7_10_2
     exec_overlap_7_10_3
     exec_overlap_7_10_4
     exec_overlap_7_11_1
     exec_overlap_7_11_2
     exec_overlap_7_11_3
     exec_overlap_7_11_4
     exec_overlap_7_12_1
     exec_overlap_7_12_2
     exec_overlap_7_12_3
     exec_overlap_7_12_4
     exec_overlap_8_1_1
     exec_overlap_8_1_2
     exec_overlap_8_1_3
     exec_overlap_8_1_4
     exec_overlap_8_2_1
     exec_overlap_8_2_2
     exec_overlap_8_2_3
     exec_overlap_8_2_4
     exec_overlap_8_3_1
     exec_overlap_8_3_2
     exec_overlap_8_3_3
     exec_overlap_8_3_4
     exec_overlap_8_4_1
     exec_overlap_8_4_2
     exec_overlap_8_4_3
     exec_overlap_8_4_4
     exec_overlap_8_5_1
     exec_overlap_8_5_2
     exec_overlap_8_5_3
     exec_overlap_8_5_4
     exec_overlap_8_6_1
     exec_overlap_8_6_2
     exec_overlap_8_6_3
     exec_overlap_8_6_4
     exec_overlap_8_7_1
     exec_overlap_8_7_2
     exec_overlap_8_7_3
     exec_overlap_8_7_4
     exec_overlap_8_8_1
     exec_overlap_8_8_2
     exec_overlap_8_8_3
     exec_overlap_8_8_4
     exec_overlap_8_9_1
     exec_overlap_8_9_2
     exec_overlap_8_9_3
     exec_overlap_8_9_4
     exec_overlap_8_10_1
     exec_overlap_8_10_2
     exec_overlap_8_10_3
     exec_overlap_8_10_4
     exec_overlap_8_11_1
     exec_overlap_8_11_2
     exec_overlap_8_11_3
     exec_overlap_8_11_4
     exec_overlap_8_12_1
     exec_overlap_8_12_2
     exec_overlap_8_12_3
     exec_overlap_8_12_4
     exec_overlap_9_1_1
     exec_overlap_9_1_2
     exec_overlap_9_1_3
     exec_overlap_9_1_4
     exec_overlap_9_2_1
     exec_overlap_9_2_2
     exec_overlap_9_2_3
     exec_overlap_9_2_4
     exec_overlap_9_3_1
     exec_overlap_9_3_2
     exec_overlap_9_3_3
     exec_overlap_9_3_4
     exec_overlap_9_4_1
     exec_overlap_9_4_2
     exec_overlap_9_4_3
     exec_overlap_9_4_4
     exec_overlap_9_5_1
     exec_overlap_9_5_2
     exec_overlap_9_5_3
     exec_overlap_9_5_4
     exec_overlap_9_6_1
     exec_overlap_9_6_2
     exec_overlap_9_6_3
     exec_overlap_9_6_4
     exec_overlap_9_7_1
     exec_overlap_9_7_2
     exec_overlap_9_7_3
     exec_overlap_9_7_4
     exec_overlap_9_8_1
     exec_overlap_9_8_2
     exec_overlap_9_8_3
     exec_overlap_9_8_4
     exec_overlap_9_9_1
     exec_overlap_9_9_2
     exec_overlap_9_9_3
     exec_overlap_9_9_4
     exec_overlap_9_10_1
     exec_overlap_9_10_2
     exec_overlap_9_10_3
     exec_overlap_9_10_4
     exec_overlap_9_11_1
     exec_overlap_9_11_2
     exec_overlap_9_11_3
     exec_overlap_9_11_4
     exec_overlap_9_12_1
     exec_overlap_9_12_2
     exec_overlap_9_12_3
     exec_overlap_9_12_4
     exec_overlap_10_1_1
     exec_overlap_10_1_2
     exec_overlap_10_1_3
     exec_overlap_10_1_4
     exec_overlap_10_2_1
     exec_overlap_10_2_2
     exec_overlap_10_2_3
     exec_overlap_10_2_4
     exec_overlap_10_3_1
     exec_overlap_10_3_2
     exec_overlap_10_3_3
     exec_overlap_10_3_4
     exec_overlap_10_4_1
     exec_overlap_10_4_2
     exec_overlap_10_4_3
     exec_overlap_10_4_4
     exec_overlap_10_5_1
     exec_overlap_10_5_2
     exec_overlap_10_5_3
     exec_overlap_10_5_4
     exec_overlap_10_6_1
     exec_overlap_10_6_2
     exec_overlap_10_6_3
     exec_overlap_10_6_4
     exec_overlap_10_7_1
     exec_overlap_10_7_2
     exec_overlap_10_7_3
     exec_overlap_10_7_4
     exec_overlap_10_8_1
     exec_overlap_10_8_2
     exec_overlap_10_8_3
     exec_overlap_10_8_4
     exec_overlap_10_9_1
     exec_overlap_10_9_2
     exec_overlap_10_9_3
     exec_overlap_10_9_4
     exec_overlap_10_10_1
     exec_overlap_10_10_2
     exec_overlap_10_10_3
     exec_overlap_10_10_4
     exec_overlap_10_11_1
     exec_overlap_10_11_2
     exec_overlap_10_11_3
     exec_overlap_10_11_4
     exec_overlap_10_12_1
     exec_overlap_10_12_2
     exec_overlap_10_12_3
     exec_overlap_10_12_4
     exec_overlap_11_1_1
     exec_overlap_11_1_2
     exec_overlap_11_1_3
     exec_overlap_11_1_4
     exec_overlap_11_2_1
     exec_overlap_11_2_2
     exec_overlap_11_2_3
     exec_overlap_11_2_4
     exec_overlap_11_3_1
     exec_overlap_11_3_2
     exec_overlap_11_3_3
     exec_overlap_11_3_4
     exec_overlap_11_4_1
     exec_overlap_11_4_2
     exec_overlap_11_4_3
     exec_overlap_11_4_4
     exec_overlap_11_5_1
     exec_overlap_11_5_2
     exec_overlap_11_5_3
     exec_overlap_11_5_4
     exec_overlap_11_6_1
     exec_overlap_11_6_2
     exec_overlap_11_6_3
     exec_overlap_11_6_4
     exec_overlap_11_7_1
     exec_overlap_11_7_2
     exec_overlap_11_7_3
     exec_overlap_11_7_4
     exec_overlap_11_8_1
     exec_overlap_11_8_2
     exec_overlap_11_8_3
     exec_overlap_11_8_4
     exec_overlap_11_9_1
     exec_overlap_11_9_2
     exec_overlap_11_9_3
     exec_overlap_11_9_4
     exec_overlap_11_10_1
     exec_overlap_11_10_2
     exec_overlap_11_10_3
     exec_overlap_11_10_4
     exec_overlap_11_11_1
     exec_overlap_11_11_2
     exec_overlap_11_11_3
     exec_overlap_11_11_4
     exec_overlap_11_12_1
     exec_overlap_11_12_2
     exec_overlap_11_12_3
     exec_overlap_11_12_4
     exec_overlap_12_1_1
     exec_overlap_12_1_2
     exec_overlap_12_1_3
     exec_overlap_12_1_4
     exec_overlap_12_2_1
     exec_overlap_12_2_2
     exec_overlap_12_2_3
     exec_overlap_12_2_4
     exec_overlap_12_3_1
     exec_overlap_12_3_2
     exec_overlap_12_3_3
     exec_overlap_12_3_4
     exec_overlap_12_4_1
     exec_overlap_12_4_2
     exec_overlap_12_4_3
     exec_overlap_12_4_4
     exec_overlap_12_5_1
     exec_overlap_12_5_2
     exec_overlap_12_5_3
     exec_overlap_12_5_4
     exec_overlap_12_6_1
     exec_overlap_12_6_2
     exec_overlap_12_6_3
     exec_overlap_12_6_4
     exec_overlap_12_7_1
     exec_overlap_12_7_2
     exec_overlap_12_7_3
     exec_overlap_12_7_4
     exec_overlap_12_8_1
     exec_overlap_12_8_2
     exec_overlap_12_8_3
     exec_overlap_12_8_4
     exec_overlap_12_9_1
     exec_overlap_12_9_2
     exec_overlap_12_9_3
     exec_overlap_12_9_4
     exec_overlap_12_10_1
     exec_overlap_12_10_2
     exec_overlap_12_10_3
     exec_overlap_12_10_4
     exec_overlap_12_11_1
     exec_overlap_12_11_2
     exec_overlap_12_11_3
     exec_overlap_12_11_4
     exec_overlap_12_12_1
     exec_overlap_12_12_2
     exec_overlap_12_12_3
     exec_overlap_12_12_4
     single_job_1_2
     single_job_1_3
     single_job_1_4
     single_job_2_1
     single_job_2_3
     single_job_2_4
     single_job_3_1
     single_job_3_2
     single_job_3_4
     single_job_4_1
     single_job_4_2
     single_job_4_3
     single_job_5_1
     single_job_5_2
     single_job_5_3
     single_job_5_4
     single_job_5_6
     single_job_5_7
     single_job_6_1
     single_job_6_2
     single_job_6_3
     single_job_6_4
     single_job_6_5
     single_job_6_7
     single_job_7_1
     single_job_7_2
     single_job_7_3
     single_job_7_4
     single_job_7_5
     single_job_7_6
     single_job_8_1
     single_job_8_2
     single_job_8_3
     single_job_8_4
     single_job_8_5
     single_job_8_6
     single_job_8_7
     single_job_8_9
     single_job_8_10
     single_job_8_11
     single_job_9_1
     single_job_9_2
     single_job_9_3
     single_job_9_4
     single_job_9_5
     single_job_9_6
     single_job_9_7
     single_job_9_8
     single_job_9_10
     single_job_9_11
     single_job_10_1
     single_job_10_2
     single_job_10_3
     single_job_10_4
     single_job_10_5
     single_job_10_6
     single_job_10_7
     single_job_10_8
     single_job_10_9
     single_job_10_11
     single_job_11_1
     single_job_11_2
     single_job_11_3
     single_job_11_4
     single_job_11_5
     single_job_11_6
     single_job_11_7
     single_job_11_8
     single_job_11_9
     single_job_11_10
     single_job_12_1
     single_job_12_2
     single_job_12_3
     single_job_12_4
     single_job_12_5
     single_job_12_6
     single_job_12_7
     single_job_12_8
     single_job_12_9
     single_job_12_10
     single_job_12_11
     single_job2_1_2
     single_job2_1_3
     single_job2_1_4
     single_job2_2_1
     single_job2_2_3
     single_job2_2_4
     single_job2_3_1
     single_job2_3_2
     single_job2_3_4
     single_job2_4_1
     single_job2_4_2
     single_job2_4_3
     single_job2_5_1
     single_job2_5_2
     single_job2_5_3
     single_job2_5_4
     single_job2_5_6
     single_job2_5_7
     single_job2_6_1
     single_job2_6_2
     single_job2_6_3
     single_job2_6_4
     single_job2_6_5
     single_job2_6_7
     single_job2_7_1
     single_job2_7_2
     single_job2_7_3
     single_job2_7_4
     single_job2_7_5
     single_job2_7_6
     single_job2_8_1
     single_job2_8_2
     single_job2_8_3
     single_job2_8_4
     single_job2_8_5
     single_job2_8_6
     single_job2_8_7
     single_job2_8_9
     single_job2_8_10
     single_job2_8_11
     single_job2_9_1
     single_job2_9_2
     single_job2_9_3
     single_job2_9_4
     single_job2_9_5
     single_job2_9_6
     single_job2_9_7
     single_job2_9_8
     single_job2_9_10
     single_job2_9_11
     single_job2_10_1
     single_job2_10_2
     single_job2_10_3
     single_job2_10_4
     single_job2_10_5
     single_job2_10_6
     single_job2_10_7
     single_job2_10_8
     single_job2_10_9
     single_job2_10_11
     single_job2_11_1
     single_job2_11_2
     single_job2_11_3
     single_job2_11_4
     single_job2_11_5
     single_job2_11_6
     single_job2_11_7
     single_job2_11_8
     single_job2_11_9
     single_job2_11_10
     single_job2_12_1
     single_job2_12_2
     single_job2_12_3
     single_job2_12_4
     single_job2_12_5
     single_job2_12_6
     single_job2_12_7
     single_job2_12_8
     single_job2_12_9
     single_job2_12_10
     single_job2_12_11
;
time ..                 Z =e= t;
time_constraint(j,a) .. t =g= s(j) + d(j,a)*x(j,a);
supply(j) ..            sum(a, x(j,a))  =e=  assign(j);
* start(j,j)             "job cannot start unless its predecessors are completed"
start_1_5..  s('J5') =g= s('J1');
start_1_6..  s('J6') =g= s('J1');
start_1_7..  s('J7') =g= s('J1');
start_2_5..  s('J5') =g= s('J2');
start_2_6..  s('J6') =g= s('J2');
start_2_7..  s('J7') =g= s('J2');
start_3_5..  s('J5') =g= s('J3');
start_3_6..  s('J6') =g= s('J3');
start_3_7..  s('J7') =g= s('J3');
start_4_5..  s('J5') =g= s('J4');
start_4_6..  s('J6') =g= s('J4');
start_4_7..  s('J7') =g= s('J4');
start_5_8..  s('J8') =g= s('J5');
start_5_9..  s('J9') =g= s('J5');
start_5_10..  s('J10') =g= s('J5');
start_5_11..  s('J11') =g= s('J5');
start_6_8..  s('J8') =g= s('J6');
start_6_9..  s('J9') =g= s('J6');
start_6_10..  s('J10') =g= s('J6');
start_6_11..  s('J11') =g= s('J6');
start_7_8..  s('J8') =g= s('J7');
start_7_9..  s('J9') =g= s('J7');
start_7_10..  s('J10') =g= s('J7');
start_7_11..  s('J11') =g= s('J7');
start_8_12..  s('J12') =g= s('J8');
start_9_12..  s('J12') =g= s('J9');
start_10_12..  s('J12') =g= s('J10');
start_11_12..  s('J12') =g= s('J11');
* start2(j,j)              "need to rename this lol ** P matrix (job order) applies here **"
start2_1_5_1..  s('J5') =g= (s('J1') + (d('J1','A1') + c('J1','A1','A1'))*(x('J1','A1') + x('J1','A1') -1));
start2_1_5_2..  s('J5') =g= (s('J1') + (d('J1','A2') + c('J1','A2','A2'))*(x('J1','A2') + x('J1','A2') -1));
start2_1_5_3..  s('J5') =g= (s('J1') + (d('J1','A3') + c('J1','A3','A3'))*(x('J1','A3') + x('J1','A3') -1));
start2_1_5_4..  s('J5') =g= (s('J1') + (d('J1','A4') + c('J1','A4','A4'))*(x('J1','A4') + x('J1','A4') -1));
start2_1_6_1..  s('J6') =g= (s('J1') + (d('J1','A1') + c('J1','A1','A1'))*(x('J1','A1') + x('J1','A1') -1));
start2_1_6_2..  s('J6') =g= (s('J1') + (d('J1','A2') + c('J1','A2','A2'))*(x('J1','A2') + x('J1','A2') -1));
start2_1_6_3..  s('J6') =g= (s('J1') + (d('J1','A3') + c('J1','A3','A3'))*(x('J1','A3') + x('J1','A3') -1));
start2_1_6_4..  s('J6') =g= (s('J1') + (d('J1','A4') + c('J1','A4','A4'))*(x('J1','A4') + x('J1','A4') -1));
start2_1_7_1..  s('J7') =g= (s('J1') + (d('J1','A1') + c('J1','A1','A1'))*(x('J1','A1') + x('J1','A1') -1));
start2_1_7_2..  s('J7') =g= (s('J1') + (d('J1','A2') + c('J1','A2','A2'))*(x('J1','A2') + x('J1','A2') -1));
start2_1_7_3..  s('J7') =g= (s('J1') + (d('J1','A3') + c('J1','A3','A3'))*(x('J1','A3') + x('J1','A3') -1));
start2_1_7_4..  s('J7') =g= (s('J1') + (d('J1','A4') + c('J1','A4','A4'))*(x('J1','A4') + x('J1','A4') -1));
start2_2_5_1..  s('J5') =g= (s('J2') + (d('J2','A1') + c('J2','A1','A1'))*(x('J2','A1') + x('J2','A1') -1));
start2_2_5_2..  s('J5') =g= (s('J2') + (d('J2','A2') + c('J2','A2','A2'))*(x('J2','A2') + x('J2','A2') -1));
start2_2_5_3..  s('J5') =g= (s('J2') + (d('J2','A3') + c('J2','A3','A3'))*(x('J2','A3') + x('J2','A3') -1));
start2_2_5_4..  s('J5') =g= (s('J2') + (d('J2','A4') + c('J2','A4','A4'))*(x('J2','A4') + x('J2','A4') -1));
start2_2_6_1..  s('J6') =g= (s('J2') + (d('J2','A1') + c('J2','A1','A1'))*(x('J2','A1') + x('J2','A1') -1));
start2_2_6_2..  s('J6') =g= (s('J2') + (d('J2','A2') + c('J2','A2','A2'))*(x('J2','A2') + x('J2','A2') -1));
start2_2_6_3..  s('J6') =g= (s('J2') + (d('J2','A3') + c('J2','A3','A3'))*(x('J2','A3') + x('J2','A3') -1));
start2_2_6_4..  s('J6') =g= (s('J2') + (d('J2','A4') + c('J2','A4','A4'))*(x('J2','A4') + x('J2','A4') -1));
start2_2_7_1..  s('J7') =g= (s('J2') + (d('J2','A1') + c('J2','A1','A1'))*(x('J2','A1') + x('J2','A1') -1));
start2_2_7_2..  s('J7') =g= (s('J2') + (d('J2','A2') + c('J2','A2','A2'))*(x('J2','A2') + x('J2','A2') -1));
start2_2_7_3..  s('J7') =g= (s('J2') + (d('J2','A3') + c('J2','A3','A3'))*(x('J2','A3') + x('J2','A3') -1));
start2_2_7_4..  s('J7') =g= (s('J2') + (d('J2','A4') + c('J2','A4','A4'))*(x('J2','A4') + x('J2','A4') -1));
start2_3_5_1..  s('J5') =g= (s('J3') + (d('J3','A1') + c('J3','A1','A1'))*(x('J3','A1') + x('J3','A1') -1));
start2_3_5_2..  s('J5') =g= (s('J3') + (d('J3','A2') + c('J3','A2','A2'))*(x('J3','A2') + x('J3','A2') -1));
start2_3_5_3..  s('J5') =g= (s('J3') + (d('J3','A3') + c('J3','A3','A3'))*(x('J3','A3') + x('J3','A3') -1));
start2_3_5_4..  s('J5') =g= (s('J3') + (d('J3','A4') + c('J3','A4','A4'))*(x('J3','A4') + x('J3','A4') -1));
start2_3_6_1..  s('J6') =g= (s('J3') + (d('J3','A1') + c('J3','A1','A1'))*(x('J3','A1') + x('J3','A1') -1));
start2_3_6_2..  s('J6') =g= (s('J3') + (d('J3','A2') + c('J3','A2','A2'))*(x('J3','A2') + x('J3','A2') -1));
start2_3_6_3..  s('J6') =g= (s('J3') + (d('J3','A3') + c('J3','A3','A3'))*(x('J3','A3') + x('J3','A3') -1));
start2_3_6_4..  s('J6') =g= (s('J3') + (d('J3','A4') + c('J3','A4','A4'))*(x('J3','A4') + x('J3','A4') -1));
start2_3_7_1..  s('J7') =g= (s('J3') + (d('J3','A1') + c('J3','A1','A1'))*(x('J3','A1') + x('J3','A1') -1));
start2_3_7_2..  s('J7') =g= (s('J3') + (d('J3','A2') + c('J3','A2','A2'))*(x('J3','A2') + x('J3','A2') -1));
start2_3_7_3..  s('J7') =g= (s('J3') + (d('J3','A3') + c('J3','A3','A3'))*(x('J3','A3') + x('J3','A3') -1));
start2_3_7_4..  s('J7') =g= (s('J3') + (d('J3','A4') + c('J3','A4','A4'))*(x('J3','A4') + x('J3','A4') -1));
start2_4_5_1..  s('J5') =g= (s('J4') + (d('J4','A1') + c('J4','A1','A1'))*(x('J4','A1') + x('J4','A1') -1));
start2_4_5_2..  s('J5') =g= (s('J4') + (d('J4','A2') + c('J4','A2','A2'))*(x('J4','A2') + x('J4','A2') -1));
start2_4_5_3..  s('J5') =g= (s('J4') + (d('J4','A3') + c('J4','A3','A3'))*(x('J4','A3') + x('J4','A3') -1));
start2_4_5_4..  s('J5') =g= (s('J4') + (d('J4','A4') + c('J4','A4','A4'))*(x('J4','A4') + x('J4','A4') -1));
start2_4_6_1..  s('J6') =g= (s('J4') + (d('J4','A1') + c('J4','A1','A1'))*(x('J4','A1') + x('J4','A1') -1));
start2_4_6_2..  s('J6') =g= (s('J4') + (d('J4','A2') + c('J4','A2','A2'))*(x('J4','A2') + x('J4','A2') -1));
start2_4_6_3..  s('J6') =g= (s('J4') + (d('J4','A3') + c('J4','A3','A3'))*(x('J4','A3') + x('J4','A3') -1));
start2_4_6_4..  s('J6') =g= (s('J4') + (d('J4','A4') + c('J4','A4','A4'))*(x('J4','A4') + x('J4','A4') -1));
start2_4_7_1..  s('J7') =g= (s('J4') + (d('J4','A1') + c('J4','A1','A1'))*(x('J4','A1') + x('J4','A1') -1));
start2_4_7_2..  s('J7') =g= (s('J4') + (d('J4','A2') + c('J4','A2','A2'))*(x('J4','A2') + x('J4','A2') -1));
start2_4_7_3..  s('J7') =g= (s('J4') + (d('J4','A3') + c('J4','A3','A3'))*(x('J4','A3') + x('J4','A3') -1));
start2_4_7_4..  s('J7') =g= (s('J4') + (d('J4','A4') + c('J4','A4','A4'))*(x('J4','A4') + x('J4','A4') -1));
start2_5_8_1..  s('J8') =g= (s('J5') + (d('J5','A1') + c('J5','A1','A1'))*(x('J5','A1') + x('J5','A1') -1));
start2_5_8_2..  s('J8') =g= (s('J5') + (d('J5','A2') + c('J5','A2','A2'))*(x('J5','A2') + x('J5','A2') -1));
start2_5_8_3..  s('J8') =g= (s('J5') + (d('J5','A3') + c('J5','A3','A3'))*(x('J5','A3') + x('J5','A3') -1));
start2_5_8_4..  s('J8') =g= (s('J5') + (d('J5','A4') + c('J5','A4','A4'))*(x('J5','A4') + x('J5','A4') -1));
start2_5_9_1..  s('J9') =g= (s('J5') + (d('J5','A1') + c('J5','A1','A1'))*(x('J5','A1') + x('J5','A1') -1));
start2_5_9_2..  s('J9') =g= (s('J5') + (d('J5','A2') + c('J5','A2','A2'))*(x('J5','A2') + x('J5','A2') -1));
start2_5_9_3..  s('J9') =g= (s('J5') + (d('J5','A3') + c('J5','A3','A3'))*(x('J5','A3') + x('J5','A3') -1));
start2_5_9_4..  s('J9') =g= (s('J5') + (d('J5','A4') + c('J5','A4','A4'))*(x('J5','A4') + x('J5','A4') -1));
start2_5_10_1..  s('J10') =g= (s('J5') + (d('J5','A1') + c('J5','A1','A1'))*(x('J5','A1') + x('J5','A1') -1));
start2_5_10_2..  s('J10') =g= (s('J5') + (d('J5','A2') + c('J5','A2','A2'))*(x('J5','A2') + x('J5','A2') -1));
start2_5_10_3..  s('J10') =g= (s('J5') + (d('J5','A3') + c('J5','A3','A3'))*(x('J5','A3') + x('J5','A3') -1));
start2_5_10_4..  s('J10') =g= (s('J5') + (d('J5','A4') + c('J5','A4','A4'))*(x('J5','A4') + x('J5','A4') -1));
start2_5_11_1..  s('J11') =g= (s('J5') + (d('J5','A1') + c('J5','A1','A1'))*(x('J5','A1') + x('J5','A1') -1));
start2_5_11_2..  s('J11') =g= (s('J5') + (d('J5','A2') + c('J5','A2','A2'))*(x('J5','A2') + x('J5','A2') -1));
start2_5_11_3..  s('J11') =g= (s('J5') + (d('J5','A3') + c('J5','A3','A3'))*(x('J5','A3') + x('J5','A3') -1));
start2_5_11_4..  s('J11') =g= (s('J5') + (d('J5','A4') + c('J5','A4','A4'))*(x('J5','A4') + x('J5','A4') -1));
start2_6_8_1..  s('J8') =g= (s('J6') + (d('J6','A1') + c('J6','A1','A1'))*(x('J6','A1') + x('J6','A1') -1));
start2_6_8_2..  s('J8') =g= (s('J6') + (d('J6','A2') + c('J6','A2','A2'))*(x('J6','A2') + x('J6','A2') -1));
start2_6_8_3..  s('J8') =g= (s('J6') + (d('J6','A3') + c('J6','A3','A3'))*(x('J6','A3') + x('J6','A3') -1));
start2_6_8_4..  s('J8') =g= (s('J6') + (d('J6','A4') + c('J6','A4','A4'))*(x('J6','A4') + x('J6','A4') -1));
start2_6_9_1..  s('J9') =g= (s('J6') + (d('J6','A1') + c('J6','A1','A1'))*(x('J6','A1') + x('J6','A1') -1));
start2_6_9_2..  s('J9') =g= (s('J6') + (d('J6','A2') + c('J6','A2','A2'))*(x('J6','A2') + x('J6','A2') -1));
start2_6_9_3..  s('J9') =g= (s('J6') + (d('J6','A3') + c('J6','A3','A3'))*(x('J6','A3') + x('J6','A3') -1));
start2_6_9_4..  s('J9') =g= (s('J6') + (d('J6','A4') + c('J6','A4','A4'))*(x('J6','A4') + x('J6','A4') -1));
start2_6_10_1..  s('J10') =g= (s('J6') + (d('J6','A1') + c('J6','A1','A1'))*(x('J6','A1') + x('J6','A1') -1));
start2_6_10_2..  s('J10') =g= (s('J6') + (d('J6','A2') + c('J6','A2','A2'))*(x('J6','A2') + x('J6','A2') -1));
start2_6_10_3..  s('J10') =g= (s('J6') + (d('J6','A3') + c('J6','A3','A3'))*(x('J6','A3') + x('J6','A3') -1));
start2_6_10_4..  s('J10') =g= (s('J6') + (d('J6','A4') + c('J6','A4','A4'))*(x('J6','A4') + x('J6','A4') -1));
start2_6_11_1..  s('J11') =g= (s('J6') + (d('J6','A1') + c('J6','A1','A1'))*(x('J6','A1') + x('J6','A1') -1));
start2_6_11_2..  s('J11') =g= (s('J6') + (d('J6','A2') + c('J6','A2','A2'))*(x('J6','A2') + x('J6','A2') -1));
start2_6_11_3..  s('J11') =g= (s('J6') + (d('J6','A3') + c('J6','A3','A3'))*(x('J6','A3') + x('J6','A3') -1));
start2_6_11_4..  s('J11') =g= (s('J6') + (d('J6','A4') + c('J6','A4','A4'))*(x('J6','A4') + x('J6','A4') -1));
start2_7_8_1..  s('J8') =g= (s('J7') + (d('J7','A1') + c('J7','A1','A1'))*(x('J7','A1') + x('J7','A1') -1));
start2_7_8_2..  s('J8') =g= (s('J7') + (d('J7','A2') + c('J7','A2','A2'))*(x('J7','A2') + x('J7','A2') -1));
start2_7_8_3..  s('J8') =g= (s('J7') + (d('J7','A3') + c('J7','A3','A3'))*(x('J7','A3') + x('J7','A3') -1));
start2_7_8_4..  s('J8') =g= (s('J7') + (d('J7','A4') + c('J7','A4','A4'))*(x('J7','A4') + x('J7','A4') -1));
start2_7_9_1..  s('J9') =g= (s('J7') + (d('J7','A1') + c('J7','A1','A1'))*(x('J7','A1') + x('J7','A1') -1));
start2_7_9_2..  s('J9') =g= (s('J7') + (d('J7','A2') + c('J7','A2','A2'))*(x('J7','A2') + x('J7','A2') -1));
start2_7_9_3..  s('J9') =g= (s('J7') + (d('J7','A3') + c('J7','A3','A3'))*(x('J7','A3') + x('J7','A3') -1));
start2_7_9_4..  s('J9') =g= (s('J7') + (d('J7','A4') + c('J7','A4','A4'))*(x('J7','A4') + x('J7','A4') -1));
start2_7_10_1..  s('J10') =g= (s('J7') + (d('J7','A1') + c('J7','A1','A1'))*(x('J7','A1') + x('J7','A1') -1));
start2_7_10_2..  s('J10') =g= (s('J7') + (d('J7','A2') + c('J7','A2','A2'))*(x('J7','A2') + x('J7','A2') -1));
start2_7_10_3..  s('J10') =g= (s('J7') + (d('J7','A3') + c('J7','A3','A3'))*(x('J7','A3') + x('J7','A3') -1));
start2_7_10_4..  s('J10') =g= (s('J7') + (d('J7','A4') + c('J7','A4','A4'))*(x('J7','A4') + x('J7','A4') -1));
start2_7_11_1..  s('J11') =g= (s('J7') + (d('J7','A1') + c('J7','A1','A1'))*(x('J7','A1') + x('J7','A1') -1));
start2_7_11_2..  s('J11') =g= (s('J7') + (d('J7','A2') + c('J7','A2','A2'))*(x('J7','A2') + x('J7','A2') -1));
start2_7_11_3..  s('J11') =g= (s('J7') + (d('J7','A3') + c('J7','A3','A3'))*(x('J7','A3') + x('J7','A3') -1));
start2_7_11_4..  s('J11') =g= (s('J7') + (d('J7','A4') + c('J7','A4','A4'))*(x('J7','A4') + x('J7','A4') -1));
start2_8_12_1..  s('J12') =g= (s('J8') + (d('J8','A1') + c('J8','A1','A1'))*(x('J8','A1') + x('J8','A1') -1));
start2_8_12_2..  s('J12') =g= (s('J8') + (d('J8','A2') + c('J8','A2','A2'))*(x('J8','A2') + x('J8','A2') -1));
start2_8_12_3..  s('J12') =g= (s('J8') + (d('J8','A3') + c('J8','A3','A3'))*(x('J8','A3') + x('J8','A3') -1));
start2_8_12_4..  s('J12') =g= (s('J8') + (d('J8','A4') + c('J8','A4','A4'))*(x('J8','A4') + x('J8','A4') -1));
start2_9_12_1..  s('J12') =g= (s('J9') + (d('J9','A1') + c('J9','A1','A1'))*(x('J9','A1') + x('J9','A1') -1));
start2_9_12_2..  s('J12') =g= (s('J9') + (d('J9','A2') + c('J9','A2','A2'))*(x('J9','A2') + x('J9','A2') -1));
start2_9_12_3..  s('J12') =g= (s('J9') + (d('J9','A3') + c('J9','A3','A3'))*(x('J9','A3') + x('J9','A3') -1));
start2_9_12_4..  s('J12') =g= (s('J9') + (d('J9','A4') + c('J9','A4','A4'))*(x('J9','A4') + x('J9','A4') -1));
start2_10_12_1..  s('J12') =g= (s('J10') + (d('J10','A1') + c('J10','A1','A1'))*(x('J10','A1') + x('J10','A1') -1));
start2_10_12_2..  s('J12') =g= (s('J10') + (d('J10','A2') + c('J10','A2','A2'))*(x('J10','A2') + x('J10','A2') -1));
start2_10_12_3..  s('J12') =g= (s('J10') + (d('J10','A3') + c('J10','A3','A3'))*(x('J10','A3') + x('J10','A3') -1));
start2_10_12_4..  s('J12') =g= (s('J10') + (d('J10','A4') + c('J10','A4','A4'))*(x('J10','A4') + x('J10','A4') -1));
start2_11_12_1..  s('J12') =g= (s('J11') + (d('J11','A1') + c('J11','A1','A1'))*(x('J11','A1') + x('J11','A1') -1));
start2_11_12_2..  s('J12') =g= (s('J11') + (d('J11','A2') + c('J11','A2','A2'))*(x('J11','A2') + x('J11','A2') -1));
start2_11_12_3..  s('J12') =g= (s('J11') + (d('J11','A3') + c('J11','A3','A3'))*(x('J11','A3') + x('J11','A3') -1));
start2_11_12_4..  s('J12') =g= (s('J11') + (d('J11','A4') + c('J11','A4','A4'))*(x('J11','A4') + x('J11','A4') -1));
* exec_overlap(j,j,a)    "if two jobs are assigned to the same agent, execution times shouldnt overlap"
exec_overlap_1_1_1 ..  x('J1','A1') + x('J1','A1') + theta('J1','J1') + theta('J1','J1') =l= 3;
exec_overlap_1_1_2 ..  x('J1','A2') + x('J1','A2') + theta('J1','J1') + theta('J1','J1') =l= 3;
exec_overlap_1_1_3 ..  x('J1','A3') + x('J1','A3') + theta('J1','J1') + theta('J1','J1') =l= 3;
exec_overlap_1_1_4 ..  x('J1','A4') + x('J1','A4') + theta('J1','J1') + theta('J1','J1') =l= 3;
exec_overlap_1_2_1 ..  x('J1','A1') + x('J2','A1') + theta('J1','J2') + theta('J2','J1') =l= 3;
exec_overlap_1_2_2 ..  x('J1','A2') + x('J2','A2') + theta('J1','J2') + theta('J2','J1') =l= 3;
exec_overlap_1_2_3 ..  x('J1','A3') + x('J2','A3') + theta('J1','J2') + theta('J2','J1') =l= 3;
exec_overlap_1_2_4 ..  x('J1','A4') + x('J2','A4') + theta('J1','J2') + theta('J2','J1') =l= 3;
exec_overlap_1_3_1 ..  x('J1','A1') + x('J3','A1') + theta('J1','J3') + theta('J3','J1') =l= 3;
exec_overlap_1_3_2 ..  x('J1','A2') + x('J3','A2') + theta('J1','J3') + theta('J3','J1') =l= 3;
exec_overlap_1_3_3 ..  x('J1','A3') + x('J3','A3') + theta('J1','J3') + theta('J3','J1') =l= 3;
exec_overlap_1_3_4 ..  x('J1','A4') + x('J3','A4') + theta('J1','J3') + theta('J3','J1') =l= 3;
exec_overlap_1_4_1 ..  x('J1','A1') + x('J4','A1') + theta('J1','J4') + theta('J4','J1') =l= 3;
exec_overlap_1_4_2 ..  x('J1','A2') + x('J4','A2') + theta('J1','J4') + theta('J4','J1') =l= 3;
exec_overlap_1_4_3 ..  x('J1','A3') + x('J4','A3') + theta('J1','J4') + theta('J4','J1') =l= 3;
exec_overlap_1_4_4 ..  x('J1','A4') + x('J4','A4') + theta('J1','J4') + theta('J4','J1') =l= 3;
exec_overlap_1_5_1 ..  x('J1','A1') + x('J5','A1') + theta('J1','J5') + theta('J5','J1') =l= 3;
exec_overlap_1_5_2 ..  x('J1','A2') + x('J5','A2') + theta('J1','J5') + theta('J5','J1') =l= 3;
exec_overlap_1_5_3 ..  x('J1','A3') + x('J5','A3') + theta('J1','J5') + theta('J5','J1') =l= 3;
exec_overlap_1_5_4 ..  x('J1','A4') + x('J5','A4') + theta('J1','J5') + theta('J5','J1') =l= 3;
exec_overlap_1_6_1 ..  x('J1','A1') + x('J6','A1') + theta('J1','J6') + theta('J6','J1') =l= 3;
exec_overlap_1_6_2 ..  x('J1','A2') + x('J6','A2') + theta('J1','J6') + theta('J6','J1') =l= 3;
exec_overlap_1_6_3 ..  x('J1','A3') + x('J6','A3') + theta('J1','J6') + theta('J6','J1') =l= 3;
exec_overlap_1_6_4 ..  x('J1','A4') + x('J6','A4') + theta('J1','J6') + theta('J6','J1') =l= 3;
exec_overlap_1_7_1 ..  x('J1','A1') + x('J7','A1') + theta('J1','J7') + theta('J7','J1') =l= 3;
exec_overlap_1_7_2 ..  x('J1','A2') + x('J7','A2') + theta('J1','J7') + theta('J7','J1') =l= 3;
exec_overlap_1_7_3 ..  x('J1','A3') + x('J7','A3') + theta('J1','J7') + theta('J7','J1') =l= 3;
exec_overlap_1_7_4 ..  x('J1','A4') + x('J7','A4') + theta('J1','J7') + theta('J7','J1') =l= 3;
exec_overlap_1_8_1 ..  x('J1','A1') + x('J8','A1') + theta('J1','J8') + theta('J8','J1') =l= 3;
exec_overlap_1_8_2 ..  x('J1','A2') + x('J8','A2') + theta('J1','J8') + theta('J8','J1') =l= 3;
exec_overlap_1_8_3 ..  x('J1','A3') + x('J8','A3') + theta('J1','J8') + theta('J8','J1') =l= 3;
exec_overlap_1_8_4 ..  x('J1','A4') + x('J8','A4') + theta('J1','J8') + theta('J8','J1') =l= 3;
exec_overlap_1_9_1 ..  x('J1','A1') + x('J9','A1') + theta('J1','J9') + theta('J9','J1') =l= 3;
exec_overlap_1_9_2 ..  x('J1','A2') + x('J9','A2') + theta('J1','J9') + theta('J9','J1') =l= 3;
exec_overlap_1_9_3 ..  x('J1','A3') + x('J9','A3') + theta('J1','J9') + theta('J9','J1') =l= 3;
exec_overlap_1_9_4 ..  x('J1','A4') + x('J9','A4') + theta('J1','J9') + theta('J9','J1') =l= 3;
exec_overlap_1_10_1 ..  x('J1','A1') + x('J10','A1') + theta('J1','J10') + theta('J10','J1') =l= 3;
exec_overlap_1_10_2 ..  x('J1','A2') + x('J10','A2') + theta('J1','J10') + theta('J10','J1') =l= 3;
exec_overlap_1_10_3 ..  x('J1','A3') + x('J10','A3') + theta('J1','J10') + theta('J10','J1') =l= 3;
exec_overlap_1_10_4 ..  x('J1','A4') + x('J10','A4') + theta('J1','J10') + theta('J10','J1') =l= 3;
exec_overlap_1_11_1 ..  x('J1','A1') + x('J11','A1') + theta('J1','J11') + theta('J11','J1') =l= 3;
exec_overlap_1_11_2 ..  x('J1','A2') + x('J11','A2') + theta('J1','J11') + theta('J11','J1') =l= 3;
exec_overlap_1_11_3 ..  x('J1','A3') + x('J11','A3') + theta('J1','J11') + theta('J11','J1') =l= 3;
exec_overlap_1_11_4 ..  x('J1','A4') + x('J11','A4') + theta('J1','J11') + theta('J11','J1') =l= 3;
exec_overlap_1_12_1 ..  x('J1','A1') + x('J12','A1') + theta('J1','J12') + theta('J12','J1') =l= 3;
exec_overlap_1_12_2 ..  x('J1','A2') + x('J12','A2') + theta('J1','J12') + theta('J12','J1') =l= 3;
exec_overlap_1_12_3 ..  x('J1','A3') + x('J12','A3') + theta('J1','J12') + theta('J12','J1') =l= 3;
exec_overlap_1_12_4 ..  x('J1','A4') + x('J12','A4') + theta('J1','J12') + theta('J12','J1') =l= 3;
exec_overlap_2_1_1 ..  x('J2','A1') + x('J1','A1') + theta('J2','J1') + theta('J1','J2') =l= 3;
exec_overlap_2_1_2 ..  x('J2','A2') + x('J1','A2') + theta('J2','J1') + theta('J1','J2') =l= 3;
exec_overlap_2_1_3 ..  x('J2','A3') + x('J1','A3') + theta('J2','J1') + theta('J1','J2') =l= 3;
exec_overlap_2_1_4 ..  x('J2','A4') + x('J1','A4') + theta('J2','J1') + theta('J1','J2') =l= 3;
exec_overlap_2_2_1 ..  x('J2','A1') + x('J2','A1') + theta('J2','J2') + theta('J2','J2') =l= 3;
exec_overlap_2_2_2 ..  x('J2','A2') + x('J2','A2') + theta('J2','J2') + theta('J2','J2') =l= 3;
exec_overlap_2_2_3 ..  x('J2','A3') + x('J2','A3') + theta('J2','J2') + theta('J2','J2') =l= 3;
exec_overlap_2_2_4 ..  x('J2','A4') + x('J2','A4') + theta('J2','J2') + theta('J2','J2') =l= 3;
exec_overlap_2_3_1 ..  x('J2','A1') + x('J3','A1') + theta('J2','J3') + theta('J3','J2') =l= 3;
exec_overlap_2_3_2 ..  x('J2','A2') + x('J3','A2') + theta('J2','J3') + theta('J3','J2') =l= 3;
exec_overlap_2_3_3 ..  x('J2','A3') + x('J3','A3') + theta('J2','J3') + theta('J3','J2') =l= 3;
exec_overlap_2_3_4 ..  x('J2','A4') + x('J3','A4') + theta('J2','J3') + theta('J3','J2') =l= 3;
exec_overlap_2_4_1 ..  x('J2','A1') + x('J4','A1') + theta('J2','J4') + theta('J4','J2') =l= 3;
exec_overlap_2_4_2 ..  x('J2','A2') + x('J4','A2') + theta('J2','J4') + theta('J4','J2') =l= 3;
exec_overlap_2_4_3 ..  x('J2','A3') + x('J4','A3') + theta('J2','J4') + theta('J4','J2') =l= 3;
exec_overlap_2_4_4 ..  x('J2','A4') + x('J4','A4') + theta('J2','J4') + theta('J4','J2') =l= 3;
exec_overlap_2_5_1 ..  x('J2','A1') + x('J5','A1') + theta('J2','J5') + theta('J5','J2') =l= 3;
exec_overlap_2_5_2 ..  x('J2','A2') + x('J5','A2') + theta('J2','J5') + theta('J5','J2') =l= 3;
exec_overlap_2_5_3 ..  x('J2','A3') + x('J5','A3') + theta('J2','J5') + theta('J5','J2') =l= 3;
exec_overlap_2_5_4 ..  x('J2','A4') + x('J5','A4') + theta('J2','J5') + theta('J5','J2') =l= 3;
exec_overlap_2_6_1 ..  x('J2','A1') + x('J6','A1') + theta('J2','J6') + theta('J6','J2') =l= 3;
exec_overlap_2_6_2 ..  x('J2','A2') + x('J6','A2') + theta('J2','J6') + theta('J6','J2') =l= 3;
exec_overlap_2_6_3 ..  x('J2','A3') + x('J6','A3') + theta('J2','J6') + theta('J6','J2') =l= 3;
exec_overlap_2_6_4 ..  x('J2','A4') + x('J6','A4') + theta('J2','J6') + theta('J6','J2') =l= 3;
exec_overlap_2_7_1 ..  x('J2','A1') + x('J7','A1') + theta('J2','J7') + theta('J7','J2') =l= 3;
exec_overlap_2_7_2 ..  x('J2','A2') + x('J7','A2') + theta('J2','J7') + theta('J7','J2') =l= 3;
exec_overlap_2_7_3 ..  x('J2','A3') + x('J7','A3') + theta('J2','J7') + theta('J7','J2') =l= 3;
exec_overlap_2_7_4 ..  x('J2','A4') + x('J7','A4') + theta('J2','J7') + theta('J7','J2') =l= 3;
exec_overlap_2_8_1 ..  x('J2','A1') + x('J8','A1') + theta('J2','J8') + theta('J8','J2') =l= 3;
exec_overlap_2_8_2 ..  x('J2','A2') + x('J8','A2') + theta('J2','J8') + theta('J8','J2') =l= 3;
exec_overlap_2_8_3 ..  x('J2','A3') + x('J8','A3') + theta('J2','J8') + theta('J8','J2') =l= 3;
exec_overlap_2_8_4 ..  x('J2','A4') + x('J8','A4') + theta('J2','J8') + theta('J8','J2') =l= 3;
exec_overlap_2_9_1 ..  x('J2','A1') + x('J9','A1') + theta('J2','J9') + theta('J9','J2') =l= 3;
exec_overlap_2_9_2 ..  x('J2','A2') + x('J9','A2') + theta('J2','J9') + theta('J9','J2') =l= 3;
exec_overlap_2_9_3 ..  x('J2','A3') + x('J9','A3') + theta('J2','J9') + theta('J9','J2') =l= 3;
exec_overlap_2_9_4 ..  x('J2','A4') + x('J9','A4') + theta('J2','J9') + theta('J9','J2') =l= 3;
exec_overlap_2_10_1 ..  x('J2','A1') + x('J10','A1') + theta('J2','J10') + theta('J10','J2') =l= 3;
exec_overlap_2_10_2 ..  x('J2','A2') + x('J10','A2') + theta('J2','J10') + theta('J10','J2') =l= 3;
exec_overlap_2_10_3 ..  x('J2','A3') + x('J10','A3') + theta('J2','J10') + theta('J10','J2') =l= 3;
exec_overlap_2_10_4 ..  x('J2','A4') + x('J10','A4') + theta('J2','J10') + theta('J10','J2') =l= 3;
exec_overlap_2_11_1 ..  x('J2','A1') + x('J11','A1') + theta('J2','J11') + theta('J11','J2') =l= 3;
exec_overlap_2_11_2 ..  x('J2','A2') + x('J11','A2') + theta('J2','J11') + theta('J11','J2') =l= 3;
exec_overlap_2_11_3 ..  x('J2','A3') + x('J11','A3') + theta('J2','J11') + theta('J11','J2') =l= 3;
exec_overlap_2_11_4 ..  x('J2','A4') + x('J11','A4') + theta('J2','J11') + theta('J11','J2') =l= 3;
exec_overlap_2_12_1 ..  x('J2','A1') + x('J12','A1') + theta('J2','J12') + theta('J12','J2') =l= 3;
exec_overlap_2_12_2 ..  x('J2','A2') + x('J12','A2') + theta('J2','J12') + theta('J12','J2') =l= 3;
exec_overlap_2_12_3 ..  x('J2','A3') + x('J12','A3') + theta('J2','J12') + theta('J12','J2') =l= 3;
exec_overlap_2_12_4 ..  x('J2','A4') + x('J12','A4') + theta('J2','J12') + theta('J12','J2') =l= 3;
exec_overlap_3_1_1 ..  x('J3','A1') + x('J1','A1') + theta('J3','J1') + theta('J1','J3') =l= 3;
exec_overlap_3_1_2 ..  x('J3','A2') + x('J1','A2') + theta('J3','J1') + theta('J1','J3') =l= 3;
exec_overlap_3_1_3 ..  x('J3','A3') + x('J1','A3') + theta('J3','J1') + theta('J1','J3') =l= 3;
exec_overlap_3_1_4 ..  x('J3','A4') + x('J1','A4') + theta('J3','J1') + theta('J1','J3') =l= 3;
exec_overlap_3_2_1 ..  x('J3','A1') + x('J2','A1') + theta('J3','J2') + theta('J2','J3') =l= 3;
exec_overlap_3_2_2 ..  x('J3','A2') + x('J2','A2') + theta('J3','J2') + theta('J2','J3') =l= 3;
exec_overlap_3_2_3 ..  x('J3','A3') + x('J2','A3') + theta('J3','J2') + theta('J2','J3') =l= 3;
exec_overlap_3_2_4 ..  x('J3','A4') + x('J2','A4') + theta('J3','J2') + theta('J2','J3') =l= 3;
exec_overlap_3_3_1 ..  x('J3','A1') + x('J3','A1') + theta('J3','J3') + theta('J3','J3') =l= 3;
exec_overlap_3_3_2 ..  x('J3','A2') + x('J3','A2') + theta('J3','J3') + theta('J3','J3') =l= 3;
exec_overlap_3_3_3 ..  x('J3','A3') + x('J3','A3') + theta('J3','J3') + theta('J3','J3') =l= 3;
exec_overlap_3_3_4 ..  x('J3','A4') + x('J3','A4') + theta('J3','J3') + theta('J3','J3') =l= 3;
exec_overlap_3_4_1 ..  x('J3','A1') + x('J4','A1') + theta('J3','J4') + theta('J4','J3') =l= 3;
exec_overlap_3_4_2 ..  x('J3','A2') + x('J4','A2') + theta('J3','J4') + theta('J4','J3') =l= 3;
exec_overlap_3_4_3 ..  x('J3','A3') + x('J4','A3') + theta('J3','J4') + theta('J4','J3') =l= 3;
exec_overlap_3_4_4 ..  x('J3','A4') + x('J4','A4') + theta('J3','J4') + theta('J4','J3') =l= 3;
exec_overlap_3_5_1 ..  x('J3','A1') + x('J5','A1') + theta('J3','J5') + theta('J5','J3') =l= 3;
exec_overlap_3_5_2 ..  x('J3','A2') + x('J5','A2') + theta('J3','J5') + theta('J5','J3') =l= 3;
exec_overlap_3_5_3 ..  x('J3','A3') + x('J5','A3') + theta('J3','J5') + theta('J5','J3') =l= 3;
exec_overlap_3_5_4 ..  x('J3','A4') + x('J5','A4') + theta('J3','J5') + theta('J5','J3') =l= 3;
exec_overlap_3_6_1 ..  x('J3','A1') + x('J6','A1') + theta('J3','J6') + theta('J6','J3') =l= 3;
exec_overlap_3_6_2 ..  x('J3','A2') + x('J6','A2') + theta('J3','J6') + theta('J6','J3') =l= 3;
exec_overlap_3_6_3 ..  x('J3','A3') + x('J6','A3') + theta('J3','J6') + theta('J6','J3') =l= 3;
exec_overlap_3_6_4 ..  x('J3','A4') + x('J6','A4') + theta('J3','J6') + theta('J6','J3') =l= 3;
exec_overlap_3_7_1 ..  x('J3','A1') + x('J7','A1') + theta('J3','J7') + theta('J7','J3') =l= 3;
exec_overlap_3_7_2 ..  x('J3','A2') + x('J7','A2') + theta('J3','J7') + theta('J7','J3') =l= 3;
exec_overlap_3_7_3 ..  x('J3','A3') + x('J7','A3') + theta('J3','J7') + theta('J7','J3') =l= 3;
exec_overlap_3_7_4 ..  x('J3','A4') + x('J7','A4') + theta('J3','J7') + theta('J7','J3') =l= 3;
exec_overlap_3_8_1 ..  x('J3','A1') + x('J8','A1') + theta('J3','J8') + theta('J8','J3') =l= 3;
exec_overlap_3_8_2 ..  x('J3','A2') + x('J8','A2') + theta('J3','J8') + theta('J8','J3') =l= 3;
exec_overlap_3_8_3 ..  x('J3','A3') + x('J8','A3') + theta('J3','J8') + theta('J8','J3') =l= 3;
exec_overlap_3_8_4 ..  x('J3','A4') + x('J8','A4') + theta('J3','J8') + theta('J8','J3') =l= 3;
exec_overlap_3_9_1 ..  x('J3','A1') + x('J9','A1') + theta('J3','J9') + theta('J9','J3') =l= 3;
exec_overlap_3_9_2 ..  x('J3','A2') + x('J9','A2') + theta('J3','J9') + theta('J9','J3') =l= 3;
exec_overlap_3_9_3 ..  x('J3','A3') + x('J9','A3') + theta('J3','J9') + theta('J9','J3') =l= 3;
exec_overlap_3_9_4 ..  x('J3','A4') + x('J9','A4') + theta('J3','J9') + theta('J9','J3') =l= 3;
exec_overlap_3_10_1 ..  x('J3','A1') + x('J10','A1') + theta('J3','J10') + theta('J10','J3') =l= 3;
exec_overlap_3_10_2 ..  x('J3','A2') + x('J10','A2') + theta('J3','J10') + theta('J10','J3') =l= 3;
exec_overlap_3_10_3 ..  x('J3','A3') + x('J10','A3') + theta('J3','J10') + theta('J10','J3') =l= 3;
exec_overlap_3_10_4 ..  x('J3','A4') + x('J10','A4') + theta('J3','J10') + theta('J10','J3') =l= 3;
exec_overlap_3_11_1 ..  x('J3','A1') + x('J11','A1') + theta('J3','J11') + theta('J11','J3') =l= 3;
exec_overlap_3_11_2 ..  x('J3','A2') + x('J11','A2') + theta('J3','J11') + theta('J11','J3') =l= 3;
exec_overlap_3_11_3 ..  x('J3','A3') + x('J11','A3') + theta('J3','J11') + theta('J11','J3') =l= 3;
exec_overlap_3_11_4 ..  x('J3','A4') + x('J11','A4') + theta('J3','J11') + theta('J11','J3') =l= 3;
exec_overlap_3_12_1 ..  x('J3','A1') + x('J12','A1') + theta('J3','J12') + theta('J12','J3') =l= 3;
exec_overlap_3_12_2 ..  x('J3','A2') + x('J12','A2') + theta('J3','J12') + theta('J12','J3') =l= 3;
exec_overlap_3_12_3 ..  x('J3','A3') + x('J12','A3') + theta('J3','J12') + theta('J12','J3') =l= 3;
exec_overlap_3_12_4 ..  x('J3','A4') + x('J12','A4') + theta('J3','J12') + theta('J12','J3') =l= 3;
exec_overlap_4_1_1 ..  x('J4','A1') + x('J1','A1') + theta('J4','J1') + theta('J1','J4') =l= 3;
exec_overlap_4_1_2 ..  x('J4','A2') + x('J1','A2') + theta('J4','J1') + theta('J1','J4') =l= 3;
exec_overlap_4_1_3 ..  x('J4','A3') + x('J1','A3') + theta('J4','J1') + theta('J1','J4') =l= 3;
exec_overlap_4_1_4 ..  x('J4','A4') + x('J1','A4') + theta('J4','J1') + theta('J1','J4') =l= 3;
exec_overlap_4_2_1 ..  x('J4','A1') + x('J2','A1') + theta('J4','J2') + theta('J2','J4') =l= 3;
exec_overlap_4_2_2 ..  x('J4','A2') + x('J2','A2') + theta('J4','J2') + theta('J2','J4') =l= 3;
exec_overlap_4_2_3 ..  x('J4','A3') + x('J2','A3') + theta('J4','J2') + theta('J2','J4') =l= 3;
exec_overlap_4_2_4 ..  x('J4','A4') + x('J2','A4') + theta('J4','J2') + theta('J2','J4') =l= 3;
exec_overlap_4_3_1 ..  x('J4','A1') + x('J3','A1') + theta('J4','J3') + theta('J3','J4') =l= 3;
exec_overlap_4_3_2 ..  x('J4','A2') + x('J3','A2') + theta('J4','J3') + theta('J3','J4') =l= 3;
exec_overlap_4_3_3 ..  x('J4','A3') + x('J3','A3') + theta('J4','J3') + theta('J3','J4') =l= 3;
exec_overlap_4_3_4 ..  x('J4','A4') + x('J3','A4') + theta('J4','J3') + theta('J3','J4') =l= 3;
exec_overlap_4_4_1 ..  x('J4','A1') + x('J4','A1') + theta('J4','J4') + theta('J4','J4') =l= 3;
exec_overlap_4_4_2 ..  x('J4','A2') + x('J4','A2') + theta('J4','J4') + theta('J4','J4') =l= 3;
exec_overlap_4_4_3 ..  x('J4','A3') + x('J4','A3') + theta('J4','J4') + theta('J4','J4') =l= 3;
exec_overlap_4_4_4 ..  x('J4','A4') + x('J4','A4') + theta('J4','J4') + theta('J4','J4') =l= 3;
exec_overlap_4_5_1 ..  x('J4','A1') + x('J5','A1') + theta('J4','J5') + theta('J5','J4') =l= 3;
exec_overlap_4_5_2 ..  x('J4','A2') + x('J5','A2') + theta('J4','J5') + theta('J5','J4') =l= 3;
exec_overlap_4_5_3 ..  x('J4','A3') + x('J5','A3') + theta('J4','J5') + theta('J5','J4') =l= 3;
exec_overlap_4_5_4 ..  x('J4','A4') + x('J5','A4') + theta('J4','J5') + theta('J5','J4') =l= 3;
exec_overlap_4_6_1 ..  x('J4','A1') + x('J6','A1') + theta('J4','J6') + theta('J6','J4') =l= 3;
exec_overlap_4_6_2 ..  x('J4','A2') + x('J6','A2') + theta('J4','J6') + theta('J6','J4') =l= 3;
exec_overlap_4_6_3 ..  x('J4','A3') + x('J6','A3') + theta('J4','J6') + theta('J6','J4') =l= 3;
exec_overlap_4_6_4 ..  x('J4','A4') + x('J6','A4') + theta('J4','J6') + theta('J6','J4') =l= 3;
exec_overlap_4_7_1 ..  x('J4','A1') + x('J7','A1') + theta('J4','J7') + theta('J7','J4') =l= 3;
exec_overlap_4_7_2 ..  x('J4','A2') + x('J7','A2') + theta('J4','J7') + theta('J7','J4') =l= 3;
exec_overlap_4_7_3 ..  x('J4','A3') + x('J7','A3') + theta('J4','J7') + theta('J7','J4') =l= 3;
exec_overlap_4_7_4 ..  x('J4','A4') + x('J7','A4') + theta('J4','J7') + theta('J7','J4') =l= 3;
exec_overlap_4_8_1 ..  x('J4','A1') + x('J8','A1') + theta('J4','J8') + theta('J8','J4') =l= 3;
exec_overlap_4_8_2 ..  x('J4','A2') + x('J8','A2') + theta('J4','J8') + theta('J8','J4') =l= 3;
exec_overlap_4_8_3 ..  x('J4','A3') + x('J8','A3') + theta('J4','J8') + theta('J8','J4') =l= 3;
exec_overlap_4_8_4 ..  x('J4','A4') + x('J8','A4') + theta('J4','J8') + theta('J8','J4') =l= 3;
exec_overlap_4_9_1 ..  x('J4','A1') + x('J9','A1') + theta('J4','J9') + theta('J9','J4') =l= 3;
exec_overlap_4_9_2 ..  x('J4','A2') + x('J9','A2') + theta('J4','J9') + theta('J9','J4') =l= 3;
exec_overlap_4_9_3 ..  x('J4','A3') + x('J9','A3') + theta('J4','J9') + theta('J9','J4') =l= 3;
exec_overlap_4_9_4 ..  x('J4','A4') + x('J9','A4') + theta('J4','J9') + theta('J9','J4') =l= 3;
exec_overlap_4_10_1 ..  x('J4','A1') + x('J10','A1') + theta('J4','J10') + theta('J10','J4') =l= 3;
exec_overlap_4_10_2 ..  x('J4','A2') + x('J10','A2') + theta('J4','J10') + theta('J10','J4') =l= 3;
exec_overlap_4_10_3 ..  x('J4','A3') + x('J10','A3') + theta('J4','J10') + theta('J10','J4') =l= 3;
exec_overlap_4_10_4 ..  x('J4','A4') + x('J10','A4') + theta('J4','J10') + theta('J10','J4') =l= 3;
exec_overlap_4_11_1 ..  x('J4','A1') + x('J11','A1') + theta('J4','J11') + theta('J11','J4') =l= 3;
exec_overlap_4_11_2 ..  x('J4','A2') + x('J11','A2') + theta('J4','J11') + theta('J11','J4') =l= 3;
exec_overlap_4_11_3 ..  x('J4','A3') + x('J11','A3') + theta('J4','J11') + theta('J11','J4') =l= 3;
exec_overlap_4_11_4 ..  x('J4','A4') + x('J11','A4') + theta('J4','J11') + theta('J11','J4') =l= 3;
exec_overlap_4_12_1 ..  x('J4','A1') + x('J12','A1') + theta('J4','J12') + theta('J12','J4') =l= 3;
exec_overlap_4_12_2 ..  x('J4','A2') + x('J12','A2') + theta('J4','J12') + theta('J12','J4') =l= 3;
exec_overlap_4_12_3 ..  x('J4','A3') + x('J12','A3') + theta('J4','J12') + theta('J12','J4') =l= 3;
exec_overlap_4_12_4 ..  x('J4','A4') + x('J12','A4') + theta('J4','J12') + theta('J12','J4') =l= 3;
exec_overlap_5_1_1 ..  x('J5','A1') + x('J1','A1') + theta('J5','J1') + theta('J1','J5') =l= 3;
exec_overlap_5_1_2 ..  x('J5','A2') + x('J1','A2') + theta('J5','J1') + theta('J1','J5') =l= 3;
exec_overlap_5_1_3 ..  x('J5','A3') + x('J1','A3') + theta('J5','J1') + theta('J1','J5') =l= 3;
exec_overlap_5_1_4 ..  x('J5','A4') + x('J1','A4') + theta('J5','J1') + theta('J1','J5') =l= 3;
exec_overlap_5_2_1 ..  x('J5','A1') + x('J2','A1') + theta('J5','J2') + theta('J2','J5') =l= 3;
exec_overlap_5_2_2 ..  x('J5','A2') + x('J2','A2') + theta('J5','J2') + theta('J2','J5') =l= 3;
exec_overlap_5_2_3 ..  x('J5','A3') + x('J2','A3') + theta('J5','J2') + theta('J2','J5') =l= 3;
exec_overlap_5_2_4 ..  x('J5','A4') + x('J2','A4') + theta('J5','J2') + theta('J2','J5') =l= 3;
exec_overlap_5_3_1 ..  x('J5','A1') + x('J3','A1') + theta('J5','J3') + theta('J3','J5') =l= 3;
exec_overlap_5_3_2 ..  x('J5','A2') + x('J3','A2') + theta('J5','J3') + theta('J3','J5') =l= 3;
exec_overlap_5_3_3 ..  x('J5','A3') + x('J3','A3') + theta('J5','J3') + theta('J3','J5') =l= 3;
exec_overlap_5_3_4 ..  x('J5','A4') + x('J3','A4') + theta('J5','J3') + theta('J3','J5') =l= 3;
exec_overlap_5_4_1 ..  x('J5','A1') + x('J4','A1') + theta('J5','J4') + theta('J4','J5') =l= 3;
exec_overlap_5_4_2 ..  x('J5','A2') + x('J4','A2') + theta('J5','J4') + theta('J4','J5') =l= 3;
exec_overlap_5_4_3 ..  x('J5','A3') + x('J4','A3') + theta('J5','J4') + theta('J4','J5') =l= 3;
exec_overlap_5_4_4 ..  x('J5','A4') + x('J4','A4') + theta('J5','J4') + theta('J4','J5') =l= 3;
exec_overlap_5_5_1 ..  x('J5','A1') + x('J5','A1') + theta('J5','J5') + theta('J5','J5') =l= 3;
exec_overlap_5_5_2 ..  x('J5','A2') + x('J5','A2') + theta('J5','J5') + theta('J5','J5') =l= 3;
exec_overlap_5_5_3 ..  x('J5','A3') + x('J5','A3') + theta('J5','J5') + theta('J5','J5') =l= 3;
exec_overlap_5_5_4 ..  x('J5','A4') + x('J5','A4') + theta('J5','J5') + theta('J5','J5') =l= 3;
exec_overlap_5_6_1 ..  x('J5','A1') + x('J6','A1') + theta('J5','J6') + theta('J6','J5') =l= 3;
exec_overlap_5_6_2 ..  x('J5','A2') + x('J6','A2') + theta('J5','J6') + theta('J6','J5') =l= 3;
exec_overlap_5_6_3 ..  x('J5','A3') + x('J6','A3') + theta('J5','J6') + theta('J6','J5') =l= 3;
exec_overlap_5_6_4 ..  x('J5','A4') + x('J6','A4') + theta('J5','J6') + theta('J6','J5') =l= 3;
exec_overlap_5_7_1 ..  x('J5','A1') + x('J7','A1') + theta('J5','J7') + theta('J7','J5') =l= 3;
exec_overlap_5_7_2 ..  x('J5','A2') + x('J7','A2') + theta('J5','J7') + theta('J7','J5') =l= 3;
exec_overlap_5_7_3 ..  x('J5','A3') + x('J7','A3') + theta('J5','J7') + theta('J7','J5') =l= 3;
exec_overlap_5_7_4 ..  x('J5','A4') + x('J7','A4') + theta('J5','J7') + theta('J7','J5') =l= 3;
exec_overlap_5_8_1 ..  x('J5','A1') + x('J8','A1') + theta('J5','J8') + theta('J8','J5') =l= 3;
exec_overlap_5_8_2 ..  x('J5','A2') + x('J8','A2') + theta('J5','J8') + theta('J8','J5') =l= 3;
exec_overlap_5_8_3 ..  x('J5','A3') + x('J8','A3') + theta('J5','J8') + theta('J8','J5') =l= 3;
exec_overlap_5_8_4 ..  x('J5','A4') + x('J8','A4') + theta('J5','J8') + theta('J8','J5') =l= 3;
exec_overlap_5_9_1 ..  x('J5','A1') + x('J9','A1') + theta('J5','J9') + theta('J9','J5') =l= 3;
exec_overlap_5_9_2 ..  x('J5','A2') + x('J9','A2') + theta('J5','J9') + theta('J9','J5') =l= 3;
exec_overlap_5_9_3 ..  x('J5','A3') + x('J9','A3') + theta('J5','J9') + theta('J9','J5') =l= 3;
exec_overlap_5_9_4 ..  x('J5','A4') + x('J9','A4') + theta('J5','J9') + theta('J9','J5') =l= 3;
exec_overlap_5_10_1 ..  x('J5','A1') + x('J10','A1') + theta('J5','J10') + theta('J10','J5') =l= 3;
exec_overlap_5_10_2 ..  x('J5','A2') + x('J10','A2') + theta('J5','J10') + theta('J10','J5') =l= 3;
exec_overlap_5_10_3 ..  x('J5','A3') + x('J10','A3') + theta('J5','J10') + theta('J10','J5') =l= 3;
exec_overlap_5_10_4 ..  x('J5','A4') + x('J10','A4') + theta('J5','J10') + theta('J10','J5') =l= 3;
exec_overlap_5_11_1 ..  x('J5','A1') + x('J11','A1') + theta('J5','J11') + theta('J11','J5') =l= 3;
exec_overlap_5_11_2 ..  x('J5','A2') + x('J11','A2') + theta('J5','J11') + theta('J11','J5') =l= 3;
exec_overlap_5_11_3 ..  x('J5','A3') + x('J11','A3') + theta('J5','J11') + theta('J11','J5') =l= 3;
exec_overlap_5_11_4 ..  x('J5','A4') + x('J11','A4') + theta('J5','J11') + theta('J11','J5') =l= 3;
exec_overlap_5_12_1 ..  x('J5','A1') + x('J12','A1') + theta('J5','J12') + theta('J12','J5') =l= 3;
exec_overlap_5_12_2 ..  x('J5','A2') + x('J12','A2') + theta('J5','J12') + theta('J12','J5') =l= 3;
exec_overlap_5_12_3 ..  x('J5','A3') + x('J12','A3') + theta('J5','J12') + theta('J12','J5') =l= 3;
exec_overlap_5_12_4 ..  x('J5','A4') + x('J12','A4') + theta('J5','J12') + theta('J12','J5') =l= 3;
exec_overlap_6_1_1 ..  x('J6','A1') + x('J1','A1') + theta('J6','J1') + theta('J1','J6') =l= 3;
exec_overlap_6_1_2 ..  x('J6','A2') + x('J1','A2') + theta('J6','J1') + theta('J1','J6') =l= 3;
exec_overlap_6_1_3 ..  x('J6','A3') + x('J1','A3') + theta('J6','J1') + theta('J1','J6') =l= 3;
exec_overlap_6_1_4 ..  x('J6','A4') + x('J1','A4') + theta('J6','J1') + theta('J1','J6') =l= 3;
exec_overlap_6_2_1 ..  x('J6','A1') + x('J2','A1') + theta('J6','J2') + theta('J2','J6') =l= 3;
exec_overlap_6_2_2 ..  x('J6','A2') + x('J2','A2') + theta('J6','J2') + theta('J2','J6') =l= 3;
exec_overlap_6_2_3 ..  x('J6','A3') + x('J2','A3') + theta('J6','J2') + theta('J2','J6') =l= 3;
exec_overlap_6_2_4 ..  x('J6','A4') + x('J2','A4') + theta('J6','J2') + theta('J2','J6') =l= 3;
exec_overlap_6_3_1 ..  x('J6','A1') + x('J3','A1') + theta('J6','J3') + theta('J3','J6') =l= 3;
exec_overlap_6_3_2 ..  x('J6','A2') + x('J3','A2') + theta('J6','J3') + theta('J3','J6') =l= 3;
exec_overlap_6_3_3 ..  x('J6','A3') + x('J3','A3') + theta('J6','J3') + theta('J3','J6') =l= 3;
exec_overlap_6_3_4 ..  x('J6','A4') + x('J3','A4') + theta('J6','J3') + theta('J3','J6') =l= 3;
exec_overlap_6_4_1 ..  x('J6','A1') + x('J4','A1') + theta('J6','J4') + theta('J4','J6') =l= 3;
exec_overlap_6_4_2 ..  x('J6','A2') + x('J4','A2') + theta('J6','J4') + theta('J4','J6') =l= 3;
exec_overlap_6_4_3 ..  x('J6','A3') + x('J4','A3') + theta('J6','J4') + theta('J4','J6') =l= 3;
exec_overlap_6_4_4 ..  x('J6','A4') + x('J4','A4') + theta('J6','J4') + theta('J4','J6') =l= 3;
exec_overlap_6_5_1 ..  x('J6','A1') + x('J5','A1') + theta('J6','J5') + theta('J5','J6') =l= 3;
exec_overlap_6_5_2 ..  x('J6','A2') + x('J5','A2') + theta('J6','J5') + theta('J5','J6') =l= 3;
exec_overlap_6_5_3 ..  x('J6','A3') + x('J5','A3') + theta('J6','J5') + theta('J5','J6') =l= 3;
exec_overlap_6_5_4 ..  x('J6','A4') + x('J5','A4') + theta('J6','J5') + theta('J5','J6') =l= 3;
exec_overlap_6_6_1 ..  x('J6','A1') + x('J6','A1') + theta('J6','J6') + theta('J6','J6') =l= 3;
exec_overlap_6_6_2 ..  x('J6','A2') + x('J6','A2') + theta('J6','J6') + theta('J6','J6') =l= 3;
exec_overlap_6_6_3 ..  x('J6','A3') + x('J6','A3') + theta('J6','J6') + theta('J6','J6') =l= 3;
exec_overlap_6_6_4 ..  x('J6','A4') + x('J6','A4') + theta('J6','J6') + theta('J6','J6') =l= 3;
exec_overlap_6_7_1 ..  x('J6','A1') + x('J7','A1') + theta('J6','J7') + theta('J7','J6') =l= 3;
exec_overlap_6_7_2 ..  x('J6','A2') + x('J7','A2') + theta('J6','J7') + theta('J7','J6') =l= 3;
exec_overlap_6_7_3 ..  x('J6','A3') + x('J7','A3') + theta('J6','J7') + theta('J7','J6') =l= 3;
exec_overlap_6_7_4 ..  x('J6','A4') + x('J7','A4') + theta('J6','J7') + theta('J7','J6') =l= 3;
exec_overlap_6_8_1 ..  x('J6','A1') + x('J8','A1') + theta('J6','J8') + theta('J8','J6') =l= 3;
exec_overlap_6_8_2 ..  x('J6','A2') + x('J8','A2') + theta('J6','J8') + theta('J8','J6') =l= 3;
exec_overlap_6_8_3 ..  x('J6','A3') + x('J8','A3') + theta('J6','J8') + theta('J8','J6') =l= 3;
exec_overlap_6_8_4 ..  x('J6','A4') + x('J8','A4') + theta('J6','J8') + theta('J8','J6') =l= 3;
exec_overlap_6_9_1 ..  x('J6','A1') + x('J9','A1') + theta('J6','J9') + theta('J9','J6') =l= 3;
exec_overlap_6_9_2 ..  x('J6','A2') + x('J9','A2') + theta('J6','J9') + theta('J9','J6') =l= 3;
exec_overlap_6_9_3 ..  x('J6','A3') + x('J9','A3') + theta('J6','J9') + theta('J9','J6') =l= 3;
exec_overlap_6_9_4 ..  x('J6','A4') + x('J9','A4') + theta('J6','J9') + theta('J9','J6') =l= 3;
exec_overlap_6_10_1 ..  x('J6','A1') + x('J10','A1') + theta('J6','J10') + theta('J10','J6') =l= 3;
exec_overlap_6_10_2 ..  x('J6','A2') + x('J10','A2') + theta('J6','J10') + theta('J10','J6') =l= 3;
exec_overlap_6_10_3 ..  x('J6','A3') + x('J10','A3') + theta('J6','J10') + theta('J10','J6') =l= 3;
exec_overlap_6_10_4 ..  x('J6','A4') + x('J10','A4') + theta('J6','J10') + theta('J10','J6') =l= 3;
exec_overlap_6_11_1 ..  x('J6','A1') + x('J11','A1') + theta('J6','J11') + theta('J11','J6') =l= 3;
exec_overlap_6_11_2 ..  x('J6','A2') + x('J11','A2') + theta('J6','J11') + theta('J11','J6') =l= 3;
exec_overlap_6_11_3 ..  x('J6','A3') + x('J11','A3') + theta('J6','J11') + theta('J11','J6') =l= 3;
exec_overlap_6_11_4 ..  x('J6','A4') + x('J11','A4') + theta('J6','J11') + theta('J11','J6') =l= 3;
exec_overlap_6_12_1 ..  x('J6','A1') + x('J12','A1') + theta('J6','J12') + theta('J12','J6') =l= 3;
exec_overlap_6_12_2 ..  x('J6','A2') + x('J12','A2') + theta('J6','J12') + theta('J12','J6') =l= 3;
exec_overlap_6_12_3 ..  x('J6','A3') + x('J12','A3') + theta('J6','J12') + theta('J12','J6') =l= 3;
exec_overlap_6_12_4 ..  x('J6','A4') + x('J12','A4') + theta('J6','J12') + theta('J12','J6') =l= 3;
exec_overlap_7_1_1 ..  x('J7','A1') + x('J1','A1') + theta('J7','J1') + theta('J1','J7') =l= 3;
exec_overlap_7_1_2 ..  x('J7','A2') + x('J1','A2') + theta('J7','J1') + theta('J1','J7') =l= 3;
exec_overlap_7_1_3 ..  x('J7','A3') + x('J1','A3') + theta('J7','J1') + theta('J1','J7') =l= 3;
exec_overlap_7_1_4 ..  x('J7','A4') + x('J1','A4') + theta('J7','J1') + theta('J1','J7') =l= 3;
exec_overlap_7_2_1 ..  x('J7','A1') + x('J2','A1') + theta('J7','J2') + theta('J2','J7') =l= 3;
exec_overlap_7_2_2 ..  x('J7','A2') + x('J2','A2') + theta('J7','J2') + theta('J2','J7') =l= 3;
exec_overlap_7_2_3 ..  x('J7','A3') + x('J2','A3') + theta('J7','J2') + theta('J2','J7') =l= 3;
exec_overlap_7_2_4 ..  x('J7','A4') + x('J2','A4') + theta('J7','J2') + theta('J2','J7') =l= 3;
exec_overlap_7_3_1 ..  x('J7','A1') + x('J3','A1') + theta('J7','J3') + theta('J3','J7') =l= 3;
exec_overlap_7_3_2 ..  x('J7','A2') + x('J3','A2') + theta('J7','J3') + theta('J3','J7') =l= 3;
exec_overlap_7_3_3 ..  x('J7','A3') + x('J3','A3') + theta('J7','J3') + theta('J3','J7') =l= 3;
exec_overlap_7_3_4 ..  x('J7','A4') + x('J3','A4') + theta('J7','J3') + theta('J3','J7') =l= 3;
exec_overlap_7_4_1 ..  x('J7','A1') + x('J4','A1') + theta('J7','J4') + theta('J4','J7') =l= 3;
exec_overlap_7_4_2 ..  x('J7','A2') + x('J4','A2') + theta('J7','J4') + theta('J4','J7') =l= 3;
exec_overlap_7_4_3 ..  x('J7','A3') + x('J4','A3') + theta('J7','J4') + theta('J4','J7') =l= 3;
exec_overlap_7_4_4 ..  x('J7','A4') + x('J4','A4') + theta('J7','J4') + theta('J4','J7') =l= 3;
exec_overlap_7_5_1 ..  x('J7','A1') + x('J5','A1') + theta('J7','J5') + theta('J5','J7') =l= 3;
exec_overlap_7_5_2 ..  x('J7','A2') + x('J5','A2') + theta('J7','J5') + theta('J5','J7') =l= 3;
exec_overlap_7_5_3 ..  x('J7','A3') + x('J5','A3') + theta('J7','J5') + theta('J5','J7') =l= 3;
exec_overlap_7_5_4 ..  x('J7','A4') + x('J5','A4') + theta('J7','J5') + theta('J5','J7') =l= 3;
exec_overlap_7_6_1 ..  x('J7','A1') + x('J6','A1') + theta('J7','J6') + theta('J6','J7') =l= 3;
exec_overlap_7_6_2 ..  x('J7','A2') + x('J6','A2') + theta('J7','J6') + theta('J6','J7') =l= 3;
exec_overlap_7_6_3 ..  x('J7','A3') + x('J6','A3') + theta('J7','J6') + theta('J6','J7') =l= 3;
exec_overlap_7_6_4 ..  x('J7','A4') + x('J6','A4') + theta('J7','J6') + theta('J6','J7') =l= 3;
exec_overlap_7_7_1 ..  x('J7','A1') + x('J7','A1') + theta('J7','J7') + theta('J7','J7') =l= 3;
exec_overlap_7_7_2 ..  x('J7','A2') + x('J7','A2') + theta('J7','J7') + theta('J7','J7') =l= 3;
exec_overlap_7_7_3 ..  x('J7','A3') + x('J7','A3') + theta('J7','J7') + theta('J7','J7') =l= 3;
exec_overlap_7_7_4 ..  x('J7','A4') + x('J7','A4') + theta('J7','J7') + theta('J7','J7') =l= 3;
exec_overlap_7_8_1 ..  x('J7','A1') + x('J8','A1') + theta('J7','J8') + theta('J8','J7') =l= 3;
exec_overlap_7_8_2 ..  x('J7','A2') + x('J8','A2') + theta('J7','J8') + theta('J8','J7') =l= 3;
exec_overlap_7_8_3 ..  x('J7','A3') + x('J8','A3') + theta('J7','J8') + theta('J8','J7') =l= 3;
exec_overlap_7_8_4 ..  x('J7','A4') + x('J8','A4') + theta('J7','J8') + theta('J8','J7') =l= 3;
exec_overlap_7_9_1 ..  x('J7','A1') + x('J9','A1') + theta('J7','J9') + theta('J9','J7') =l= 3;
exec_overlap_7_9_2 ..  x('J7','A2') + x('J9','A2') + theta('J7','J9') + theta('J9','J7') =l= 3;
exec_overlap_7_9_3 ..  x('J7','A3') + x('J9','A3') + theta('J7','J9') + theta('J9','J7') =l= 3;
exec_overlap_7_9_4 ..  x('J7','A4') + x('J9','A4') + theta('J7','J9') + theta('J9','J7') =l= 3;
exec_overlap_7_10_1 ..  x('J7','A1') + x('J10','A1') + theta('J7','J10') + theta('J10','J7') =l= 3;
exec_overlap_7_10_2 ..  x('J7','A2') + x('J10','A2') + theta('J7','J10') + theta('J10','J7') =l= 3;
exec_overlap_7_10_3 ..  x('J7','A3') + x('J10','A3') + theta('J7','J10') + theta('J10','J7') =l= 3;
exec_overlap_7_10_4 ..  x('J7','A4') + x('J10','A4') + theta('J7','J10') + theta('J10','J7') =l= 3;
exec_overlap_7_11_1 ..  x('J7','A1') + x('J11','A1') + theta('J7','J11') + theta('J11','J7') =l= 3;
exec_overlap_7_11_2 ..  x('J7','A2') + x('J11','A2') + theta('J7','J11') + theta('J11','J7') =l= 3;
exec_overlap_7_11_3 ..  x('J7','A3') + x('J11','A3') + theta('J7','J11') + theta('J11','J7') =l= 3;
exec_overlap_7_11_4 ..  x('J7','A4') + x('J11','A4') + theta('J7','J11') + theta('J11','J7') =l= 3;
exec_overlap_7_12_1 ..  x('J7','A1') + x('J12','A1') + theta('J7','J12') + theta('J12','J7') =l= 3;
exec_overlap_7_12_2 ..  x('J7','A2') + x('J12','A2') + theta('J7','J12') + theta('J12','J7') =l= 3;
exec_overlap_7_12_3 ..  x('J7','A3') + x('J12','A3') + theta('J7','J12') + theta('J12','J7') =l= 3;
exec_overlap_7_12_4 ..  x('J7','A4') + x('J12','A4') + theta('J7','J12') + theta('J12','J7') =l= 3;
exec_overlap_8_1_1 ..  x('J8','A1') + x('J1','A1') + theta('J8','J1') + theta('J1','J8') =l= 3;
exec_overlap_8_1_2 ..  x('J8','A2') + x('J1','A2') + theta('J8','J1') + theta('J1','J8') =l= 3;
exec_overlap_8_1_3 ..  x('J8','A3') + x('J1','A3') + theta('J8','J1') + theta('J1','J8') =l= 3;
exec_overlap_8_1_4 ..  x('J8','A4') + x('J1','A4') + theta('J8','J1') + theta('J1','J8') =l= 3;
exec_overlap_8_2_1 ..  x('J8','A1') + x('J2','A1') + theta('J8','J2') + theta('J2','J8') =l= 3;
exec_overlap_8_2_2 ..  x('J8','A2') + x('J2','A2') + theta('J8','J2') + theta('J2','J8') =l= 3;
exec_overlap_8_2_3 ..  x('J8','A3') + x('J2','A3') + theta('J8','J2') + theta('J2','J8') =l= 3;
exec_overlap_8_2_4 ..  x('J8','A4') + x('J2','A4') + theta('J8','J2') + theta('J2','J8') =l= 3;
exec_overlap_8_3_1 ..  x('J8','A1') + x('J3','A1') + theta('J8','J3') + theta('J3','J8') =l= 3;
exec_overlap_8_3_2 ..  x('J8','A2') + x('J3','A2') + theta('J8','J3') + theta('J3','J8') =l= 3;
exec_overlap_8_3_3 ..  x('J8','A3') + x('J3','A3') + theta('J8','J3') + theta('J3','J8') =l= 3;
exec_overlap_8_3_4 ..  x('J8','A4') + x('J3','A4') + theta('J8','J3') + theta('J3','J8') =l= 3;
exec_overlap_8_4_1 ..  x('J8','A1') + x('J4','A1') + theta('J8','J4') + theta('J4','J8') =l= 3;
exec_overlap_8_4_2 ..  x('J8','A2') + x('J4','A2') + theta('J8','J4') + theta('J4','J8') =l= 3;
exec_overlap_8_4_3 ..  x('J8','A3') + x('J4','A3') + theta('J8','J4') + theta('J4','J8') =l= 3;
exec_overlap_8_4_4 ..  x('J8','A4') + x('J4','A4') + theta('J8','J4') + theta('J4','J8') =l= 3;
exec_overlap_8_5_1 ..  x('J8','A1') + x('J5','A1') + theta('J8','J5') + theta('J5','J8') =l= 3;
exec_overlap_8_5_2 ..  x('J8','A2') + x('J5','A2') + theta('J8','J5') + theta('J5','J8') =l= 3;
exec_overlap_8_5_3 ..  x('J8','A3') + x('J5','A3') + theta('J8','J5') + theta('J5','J8') =l= 3;
exec_overlap_8_5_4 ..  x('J8','A4') + x('J5','A4') + theta('J8','J5') + theta('J5','J8') =l= 3;
exec_overlap_8_6_1 ..  x('J8','A1') + x('J6','A1') + theta('J8','J6') + theta('J6','J8') =l= 3;
exec_overlap_8_6_2 ..  x('J8','A2') + x('J6','A2') + theta('J8','J6') + theta('J6','J8') =l= 3;
exec_overlap_8_6_3 ..  x('J8','A3') + x('J6','A3') + theta('J8','J6') + theta('J6','J8') =l= 3;
exec_overlap_8_6_4 ..  x('J8','A4') + x('J6','A4') + theta('J8','J6') + theta('J6','J8') =l= 3;
exec_overlap_8_7_1 ..  x('J8','A1') + x('J7','A1') + theta('J8','J7') + theta('J7','J8') =l= 3;
exec_overlap_8_7_2 ..  x('J8','A2') + x('J7','A2') + theta('J8','J7') + theta('J7','J8') =l= 3;
exec_overlap_8_7_3 ..  x('J8','A3') + x('J7','A3') + theta('J8','J7') + theta('J7','J8') =l= 3;
exec_overlap_8_7_4 ..  x('J8','A4') + x('J7','A4') + theta('J8','J7') + theta('J7','J8') =l= 3;
exec_overlap_8_8_1 ..  x('J8','A1') + x('J8','A1') + theta('J8','J8') + theta('J8','J8') =l= 3;
exec_overlap_8_8_2 ..  x('J8','A2') + x('J8','A2') + theta('J8','J8') + theta('J8','J8') =l= 3;
exec_overlap_8_8_3 ..  x('J8','A3') + x('J8','A3') + theta('J8','J8') + theta('J8','J8') =l= 3;
exec_overlap_8_8_4 ..  x('J8','A4') + x('J8','A4') + theta('J8','J8') + theta('J8','J8') =l= 3;
exec_overlap_8_9_1 ..  x('J8','A1') + x('J9','A1') + theta('J8','J9') + theta('J9','J8') =l= 3;
exec_overlap_8_9_2 ..  x('J8','A2') + x('J9','A2') + theta('J8','J9') + theta('J9','J8') =l= 3;
exec_overlap_8_9_3 ..  x('J8','A3') + x('J9','A3') + theta('J8','J9') + theta('J9','J8') =l= 3;
exec_overlap_8_9_4 ..  x('J8','A4') + x('J9','A4') + theta('J8','J9') + theta('J9','J8') =l= 3;
exec_overlap_8_10_1 ..  x('J8','A1') + x('J10','A1') + theta('J8','J10') + theta('J10','J8') =l= 3;
exec_overlap_8_10_2 ..  x('J8','A2') + x('J10','A2') + theta('J8','J10') + theta('J10','J8') =l= 3;
exec_overlap_8_10_3 ..  x('J8','A3') + x('J10','A3') + theta('J8','J10') + theta('J10','J8') =l= 3;
exec_overlap_8_10_4 ..  x('J8','A4') + x('J10','A4') + theta('J8','J10') + theta('J10','J8') =l= 3;
exec_overlap_8_11_1 ..  x('J8','A1') + x('J11','A1') + theta('J8','J11') + theta('J11','J8') =l= 3;
exec_overlap_8_11_2 ..  x('J8','A2') + x('J11','A2') + theta('J8','J11') + theta('J11','J8') =l= 3;
exec_overlap_8_11_3 ..  x('J8','A3') + x('J11','A3') + theta('J8','J11') + theta('J11','J8') =l= 3;
exec_overlap_8_11_4 ..  x('J8','A4') + x('J11','A4') + theta('J8','J11') + theta('J11','J8') =l= 3;
exec_overlap_8_12_1 ..  x('J8','A1') + x('J12','A1') + theta('J8','J12') + theta('J12','J8') =l= 3;
exec_overlap_8_12_2 ..  x('J8','A2') + x('J12','A2') + theta('J8','J12') + theta('J12','J8') =l= 3;
exec_overlap_8_12_3 ..  x('J8','A3') + x('J12','A3') + theta('J8','J12') + theta('J12','J8') =l= 3;
exec_overlap_8_12_4 ..  x('J8','A4') + x('J12','A4') + theta('J8','J12') + theta('J12','J8') =l= 3;
exec_overlap_9_1_1 ..  x('J9','A1') + x('J1','A1') + theta('J9','J1') + theta('J1','J9') =l= 3;
exec_overlap_9_1_2 ..  x('J9','A2') + x('J1','A2') + theta('J9','J1') + theta('J1','J9') =l= 3;
exec_overlap_9_1_3 ..  x('J9','A3') + x('J1','A3') + theta('J9','J1') + theta('J1','J9') =l= 3;
exec_overlap_9_1_4 ..  x('J9','A4') + x('J1','A4') + theta('J9','J1') + theta('J1','J9') =l= 3;
exec_overlap_9_2_1 ..  x('J9','A1') + x('J2','A1') + theta('J9','J2') + theta('J2','J9') =l= 3;
exec_overlap_9_2_2 ..  x('J9','A2') + x('J2','A2') + theta('J9','J2') + theta('J2','J9') =l= 3;
exec_overlap_9_2_3 ..  x('J9','A3') + x('J2','A3') + theta('J9','J2') + theta('J2','J9') =l= 3;
exec_overlap_9_2_4 ..  x('J9','A4') + x('J2','A4') + theta('J9','J2') + theta('J2','J9') =l= 3;
exec_overlap_9_3_1 ..  x('J9','A1') + x('J3','A1') + theta('J9','J3') + theta('J3','J9') =l= 3;
exec_overlap_9_3_2 ..  x('J9','A2') + x('J3','A2') + theta('J9','J3') + theta('J3','J9') =l= 3;
exec_overlap_9_3_3 ..  x('J9','A3') + x('J3','A3') + theta('J9','J3') + theta('J3','J9') =l= 3;
exec_overlap_9_3_4 ..  x('J9','A4') + x('J3','A4') + theta('J9','J3') + theta('J3','J9') =l= 3;
exec_overlap_9_4_1 ..  x('J9','A1') + x('J4','A1') + theta('J9','J4') + theta('J4','J9') =l= 3;
exec_overlap_9_4_2 ..  x('J9','A2') + x('J4','A2') + theta('J9','J4') + theta('J4','J9') =l= 3;
exec_overlap_9_4_3 ..  x('J9','A3') + x('J4','A3') + theta('J9','J4') + theta('J4','J9') =l= 3;
exec_overlap_9_4_4 ..  x('J9','A4') + x('J4','A4') + theta('J9','J4') + theta('J4','J9') =l= 3;
exec_overlap_9_5_1 ..  x('J9','A1') + x('J5','A1') + theta('J9','J5') + theta('J5','J9') =l= 3;
exec_overlap_9_5_2 ..  x('J9','A2') + x('J5','A2') + theta('J9','J5') + theta('J5','J9') =l= 3;
exec_overlap_9_5_3 ..  x('J9','A3') + x('J5','A3') + theta('J9','J5') + theta('J5','J9') =l= 3;
exec_overlap_9_5_4 ..  x('J9','A4') + x('J5','A4') + theta('J9','J5') + theta('J5','J9') =l= 3;
exec_overlap_9_6_1 ..  x('J9','A1') + x('J6','A1') + theta('J9','J6') + theta('J6','J9') =l= 3;
exec_overlap_9_6_2 ..  x('J9','A2') + x('J6','A2') + theta('J9','J6') + theta('J6','J9') =l= 3;
exec_overlap_9_6_3 ..  x('J9','A3') + x('J6','A3') + theta('J9','J6') + theta('J6','J9') =l= 3;
exec_overlap_9_6_4 ..  x('J9','A4') + x('J6','A4') + theta('J9','J6') + theta('J6','J9') =l= 3;
exec_overlap_9_7_1 ..  x('J9','A1') + x('J7','A1') + theta('J9','J7') + theta('J7','J9') =l= 3;
exec_overlap_9_7_2 ..  x('J9','A2') + x('J7','A2') + theta('J9','J7') + theta('J7','J9') =l= 3;
exec_overlap_9_7_3 ..  x('J9','A3') + x('J7','A3') + theta('J9','J7') + theta('J7','J9') =l= 3;
exec_overlap_9_7_4 ..  x('J9','A4') + x('J7','A4') + theta('J9','J7') + theta('J7','J9') =l= 3;
exec_overlap_9_8_1 ..  x('J9','A1') + x('J8','A1') + theta('J9','J8') + theta('J8','J9') =l= 3;
exec_overlap_9_8_2 ..  x('J9','A2') + x('J8','A2') + theta('J9','J8') + theta('J8','J9') =l= 3;
exec_overlap_9_8_3 ..  x('J9','A3') + x('J8','A3') + theta('J9','J8') + theta('J8','J9') =l= 3;
exec_overlap_9_8_4 ..  x('J9','A4') + x('J8','A4') + theta('J9','J8') + theta('J8','J9') =l= 3;
exec_overlap_9_9_1 ..  x('J9','A1') + x('J9','A1') + theta('J9','J9') + theta('J9','J9') =l= 3;
exec_overlap_9_9_2 ..  x('J9','A2') + x('J9','A2') + theta('J9','J9') + theta('J9','J9') =l= 3;
exec_overlap_9_9_3 ..  x('J9','A3') + x('J9','A3') + theta('J9','J9') + theta('J9','J9') =l= 3;
exec_overlap_9_9_4 ..  x('J9','A4') + x('J9','A4') + theta('J9','J9') + theta('J9','J9') =l= 3;
exec_overlap_9_10_1 ..  x('J9','A1') + x('J10','A1') + theta('J9','J10') + theta('J10','J9') =l= 3;
exec_overlap_9_10_2 ..  x('J9','A2') + x('J10','A2') + theta('J9','J10') + theta('J10','J9') =l= 3;
exec_overlap_9_10_3 ..  x('J9','A3') + x('J10','A3') + theta('J9','J10') + theta('J10','J9') =l= 3;
exec_overlap_9_10_4 ..  x('J9','A4') + x('J10','A4') + theta('J9','J10') + theta('J10','J9') =l= 3;
exec_overlap_9_11_1 ..  x('J9','A1') + x('J11','A1') + theta('J9','J11') + theta('J11','J9') =l= 3;
exec_overlap_9_11_2 ..  x('J9','A2') + x('J11','A2') + theta('J9','J11') + theta('J11','J9') =l= 3;
exec_overlap_9_11_3 ..  x('J9','A3') + x('J11','A3') + theta('J9','J11') + theta('J11','J9') =l= 3;
exec_overlap_9_11_4 ..  x('J9','A4') + x('J11','A4') + theta('J9','J11') + theta('J11','J9') =l= 3;
exec_overlap_9_12_1 ..  x('J9','A1') + x('J12','A1') + theta('J9','J12') + theta('J12','J9') =l= 3;
exec_overlap_9_12_2 ..  x('J9','A2') + x('J12','A2') + theta('J9','J12') + theta('J12','J9') =l= 3;
exec_overlap_9_12_3 ..  x('J9','A3') + x('J12','A3') + theta('J9','J12') + theta('J12','J9') =l= 3;
exec_overlap_9_12_4 ..  x('J9','A4') + x('J12','A4') + theta('J9','J12') + theta('J12','J9') =l= 3;
exec_overlap_10_1_1 ..  x('J10','A1') + x('J1','A1') + theta('J10','J1') + theta('J1','J10') =l= 3;
exec_overlap_10_1_2 ..  x('J10','A2') + x('J1','A2') + theta('J10','J1') + theta('J1','J10') =l= 3;
exec_overlap_10_1_3 ..  x('J10','A3') + x('J1','A3') + theta('J10','J1') + theta('J1','J10') =l= 3;
exec_overlap_10_1_4 ..  x('J10','A4') + x('J1','A4') + theta('J10','J1') + theta('J1','J10') =l= 3;
exec_overlap_10_2_1 ..  x('J10','A1') + x('J2','A1') + theta('J10','J2') + theta('J2','J10') =l= 3;
exec_overlap_10_2_2 ..  x('J10','A2') + x('J2','A2') + theta('J10','J2') + theta('J2','J10') =l= 3;
exec_overlap_10_2_3 ..  x('J10','A3') + x('J2','A3') + theta('J10','J2') + theta('J2','J10') =l= 3;
exec_overlap_10_2_4 ..  x('J10','A4') + x('J2','A4') + theta('J10','J2') + theta('J2','J10') =l= 3;
exec_overlap_10_3_1 ..  x('J10','A1') + x('J3','A1') + theta('J10','J3') + theta('J3','J10') =l= 3;
exec_overlap_10_3_2 ..  x('J10','A2') + x('J3','A2') + theta('J10','J3') + theta('J3','J10') =l= 3;
exec_overlap_10_3_3 ..  x('J10','A3') + x('J3','A3') + theta('J10','J3') + theta('J3','J10') =l= 3;
exec_overlap_10_3_4 ..  x('J10','A4') + x('J3','A4') + theta('J10','J3') + theta('J3','J10') =l= 3;
exec_overlap_10_4_1 ..  x('J10','A1') + x('J4','A1') + theta('J10','J4') + theta('J4','J10') =l= 3;
exec_overlap_10_4_2 ..  x('J10','A2') + x('J4','A2') + theta('J10','J4') + theta('J4','J10') =l= 3;
exec_overlap_10_4_3 ..  x('J10','A3') + x('J4','A3') + theta('J10','J4') + theta('J4','J10') =l= 3;
exec_overlap_10_4_4 ..  x('J10','A4') + x('J4','A4') + theta('J10','J4') + theta('J4','J10') =l= 3;
exec_overlap_10_5_1 ..  x('J10','A1') + x('J5','A1') + theta('J10','J5') + theta('J5','J10') =l= 3;
exec_overlap_10_5_2 ..  x('J10','A2') + x('J5','A2') + theta('J10','J5') + theta('J5','J10') =l= 3;
exec_overlap_10_5_3 ..  x('J10','A3') + x('J5','A3') + theta('J10','J5') + theta('J5','J10') =l= 3;
exec_overlap_10_5_4 ..  x('J10','A4') + x('J5','A4') + theta('J10','J5') + theta('J5','J10') =l= 3;
exec_overlap_10_6_1 ..  x('J10','A1') + x('J6','A1') + theta('J10','J6') + theta('J6','J10') =l= 3;
exec_overlap_10_6_2 ..  x('J10','A2') + x('J6','A2') + theta('J10','J6') + theta('J6','J10') =l= 3;
exec_overlap_10_6_3 ..  x('J10','A3') + x('J6','A3') + theta('J10','J6') + theta('J6','J10') =l= 3;
exec_overlap_10_6_4 ..  x('J10','A4') + x('J6','A4') + theta('J10','J6') + theta('J6','J10') =l= 3;
exec_overlap_10_7_1 ..  x('J10','A1') + x('J7','A1') + theta('J10','J7') + theta('J7','J10') =l= 3;
exec_overlap_10_7_2 ..  x('J10','A2') + x('J7','A2') + theta('J10','J7') + theta('J7','J10') =l= 3;
exec_overlap_10_7_3 ..  x('J10','A3') + x('J7','A3') + theta('J10','J7') + theta('J7','J10') =l= 3;
exec_overlap_10_7_4 ..  x('J10','A4') + x('J7','A4') + theta('J10','J7') + theta('J7','J10') =l= 3;
exec_overlap_10_8_1 ..  x('J10','A1') + x('J8','A1') + theta('J10','J8') + theta('J8','J10') =l= 3;
exec_overlap_10_8_2 ..  x('J10','A2') + x('J8','A2') + theta('J10','J8') + theta('J8','J10') =l= 3;
exec_overlap_10_8_3 ..  x('J10','A3') + x('J8','A3') + theta('J10','J8') + theta('J8','J10') =l= 3;
exec_overlap_10_8_4 ..  x('J10','A4') + x('J8','A4') + theta('J10','J8') + theta('J8','J10') =l= 3;
exec_overlap_10_9_1 ..  x('J10','A1') + x('J9','A1') + theta('J10','J9') + theta('J9','J10') =l= 3;
exec_overlap_10_9_2 ..  x('J10','A2') + x('J9','A2') + theta('J10','J9') + theta('J9','J10') =l= 3;
exec_overlap_10_9_3 ..  x('J10','A3') + x('J9','A3') + theta('J10','J9') + theta('J9','J10') =l= 3;
exec_overlap_10_9_4 ..  x('J10','A4') + x('J9','A4') + theta('J10','J9') + theta('J9','J10') =l= 3;
exec_overlap_10_10_1 ..  x('J10','A1') + x('J10','A1') + theta('J10','J10') + theta('J10','J10') =l= 3;
exec_overlap_10_10_2 ..  x('J10','A2') + x('J10','A2') + theta('J10','J10') + theta('J10','J10') =l= 3;
exec_overlap_10_10_3 ..  x('J10','A3') + x('J10','A3') + theta('J10','J10') + theta('J10','J10') =l= 3;
exec_overlap_10_10_4 ..  x('J10','A4') + x('J10','A4') + theta('J10','J10') + theta('J10','J10') =l= 3;
exec_overlap_10_11_1 ..  x('J10','A1') + x('J11','A1') + theta('J10','J11') + theta('J11','J10') =l= 3;
exec_overlap_10_11_2 ..  x('J10','A2') + x('J11','A2') + theta('J10','J11') + theta('J11','J10') =l= 3;
exec_overlap_10_11_3 ..  x('J10','A3') + x('J11','A3') + theta('J10','J11') + theta('J11','J10') =l= 3;
exec_overlap_10_11_4 ..  x('J10','A4') + x('J11','A4') + theta('J10','J11') + theta('J11','J10') =l= 3;
exec_overlap_10_12_1 ..  x('J10','A1') + x('J12','A1') + theta('J10','J12') + theta('J12','J10') =l= 3;
exec_overlap_10_12_2 ..  x('J10','A2') + x('J12','A2') + theta('J10','J12') + theta('J12','J10') =l= 3;
exec_overlap_10_12_3 ..  x('J10','A3') + x('J12','A3') + theta('J10','J12') + theta('J12','J10') =l= 3;
exec_overlap_10_12_4 ..  x('J10','A4') + x('J12','A4') + theta('J10','J12') + theta('J12','J10') =l= 3;
exec_overlap_11_1_1 ..  x('J11','A1') + x('J1','A1') + theta('J11','J1') + theta('J1','J11') =l= 3;
exec_overlap_11_1_2 ..  x('J11','A2') + x('J1','A2') + theta('J11','J1') + theta('J1','J11') =l= 3;
exec_overlap_11_1_3 ..  x('J11','A3') + x('J1','A3') + theta('J11','J1') + theta('J1','J11') =l= 3;
exec_overlap_11_1_4 ..  x('J11','A4') + x('J1','A4') + theta('J11','J1') + theta('J1','J11') =l= 3;
exec_overlap_11_2_1 ..  x('J11','A1') + x('J2','A1') + theta('J11','J2') + theta('J2','J11') =l= 3;
exec_overlap_11_2_2 ..  x('J11','A2') + x('J2','A2') + theta('J11','J2') + theta('J2','J11') =l= 3;
exec_overlap_11_2_3 ..  x('J11','A3') + x('J2','A3') + theta('J11','J2') + theta('J2','J11') =l= 3;
exec_overlap_11_2_4 ..  x('J11','A4') + x('J2','A4') + theta('J11','J2') + theta('J2','J11') =l= 3;
exec_overlap_11_3_1 ..  x('J11','A1') + x('J3','A1') + theta('J11','J3') + theta('J3','J11') =l= 3;
exec_overlap_11_3_2 ..  x('J11','A2') + x('J3','A2') + theta('J11','J3') + theta('J3','J11') =l= 3;
exec_overlap_11_3_3 ..  x('J11','A3') + x('J3','A3') + theta('J11','J3') + theta('J3','J11') =l= 3;
exec_overlap_11_3_4 ..  x('J11','A4') + x('J3','A4') + theta('J11','J3') + theta('J3','J11') =l= 3;
exec_overlap_11_4_1 ..  x('J11','A1') + x('J4','A1') + theta('J11','J4') + theta('J4','J11') =l= 3;
exec_overlap_11_4_2 ..  x('J11','A2') + x('J4','A2') + theta('J11','J4') + theta('J4','J11') =l= 3;
exec_overlap_11_4_3 ..  x('J11','A3') + x('J4','A3') + theta('J11','J4') + theta('J4','J11') =l= 3;
exec_overlap_11_4_4 ..  x('J11','A4') + x('J4','A4') + theta('J11','J4') + theta('J4','J11') =l= 3;
exec_overlap_11_5_1 ..  x('J11','A1') + x('J5','A1') + theta('J11','J5') + theta('J5','J11') =l= 3;
exec_overlap_11_5_2 ..  x('J11','A2') + x('J5','A2') + theta('J11','J5') + theta('J5','J11') =l= 3;
exec_overlap_11_5_3 ..  x('J11','A3') + x('J5','A3') + theta('J11','J5') + theta('J5','J11') =l= 3;
exec_overlap_11_5_4 ..  x('J11','A4') + x('J5','A4') + theta('J11','J5') + theta('J5','J11') =l= 3;
exec_overlap_11_6_1 ..  x('J11','A1') + x('J6','A1') + theta('J11','J6') + theta('J6','J11') =l= 3;
exec_overlap_11_6_2 ..  x('J11','A2') + x('J6','A2') + theta('J11','J6') + theta('J6','J11') =l= 3;
exec_overlap_11_6_3 ..  x('J11','A3') + x('J6','A3') + theta('J11','J6') + theta('J6','J11') =l= 3;
exec_overlap_11_6_4 ..  x('J11','A4') + x('J6','A4') + theta('J11','J6') + theta('J6','J11') =l= 3;
exec_overlap_11_7_1 ..  x('J11','A1') + x('J7','A1') + theta('J11','J7') + theta('J7','J11') =l= 3;
exec_overlap_11_7_2 ..  x('J11','A2') + x('J7','A2') + theta('J11','J7') + theta('J7','J11') =l= 3;
exec_overlap_11_7_3 ..  x('J11','A3') + x('J7','A3') + theta('J11','J7') + theta('J7','J11') =l= 3;
exec_overlap_11_7_4 ..  x('J11','A4') + x('J7','A4') + theta('J11','J7') + theta('J7','J11') =l= 3;
exec_overlap_11_8_1 ..  x('J11','A1') + x('J8','A1') + theta('J11','J8') + theta('J8','J11') =l= 3;
exec_overlap_11_8_2 ..  x('J11','A2') + x('J8','A2') + theta('J11','J8') + theta('J8','J11') =l= 3;
exec_overlap_11_8_3 ..  x('J11','A3') + x('J8','A3') + theta('J11','J8') + theta('J8','J11') =l= 3;
exec_overlap_11_8_4 ..  x('J11','A4') + x('J8','A4') + theta('J11','J8') + theta('J8','J11') =l= 3;
exec_overlap_11_9_1 ..  x('J11','A1') + x('J9','A1') + theta('J11','J9') + theta('J9','J11') =l= 3;
exec_overlap_11_9_2 ..  x('J11','A2') + x('J9','A2') + theta('J11','J9') + theta('J9','J11') =l= 3;
exec_overlap_11_9_3 ..  x('J11','A3') + x('J9','A3') + theta('J11','J9') + theta('J9','J11') =l= 3;
exec_overlap_11_9_4 ..  x('J11','A4') + x('J9','A4') + theta('J11','J9') + theta('J9','J11') =l= 3;
exec_overlap_11_10_1 ..  x('J11','A1') + x('J10','A1') + theta('J11','J10') + theta('J10','J11') =l= 3;
exec_overlap_11_10_2 ..  x('J11','A2') + x('J10','A2') + theta('J11','J10') + theta('J10','J11') =l= 3;
exec_overlap_11_10_3 ..  x('J11','A3') + x('J10','A3') + theta('J11','J10') + theta('J10','J11') =l= 3;
exec_overlap_11_10_4 ..  x('J11','A4') + x('J10','A4') + theta('J11','J10') + theta('J10','J11') =l= 3;
exec_overlap_11_11_1 ..  x('J11','A1') + x('J11','A1') + theta('J11','J11') + theta('J11','J11') =l= 3;
exec_overlap_11_11_2 ..  x('J11','A2') + x('J11','A2') + theta('J11','J11') + theta('J11','J11') =l= 3;
exec_overlap_11_11_3 ..  x('J11','A3') + x('J11','A3') + theta('J11','J11') + theta('J11','J11') =l= 3;
exec_overlap_11_11_4 ..  x('J11','A4') + x('J11','A4') + theta('J11','J11') + theta('J11','J11') =l= 3;
exec_overlap_11_12_1 ..  x('J11','A1') + x('J12','A1') + theta('J11','J12') + theta('J12','J11') =l= 3;
exec_overlap_11_12_2 ..  x('J11','A2') + x('J12','A2') + theta('J11','J12') + theta('J12','J11') =l= 3;
exec_overlap_11_12_3 ..  x('J11','A3') + x('J12','A3') + theta('J11','J12') + theta('J12','J11') =l= 3;
exec_overlap_11_12_4 ..  x('J11','A4') + x('J12','A4') + theta('J11','J12') + theta('J12','J11') =l= 3;
exec_overlap_12_1_1 ..  x('J12','A1') + x('J1','A1') + theta('J12','J1') + theta('J1','J12') =l= 3;
exec_overlap_12_1_2 ..  x('J12','A2') + x('J1','A2') + theta('J12','J1') + theta('J1','J12') =l= 3;
exec_overlap_12_1_3 ..  x('J12','A3') + x('J1','A3') + theta('J12','J1') + theta('J1','J12') =l= 3;
exec_overlap_12_1_4 ..  x('J12','A4') + x('J1','A4') + theta('J12','J1') + theta('J1','J12') =l= 3;
exec_overlap_12_2_1 ..  x('J12','A1') + x('J2','A1') + theta('J12','J2') + theta('J2','J12') =l= 3;
exec_overlap_12_2_2 ..  x('J12','A2') + x('J2','A2') + theta('J12','J2') + theta('J2','J12') =l= 3;
exec_overlap_12_2_3 ..  x('J12','A3') + x('J2','A3') + theta('J12','J2') + theta('J2','J12') =l= 3;
exec_overlap_12_2_4 ..  x('J12','A4') + x('J2','A4') + theta('J12','J2') + theta('J2','J12') =l= 3;
exec_overlap_12_3_1 ..  x('J12','A1') + x('J3','A1') + theta('J12','J3') + theta('J3','J12') =l= 3;
exec_overlap_12_3_2 ..  x('J12','A2') + x('J3','A2') + theta('J12','J3') + theta('J3','J12') =l= 3;
exec_overlap_12_3_3 ..  x('J12','A3') + x('J3','A3') + theta('J12','J3') + theta('J3','J12') =l= 3;
exec_overlap_12_3_4 ..  x('J12','A4') + x('J3','A4') + theta('J12','J3') + theta('J3','J12') =l= 3;
exec_overlap_12_4_1 ..  x('J12','A1') + x('J4','A1') + theta('J12','J4') + theta('J4','J12') =l= 3;
exec_overlap_12_4_2 ..  x('J12','A2') + x('J4','A2') + theta('J12','J4') + theta('J4','J12') =l= 3;
exec_overlap_12_4_3 ..  x('J12','A3') + x('J4','A3') + theta('J12','J4') + theta('J4','J12') =l= 3;
exec_overlap_12_4_4 ..  x('J12','A4') + x('J4','A4') + theta('J12','J4') + theta('J4','J12') =l= 3;
exec_overlap_12_5_1 ..  x('J12','A1') + x('J5','A1') + theta('J12','J5') + theta('J5','J12') =l= 3;
exec_overlap_12_5_2 ..  x('J12','A2') + x('J5','A2') + theta('J12','J5') + theta('J5','J12') =l= 3;
exec_overlap_12_5_3 ..  x('J12','A3') + x('J5','A3') + theta('J12','J5') + theta('J5','J12') =l= 3;
exec_overlap_12_5_4 ..  x('J12','A4') + x('J5','A4') + theta('J12','J5') + theta('J5','J12') =l= 3;
exec_overlap_12_6_1 ..  x('J12','A1') + x('J6','A1') + theta('J12','J6') + theta('J6','J12') =l= 3;
exec_overlap_12_6_2 ..  x('J12','A2') + x('J6','A2') + theta('J12','J6') + theta('J6','J12') =l= 3;
exec_overlap_12_6_3 ..  x('J12','A3') + x('J6','A3') + theta('J12','J6') + theta('J6','J12') =l= 3;
exec_overlap_12_6_4 ..  x('J12','A4') + x('J6','A4') + theta('J12','J6') + theta('J6','J12') =l= 3;
exec_overlap_12_7_1 ..  x('J12','A1') + x('J7','A1') + theta('J12','J7') + theta('J7','J12') =l= 3;
exec_overlap_12_7_2 ..  x('J12','A2') + x('J7','A2') + theta('J12','J7') + theta('J7','J12') =l= 3;
exec_overlap_12_7_3 ..  x('J12','A3') + x('J7','A3') + theta('J12','J7') + theta('J7','J12') =l= 3;
exec_overlap_12_7_4 ..  x('J12','A4') + x('J7','A4') + theta('J12','J7') + theta('J7','J12') =l= 3;
exec_overlap_12_8_1 ..  x('J12','A1') + x('J8','A1') + theta('J12','J8') + theta('J8','J12') =l= 3;
exec_overlap_12_8_2 ..  x('J12','A2') + x('J8','A2') + theta('J12','J8') + theta('J8','J12') =l= 3;
exec_overlap_12_8_3 ..  x('J12','A3') + x('J8','A3') + theta('J12','J8') + theta('J8','J12') =l= 3;
exec_overlap_12_8_4 ..  x('J12','A4') + x('J8','A4') + theta('J12','J8') + theta('J8','J12') =l= 3;
exec_overlap_12_9_1 ..  x('J12','A1') + x('J9','A1') + theta('J12','J9') + theta('J9','J12') =l= 3;
exec_overlap_12_9_2 ..  x('J12','A2') + x('J9','A2') + theta('J12','J9') + theta('J9','J12') =l= 3;
exec_overlap_12_9_3 ..  x('J12','A3') + x('J9','A3') + theta('J12','J9') + theta('J9','J12') =l= 3;
exec_overlap_12_9_4 ..  x('J12','A4') + x('J9','A4') + theta('J12','J9') + theta('J9','J12') =l= 3;
exec_overlap_12_10_1 ..  x('J12','A1') + x('J10','A1') + theta('J12','J10') + theta('J10','J12') =l= 3;
exec_overlap_12_10_2 ..  x('J12','A2') + x('J10','A2') + theta('J12','J10') + theta('J10','J12') =l= 3;
exec_overlap_12_10_3 ..  x('J12','A3') + x('J10','A3') + theta('J12','J10') + theta('J10','J12') =l= 3;
exec_overlap_12_10_4 ..  x('J12','A4') + x('J10','A4') + theta('J12','J10') + theta('J10','J12') =l= 3;
exec_overlap_12_11_1 ..  x('J12','A1') + x('J11','A1') + theta('J12','J11') + theta('J11','J12') =l= 3;
exec_overlap_12_11_2 ..  x('J12','A2') + x('J11','A2') + theta('J12','J11') + theta('J11','J12') =l= 3;
exec_overlap_12_11_3 ..  x('J12','A3') + x('J11','A3') + theta('J12','J11') + theta('J11','J12') =l= 3;
exec_overlap_12_11_4 ..  x('J12','A4') + x('J11','A4') + theta('J12','J11') + theta('J11','J12') =l= 3;
exec_overlap_12_12_1 ..  x('J12','A1') + x('J12','A1') + theta('J12','J12') + theta('J12','J12') =l= 3;
exec_overlap_12_12_2 ..  x('J12','A2') + x('J12','A2') + theta('J12','J12') + theta('J12','J12') =l= 3;
exec_overlap_12_12_3 ..  x('J12','A3') + x('J12','A3') + theta('J12','J12') + theta('J12','J12') =l= 3;
exec_overlap_12_12_4 ..  x('J12','A4') + x('J12','A4') + theta('J12','J12') + theta('J12','J12') =l= 3;
* single_job(j,j)        "an agent may process at most 1 job at a time"
single_job_1_2..  s('J2') - sum(a, d('J1',a)*x('J1',a)) - s('J1') =g= (-M)*theta('J1','J2');
single_job_1_3..  s('J3') - sum(a, d('J1',a)*x('J1',a)) - s('J1') =g= (-M)*theta('J1','J3');
single_job_1_4..  s('J4') - sum(a, d('J1',a)*x('J1',a)) - s('J1') =g= (-M)*theta('J1','J4');
single_job_2_1..  s('J1') - sum(a, d('J2',a)*x('J2',a)) - s('J2') =g= (-M)*theta('J2','J1');
single_job_2_3..  s('J3') - sum(a, d('J2',a)*x('J2',a)) - s('J2') =g= (-M)*theta('J2','J3');
single_job_2_4..  s('J4') - sum(a, d('J2',a)*x('J2',a)) - s('J2') =g= (-M)*theta('J2','J4');
single_job_3_1..  s('J1') - sum(a, d('J3',a)*x('J3',a)) - s('J3') =g= (-M)*theta('J3','J1');
single_job_3_2..  s('J2') - sum(a, d('J3',a)*x('J3',a)) - s('J3') =g= (-M)*theta('J3','J2');
single_job_3_4..  s('J4') - sum(a, d('J3',a)*x('J3',a)) - s('J3') =g= (-M)*theta('J3','J4');
single_job_4_1..  s('J1') - sum(a, d('J4',a)*x('J4',a)) - s('J4') =g= (-M)*theta('J4','J1');
single_job_4_2..  s('J2') - sum(a, d('J4',a)*x('J4',a)) - s('J4') =g= (-M)*theta('J4','J2');
single_job_4_3..  s('J3') - sum(a, d('J4',a)*x('J4',a)) - s('J4') =g= (-M)*theta('J4','J3');
single_job_5_1..  s('J1') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =g= (-M)*theta('J5','J1');
single_job_5_2..  s('J2') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =g= (-M)*theta('J5','J2');
single_job_5_3..  s('J3') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =g= (-M)*theta('J5','J3');
single_job_5_4..  s('J4') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =g= (-M)*theta('J5','J4');
single_job_5_6..  s('J6') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =g= (-M)*theta('J5','J6');
single_job_5_7..  s('J7') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =g= (-M)*theta('J5','J7');
single_job_6_1..  s('J1') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =g= (-M)*theta('J6','J1');
single_job_6_2..  s('J2') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =g= (-M)*theta('J6','J2');
single_job_6_3..  s('J3') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =g= (-M)*theta('J6','J3');
single_job_6_4..  s('J4') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =g= (-M)*theta('J6','J4');
single_job_6_5..  s('J5') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =g= (-M)*theta('J6','J5');
single_job_6_7..  s('J7') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =g= (-M)*theta('J6','J7');
single_job_7_1..  s('J1') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =g= (-M)*theta('J7','J1');
single_job_7_2..  s('J2') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =g= (-M)*theta('J7','J2');
single_job_7_3..  s('J3') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =g= (-M)*theta('J7','J3');
single_job_7_4..  s('J4') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =g= (-M)*theta('J7','J4');
single_job_7_5..  s('J5') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =g= (-M)*theta('J7','J5');
single_job_7_6..  s('J6') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =g= (-M)*theta('J7','J6');
single_job_8_1..  s('J1') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J1');
single_job_8_2..  s('J2') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J2');
single_job_8_3..  s('J3') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J3');
single_job_8_4..  s('J4') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J4');
single_job_8_5..  s('J5') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J5');
single_job_8_6..  s('J6') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J6');
single_job_8_7..  s('J7') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J7');
single_job_8_9..  s('J9') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J9');
single_job_8_10..  s('J10') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J10');
single_job_8_11..  s('J11') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =g= (-M)*theta('J8','J11');
single_job_9_1..  s('J1') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J1');
single_job_9_2..  s('J2') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J2');
single_job_9_3..  s('J3') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J3');
single_job_9_4..  s('J4') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J4');
single_job_9_5..  s('J5') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J5');
single_job_9_6..  s('J6') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J6');
single_job_9_7..  s('J7') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J7');
single_job_9_8..  s('J8') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J8');
single_job_9_10..  s('J10') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J10');
single_job_9_11..  s('J11') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =g= (-M)*theta('J9','J11');
single_job_10_1..  s('J1') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J1');
single_job_10_2..  s('J2') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J2');
single_job_10_3..  s('J3') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J3');
single_job_10_4..  s('J4') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J4');
single_job_10_5..  s('J5') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J5');
single_job_10_6..  s('J6') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J6');
single_job_10_7..  s('J7') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J7');
single_job_10_8..  s('J8') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J8');
single_job_10_9..  s('J9') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J9');
single_job_10_11..  s('J11') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =g= (-M)*theta('J10','J11');
single_job_11_1..  s('J1') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J1');
single_job_11_2..  s('J2') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J2');
single_job_11_3..  s('J3') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J3');
single_job_11_4..  s('J4') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J4');
single_job_11_5..  s('J5') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J5');
single_job_11_6..  s('J6') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J6');
single_job_11_7..  s('J7') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J7');
single_job_11_8..  s('J8') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J8');
single_job_11_9..  s('J9') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J9');
single_job_11_10..  s('J10') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =g= (-M)*theta('J11','J10');
single_job_12_1..  s('J1') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J1');
single_job_12_2..  s('J2') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J2');
single_job_12_3..  s('J3') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J3');
single_job_12_4..  s('J4') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J4');
single_job_12_5..  s('J5') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J5');
single_job_12_6..  s('J6') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J6');
single_job_12_7..  s('J7') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J7');
single_job_12_8..  s('J8') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J8');
single_job_12_9..  s('J9') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J9');
single_job_12_10..  s('J10') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J10');
single_job_12_11..  s('J11') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =g= (-M)*theta('J12','J11');
* single_job2(j,j)       "this also needs renamed"
single_job2_1_2..  s('J2') - sum(a, d('J1',a)*x('J1',a)) - s('J1') =l= M*(1-theta('J1','J2'));
single_job2_1_3..  s('J3') - sum(a, d('J1',a)*x('J1',a)) - s('J1') =l= M*(1-theta('J1','J3'));
single_job2_1_4..  s('J4') - sum(a, d('J1',a)*x('J1',a)) - s('J1') =l= M*(1-theta('J1','J4'));
single_job2_2_1..  s('J1') - sum(a, d('J2',a)*x('J2',a)) - s('J2') =l= M*(1-theta('J2','J1'));
single_job2_2_3..  s('J3') - sum(a, d('J2',a)*x('J2',a)) - s('J2') =l= M*(1-theta('J2','J3'));
single_job2_2_4..  s('J4') - sum(a, d('J2',a)*x('J2',a)) - s('J2') =l= M*(1-theta('J2','J4'));
single_job2_3_1..  s('J1') - sum(a, d('J3',a)*x('J3',a)) - s('J3') =l= M*(1-theta('J3','J1'));
single_job2_3_2..  s('J2') - sum(a, d('J3',a)*x('J3',a)) - s('J3') =l= M*(1-theta('J3','J2'));
single_job2_3_4..  s('J4') - sum(a, d('J3',a)*x('J3',a)) - s('J3') =l= M*(1-theta('J3','J4'));
single_job2_4_1..  s('J1') - sum(a, d('J4',a)*x('J4',a)) - s('J4') =l= M*(1-theta('J4','J1'));
single_job2_4_2..  s('J2') - sum(a, d('J4',a)*x('J4',a)) - s('J4') =l= M*(1-theta('J4','J2'));
single_job2_4_3..  s('J3') - sum(a, d('J4',a)*x('J4',a)) - s('J4') =l= M*(1-theta('J4','J3'));
single_job2_5_1..  s('J1') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =l= M*(1-theta('J5','J1'));
single_job2_5_2..  s('J2') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =l= M*(1-theta('J5','J2'));
single_job2_5_3..  s('J3') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =l= M*(1-theta('J5','J3'));
single_job2_5_4..  s('J4') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =l= M*(1-theta('J5','J4'));
single_job2_5_6..  s('J6') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =l= M*(1-theta('J5','J6'));
single_job2_5_7..  s('J7') - sum(a, d('J5',a)*x('J5',a)) - s('J5') =l= M*(1-theta('J5','J7'));
single_job2_6_1..  s('J1') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =l= M*(1-theta('J6','J1'));
single_job2_6_2..  s('J2') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =l= M*(1-theta('J6','J2'));
single_job2_6_3..  s('J3') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =l= M*(1-theta('J6','J3'));
single_job2_6_4..  s('J4') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =l= M*(1-theta('J6','J4'));
single_job2_6_5..  s('J5') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =l= M*(1-theta('J6','J5'));
single_job2_6_7..  s('J7') - sum(a, d('J6',a)*x('J6',a)) - s('J6') =l= M*(1-theta('J6','J7'));
single_job2_7_1..  s('J1') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =l= M*(1-theta('J7','J1'));
single_job2_7_2..  s('J2') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =l= M*(1-theta('J7','J2'));
single_job2_7_3..  s('J3') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =l= M*(1-theta('J7','J3'));
single_job2_7_4..  s('J4') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =l= M*(1-theta('J7','J4'));
single_job2_7_5..  s('J5') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =l= M*(1-theta('J7','J5'));
single_job2_7_6..  s('J6') - sum(a, d('J7',a)*x('J7',a)) - s('J7') =l= M*(1-theta('J7','J6'));
single_job2_8_1..  s('J1') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J1'));
single_job2_8_2..  s('J2') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J2'));
single_job2_8_3..  s('J3') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J3'));
single_job2_8_4..  s('J4') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J4'));
single_job2_8_5..  s('J5') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J5'));
single_job2_8_6..  s('J6') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J6'));
single_job2_8_7..  s('J7') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J7'));
single_job2_8_9..  s('J9') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J9'));
single_job2_8_10..  s('J10') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J10'));
single_job2_8_11..  s('J11') - sum(a, d('J8',a)*x('J8',a)) - s('J8') =l= M*(1-theta('J8','J11'));
single_job2_9_1..  s('J1') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J1'));
single_job2_9_2..  s('J2') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J2'));
single_job2_9_3..  s('J3') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J3'));
single_job2_9_4..  s('J4') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J4'));
single_job2_9_5..  s('J5') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J5'));
single_job2_9_6..  s('J6') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J6'));
single_job2_9_7..  s('J7') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J7'));
single_job2_9_8..  s('J8') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J8'));
single_job2_9_10..  s('J10') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J10'));
single_job2_9_11..  s('J11') - sum(a, d('J9',a)*x('J9',a)) - s('J9') =l= M*(1-theta('J9','J11'));
single_job2_10_1..  s('J1') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J1'));
single_job2_10_2..  s('J2') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J2'));
single_job2_10_3..  s('J3') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J3'));
single_job2_10_4..  s('J4') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J4'));
single_job2_10_5..  s('J5') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J5'));
single_job2_10_6..  s('J6') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J6'));
single_job2_10_7..  s('J7') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J7'));
single_job2_10_8..  s('J8') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J8'));
single_job2_10_9..  s('J9') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J9'));
single_job2_10_11..  s('J11') - sum(a, d('J10',a)*x('J10',a)) - s('J10') =l= M*(1-theta('J10','J11'));
single_job2_11_1..  s('J1') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J1'));
single_job2_11_2..  s('J2') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J2'));
single_job2_11_3..  s('J3') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J3'));
single_job2_11_4..  s('J4') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J4'));
single_job2_11_5..  s('J5') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J5'));
single_job2_11_6..  s('J6') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J6'));
single_job2_11_7..  s('J7') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J7'));
single_job2_11_8..  s('J8') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J8'));
single_job2_11_9..  s('J9') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J9'));
single_job2_11_10..  s('J10') - sum(a, d('J11',a)*x('J11',a)) - s('J11') =l= M*(1-theta('J11','J10'));
single_job2_12_1..  s('J1') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J1'));
single_job2_12_2..  s('J2') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J2'));
single_job2_12_3..  s('J3') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J3'));
single_job2_12_4..  s('J4') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J4'));
single_job2_12_5..  s('J5') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J5'));
single_job2_12_6..  s('J6') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J6'));
single_job2_12_7..  s('J7') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J7'));
single_job2_12_8..  s('J8') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J8'));
single_job2_12_9..  s('J9') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J9'));
single_job2_12_10..  s('J10') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J10'));
single_job2_12_11..  s('J11') - sum(a, d('J12',a)*x('J12',a)) - s('J12') =l= M*(1-theta('J12','J11'));

model aes /all/ ;
solve aes using MIP minimizing Z;

