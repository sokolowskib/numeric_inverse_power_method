function [lambda, v, errEst, iter] = inverse_shifted(A, tol, maxIter)
% Funkcja pomocnicza do testów numerycznych. Funkcja z każdą iteracją
% wykonuje A = A - mi * I, gdzie mi to wyznaczone w ostatniej iteracji
% przybliżenie lambdy. Większa precyzja, kosztem wzrostu złożoności.

n = size(A, 1);
v = randn(n, 1) + 1i * randn(n, 1);
v = v / norm(v);
iter = 0;

% początkowe przesunięcie
lambda = 0; 
for i = 1:maxIter
    iter = i;
    
    % przygotowanie macierzy z aktualnym przesunięciem
    A_shift = A - lambda * eye(n);
    
    % rozkład LU 
    [L, U, p] = LU(A_shift);
    
    % rozwiązanie układu
    b = v(p);
    y = forw_sub(L, b);
    x = back_sub(U, y);
    
    % normalizacja nowego wektora własnego
    v = x / norm(x);
    
    % aktualizacja mi
    lambda = v' * A * v;
    
    % obliczenie błędu
    errEst = norm(A * v - lambda * v) / abs(lambda);
    
    if errEst < tol
        break;
    end
end
end