function u = boundary_condition(varargin)
% update the velocity value as per the selected boundary condition
%
% u = boundary_condition(u, 'type', u0, T, dt, mu, dx)
% input :
%        u    = New velocity which boundary need to update
%        type = type of boundary condition
%               1. 'open'
%               2. 'rigid'
%               3. 'soft'
%       u0    = Old velocity
%       T     = Tension
%       dt    = time resolution
%       mu    = mass density
%       dx    = spacial resolution
%
% Example u = boundary_condition(u, 'open', )
%         u = boundary_condition(u, 'soft', u0, T, dt, mu, dx)
%
% Author : Ajay Lotekar
%

args = varargin; % get the input arguments
nargs = nargin;  % Number of arguments

if nargs == 0 % show only help
    help boundary_condition;
    return
end

if nargs<2
    error('input error: number of input argumens should be greater than or equal to two')
end



switch lower(args{2})
    case {'open'}
        u = args{1};
        u(1)    =   u(2);
        u(end)  = u(end-1);
    case {'rigid'}
        u = args{1};
        u(1)    = 0.0;
        u(end)  = 0.0;
    case {'soft'}
        if ~(nargs==7)
            error('input error: Not enough input argument')
        end
        u  = args{1};
        uo = args{3};
        T  = args{4}; 
        dt = args{5};
        mu = args{6};
        dx = args{7};
        
        u(1) =  (2-((T*dt^2)/(mu*dx^2)))*u(1)-uo(1)...
            +((T*dt^2)/(mu*dx^2))*u(2);
        u(end) = (2-((T*dt^2)/(mu*dx^2)))*u(end)-uo(end)...
            +((T*dt^2)/(mu*dx^2))*u(end-1);
        
end


end