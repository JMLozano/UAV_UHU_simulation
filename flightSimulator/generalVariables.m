function [M1,M2,Inercia,d,L,Fsur,Keff,m,g]=generalVariables()

    M1=0;% Torque
    M2=0;%Anti torque
    
    Inercia =0.0095;%Moment of inercia
    
    d = 0.02; % Vertical distance from gravity center to flap
    L = 0.5; % UAV diameter
    
    Fsur =2.0614;% Fsur 
    Keff = 0.9; %Keff
    m = 1.460;%Mass
    g=9.80665;%Gravity

end