function u = control(t, q, dq, q0, dq0, step_number)

global gait;

if (gait == 1)
    target_q3 = 0;
    target_q2 = -pi/12;
    Kp1 = 100; 
    Kp2 = -50;  
    Kd1 = 20;  
    Kd2 = -5;   
elseif (gait == 2)
    target_q3 = -pi/30;
    target_q2 = -pi/12;
    Kp1 = 100; 
    Kp2 = -50;  
    Kd1 = 20;  
    Kd2 = -7;
elseif (gait == 3)
    target_q3 = 0;
    target_q2 = -pi/18;
    Kp1 = 80; 
    Kp2 = -145;  
    Kd1 = 10;  
    Kd2 = -10;  
end

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
