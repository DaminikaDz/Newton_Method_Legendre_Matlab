function newton_legendre_gui()
%Uwaga: Funkcja fsolve wymaga zainstalowanego Optimization Toolbox!

    % GUI dla metody Newtona z wielomianami Legendre'a
    fig = uifigure('Name', 'Metoda Newtona - Wielomiany Legendre''a', 'Position', [100, 100, 800, 600]);

    % Stopień wielomianu
    uilabel(fig, 'Position', [20, 520, 120, 20], 'Text', 'Stopień n:');
    degreeInput = uieditfield(fig, 'numeric', 'Position', [150, 520, 100, 20], 'Value', 5);

    % Początkowy punkt
    uilabel(fig, 'Position', [20, 480, 120, 20], 'Text', 'Punkt startowy z0:');
    startPointInput = uieditfield(fig, 'text', 'Position', [150, 480, 100, 20], 'Value', '0.5+0.5i');

    % Maksymalna liczba iteracji
    uilabel(fig, 'Position', [20, 440, 150, 20], 'Text', 'Maks. liczba iteracji:');
    maxIterInput = uieditfield(fig, 'numeric', 'Position', [170, 440, 100, 20], 'Value', 100);

    % Tolerancja
    uilabel(fig, 'Position', [20, 400, 120, 20], 'Text', 'Tolerancja:');
    tolInput = uieditfield(fig, 'numeric', 'Position', [150, 400, 100, 20], 'Value', 1e-6);

    % Przycisk startu
    uibutton(fig, 'Position', [20, 360, 100, 30], 'Text', 'Start', 'ButtonPushedFcn', @(btn, event)runMethod());

    % Wyniki
    resultLabel = uilabel(fig, 'Position', [20, 320, 300, 20], 'Text', 'Znaleziony pierwiastek (Newton): ');
    fsolveLabel = uilabel(fig, 'Position', [20, 300, 300, 20], 'Text', 'Znaleziony pierwiastek (fsolve): ');
    iterLabel = uilabel(fig, 'Position', [20, 280, 300, 20], 'Text', 'Liczba iteracji: ');
    absErrorLabel = uilabel(fig, 'Position', [20, 260, 300, 20], 'Text', 'Błąd bezwzględny: ');
    relErrorLabel = uilabel(fig, 'Position', [20, 240, 300, 20], 'Text', 'Błąd względny: ');

    % Oś dla wizualizacji
    ax = uiaxes(fig, 'Position', [350, 100, 400, 400]);
    title(ax, 'Trajektoria iteracji');
    xlabel(ax, 'Re(z)');
    ylabel(ax, 'Im(z)');
    grid(ax, 'on');

    % Funkcja wywoływana przez przycisk
    function runMethod()
        % Pobranie wartości z GUI
        try
            n = degreeInput.Value;
            z0 = str2double(startPointInput.Value); 
            if isempty(z0)
                uialert(fig, 'Niepoprawny format punktu startowego z0. Wprowadź wartość w formacie zespolonym, np. 0.5+0.5i.', 'Błąd');
                return;
            end
            max_iter = maxIterInput.Value;
            tol = tolInput.Value;

            % Wywołanie metody Newtona
            [root_newton, iterations, trajectory] = metoda_newtona(n, z0, tol, max_iter);

            % Wywołanie funkcji fsolve
            options = optimoptions('fsolve', 'Display', 'off', 'OptimalityTolerance', tol, 'MaxIterations', max_iter);
            root_fsolve = fsolve(@(x) legendre_polynomial1(n, x), z0, options);


            % Obliczenie błędów
            abs_error = abs(root_fsolve - root_newton);
            rel_error = abs_error / abs(root_fsolve);

            % Wyświetlenie wyników w GUI
            resultLabel.Text = sprintf('Znaleziony pierwiastek (Newton): %.6f + %.6fi', real(root_newton), imag(root_newton));
            fsolveLabel.Text = sprintf('Znaleziony pierwiastek (fsolve): %.6f + %.6fi', real(root_fsolve), imag(root_fsolve));
            iterLabel.Text = sprintf('Liczba iteracji: %d', iterations);
            absErrorLabel.Text = sprintf('Błąd bezwzględny: %.2e', abs_error);
            relErrorLabel.Text = sprintf('Błąd względny: %.2e', rel_error);

            % Wizualizacja tylko trajektorii iteracji na wykresie
            hold(ax, 'off');
            plot(ax, real(trajectory), imag(trajectory), '-o', 'LineWidth', 2);
            hold(ax, 'on');
            scatter(ax, real(root_newton), imag(root_newton), 100, 'r', 'filled'); % Wynik Newtona
            scatter(ax, real(root_fsolve), imag(root_fsolve), 100, 'g', 'filled'); % Wynik fsolve
            hold(ax, 'off');
        catch ME
            uialert(fig, ME.message, 'Błąd');
        end
    end
end
