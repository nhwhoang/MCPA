set(0,'DefaultFigureWindowStyle','docked')
      
% Constant and parameters
m = 9.10938215e-31;             
g = 9.80665;                     
q = 1.60217653e-19;            

dt = 0.1;   
t = 0;
N = 200;    % number of advancement
dl = 0;     % distance travelled
E = 10e3;
F = q*E;

% Set position and velocity at 0
X = zeros(1,N);
Vx = zeros(1,N);

% Advance electron and update X and Vx
for i = 2:N
    dVx = F/m * dt;
    Vx(i) = Vx(i-1) + dVx;
    
    dx = Vx(i-1) + dVx;
    X(i) = X(i-1) + dx;
    
    dl = dl + dx;   % travel distance
    t = t + dt;
    
    % Scattering
    Pscat = 0.05;   
    if rand() <= Pscat
        Vx(i) = 0;
    end
    
    % Drift velocity calculation
    Vdx = sum(Vx)/i;
    
    % Plots
    subplot(2,1,1);
    plot([t-dt,t],[X(i-1),X(i)]);
    hold on;
    xlabel('Time');
    ylabel('Position');
    pause(1e-7)
    
    subplot(2,1,2); 
    plot([t-dt,t],[Vx(i-1),Vx(i)]);
    hold on;
    xlabel('Time');
    ylabel('Velocity');
    title(sprintf('Drift velocity (in blue): %.4d m/s', Vdx));
    plot(t,Vdx,'b*');
    pause(1e-7)
    
end