Once inside the folder of the project, open the "Stickybot_launch.m" file. 
By changing the parameters inside the commented section "ENTER YOUR COMMAND", you can now launch the robot.
Four parameters are available:
- controller: This value allows you to choose the type of controller fot the robot
	--> 1: PD controller
	--> 2: Trajectory planning controller

- perturbation: This value allows you to apply a perturbation to the robot during his trip or not
	--> 0: No perturbation
	--> 1: Apply a perturabtion

- min: This value allows you to choose the direction of the perturbation.
	--> 1: Positive pertubation
	--> -1: Negative pertubation

- gait: This value allows you to choose the gait of the robot.
	--> 1: 1st gait
	--> 2: 2nd gait
	--> 3: 3rd gait

- num_steps: This value allows you to choose the number of steps.
	--> Choose any interger