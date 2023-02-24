%%%%%%%% PARÁMETROS DEL PROBLEMA %%%%%%%%

% Extremo de x
L = 1;

% Extremo de t
T = 10;

% Parámetros de malla
I = 15;
J = 50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x_grid, t_grid, U] = solve_waves_equation(L, T, I, J);
plot_solution(t_grid, x_grid, U)