%% Run assignment 4 - group 7

clear;
close all;
clc;
format long;
options = optimset('Display','off'); % set to on to see output of fsolve 


%% Market data

if ispc()   % Windows version
    formatData='dd/mm/yyyy'; 
    [datesSet, ratesSet] = readExcelData('MktData_CurveBootstrap_AY22-23', formatData);
else        % MacOS version
    datesSet = load("datesSet.mat");
    datesSet = datesSet.datesSet;
    ratesSet = load("ratesSet.mat") ;
    ratesSet = ratesSet.ratesSet;
end

% Bootstrap
[dates, discounts] = BootStrap(datesSet, ratesSet);


%% Parameters

notional = 2e9;
T = 4;
p_default = 0.05;
rho = 0.5;
recovery = 0.3;
B_T = discounts(15);


%% a) Price of a mezzanine tranche with double t-student

nu = 4;
Kd = 0.06;
Ku = 0.09;
notional_mezzanine = notional*(Ku-Kd);

% Compute the price
price_dts_LHP = mezzanine_tranche_price_dts_LHP(nu, Kd, Ku, p_default, rho, recovery, B_T, notional,options);


%% b) Price of a mezzanine tranche with Vasicek

nu_b = 200;

% Compute the prices
price_vasiceck = mezzanine_tranche_price_vasicek(Kd, Ku, p_default, rho, recovery, B_T, notional);
price_dts_b = mezzanine_tranche_price_dts_LHP(nu_b, Kd, Ku, p_default, rho, recovery, B_T, notional,options);

% Display relative difference
disp('The relative difference between the price with vasiceck and double t-student with nu=200 is:')
disp(abs(price_vasiceck - price_dts_b)/price_vasiceck);


%% c) Homogenius Portfolio

I = [10; 30; 50; 1e2; 5e2; 1e3; 5e3; 1e4; 2e4];

% Compute the prices
price_approx = mezzanine_tranche_price_dts_KL(nu, Kd, Ku, p_default, rho, recovery, B_T, notional, I, options)/notional_mezzanine;
price_exact = mezzanine_tranche_price_dts_exact(nu, Kd, Ku, p_default, rho, recovery, B_T, notional, I(1:3), options)/notional_mezzanine;
price_LHP = price_dts_LHP/notional_mezzanine;

% Plot the prices
semilogx_tranche_prices(I, price_approx, price_exact, price_LHP);


%% d) 

Ku_equity = 0.03;
Kd_equity = 0;
notional_tranche_equity = (Ku_equity-Kd_equity)*notional;

% Compute the prices
price_approx_equity = mezzanine_tranche_price_dts_KL(nu, Kd_equity, Ku_equity, p_default, rho, recovery, B_T, notional, I, options)/notional_tranche_equity;
price_exact_equity = mezzanine_tranche_price_dts_exact(nu, Kd_equity, Ku_equity, p_default, rho, recovery, B_T, notional, I(1:3), options)/notional_tranche_equity;
price_LHP_equity = mezzanine_tranche_price_dts_LHP(nu, Kd_equity, Ku_equity, p_default, rho, recovery, B_T, notional,options)/notional_tranche_equity;

% Plot the prices
semilogx_tranche_prices(I, price_approx_equity, price_exact_equity, price_LHP_equity);


%% Alternative approach

% Compute the price of the reference portfolio
P_portfolio = B_T*notional*(1-(1-recovery)*p_default);

% Parameters for the remaining tranche
Kd_tranche = 0.03;
Ku_tranche = 1;
notional_tranche = notional*(Ku_tranche-Kd_tranche);

% Compute the prices of the equity tranche
price_equity_approx = (P_portfolio - mezzanine_tranche_price_dts_KL(nu, Kd_tranche, Ku_tranche, p_default, rho, recovery, B_T, notional, I, options))/notional_tranche_equity;
price_equity_exact = (P_portfolio - mezzanine_tranche_price_dts_exact(nu, Kd_tranche, Ku_tranche, p_default, rho, recovery, B_T, notional, I(1:3), options))/notional_tranche_equity;
price_equity_LHP = (P_portfolio - mezzanine_tranche_price_dts_LHP(nu, Kd_tranche, Ku_tranche, p_default, rho, recovery, B_T, notional, options))/notional_tranche_equity;

% Plot the prices
semilogx_tranche_prices(I, price_equity_approx, price_equity_exact, price_equity_LHP);

