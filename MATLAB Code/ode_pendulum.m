%% Pendulum Simulation
% Author: Xinyi Cai
% Date: 11/3/2020

%% Housekeeping
clear all
clc

%% Pendulum Simulation
x0 = [0; 0; deg2rad(30); 0]; 
F = 0; 
options = odeset('RelTol', 1.0E-08, 'AbsTol', 1.0E-08);
[tout, yout] = ode45(@pendulum, [0 5], x0, options, F); 

%% Plotting
subplot(2, 1, 1);
plot(tout, rad2deg(yout(:, 3))); 
title('Pendulum Position vs Time'); 
xlabel('Time (s)'); 
ylabel('Angle (degree)'); 

subplot(2, 1, 2);
plot(tout, yout(:, 1)); 
title('Trolley Position vs Time'); 
xlabel('Time (s)'); 
ylabel('Distance (m)'); 

