function plot_solution(x_grid, t_grid, U)
  ## Genera el grafico de una funci�n de dos dimensiones. Para cada punto (x_i, t_i)
  ## del dominio, la matriz U en la posici�n i y j contiene el valor de U(x_i, t_j).
  ## 
  ## Argumentos:
  ##    - x_grid: Un vector, representando la partici�n efectuada en el eje X.
  ##    - t_grid: Un vector, representando la partici�n efectuada en el eje Y.
  ##    - U: Una matriz, representando los valores de la funci�n discretizada.
  [xx, yy] = meshgrid(x_grid, t_grid);
  mesh(xx, yy, U)
endfunction