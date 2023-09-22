function price = mezzanine_tranche_price_dts_KL(nu, Kd, Ku, p_default, rho, recovery, B_T, notional, I, options)
% Computes the price of a mezzanine tranche with double t-student model
% with KL approximation

% INPUT:
% nu:           degrees of freedom of t-student distribution
% Kd:           relative lower bound of the tranche
% Ku:           relative upper bound of the tranche
% p_default:    probability of default of one mortgage
% rho:          correlation between defaults of mortgages in the ptf
% recovery:     recovery rate of one mortgage
% B_T:          discount factor at maturity
% notional:     total notional of the ptf
% I:            number of mortgages (can be a vector)
% options:      to shut off/display the output of fsolve
% flag:         (optional) sets the integration rule for the outer integral
%                          1: rectangular
%                          2: trapezoidal
%                          3: Cavalieri-Simpson

% OUTPUT:
% price:        price of the tranche


% If flag is not set, automatically use the rectangular rule
if nargin<11
    flag=1;
end

% Initialization
price = zeros(size(I))';

% Parameters
min_y = -30;
max_y = 30;

% Calibration of K
g = @(K) quadgk(@(y) tcdf((K-sqrt(rho).*y)./sqrt(1-rho),nu).*tpdf(y,nu),min_y,max_y) - p_default;
K0 = 0;
K = fsolve(g,K0,options);

% Computation of the probability of 1 default given y
p = @(y) tcdf((K-sqrt(rho).*y)./sqrt(1-rho),nu);

% Computation of the Kullabck-Leibler approximation
KL = @(z,y) z.*log(z./p(y))+(1-z).*log((1-z)./(1-p(y)));

% Definition of the loss of the tranche
loss_tranche = @(z) min( max(((1-recovery).*z-Kd),0), (Ku-Kd));

for i=1:length(I)

    % Computation of the C1 coefficient
    C1 = @(z) sqrt(I(i)./(2.*pi.*z.*(1-z)));

    % Computation of the inner integral
    int_inner = @(y)  arrayfun(@(y) quadgk(@(z) C1(z).*exp(-I(i).*KL(z,y)).*loss_tranche(z), 0, 1), y); %internal integral with quadgk

    % Computation of the outer integral
    fun = @(y) int_inner(y).*tpdf(y,nu);
    M=1000;
    switch flag
        case 1
            int_ext = midpointc(fun,min_y,max_y,M);
        case 2
            int_ext = trapezoidalc(min_y,max_y,M,fun);
        case 3
            int_ext = simpsonc(min_y,max_y,M,fun);
        otherwise
            disp('Wrong value for flag');
            return
    end
    
    % Computation of the price
    price(i) = B_T*notional*((Ku-Kd) - int_ext);

end

end