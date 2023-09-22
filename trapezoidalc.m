function defint = trapezoidalc(a,b,m, fun)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OCTAVE functions derived from a set of
% MATLAB functions prepared for the book
% 'Numerical Mathematics' by A.Quarteroni,
%  R. Sacco and F. Saleri
%
% Reviewed and adapted to OCTAVE by 
% L.Bonaventura, MOX - Polimi, 2010-15
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  defint = trapezoidal(a,b,m,fun)
%
%  Composite trapezoidal formula for
%  definite integral of f(x) on interval [a,b]
%
%  Input parameters:
%
%  fun      Function handle to function definining integrand f(x)
%  a,b      extremes of integration interval
%  m        number of subintervals
%
%  Output parameters:
%
%  defint        Value of composite trapezoidal approximation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=(b-a)/m; 
x=[a:h:b];
dim = max(size(x));
y=fun(x); 
if size(y)==1, 
   y=diag(ones(dim))*y; 
end 
defint=h*(0.5*y(1)+sum(y(2:m))+0.5*y(m+1));
return
