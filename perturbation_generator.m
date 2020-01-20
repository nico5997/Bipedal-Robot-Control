function u_pertubation = perturbation_generator()

global gait;
global controller;
global min;

% Positive torque applied
if (min == 1) 
    % PD control
    if (controller == 1)
        if (gait == 1)
            % Maximum value legs controller = 65
            u_pertubation = 65;
        elseif (gait == 2)
            % Maximum value legs controller = 70 
            u_pertubation = 70;
        elseif (gait == 3)
            % Maximum value legs controller = 34
            u_pertubation = 34;
        end
    % Trajectory planning control
    elseif(controller == 2)
        if (gait == 1)
            % Maximum value legs controller = 111
            u_pertubation = 111;
        elseif (gait == 2)
            % Maximum value legs controller = 40
            u_pertubation = 40;
        elseif (gait == 3)
            % Maximum value legs controller = 38
            u_pertubation = 38; 
        end
    end
% Negative torque applied
elseif (min == -1)
    % PD control
    if (controller == 1)
        if (gait == 1)
            % Maximum value legs controller = -10
            u_pertubation = -10;
        elseif (gait == 2)
            % Maximum value legs controller = -35
            u_pertubation = -35;
        elseif (gait == 3)
            % Maximum value legs controller = -18
            u_pertubation = -18;
        end
    % Trajectory planning control
    elseif(controller == 2)
        if (gait == 1)
            % Maximum value legs controller = -16
            u_pertubation = -16;
        elseif (gait == 2)
            % Maximum value legs controller = -3
            u_pertubation = -3;
        elseif (gait == 3) 
            % Maximum value legs controller = -50
            u_pertubation = -50;
        end
    end
end

end