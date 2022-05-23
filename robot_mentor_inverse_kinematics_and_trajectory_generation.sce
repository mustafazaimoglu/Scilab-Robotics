// Special Thanks to Witold Żorski
// This script is for ROBOT MENTOR.
clc
clear
close(winsid());

function []=mypoints(x,y)
    _size = size(x)(2);
    plot(x(1),y(1),"b.");
    for i=2:_size - 2
        plot(x(i),y(i),"d");
    end
    plot(x(_size-1),y(_size-1),"r.") ;
    plot(x(_size),y(_size),"*");
endfunction

function []=mypoints2(x,y)
    _size = size(x)(2);
    plot(x(_size-1),y(_size-1),"*") ;
    plot(x(_size),y(_size),"X");
endfunction

h = 37 / 10;
l_1 = 17 / 10;
l_2 = 15 / 10;
l_3 = 10.5 / 10;

origin = [0;0;0;1];
tool = [l_3;0;0;1];

// TRAJECTORY delay added
tt = 0:0.03125:1
tt_size = size(tt)(2)

start_x = 1.4
start_y = 6.3
start_z = -1

end_x = 2.7
end_y = 2.5
end_z = 1

phi = -30

for i=1:tt_size
    x = start_x + (tt(i) * (end_x - start_x))
    y = start_y + (tt(i) * (end_y - start_y)) - h
    z = start_z + (tt(i) * (end_z - start_z))

    distance = sqrt(x^2 + y^2);
    theta1_rad = atan(z,distance)
    temp_theta1 = theta1_rad * 180 / %pi
    center_rad = atan(y,x)
    center_deg = center_rad * 180 / %pi
    temp_cos_v = acos((x^2 + y^2 + l_1^2 - l_2^2) / ((2 * l_1) * sqrt(x^2 + y^2))) * 180 / %pi
    temp_theta2 = center_deg - temp_cos_v
    temp_theta3 = acos((x^2 + y^2 - l_1^2 - l_2^2) / (2 * l_1 * l_2)) * 180 / %pi
    temp_theta4 = phi - (temp_theta2 + temp_theta3)

    t1 = temp_theta1;
    t2 = temp_theta2;
    t3 = temp_theta3;
    t4 = temp_theta4;

    tr_1 = t1 * %pi / 180;
    tr_2 = t2 * %pi / 180;
    tr_3 = t3 * %pi / 180;
    tr_4 = t4 * %pi / 180;

    TM0 = [cos(tr_1) -sin(tr_1) 0 0; sin(tr_1) cos(tr_1) 0 0; 0 0 1 h; 0 0 0 1;]
    TM1 = [cos(tr_2) -sin(tr_2) 0 0; 0 0 -1 0;sin(tr_2) cos(tr_2) 0 0; 0 0 0 1;]
    TM2 = [cos(tr_3) -sin(tr_3) 0 l_1; sin(tr_3) cos(tr_3) 0 0; 0 0 1 0; 0 0 0 1;]
    TM3 = [cos(tr_4) -sin(tr_4) 0 l_2; sin(tr_4) cos(tr_4) 0 0; 0 0 1 0; 0 0 0 1;]

    real_P4 = TM0 * TM1 * TM2 * TM3 * tool;

    TM0 = [cos(0) -sin(0) 0 0; sin(0) cos(0) 0 0; 0 0 1 h; 0 0 0 1;]
    TM4 = [1 0 0 1; 0 1 0 0; 0 0 1 0; 0 0 0 1;]

    P1 = TM0 * TM1 * origin;
    P2 = TM0 * TM1 * TM2 * origin;
    P3 = TM0 * TM1 * TM2 * TM3 * origin;
    P4 = TM0 * TM1 * TM2 * TM3 * tool;

    real_P4 = [sqrt(real_P4(1)^2 + real_P4(2)^2); 0; real_P4(3); real_P4(4);]
    real_P5 = TM4 * real_P4;

    TM00 = [cos(tr_1) -sin(tr_1) 0 0; 0 1 0 0;sin(tr_1) cos(tr_1) 0 0; 0 0 0 1;]
    F1 = TM00 * real_P4;
    F2 = TM00 * real_P5;

    x1 = [0,P1(1),P2(1),P3(1),P4(1)];
    y1 = [0,P1(3),P2(3),P3(3),P4(3)];

    x2 = [0,F1(1),F2(1)];
    y2 = [0,-F1(3),-F2(3)];

    plot(x1,y1,x2,y2);
    plot(real_P5(1),real_P5(3),"X");
    mtlb_axis([-5,5,-6,8]);
    mypoints2(x2,y2);
    xgrid(5,1,9);

    sleep(40) // DELAY
end




