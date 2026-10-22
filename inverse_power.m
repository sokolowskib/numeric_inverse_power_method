function [lambda, v, errEst, iter] = inverse_power(A, tol, maxIter)
% Funkcja wykonuje iteracje odwróconej metody potęgowej w celu znalezienia 
% minimalnej wartości własnej macierzy A. Funkcja zatrzyma się po
% osiągnięciu wystarczająco dobrego przybliżenia (mniejszego niż tol), bądź
% wykonania maxIter iteracji. 
% WEJŚCIE
%   A - macierz kwadratowa określona nad ciałem liczb zespolonych
%  tol - tolerancja błędu przybliżenia wartości własnej
%  maxIter - maksymalna liczba iteracji, którą funkcja może wykonać
% WYJŚCIE
% lambda - przybliżenie wartości własnej
%   v - odpowiadający jej wektor własny
% errEst - błąd przybliżenia wartości własnej
% iter - ilość iteracji, jaką finalnie wykonał program

n = size(A, 1);
v = rand(n, 1) + 1i * randn(n, 1);
v = v / norm(v);

% wykonanie rozkładu LU na macierzy A
[L, U, p] = LU(A);


errEst = inf;
iter = 0;
for i = 1:maxIter
    iter = i;
    % modyfikacja wektora z poprzedniej iteracji, w teorii to mnożenie 
    % macierzą permutacji wynikającej z wyboru elementu głównego
    b = v(p);
    y = forw_sub(L, b);
    x = back_sub(U, y);
    
    % obliczenie wartości własnej
    lambda = 1 / (v' * x);
    v = x / norm(x);
    
    % obliczenie błędu przybliżenia
    errEst = norm(A * v - lambda * v) / abs(lambda);

    % sprawdzenie czy można przerwać program na podstawie tolerancji błędu
    if errEst < tol
        break;
    end
end