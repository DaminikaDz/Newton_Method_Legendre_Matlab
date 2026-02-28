function generate_test_cases()
%Uwaga: Funkcja fsolve wymaga zainstalowanego Optimization Toolbox!

    % Funkcja generująca 10 przykładów z różnymi parametrami:
    % stopniem wielomianu, punktem startowym, tolerancją i liczbą iteracji.
    % Wyniki są porównywane z funkcją wbudowaną fsolve.

    % Tablica przykładów testowych
    test_cases = {
        2,   100.0+100.0i,    1e-6,   50; 
        3, -1.5+2.0i, 1e-6, 100;
        5,  0.5+0.5i, 1e-6,   100;
        7,  0.1+3.0i, 1e-8,   100;
        8,  -2.0+0.5i, 1e-8,   100;
        85,  25.0+25.0i,  1e-2,   900;   
        100, 50.0+50.0i,  1e-12,  1000;  
        100, 0.001+0.00i,  1e-12,  1000;
    };

    % Nagłówek wyników
    fprintf('Przypadki testowe dla metody Newtona z porównaniem do funkcji fsolve:\n');
    fprintf('-----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
    fprintf('%-8s %-20s %-13s %-8s %-20s %-25s %-15s %-15s %-15s\n', ...
    'n', 'z0', 'Tolerancja', 'MaxIter', 'Iteracje Newtona', ...
    'Newton (Re + Im)', 'fsolve (Re + Im)', 'Błąd bezwzgl.', 'Błąd względny');
    fprintf('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------\n');

    % Przetwarzanie każdego przypadku testowego
    for i = 1:size(test_cases, 1)
        n = test_cases{i, 1};
        z0 = test_cases{i, 2};
        tol = test_cases{i, 3};
        max_iter = test_cases{i, 4};

        % Wywołanie metody Newtona
        try
            [root_newton, iterations, ~] = metoda_newtona(n, z0, tol, max_iter);
        catch
            root_newton = NaN;
            iterations = NaN;
        end

        % Wywołanie funkcji fsolve
        try
            options = optimoptions('fsolve', 'Display', 'off', 'OptimalityTolerance', tol, 'MaxIterations', 200);
            root_fsolve = fsolve(@(x) legendre_polynomial1(n, x), z0, options);
        catch
            root_fsolve = NaN;
        end

        % Obliczenie błędów
        if ~isnan(root_newton) && ~isnan(root_fsolve)
            error_absolute = abs(root_fsolve - root_newton);
            error_relative = error_absolute / abs(root_fsolve);
        else
            error_absolute = NaN;
            error_relative = NaN;
        end

        % Wyświetlenie wyników
        fprintf('%-5d %10.4f + %10.4fi %-13.1e %-10d %-10d %10.4f + %10.4fi %10.4f + %10.4fi %-15.2e %-15.2e\n', ...
    n, real(z0), imag(z0), tol, max_iter, iterations, ...
    real(root_newton), imag(root_newton), ...
    real(root_fsolve), imag(root_fsolve), ...
    error_absolute, error_relative);

    end

    fprintf('-----------------------------------------------------------------------------------------------------------------------------------------------------------\n');
end

