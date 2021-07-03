function du = push(varargin)
% Function give the initial acceleration with given input choice
%
% du = push(du, 'positive', x, wd)
% Inputs : 
%           du  : accleration 
%           dir : direction of accelaration
%               1. 'postive'
%               2. 'negative'
%               3. 'zero'
%
%
% Author: Ajay Lotekar

args = varargin; % get the input arguments
nargs = nargin;  % Number of arguments

if nargs>5
    error('input error: number of input argumens should not be greater 5')
end

switch lower(args{2})
    case {'positive'}
        du = args{1};
        x  = args{3};
        wd = args{4};
        c  = args{5};
        
        idx = 2:length(du)-1;
        du(idx)  = 2*(1/wd)*c*(x(idx)- 0.5).*exp(-(1/wd)*(x(idx)- 0.5).^2);

    case {'negative'}
        du = args{1};
        x  = args{3};
        wd = args{4};
        c  = args{5};
        
        idx = 2:length(du)-1;
        du(idx)  = -2*(1/wd)*c*(x(idx)- 0.5).*exp(-(1/wd)*(x(idx)- 0.5).^2);
    case {'zero'}    
        du = args{1};   
end

end
