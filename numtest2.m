function numtest2()
% Celem testu jest weryfikacja teoretycznej zależności tempa zbieżności 
% od ilorazu dwóch najmniejszych (co do modułu) wartości własnych.

fprintf('%s\n', repmat('-', 1, 85));
fprintf(['TEST NUMERYCZNY 2: Wpływ ilorazu |lambda1 / lambda2| na zbieżność' ...
    ' metody\n'])
fprintf('%s\n', repmat('-', 1, 85));

n = 50;
gaps = [10, 2, 1.1, 1.01, 1.001]; % gaps(i) to |lambda2 / lambda1|
iter_counts = zeros(length(gaps), 1);
final_errors = zeros(length(gaps), 1);

for k = 1:length(gaps)
    gap = gaps(k);
    
    % lambda1 = 1, lambda2 = gap
    D = diag([1, gap, linspace(gap + 1, gap + 10, n - 2)]);
    
    % tworzenie testowej macierzy z wyznaczonym stosunkiem 2 minimalnych 
    % lambd jak wyżej
    [Q, ~] = qr(randn(n) + 1i * randn(n));
    A = Q * D * Q';
    
    [~, ~, errEst, iter] = inverse_power(A, 1e-14, 1000); 
    iter_counts(k) = iter;
    final_errors(k) = errEst;
    
    fprintf('Iloraz: %6.3f | Iteracje: %4d | Błąd końcowy: %1.2e\n', ...
            gap, iter, final_errors(k));
end

fprintf('%s\n', repmat('-', 1, 85));
fprintf('Test zakończony.\n');
end