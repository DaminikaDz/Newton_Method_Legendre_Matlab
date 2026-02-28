function [wn, wn_prime] = legendre_polynomial(n, x)
    % Funkcja obliczająca wartość wielomianu Legendre'a P_n(z) i jego pochodnej
    % za pomocą rekurencji
    
    % Warunki początkowe
    L_prev = 1;     % P_0(z)
    L_curr = x;     % P_1(z)
    L_prime_prev = 0; % P'_0(z)
    L_prime_curr = 1; % P'_1(z)

    if n == 0
        wn = L_prev;
        wn_prime = L_prime_prev;
        return;
    elseif n == 1
        wn = L_curr;
        wn_prime = L_prime_curr;
        return;
    end

    % Rekurencyjne obliczanie wartości i pochodnej
    for k = 1:n-1
        L_next = ((2*k + 1) * x * L_curr - k * L_prev) / (k + 1);
        L_prime_next = (2*k + 1) * L_curr + L_prime_prev;

        L_prev = L_curr;
        L_curr = L_next;
        L_prime_prev = L_prime_curr;
        L_prime_curr = L_prime_next;
    end

    wn = L_curr;
    wn_prime = L_prime_curr;
end
