function test_stop() 
% Test sprawdza, czy funkcja reaguje poprawnie na ustalenie małej
% tolerancji na błąd

fprintf('%s\n',repmat('-', 1, 110));
fprintf('TEST: Weryfikacja poprawności warunku stopu (parametr tol)\n')
fprintf(['Test uruchamia funkcję dla tej samej macierzy z różnymi ' ...
    'wartościami tol\n'])
fprintf(['Sprawdzana jest korelacja między zadaną precyzją a ' ...
    ' liczbą wykonanych iteracji oraz zbieżnością metody.\n'])
fprintf('\n')
fprintf('%s\n',repmat('-', 1, 110));

% Tworzymy macierz diagonalną o znanych i dobrze odseparowanych wartościach 
% własnych
D = diag([1, 10, 20, 30, 40]); 
n = 5;

[Q, ~] = qr(randn(n) + 1i * randn(n)); % Losowa macierz unitarna

% Konstrukcja macierzy A podobnej do D, macierz A ma te same wartości
% własne co D (czyli wartości na diagonali)
A = Q * D * Q';

% lista testowanych tolerancji
tols = [1e-2; 1e-4; 1e-6; 1e-8; 1e-10; 1e-13];
m = length(tols);
final_err = zeros(m, 1);
iter_counts = zeros(m, 1);
labels = strings(m, 1);

for k = 1:m
    current_tol = tols(k);
    % wywołanie metody
    [~, ~, errEst, iter] = inverse_power(A, current_tol, 500);
    
    final_err(k) = errEst;
    iter_counts(k) = iter;
    labels(k) = sprintf('tol = %.0e', current_tol);
end

T = table(labels, iter_counts, final_err, ...
    'VariableNames', {'Zadana_Tolerancja', 'Liczba_Iteracji', ...
    'Blad_Koncowy'});
format long e
disp(T)

fprintf('%s\n', repmat('-', 1, 110));
fprintf('Test zakończony.\n');
end