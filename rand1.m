clear;
clc;
f=fopen('iris.txt','w');

male=175+sqrt(15)*randn(1,400);
female=165+sqrt(10)*randn(1,200);
for i=1:400
         fprintf(f,'%g ',male(i));
end
for i=1:200
         fprintf(f,'%g ',female(i));
end
fclose(f);
