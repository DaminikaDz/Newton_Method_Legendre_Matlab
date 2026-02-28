# Newton Method for Legendre Polynomial Roots (MATLAB)

This project presents a MATLAB implementation of Newton’s method for finding complex roots of Legendre polynomials.

The application computes polynomial values and derivatives, performs iterative root finding, and provides graphical visualization of Newton iteration trajectories. The results are also compared with MATLAB’s built-in `fsolve` function.

## Features

- Recursive computation of Legendre polynomials and derivatives
- Newton method for complex root finding
- GUI for visualization of iteration trajectories
- Comparison with MATLAB `fsolve`
- Numerical error analysis and convergence statistics
- Test case generation for multiple polynomial degrees and initial points

## Project Structure
src/ MATLAB source code
report/ Project report (PDF)


## Main Components

- `legendre_polynomial.m` – computes Legendre polynomial and derivative  
- `metoda_newtona.m` – Newton root finding algorithm  
- `newton_legendre_gui.m` – graphical interface and visualization  
- `generate_test_cases.m` – comparison with `fsolve`  

## Requirements

- MATLAB
- Optimization Toolbox (for `fsolve`)

## Scientific Background

Newton’s method iteratively updates the complex estimate:

z_{n+1} = z_n − w_n(z) / w'_n(z)

where \( w_n(z) \) is the Legendre polynomial and \( w'_n(z) \) its derivative.

The method converges when:

|z_{n+1} − z_n| < ε

## Report

See the full project report:

`report/Newton_Legendre_Report.pdf`
