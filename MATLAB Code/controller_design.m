%% Controller Design
% Author: Xinyi Cai
% Date: 11/3/2020

%% Housekeeping
clear all
clc

%% Initialization
addpath('../RLS')
load bridgeCraneID.mat

%% LQR Gain
q1_max = 3; 
q2_max = deg2rad(30); 
u_max = 5; 

Q = diag([1/q1_max, 1/q2_max]); 
R = 1/u_max; 

K = lqr(A, B, Q, R)