%% Plot Controller
% Author: Xinyi Cai
% Date: 11/18/2020

%% Housekeeping
close all
clear all
clc

%% Initialization
addpath('./Controller_Data')

%% Data Extraction
filename = {'GT_BridgeCrane_Data_FBControl_0.6.csv',... 
            'GT_BridgeCrane_Data_FBControl_0.8.csv',... 
            'GT_BridgeCrane_Data_FBControl_1.0.csv'}; 

for i = 1:length(filename)
    data = importfile_bridge(filename{i}, [2 inf]); 

    y_deflection = data.YPayloadDeflectionmm; 

    % Remove bias
    y_deflection = y_deflection - mean(y_deflection(end-20:end)); 
    y_def{i} = y_deflection; 

end


%%
load('Simulation Data.mat')

Ts = 0.05; 
figure; 
set(gcf,'position',[100, 100, 800, 400])

L06m = y_def{1};
L06m = L06m(9:end);
L1m = y_def{3};
L1m = L1m(7:end);

hold on; grid on
plot(t1, (x1(:, 2)*1000), 'r--')
plot(0:Ts:length(L06m)*Ts - Ts, L06m, 'b')
plot(0:Ts:length(y_def{2})*Ts - Ts, y_def{2}, 'g')
plot(0:Ts:length(L1m)*Ts - Ts, L1m, 'r')
legend('Simulation: L = 1 m', 'L = 0.6 m', 'L = 0.8 m', 'L = 1.0 m')
xlabel('Time (s)')
ylabel('Deflection (mm)')
title('Full State Feedback Control Performance')


