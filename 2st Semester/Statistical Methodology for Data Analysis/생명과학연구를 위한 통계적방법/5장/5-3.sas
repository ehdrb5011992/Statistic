data fivethree;
INPUT trt$ x y @@;
CARDS ;
A 11 6 B 6 0 C 16 13
A 8 0 B 6 2 C 13 10
A 5 2 B 7 3 C 11 18
A 14 8 B 8 1 C 9 5
A 19 11 B 18 18 C 21 23
A 6 4 B 8 4 C 16 12
A 10 13 B 19 14 C 12 5
A 6 1 B 8 9 C 12 16
A 11 8 B 5 1 C 7 1
A 3 0 B 15 9 C 12 20
;
run;

proc glm data=fivethree;
class trt ;
model y=trt x trt*x ;
run; quit;

proc glm data=fivethree;
class trt ;
model y=trt x / solution ;
lsmeans trt/tdiff;
run; quit;

proc export data=fivethree
outfile = 'C:\Users\82104\Desktop\5_3.txt'
dbms = dlm replace;
run;
