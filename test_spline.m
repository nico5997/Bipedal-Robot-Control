clc 
close all
clear all

x = [-pi/8; -pi/16; pi/16; pi/8];
y = [-0.12; -0.12*1.25; 0.12*1.25; 0.12];
s = spline(x,y);

p1 = @(x_b) s.coefs(1,1)*(x_b-x(1)).^3 + s.coefs(1,2)*(x_b-x(1)).^2 +s.coefs(1,3)*(x_b-x(1)) + s.coefs(1,4);
dp1 = @(x_b) 3*s.coefs(1,1)*(x_b-x(1)).^2 + 2*s.coefs(1,2)*(x_b-x(1)) + s.coefs(1,3);

x_q = -0.5:0.01:0.5;

figure
plot(x,y,'o',x_q,p1(x_q));
xlabel('q1 [rad]');
ylabel('Distance (swing-hip) [m]');
axis([-pi/8 pi/8 -0.2 0.2]);

