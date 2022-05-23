clc
clear
close(winsid());

l_1 = 4;
l_2 = 3;
l_3 = .5;
tool = [l_3;0;0;1]
phi = 45

x = 1
y = 3.5

disp(x)
disp(y)

center_rad = atan(y,x)
center_deg = center_rad * 180 / %pi

disp("center")
disp(center_deg)

temp_theta2 = acos((x^2 + y^2 - l_1^2 - l_2^2) / (2 * l_1 * l_2)) * 180 / %pi
temp_cos_v = acos((x^2 + y^2 + l_1^2 - l_2^2) / ((2 * l_1) * sqrt(x^2 + y^2))) * 180 / %pi

temp_theta1 = center_deg - temp_cos_v

disp("theta1")
disp(temp_theta1)
disp("theta2")
disp(temp_theta2)
disp("to center")
disp(temp_cos_v)

t1 = temp_theta1;
t2 = temp_theta2;
t3 = phi - (temp_theta1 + temp_theta2);

tr_1 = t1 * %pi / 180;
tr_2 = t2 * %pi / 180;
tr_3 = t3 * %pi / 180;

TM0 = [cos(tr_1) -sin(tr_1) 0 0; sin(tr_1) cos(tr_1) 0 0; 0 0 1 0; 0 0 0 1;]
TM1 = [cos(tr_2) -sin(tr_2) 0 l_1; sin(tr_2) cos(tr_2) 0 0; 0 0 1 0; 0 0 0 1;]
TM2 = [cos(tr_3) -sin(tr_3) 0 l_2; sin(tr_3) cos(tr_3) 0 0; 0 0 1 0; 0 0 0 1;]

P1 = TM0 * TM1 * [0;0;0;1];
P2 = TM0 * TM1 * TM2 * [0;0;0;1];
P3 = TM0 * TM1 * TM2 * tool;

x = [0,P1(1),P2(1),P3(1)];
y = [0,P1(2),P2(2),P3(2)];

plot(x,y);
mtlb_axis([-6,8,-6,8]);
xgrid(5,1,2);
