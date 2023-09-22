function Imp=midpointc(fun,a,b,M,varargin)
%MIDPOINTC Formula composita del punto medio.
%   IMP = MIDPOINTC(FUN,A,B,M) calcola una
%   approssimazione dell'integrale della funzione
%   tramite la formula composita del punto medio
%   (su M intervalli equispaziati). FUN e' una
%   function che riceve in ingresso un vettore x
%   e restituisce  un vettore reale. FUN puo' essere
%   una anonymous function o una function definita
%   in un M-file.
%   IMP = MIDPOINTC(FUN,A,B,M,P1,P2,...) passa alla
%   function FUN i parametri opzionali
%   P1,P2,... come FUN(X,P1,P2,...).
H=(b-a)/M;
x = linspace(a+H/2,b-H/2,M);
fmp=fun(x,varargin{:}).*ones(1,M);
Imp=H*sum(fmp);
return
