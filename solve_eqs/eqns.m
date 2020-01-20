function dy = eqns(t, y, y0, step_number)
% n this is the dimension of the ODE, note that n is 2*DOF, why? 
% y1 = q1, y2 = q2, y3 = q3, y4 = dq1, y5 = dq2, y6 = dq3

q = [y(1); y(2); y(3)];
dq = [y(4); y(5); y(6)];

q0 = [y0(1); y0(2); y0(3)];
dq0 = [y0(4); y0(5); y0(6)];

global controller;
global perturbation;
global nbcontroller;
global sys_disturbated_yet;

if (controller == 1)
    u = control(t, q, dq, q0, dq0, step_number); 
elseif(controller == 2)
    u = control2(t, q, dq, q0, dq0, step_number); 
end

if(sys_disturbated_yet <= 150 && step_number == 50)
    if (perturbation == 1)
        u_perturbation = perturbation_generator();
        u(2) = u(2) + u_perturbation;
    end
    sys_disturbated_yet = sys_disturbated_yet + 1;
end


C = eval_C(q, dq);
G = eval_G(q);
B = eval_B();
M = eval_M(q);

n = 6;

A = [zeros(3), eye(3); zeros(3), -M^(-1)*C];
G_p = [zeros(3,1);  -M^(-1)*G];
B = [zeros(3,2);  M^(-1)*B];

% write down the equations for dy:
dy = A*y + G_p + B*u;

global U_total;
global dq_total;

U_total = [U_total [u;t]];
dq_total = [dq_total dq];
 
end