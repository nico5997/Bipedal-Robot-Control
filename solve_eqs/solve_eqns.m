function sln = solve_eqns(q0, dq0, num_steps)

options = odeset('RelTol',1e-5,'Events',@event_func);
h = 0.001; % time step
tmax = 2; % max time that we allow for a single step
tspan = 0:h:tmax; % from 0 to tmax with time step h
y0 = [q0; dq0];
t0 = 0;

% we define the solution as a structure to simplify the post-analyses and
% animation, here we intialize it to null.

sln.T = {};
sln.Y = {};
sln.TE = {};
sln.YE = {};

global sys_disturbated_yet;
sys_disturbated_yet = 0;

for i = 1:num_steps
   [T, Y, TE, YE] = ode45(@(t, y) eqns(t, y, y0, i), t0 + tspan, y0, options); % use ode45 to solve the equations of motion (eqns.m)
   sln.T{i} = T;
   sln.Y{i} = Y;
   sln.TE{i} = TE;
   sln.YE{i} = YE;
   
    if T(end) == tmax
        break
    end
    % Impact map
    if (isempty(YE)) 
        break
    end
    [y0(1:3), y0(4:6)] = impact(YE(1:3)', YE(4:6)');
    t0 = T(end);
    
end

end


