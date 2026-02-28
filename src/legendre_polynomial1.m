function polynomial = legendre_polynomial1(n, x)
%Jest pomocniczą funkcją która stosuje legendre_polynomial
%Jest używana w sytuacjach, gdzie pochodna nie jest potrzebna
    [Pn, ~] = legendre_polynomial(n, x);
    polynomial = Pn;
end