%% Full State Feedback Controller (u = -Kx)

% Housekeeping:
close all
clear
clc

g = 9.81; % Acceleration due to gravity in m/s^2
L = 1; % Cable Length
wn = sqrt(g/L); % Natural Frequency of Pendulum
zeta = 0.0078; % Damping of system

% Setting State Matrices of System:
A = [0, 1, 0, 0; 
    -g/L, (-2*wn*zeta), 0, 0;
    0, 0, 0, 1;
    0, 0, 0, 0]; 
B = [0; 1/L; 0; 1]; 
C = [0 (-1/L) 0 0; 0 0 0 0; 0 0 0 1];
D = 0;

% Creating the desired poles of the controlled system:
wn_des = 1 .* sqrt(g/L); % Desired natural frequency of the controlled system
zeta_des = 0.5; % Desired damping of the controlled system
Pd1 = (-zeta_des .* wn) + (sqrt((zeta_des.^2) - 1).*wn_des);
Pd2 = conj(Pd1);
Pd3 = -2 + 2i;
Pd4 = conj(Pd3);
Pd = [Pd1; Pd2; Pd3; Pd4];

K = place(A, B, Pd); % Calculating the full state feedback controller gains

A_new = A - (B*K); % Calculating the system's new state matrix

csys = ss(A_new, B, C, D); % Creating controlled continuous-time system

% Performing Linear Simulation:
t = [0:0.01:9];
u = ones(length(t), 1);
x0 = [0 (0.2*L) 0 0];
[y1, t1, x1] = lsim(csys, u, t, x0);

% Plotting Results:
figure
subplot(4, 1, 1)
plot(t1, x1(:, 1), 'b')
xlabel('Time (s)')
ylabel('Integral of Deflection')

subplot(4, 1, 2)
plot(t1, x1(:, 2), 'b')
xlabel('Time (s)')
ylabel('Deflection')

subplot(4, 1, 3)
plot(t1, x1(:, 3), 'r')
xlabel('Time (s)')
ylabel('Integral of Position')

subplot(4, 1, 4)
plot(t1, x1(:, 4), 'r')
xlabel('Time (s)')
ylabel('Position')
