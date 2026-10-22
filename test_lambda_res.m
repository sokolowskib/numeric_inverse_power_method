function test_lambda_res()
% Funkcja testowa weryfikująca poprawność wyznaczenia pary wartości i
% wektora własnego dla różnych macierzy

fprintf('%s\n',repmat('-', 1, 85));
fprintf(['TEST: Błąd pary wartości i wektora własnego w' ...
    ' różnych przypadkach\n'])
fprintf('Sprawdzenie błędu: ||Av - lambda*v||_2 / |lambda|\n')
fprintf('\n')
fprintf('%s\n',repmat('-', 1, 85));

% Definicje zestawów testowych (wartosci na przekątnej D)
test_sets = {
    [10, 5, 2],          % Dodatnia
    [10, -3, 8],         % Ujemna (najmniejszy moduł to |-3| = 3)
    [5+5i, 1-1i, 10],    % Zespolona (najmniejszy moduł to |1-i|=1.41)
    ones(1, 5),          % Wielokrotność I
    [100, 200, 5.5]      % Skrajne wartosci, |lambda_2 / lambda_1| >> 1
};

descriptions = {
    'Lambda wartością dodatnią',
    'Lambda wartością ujemną',
    'Lambda liczbą zespoloną',
    'A to Wielokrotność I',
    '|lambda_2 / lambda_1| >> 1'
};

tol = 1e-14;
maxIter = 100;

for k = 1:length(test_sets)
    D_vals = test_sets{k};
    n = length(D_vals);
    D = diag(D_vals);
    
    % generowanie macierzy unitarnej oraz inicjalizacja macierzy test. A
    [Q, ~] = qr(randn(n) + 1i * randn(n));
    A = Q * D * Q';
    
    % wywołanie metody
    [lambda, ~, errEst, iter] = inverse_power(A, tol, maxIter);
    
    % Znalezienie wartości teoretycznej dla porównania
    [~, idx] = min(abs(D_vals));
    expected_lambda = D_vals(idx);
    
    fprintf('Przypadek: %s\n', descriptions{k});
    fprintf('  %-20s %12.4f %+12.4fi\n', ...
        'Przybliżona lambda:', real(lambda), imag(lambda));
    fprintf('  %-20s %12.4f %+12.4fi\n', ...
        'Poprawna lambda:', real(expected_lambda), imag(expected_lambda));
    fprintf('  %-20s %12.2e\n', ...
        'Błąd względny:', errEst);
    fprintf('  %-20s %12d\n', ...
        'Iteracje:', iter);
    fprintf('%s\n', repmat('-', 1, 85));
end

fprintf('Test zakończony.\n');
end