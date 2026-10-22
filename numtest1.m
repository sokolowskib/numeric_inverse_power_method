function numtest1()
% Celem testu jest określenie wpływu rozmiaru macierzy (N) na czas 
% wykonania oraz precyzję uzyskanego przybliżenia wartości własnej.

fprintf('%s\n', repmat('-', 1, 100));
fprintf(['TEST NUMERYCZNY 1: Wpływ rozmiaru macierzy na poprawność ' ...
    'przybliżenia i czas wykonania funkcji\n'])
fprintf('%s\n', repmat('-', 1, 100));

% Rozmiary macierzy do testów
sizes = [10, 100, 250, 500, 1000]; 
results_err = zeros(length(sizes), 1);
results_time = zeros(length(sizes), 1);

for k = 1:length(sizes)
    n = sizes(k);

    % Konstrukcja macierzy o znanych wartościach własnych
    D = diag([1, linspace(10, 20, n - 1)]);
    [Q, ~] = qr(randn(n) + 1i * randn(n));
    A = Q * D * Q';
    
    % włączenie zegarka
    tic;
    [~, ~, errEst, iter] = inverse_power(A, 1e-14, 100);
    results_time(k) = toc;
    results_err(k) = errEst;
    
    fprintf('N = %4d | Czas: %6.4fs | Błąd: %1.2e | Iteracje: %d\n', ...
            n, results_time(k), results_err(k), iter);
end
fprintf('%s\n', repmat('-', 1, 100));
fprintf('Test zakończony.\n');
end