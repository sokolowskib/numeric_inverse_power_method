% skrypt do wykresu

% dane z testu numtest3
gaps = [1.500, 1.100, 1.050, 1.010, 1.001];

time_std = [0.0400, 0.0746, 0.1312, 0.4734, 0.6398];
err_std  = [8.9e-09, 9.2e-09, 9.6e-09, 9.9e-09, 1.1e-04];

time_shift = [0.1198, 0.1170, 0.1167, 0.1400, 0.1170];
err_shift  = [1.5e-15, 1.4e-15, 1.5e-15, 1.6e-15, 1.9e-15];

figure('Name', 'Porównanie Metod', 'Color', 'w');

subplot(2, 1, 1);
plot(gaps, time_std, '-o', 'LineWidth', 2, 'MarkerSize', 8); hold on;
plot(gaps, time_shift, '-s', 'LineWidth', 2, 'MarkerSize', 8);
set(gca, 'XDir', 'reverse'); 
grid on;
ylabel('Czas wykonania [s]');
title('Wydajnosc czasowa w zaleznosci od |\lambda_2/\lambda_1|');
legend('Standardowa', 'Z przesunięciem', 'Location', 'northwest');

subplot(2, 1, 2);
semilogy(gaps, err_std, '-o', 'LineWidth', 2, 'MarkerSize', 8); hold on;
semilogy(gaps, err_shift, '-s', 'LineWidth', 2, 'MarkerSize', 8);
set(gca, 'XDir', 'reverse');
grid on;
xlabel('|\lambda_2/\lambda_1|');
ylabel('Blad względny');
title('Błąd względny w zależności od |\lambda_2/\lambda_1|');
legend('Standardowa', 'Z przesunięciem', 'Location', 'northwest');