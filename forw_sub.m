function y = forw_sub(L,b)
% Funkcja rozwiązuje układ równań Ly = b za pomocą operacji na wektorach
% WEJŚCIE
%   L - macierz dolnotrójkątna z 1 na diagonali
%   b - wektor wartości
% WYJŚCIE
%   y - wektor wynikowy

% Pobranie długości wektora i inicjalizacja wektora wynikowego
n = length(b);
y = zeros(n, 1); 

for i = 1:n 
    % Implementacja wzoru: y_i = (b_i - sum_{j=1}^{i-1} L_ij * y_j) / L_ii
    % Wykorzystujemy iloczyn skalarny wiersza z L i obliczonych już y
    y(i) = (b(i) - L(i, 1:i - 1) * y(1:i - 1)) / L(i, i);
end