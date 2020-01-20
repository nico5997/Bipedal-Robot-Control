clc
close all
clear all

global gait;
global perturbation;
global controller;
global min;
%%%%%%%%%%%%%%%%%%%%%%%%%% ENTER YOUR COMMAND HERE %%%%%%%%%%%%%%%%%%%%%%%%

controller = 1;
gait = 1;
perturbation = 0;
min = 1;
num_steps = 20;


%%%%%%%%%%%%%%%%%%%%%%%%%% ENTER YOUR COMMAND HERE %%%%%%%%%%%%%%%%%%%%%%%%
addpath('./kinematics', './control', './dynamics', './set_parameters/', ...
    './solve_eqns/', './visualize', './analysis')
q0 = [pi/12; -pi/12; 0];
dq0 = [0;0;0];
[m1, m2, m3, l1, l2, l3, g] = set_parameters();
sln = solve_eqns(q0, dq0, num_steps);
animate(sln);
analyze(sln);

