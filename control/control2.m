function u = control2(t, q, dq, q0, dq0, step_number)

global gait;

if (gait == 1)
    target_q3 = 0;
    dist = 0.12;
    target_q1 = pi/11;
    Kp1 = 100; 
    Kp2 = -50;  
    Kd1 = 20;  
    Kd2 = -5;   
elseif (gait == 2)
    target_q3 = -pi/35;
    dist = 0.16;
    target_q1 = pi/11;
    Kp1 = 100; 
    Kp2 = -50;  
    Kd1 = 20;  
    Kd2 = -3;
elseif (gait == 3)
    target_q3 = pi/40;
    dist = 0.08;
    target_q1 = pi/14;
    Kp1 = 100; 
    Kp2 = -180;  
    Kd1 = 10;  
    Kd2 = -12;   
end

[~, ~, ~, ~, l2, ~, ~] = set_parameters();
x = [-target_q1; -target_q1/5; target_q1/5; target_q1];
y = [-dist; -1.25*dist; 1.25*dist; dist];
s = spline(x,y);

bezier = @(x) s.coefs(1,1)*(x-x(1)).^3 + s.coefs(1,2)*(x-x(1)).^2 +s.coefs(1,3)*(x-x(1)) + s.coefs(1,4);

if(q(1)<-target_q1)
        target = -dist;
end
if(q(1)>target_q1)
        target = dist;
end
if(q(1)>-target_q1 && q(1)<target_q1)
        target = bezier(q(1));
end

target_q2 = -asin(target)/(-l2);

u1 = Kd1*(dq(3)) + Kp1*(q(3) - target_q3);
u2 = Kd2*(dq(2)) + Kp2*(q(2) - target_q2);

if u1 > 30
    u1 = 30;
end
if u2 > 30
    u2 = 30;
end

if u1 < -30
    u1 = -30;
end
if u2 < -30
    u2 = -30;
end

u = [u1; u2];
end