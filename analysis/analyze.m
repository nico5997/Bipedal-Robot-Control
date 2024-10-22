%% Read the README_ASSIGN4.pdf to see what results you need to analyze here. 
function sln = analyze(sln)

[~ , num_of_steps] = size(sln.T);
[m1, m2, m3, ~, ~, ~, g] = set_parameters();
Angles = [];
t = [];
r0 = [0];
r0_h = [0];
x_h_total = [];
te =[];
ye =[];

for i = 1:num_of_steps
    t = [t; sln.T{1,i}];
    Angles = [Angles;sln.Y{1,i}];
    if(size(sln.YE{1,i}) == [0 0])
       break; 
    end
    q = sln.YE{1,i};
    ye = [ye sln.YE{1,i}'];
    q = q(1:3);
    [x0, ~, ~, ~] = kin_swf(q);
    [x0_h,~,~,~] = kin_hip(q);
    r0 = [r0 (r0(end) + x0)];
    r0_h = [r0_h (r0_h(end)+x0_h)];
    for j = 1:length(sln.T{1,i})
        q = sln.Y{1,i};
        q = q(j,1:3);
        x_h_total = [x_h_total r0(i)+kin_hip(q)];
    end
    te = [te sln.TE{1,i}];
end


% Plots of the angles with respect to time
figure
subplot(321);
plot(t,Angles(:,1));
ylabel('q1[rad/s]');
xlabel('t[s]');
title('Angle q1 vs. time');

subplot(322);
plot(t,Angles(:,2));
ylabel('q2[rad/s]');
xlabel('t[s]');
title('Angle q2 vs. time');

subplot(323);
plot(t,Angles(:,3));
ylabel('q3[rad/s]');
xlabel('t[s]');
title('Angle q3 vs. time');

% Plot of the velocity on x axis with respect to time
Vx = diff(x_h_total)./diff(t');
for i = 1:length(Vx)
    if (Vx(i)>10000)
        Vx(i) = min(Vx);
    end
end

for i = 1:length(Vx)
    if (Vx(i)<-10000)
        Vx(i) = max(Vx);
    end
end

% mean(Velocity on x)
subplot(324);
plot(t(1:(end-1)),Vx);
ylabel('Vx hip[m/s]');
xlabel('t[s]');
title('Horizontal velocity  vs. time');

% Plot of displacement of the each steap with respect to step num
disp = diff(r0);
subplot(325);
stem(disp);
ylabel('displacement of the hip');
xlabel('number of step');
title('Displacement in each step');

% Plot step frequency with respect to step num
freq = diff([0 te]).^(-1);
subplot(326);
stem(freq);
ylabel('step frequency[1/s]');
xlabel('number of step');
title('Step frequency q1 vs. time');

% Plots of torques with respect to time
global U_total;
figure
subplot(321);
plot(U_total(3,:),U_total(1,:));
ylabel('u1[Nm]');
xlabel('t[s]');
title('Input u1 q1 vs. time');

subplot(322);
plot(U_total(3,:),U_total(2,:));
ylabel('u2[Nm]');
xlabel('t[s]');
title('Input u2 q1 vs. time');

% Calulation of the CoT
global dq_total;

sum1 = 0;
sum2 = 0;
sum = 0;
nb = 1;

N = size(dq_total(1,:));
for j = 2:1:(N(2)-1)
    dq = dq_total(1:3,j);
    u = U_total(1:3,j);
    u_plus = U_total(1:3,j+1);
    sum1 = sum1 + max([0, u(1)*(dq(1)-dq(3))])*(u_plus(3)-u(3));
    sum2 = sum2 + max([0, u(2)*(dq(2)-dq(3))])*(u_plus(3)-u(3));
    sum = sum1 + sum2;
end


COT = sum/((x_h_total(end)- x_h_total(1))*g*(m1 + m2 + m3))

% Plots of the limit cycles speed with respect to q position
subplot(3,2,3);
plot(Angles(:,1),Angles(:,4));
xlabel('q1');
ylabel('dq1');
title('limit cycle speed dq1 vs. q1');

subplot(3,2,4);
plot(Angles(:,2),Angles(:,5));
xlabel('q2');
ylabel('dq2');
title('limit cycle speed dq2 vs. q2');

subplot(3,2,5);
plot(Angles(:,3),Angles(:,6));
xlabel('q3');
ylabel('dq3');
title('limit cycle speed dq3 vs. q3');

%gait speed
t_a = sln.T{1,end-5};
t_b = sln.T{1,end};
q_tmp = sln.Y{1,end-5};
[x0, ~, ~, ~] = kin_swf(q_tmp(1,1:3));
q_tmp  =sln.Y{1,end};
[x1, ~, ~, ~] = kin_swf(q_tmp(1,1:3));
gait_speed = (x1+r0(end-1)-x0-r0(end-5))/(t_b(1)-t_a(1))

end