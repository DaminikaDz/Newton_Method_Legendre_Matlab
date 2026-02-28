function [root, iterations, trajectory] = metoda_newtona(n, z0, tol, max_iter)
    % Funkcja iteracyjnie oblicza pierwiastki wielomianu Legendre'a metodą Newtona

    % Początkowe ustawienia
    z = z0;
    iterations = 0;
    trajectory = zeros(1, max_iter + 1);
    trajectory(1) = z0;

    for k = 1:max_iter
        % Obliczenie wartości wielomianu Legendre'a i jego pochodnej
        [wn, wn_prime] = legendre_polynomial(n, z);

        % Sprawdzenie pochodnej
        if wn_prime == 0
            error('Pochodna wynosi zero - metoda Newtona nie może kontynuować.');
        end

        % Aktualizacja przybliżenia
        z_next = z - wn / wn_prime;
        trajectory(k+1) = z_next;

        % Sprawdzenie kryterium stopu
        if abs(z_next - z) < tol
            root = z_next;
            trajectory = trajectory(1:k+1);
            return;
        end

        z = z_next;
        iterations = iterations + 1;
    end

    error('Metoda Newtona nie zbiega w zadanej liczbie iteracji.');
end