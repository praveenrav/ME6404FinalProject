%% Housekeeping
clear all
clc

%% Parameters
g = 9.81; 
L = 1; 

%%
A = [0, 1, 0, 0; 
    -g/L, 0, 0, 0;
    0, 0, 0, 1;
    0, 0, 0, 0]; 
B = [0; -1/L; 0; 1]; 
C = [0 (-1/L) 0 0; 0 0 1 0; 0 0 0 1];
D = 0;

q1_max = 5*pi/180;     % rad*s
q2_max = 5*pi/180;      % rad
q3_max = 5;            %m
u_max = 10;             % m/s

Q = diag([1/q1_max, 1/q2_max, 1/q3_max, 1]); 
%Q = eye(4);
R = 1/u_max; 

K = lqr(A, B, Q, R);

A_new = (A - B*K);
csys = ss(A_new, B, C, D);

%r_coef = -1 .* inv(C * inv(A_new) * B)

% Performing Linear Simulation:
t = [0:0.01:10];
u = ones(length(t), 1);
x0 = [0 pi/6 0 0];
[y1, t1, x1] = lsim(csys, u, t, x0);
S1 = lsiminfo(y1, t1);

figure
subplot(4, 1, 1)
plot(t1, x1(:, 1), 'b')
xlabel('Time (s)')
ylabel('Integral of Angle * Length')

subplot(4, 1, 2)
plot(t1, x1(:, 2), 'b')
xlabel('Time (s)')
ylabel('Angle * Length')

subplot(4, 1, 3)
plot(t1, x1(:, 3), 'r')
xlabel('Time (s)')
ylabel('Integral of Position')

subplot(4, 1, 4)
plot(t1, x1(:, 4), 'r')
xlabel('Time (s)')
ylabel('Position')

