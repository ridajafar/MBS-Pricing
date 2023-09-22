function price = mezzanine_tranche_price_dts_LHP(nu, Kd, Ku, p_default, rho, recovery, B_T, notional,options)
% Computed the price of a mezzanine tranche  with double t-student model
% with LHP approximation

% INPUT:
% nu:           degrees of freedom of t-student distribution
% Kd:           relative lower bound of the tranche
% Ku:           relative upper bound of the tranche
% p_default:    probability of default of one mortgage
% rho:          correlation between defaults of mortgages in the ptf
% recovery:     recovery rate of one mortgage
% B_T:          discount factor at maturity
% notional:     total notional of the ptf
% options:      to shut off/display the output of fsolve

% OUTPUT:
% price:        price of the tranche


% Parameters 
min_y = -30;
max_y = 30;

% Calibration of K
g = @(K) quadgk(@(y) tcdf((K-sqrt(rho).*y)./sqrt(1-rho),nu).*tpdf(y,nu),min_y,max_y) - p_default;
K0 = 0;
K = fsolve(g,K0,options);

% Definition of the derivative of P(z<=x)
y_star = @(x) - (tinv(x,nu).*sqrt(1-rho) - K)./sqrt(rho);
P_der = @(x) tpdf(-y_star(x),nu)*sqrt(1-rho)/sqrt(rho)./tpdf(tinv(x,nu),nu);

% Definition of the loss of the tranche
loss_tranche = @(z) min( max(((1-recovery).*z-Kd),0), (Ku-Kd));

% Computation of the integral
E = quadgk(@(z) P_der(z).*loss_tranche(z),0,1);

% Computation of the price of the tranche
price = B_T*notional*((Ku-Kd) - E);

end