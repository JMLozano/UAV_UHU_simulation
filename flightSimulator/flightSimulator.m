function flightSimulator()
clear all
clc
close all

global a1_real
global a2_real
global fuerza_real
global x_real
global y_real
global z_real
global tiempo_real

a1_real=45;
a2_real=45;
x_real=0;
y_real=0;
z_real=0;
fuerza_real=2.06141;
tiempo_real=1;

figure('rend','painters','pos',[10 10 900 600])

btnActualizar = uicontrol('Style', 'pushbutton', 'String', 'Run',...
    'Position', [25 580 50 25],...
    'FontSize', 15, ...
    'Callback', @dibujarGraf);
sldTiempo=uicontrol('Style','slider',...
    'Min',0.1,'Max',10,'Value',1',....
    'Position',[560 580 120 20],...
    'Callback',@actualizarTiempo);
txtTiempo=uicontrol('Style','text',...
    'Position',[560,560,120,20],'String','Time:');
sldA1=uicontrol('Style','slider',...
    'Min',0,'Max',90,'Value',45',....
    'Position',[80 580 120 20],...
    'Callback',@actualizarA1);
txtA1=uicontrol('Style','text',...
    'Position',[80,560,120,20],'String','a1:');
sldA2=uicontrol('Style','slider',...
    'Min',0,'Max',90,'Value',45',....
    'Position',[240 580 120 20],...
    'Callback',@actualizarA2);
txtA2=uicontrol('Style','text',...
    'Position',[240,560,120,20],'String','a2:');
sldA3=uicontrol('Style','slider',... %Fuerza
    'Min',0,'Max',13.36,'Value',2.0614',....
    'Position',[400 580 120 20],...
    'Callback',@actualizarFuerza);
txtA3=uicontrol('Style','text',...
    'Position',[400,560,120,20],'String','Force :');

stringTiempo=sprintf('Time: %f',tiempo_real);
set(txtTiempo,'String',stringTiempo);
stringA1=sprintf('a1: %f',a1_real);
set(txtA1,'String',stringA1);
stringA2=sprintf('a2: %f',a2_real);
set(txtA2,'String',stringA2);
stringA3=sprintf('Force: %f',fuerza_real);
set(txtA3,'String',stringA3);
        

[x_real,y_real,z_real]=aGlobalLocal(a1_real,a2_real,x_real,y_real,z_real,tiempo_real,fuerza_real);


    function actualizarTiempo(source,event)
        tiempo_real=source.Value;
        stringTiempo=sprintf('Time: %f',tiempo_real);
        set(txtTiempo,'String',stringTiempo);
    end
    function actualizarA1(source,event)
        a1_real=source.Value;
        stringA1=sprintf('a1: %f',a1_real);
        set(txtA1,'String',stringA1);
    end
    function actualizarA2(source,event)
        a2_real=source.Value;
        stringA2=sprintf('a2: %f',a2_real);
        set(txtA2,'String',stringA2);
    end
    function actualizarFuerza(source, event)
        fuerza_real=source.Value;
        stringA3=sprintf('Force: %f',fuerza_real);
        set(txtA3,'String',stringA3);
    end
    function dibujarGraf(source,event)
                [x_real,y_real,z_real]=aGlobalLocal(a1_real,a2_real,x_real,y_real,z_real,tiempo_real,fuerza_real)
    end
    function [posXfin,posYfin,posZfin]=aGlobalLocal(a1,a2,posX,posY,posZ,tMax,fuerza)
        [M1,M2,Inercia,d,L,Fsur,Keff,m,g]=generalVariables();
        
        Fsur=fuerza;
        
        eulerX = -Fsur * Keff *(cosd(a2) - sind(a2)) * (d + L/2)/Inercia;
        eulerY = Fsur * Keff *(cosd(a1) - sind(a1)) * (d + L/2)/Inercia;
        eulerZ = (M1 - M2)/Inercia;
        
        P = Keff*cosd(a1)-4*Keff+Keff*cosd(a2)+Keff*sind(a1)+Keff*sind(a2)+8;
        
        tiempo=0:0.1:tMax;
        tiempo=1;
        i=1;
        t=1;
        
        posX_tiempo(1)=posX;
        posY_tiempo(1)=posY;
        posZ_tiempo(1)=posZ;
        

            
            t=1;%tiempo(i);
            
            
            eulerX_Int=1/2*eulerX*t^2;%Posición angular
            eulerY_Int=1/2*eulerY*t^2;
            eulerZ_Int=1/2*eulerZ*t^2;
            
            accX_1=Keff*cosd(eulerZ_Int)*cosd(eulerY_Int)*(cosd(a1)-sind(a1));
            accX_2=Keff*(cosd(a2)-sind(a2))*(cosd(eulerX_Int)*sind(eulerZ_Int)+cosd(eulerZ_Int)*sind(eulerX_Int)*sind(eulerY_Int));
            accX_3=(sind(eulerX_Int)*sind(eulerZ_Int)-cosd(eulerX_Int)*cosd(eulerZ_Int)*sind(eulerY_Int))*P;
            accX=accX_1+accX_2-accX_3;
            accX=-(Fsur/m*accX);
            
            accY_1=Keff*cosd(eulerY_Int)*sind(eulerZ_Int)*(cosd(a1)-sind(a1));
            accY_2=Keff*(cosd(a2)-sind(a2))*(cosd(eulerX_Int)*cosd(eulerZ_Int)-sind(eulerX_Int)*sind(eulerZ_Int)*sind(eulerY_Int));
            accY_3=(cosd(eulerZ_Int)*sind(eulerX_Int)+cosd(eulerX_Int)*sind(eulerZ_Int)*sind(eulerY_Int))*P;
            accY=accY_1-accY_2+accY_3;
            accY=Fsur/m*accY;
            
            accZ_1=Keff*sind(eulerY_Int)*(cosd(a1)-sind(a1));
            accZ_2=Keff*cosd(eulerY_Int)*sind(eulerX_Int)*(cosd(a2)-sind(a2));
            accZ_3=cosd(eulerX_Int)*cosd(eulerY_Int)*P;
            accZ=accZ_1+accZ_2+accZ_3;
            accZ=((Fsur/m)*(accZ))-g;
            accZ=round(accZ,4);
            
            posX_tiempo(i+1)=posX+1/2*accX*t^2;
            posY_tiempo(i+1)=posY+1/2*accY*t^2;
            posZ_tiempo(i+1)=posZ+1/2*accZ*t^2;
            if(posZ_tiempo(i+1)<0)
                posZ_tiempo(i+1)=0;
            end
            

        xlabel('x');
        hold on
        ylabel('y');
        zlabel('z');
        grid on
        plot3((posX_tiempo),(posY_tiempo),(posZ_tiempo),'s','MarkerEdgeColor','b')
        xlim([-100 100])
        ylim([-100 100])
        zlim([0 50])
        
     
        posXfin=posX_tiempo(2);
        posYfin=posY_tiempo(2);
        posZfin=posZ_tiempo(2);
    end
end