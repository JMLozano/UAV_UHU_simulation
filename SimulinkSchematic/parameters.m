clear
close all
clc


M1=0;% Torque
M2=0;%Anti torque

Inercia =0.0067;%Moment of inercia

d = 0.02; % Vertical distance from gravity center to flap
L = 0.5; % UAV diameter

Fsur =2.0614;% Fsur 
Keff = 0.9; %Keff
m = 1.460;%Mass
g=9.80665;%Gravity

%% PID values
kp_angle=2.55;
kp=15.8;
ki=0.35;
kd=0;


%% Intial values
v0=0; % Angular velocity 
fi0=45; % Angle

%% load fuzzy controller 
ControlFuzzy=readfis('ControlFuzzyManual.fis');
ControlFuzzyMam=readfis('ControlGeneticFuzzyMamdani.fis');
ControlFuzzySug=readfis('ControlGeneticFuzzySugeno.fis');
