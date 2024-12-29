%{
 @file representar.m
 @brief Funcion para representar datos de entrada y salida desde un archivo.

 Esta funcion carga datos desde un archivo especificado y representa los datos de entrada y salida
 en una gráfica. También añade títulos y etiquetas apropiadas a la gráfica basándose en los parámetros proporcionados.

 @param archivo La ruta al archivo que contiene los datos a graficar.
 @param valor_entrada El valor del escalón de entrada.
 @param unidades Las unidades de los datos de entrada y salida.
 @param pert El número de personas (perturbación) que afectan el sistema. Si pert es 0,
             el titulo no incluirá el número de personas.

 @return salida Los datos de salida extraídos del archivo.
 @return tiempo Los datos de tiempo extraídos del archivo.
 %}
function [salida,tiempo] = representar(archivo, valor_entrada, unidades, pert)
    figure;

    datos = load(archivo); % Cargar los datos del archivo
    tiempo = datos(:,1);   % Asignar la primera columna de datos a la variable tiempo
    entrada = datos(:,2);  % Asignar la segunda columna de datos a la variable entrada
    salida = datos(:,3);   % Asignar la tercera columna de datos a la variable salida

    plot(tiempo,entrada) 
    hold on 
    plot(tiempo,salida)
    hold off 

    if(pert == 0)          
        title(sprintf('Entrada y salida con escalón %.2f %s', valor_entrada, unidades))
        xlabel('Tiempo (s)')
        ylabel(sprintf('Amplitud (%s)', unidades))
        grid on;
    else
        title(sprintf('Entrada y salida con escalón %.2f %s con %d personas', valor_entrada, unidades, pert))
        xlabel('Tiempo (s)')
        ylabel(sprintf('Amplitud (%s)', unidades))
        grid on;
    end
end

