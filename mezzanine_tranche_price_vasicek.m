function price = mezzanine_tranche_price_vasicek(Kd, Ku, p_default, rho, recovery, B_T, notional)
% Computes the price of a mezzanine tranche with Vasiceck model

% INPUT:
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


% Calibration of K
K = norminv(p_default);

% Definition of the derivative of P(z<=x)
y_star = @(x) - (norminv(x).*sqrt(1-rho) - K)./sqrt(rho);
P_der = @(x) normpdf(-y_star(x))*sqrt(1-rho)/sqrt(rho)./normpdf(norminv(x));

% Definition of the loss of the tranche
loss_tranche = @(z) min( max(((1-recovery).*z-Kd),0), (Ku-Kd));

% Computation of the integral
E = quadgk(@(z) P_der(z).*loss_tranche(z),0,1);

% Computation of the price of the tranche
price = B_T*notional*((Ku-Kd) - E);

end