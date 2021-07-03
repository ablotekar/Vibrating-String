%% Vibrating String
% 
% Simulation of the vibrating string with different boundary
%
%
%
% Author: Ajay Lotekar
%%
clear; close all; clc;

Nt      = 1000;         % number of time steps 
maxtime = 0.01;          % maximum simulation time 
dt      =  0.0001;      % time increment 
N       =  101;         % number of points in the x-grid 
L       =  1;           % string length 
dx      =  0.01;        % space increment 
x       =  0:dx:1;      % x array 
T       =  10;          % tension 
mu      =  0.001;       % mass density 
c       =  100;         % wave velocity 
wd      = 0.01;         % width of perturbation
epsilon = (dt*c/dx)^2; % Needs to remain < 1 to insure stability
boundary = 'rigid';   % Options: rigid, open, soft
accl     = 'zero';    % Options: positive, negative, zero

% Initialize U and Uold. Lets  Uold = u(0), U = u(x,1) dt). 
time = 0.0;        
U0  = zeros(1,N); 
dU0 = zeros(1,N);
U    = zeros(1,N);
Unew = zeros(1,N); 

% counters
idx = 2:(N-1);

% Initial condition  
U0(idx)   = exp(-(1/wd)*(x(idx) - 0.5).^2);

dU0 = push(dU0, accl, x, wd,c);

Uold = U0; 

U(idx) = 0.5*epsilon*(U0(idx+1) + U0(idx-1)) ...
                    + (1.0-epsilon)*U0(idx) + dt * dU0(idx); 


while time < maxtime 
    time    = time + dt; 
    % Boundary condtion 
    Unew = boundary_condition(Unew, boundary, Uold, T, dt, mu, dx);
    
    
       Unew(idx) = epsilon * ( U(idx+1) + U(idx-1) ) + ... 
             2.d0 * (1.0-epsilon)*U(idx) - Uold(idx); 
         
    
    % Shuffle arrays, and animate 
    Uold = U; 
    U    = Unew; 
    
    tim = ['\color{red}','Time = ', num2str(time), ' s'];
    clf        % Animation Step 1: clear the screen 
    plot(x,U,'m','LineWidth',2)  % Animation Step 2: plot the new data
    axis([0 1, -1 1.2]);
    title(tim, 'FontSize' , 12, 'FontWeight', 'bold')
    xlabel('X','FontSize',12,'FontWeight','bold') % x-axis label
    ylabel('Y','FontSize',12,'FontWeight','bold') % y-axis label
    grid on 
    ax= gca;
    ax.GridLineStyle = '--';
   
    
    pause(0.04)
  
 
end