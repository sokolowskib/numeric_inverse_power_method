function x = back_sub(U, y)
% Funkcja rozwiązuje układ równań Ux = y za pomocą podstawiania wstecz.
% WEJŚCIE
%   U - macierz górnotrójkątna
%   y - wektor wynikowy  otrzymany z forw_sub (L*y = b)
% WYJŚCIE
%   x - wektor wynikowy (rozwiązanie układu Ax = b)

% Pobranie rozmiaru macierzy i inicjalizacja wektora wynikowego
n = size(U, 1);
x = zeros(n, 1);

for i = n:-1:1
    % Implementacja wzoru: x_i = (y_i - sum_{j=i+1}^{n} U_ij * x_j) / U_ii
    % Wykorzystujemy iloczyn skalarny wiersza z U i wyznaczonych już x
    x(i) = (y(i) - U(i, i + 1:n) * x(i + 1:n)) / U(i, i);
end