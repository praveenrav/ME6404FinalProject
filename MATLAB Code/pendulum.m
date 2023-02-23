%% Pendulum Dynamics

function xdot = pendulum(t, x, u)

% Parameters 
g = 9.81; % gravity
mc = 1; 
mb = 0.5; 
L = 0.54; 
F = u;
mT = mb+mc; 

 
 % Solving mass matrix
M = [mT, mb*L*cos(x(3)); 
     cos(x(3)), L]; 

b = [F - mb*x(4)^2*L*sin(x(3)); 
     -g*sin(x(3))]; 

Z = M\b; 
  
xdot = [x(2); Z(1); x(4); Z(2)]; 
   
     
 