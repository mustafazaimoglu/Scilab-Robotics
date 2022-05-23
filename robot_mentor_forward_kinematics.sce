// Special Thanks to Witold Żorski
// This script is for ROBOT MENTOR.
clc
clear
close(winsid());

function []=myarc(xs,ys,r,a1,a2) //works better then xarc
  if abs(a1-a2)>%pi then //angles <pi
    if a1>a2 then a2=a2+2*%pi
    else a1=a1+2*%pi
    end
  end;

  a=a1:0.01:a2; if a1>a2 then a=a2:0.01:a1; end;
  x=xs+r*cos(a);
  y=ys+r*sin(a);
  plot(x,y) 
endfunction

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

t1 = 60;
t2 = 45;
t3 = -45;
t4 = -45;

tr_1 = t1 * %pi / 180;
tr_2 = t2 * %pi / 180;
tr_3 = t3 * %pi / 180;
tr_4 = t4 * %pi / 180;

origin = [0;0;0;1];
tool = [l_3;0;0;1];

TM0 = [cos(0) -sin(0) 0 0; sin(0) cos(0) 0 0; 0 0 1 h; 0 0 0 1;]
TM1 = [cos(tr_2) -sin(tr_2) 0 0; 0 0 -1 0;sin(tr_2) cos(tr_2) 0 0; 0 0 0 1;]
TM2 = [cos(tr_3) -sin(tr_3) 0 l_1; sin(tr_3) cos(tr_3) 0 0; 0 0 1 0; 0 0 0 1;]
TM3 = [cos(tr_4) -sin(tr_4) 0 l_2; sin(tr_4) cos(tr_4) 0 0; 0 0 1 0; 0 0 0 1;]
TM4 = [1 0 0 1; 0 1 0 0; 0 0 1 0; 0 0 0 1;]

P1 = TM0 * TM1 * origin;
P2 = TM0 * TM1 * TM2 * origin;
P3 = TM0 * TM1 * TM2 * TM3 * origin;
P4 = TM0 * TM1 * TM2 * TM3 * tool;
P5 = TM4 * P4;

TM00 = [cos(tr_1) -sin(tr_1) 0 0; 0 1 0 0;sin(tr_1) cos(tr_1) 0 0; 0 0 0 1;]
F1 = TM00 * P4;
F2 = TM00 * P5;

x1 = [0,P1(1),P2(1),P3(1),P4(1)];
y1 = [0,P1(3),P2(3),P3(3),P4(3)];

x2 = [0,F1(1),F2(1)];
y2 = [0,-F1(3),-F2(3)];

plot(x1,y1,x2,y2);
plot(P5(1),P5(3),"X");
mtlb_axis([-5,5,-6,8]);
myarc(0,0,0.5,0,-tr_1);
myarc(P1(1),P1(3),0.5,0,tr_2);
myarc(P2(1),P2(3),0.5,tr_2,tr_3+tr_2);
myarc(P3(1),P3(3),0.5,tr_3+tr_2,tr_4+tr_3+tr_2);
mypoints(x1,y1);
mypoints2(x2,y2);
xgrid(5,1,9);

disp("X : " + string(P5(1)));
disp("Y : " + string(P5(3)));
disp("Z : " + string(P5(2)));
disp("FI : " + string(t2+t3+t4));
