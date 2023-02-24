function [x_grid, t_grid, U] = solve_waves_equation(L, T, I, J)
  ## Resuelve la ecuacion de ondas en derivadas parciales usando la discretizacion 
  ## del dominio y las diferencias finitas. Para cada punto (x_i, t_i) del
  ## dominio, se genera el elemento de la matriz U en la posicion i y j , que 
  ## contiene el valor de U(x_i, t_j).
  ## 
  ## Input:
  ##    - L: Longitud del intervalo de definicion de la variable espacial.
  ##    - T: Longitud del intervalo de definición de la variable temporal.
  ##    - I: Numero de particiones que se realizan sobre el intervalo [0, L].
  ##    - J: Numero de particiones que se realizan sobre el intervalo [0, T].
  ## 
  ## Output:
  ##    - x_grid: Un vector, representando la particion efectuada en el eje X.
  ##    - t_grid: Un vector, representando la particion efectuada en el eje Y.
  ##    - U: Una matriz, representando los valores de la funcion discretizada.
  
  %%%%%%%%%%%%%%%%%% Parametros iniciales %%%%%%%%%%%%%%%%%%%%
  x_grid = linspace(0, L, I+1);
  t_grid = linspace(0, T, J+1);
  U = zeros(I+1, J+1);
  
  h = L/I;
  k = T/J;
  alpha = k/h;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
 
  %%%%%%%%%%% Inicializacion de la matriz del sistema %%%%%%%%
  B = zeros(I-1, I-1);
  
  for i=1:I-1
    % Diagonal principal
    B(i,i) = (1+(alpha**2))/2;
  endfor
  for i=2:I-1
    % Subdiagonal superior
    B(i-1,i) = -((alpha**2)/4);
  endfor
  for i=1:I-2
    % Subdiagonal inferior
    B(i+1,i) = -((alpha**2)/4);
  endfor
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %%%%%%%%%%%%%%%%% Condiciones de frontera %%%%%%%%%%%%%%%%%%
  for i = 1:I+1
    U(i, 1) = f(x_grid(i));
  endfor
  
  for j = 1:J+1
    U(1, j) = 0;
    U(I+1, j) = 0;
  endfor
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %% Configuracion de las condiciones iniciales del sistema %%
  initial_u = zeros(I-1, 1);
  temp_solution = inv(B)*(initial_u); %TODO: REMOVER LA INVERSA %(Aqui se resuelve el vector w_i inicial)
  for i = 2:I
    initial_u(i-1) = (temp_solution(i-1,1)/2) - (g(x_grid(i))*k); %(Aqui se resuelve u_(i,-1) a partir de temp_solution)
  endfor
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %%%%%% Calculo de u_1 a partir de la condición u_(-1) %%%%%%
  U(2:I,2) = temp_solution - initial_u;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  %%%%%% Resolucion iterativa del sistema de ecuaciones %%%%%%
  for k = 3:J+1
    U(2:I, k) = inv(B)*U(2:I,k-1) - U(2:I,k-2);
  endfor
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
endfunction