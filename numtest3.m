function numtest3()
% Porównanie zbieżności i czasu wykonania klasycznej
% odwróconej metody potęgowej oraz metody z przesunięciem.

fprintf('%s\n', repmat('-', 1, 110));
fprintf(['TEST NUMERYCZNY 3: Porównanie czasu wykonania i zbieżności' ...
    ' metody standardowej i metody z przesunięciem\n'])
fprintf(['Parametry: n=200, tol_1=1e-8, tol_2 = 1e-14,' ...
    ' różne odstępy (|lambda2/lambda1|)\n'])
fprintf('%s\n', repmat('-', 1, 110));

n = 200;

% gaps(i) to |lambda2 / lambda1|
gaps = [1.5, 1.1, 1.05, 1.01, 1.001]; 
tol = 1e-8;
tol_shift = 1e-14;
maxIter = 2000;

fprintf('%-8s | %-28s | %-28s | %-15s\n', ...
        'Gap', 'Standard', 'Z przesunięciem', 'Zysk Czasu');
fprintf('%-8s | %-5s | %-10s | %-6s | %-5s | %-10s | %-6s | %-15s\n', ...
        'L2/L1', 'Iter', 'Błąd', 'Czas[s]', 'Iter', 'Błąd', ...
        'Czas[s]', 'std vs mi');
fprintf('%s\n', repmat('-', 1, 110));

for k = 1:length(gaps)
    gap = gaps(k);
    
    % lambda1 = 1, lambda2 = gap
    D = diag([1, gap, linspace(gap + 0.5, gap + 5, n - 2)]);

    % tworzenie testowej macierzy z wyznaczonym stosunkiem 2 minimalnych 
    % lambd jak wyżej
    [Q, ~] = qr(randn(n) + 1i * randn(n));
    A = Q * D * Q';
    
    % standardowa odwrócona metoda potęgowa
    tic;
    [~, ~, err1, iter1] = inverse_power(A, tol, maxIter);
    t1 = toc;
    
    % metoda z przesunięciem, mi = x^(k) , A = A - mi * I w kazdej iteracji
    tic;
    [~, ~, err2, iter2] = inverse_shifted(A, tol_shift, maxIter);
    t2 = toc;
    
    % obliczenie zysku (ile razy szybciej/wolniej)
    speed_ratio = t1 / t2;
    
    fprintf(['%-8.3f | %-5d | %-10.1e | %-7.4f | %-5d | %-10.1e | %-7.4f |' ...
        ' x %-15.2f\n'], ...
            gap, iter1, err1, t1, iter2, err2, t2, speed_ratio);
end

fprintf('%s\n', repmat('-', 1, 110));
fprintf('Test zakończony.\n');
end