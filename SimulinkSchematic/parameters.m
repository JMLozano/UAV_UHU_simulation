clear
close all
clc


M1=0;% Torque
M2=0;%Anti torque

Inercia =0.0095;%Moment of inercia

d = 0.02; % Vertical distance from gravity center to flap
L = 0.5; % UAV diameter

Fsur =2.0614;% Fsur 
Keff = 0.9; %Keff
m = 1.460;%Mass
g=9.80665;%Gravity

%% PID values
kp_angle=6;

kp=23.0500;
ki=768.3330;
kd=0.1537;

%% Intial values
v0=0; % Angular velocity 
fi0=30; % Angle

%% load fuzzy controller 
ControlFuzzy=readfis('ControlFuzzy');