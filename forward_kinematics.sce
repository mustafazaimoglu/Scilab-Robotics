clc
clear
close(winsid());

l_1 = 4;
l_2 = 3;
l_3 = 2;

t1 = 80;
t2 = -40;
t3 = -60;

tr_1 = t1 * %pi / 180;
tr_2 = t2 * %pi / 180;
tr_3 = t3 * %pi / 180;

tool = [l_3;0;0;1]

TM0 = [cos(tr_1) -sin(tr_1) 0 0; sin(tr_1) cos(tr_1) 0 0; 0 0 1 0; 0 0 0 1;]
TM1 = [cos(tr_2) -sin(tr_2) 0 l_1; sin(tr_2) cos(tr_2) 0 0; 0 0 1 0; 0 0 0 1;]
TM2 = [cos(tr_3) -sin(tr_3) 0 l_2; sin(tr_3) cos(tr_3) 0 0; 0 0 1 0; 0 0 0 1;]

P1 = TM0 * TM1 * [0;0;0;1];
P2 = TM0 * TM1 * TM2 * [0;0;0;1];
P3 = TM0 * TM1 * TM2 * tool;
disp(P1);
disp(P2);
disp(P3);

x = [0,P1(1),P2(1),P3(1)];
y = [0,P1(2),P2(2),P3(2)];
plot(x,y);
mtlb_axis([-6,8,-6,8]);
xgrid(5,1,2);
