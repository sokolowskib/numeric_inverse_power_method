function [L, U, p] = LU(A)
% Znajdowanie rozkładu LU z częściowym wyborem elementu głównego. Funkcja
% wykonuje eliminację Gaussa dla i-tej wartości na diagonali, 
% a następnie zapisuje mnożnik pod diagonalą (l_i,i+1:n). Na końcu
% wydostaje wartości macierzy L oraz U ze zmodyfikowanej macierzy A.
% WEJŚCIE
%   A - kwadratowa macierz określona nad ciałem liczb zespolonych
% WYJŚCIE
%   L - macierz dolnotrójkątna, posiada wartość 1 na każdym el. diagonali 
%   U - macierz górnotrójkątna
%   p - wektor 1:n reprezentujący wybór elementu głównego w rozkładzie,
%   wykorzystać można jako b(p) gdzie b to losowy wektor, wykona te 
%   same operacje permutacji wierszy co w rozkładzie
  
% pobranie rozmiaru macierzy i inicjalizacja wektora reprezentującego
% permutacje
n = size(A, 1);
p = 1:n;

for k = 1:n - 1
    % znalezienie maksymalnej wartości w kolumnie
    [~, index] = max(abs(A(k:n, k)));
    pivot_row = index + k - 1;
    
    % podmiana wierszy
    A([k, pivot_row], :) = A([pivot_row, k], :);
    p([k, pivot_row]) = p([pivot_row, k]);
    
    for i = k + 1:n
        % zapisanie mnożnika (wartości w macierzy L) pod diagonalą
        A(i, k) = A(i, k) / A(k, k);
        
        % eliminacja gaussa w dalszych kolumnach
        A(i, k + 1:n) = A(i, k + 1:n) - A(i, k) * A(k, k + 1:n);
    end
end

% wyciągnięcie macierzy L i U ze zmodyfikowanej macierzy A
L = tril(A, -1) + eye(n); 
U = triu(A);               
end
