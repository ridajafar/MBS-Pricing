function semilogx_tranche_prices(I, price_approx, price_exact, price_LHP)
% Plot in log-lin scale the price of the tranche with KL and LHP
% approximation and the exact one

figure()
semilogx(I,price_approx,'-o','Color','#0072BD','LineWidth',1.3)
hold on
semilogx(I(1:3),price_exact,'-o','Color','#D95319','LineWidth',1.3)
semilogx(I,price_LHP*ones(size(I)),'Color','#EDB120','LineWidth',1.3)
grid on
axis padded
xlabel('Number of mortgages')
ylabel('Relative price of the tranche')
legend('KL approximation','Exact solution','LHP approximation')
hold off

end