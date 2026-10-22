function test_lu_res() 
% Test ma za zadanie sprawdzić, czy rozkład LU = PA jest wykonywany
% poprawnie w sensie błędu względnego normy ||PA - LU|| / ||A||
% Macierze A są natomiast przekątniowo dominująca, żeby zapewnić istnienie
% owego rozkładu

fprintf('%s\n',repmat('-', 1, 85));
fprintf(['TEST: Sprawdzenie błędu względnego rozkładu LU ' ...
    '(||PA - LU|| / ||A||)\n'])
fprintf(['Test weryfikuje dokładność rozkładu dla pseudolosowych' ...
    ' macierzy kwadratowych\n'])
fprintf('\n')
fprintf('%s\n',repmat('-', 1, 85));

n_vals = [5; 10; 25; 50; 100; 250; 500];
m = length(n_vals);
res_rel = zeros(m, 1);
n_labels = strings(m, 1);

for k = 1:m
    n = n_vals(k);

    % dodajemy duże wartości na diagonali aby zapewnić istnienie rozkładu
    A = (randn(n, n) + 1i * randn(n, n)) + (2 * n * eye(n));
    
    % wykonanie rozkładu LU
    [L, U, p] = LU(A);

    residue = norm(A(p, :) - L * U);
    
    % policzenie błędu względnego
    res_rel(k) = residue / norm(A);
    n_labels(k) = sprintf('N = %d', n);
end

T = table(n_labels, res_rel, 'VariableNames', {'Rozmiar_N', ...
    'Bląd_Względny'});
format long e
disp(T)

fprintf('%s\n', repmat('-', 1, 85));
fprintf('Test zakończony.\n');
end