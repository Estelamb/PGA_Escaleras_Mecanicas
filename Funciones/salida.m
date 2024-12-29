%{
 @file salida.m
 @brief Esta función calcula la respuesta del sistema a una entrada escalón y representa la respuesta.

 @param salida Vector que contiene la señal de salida.
 @param tiempo Vector que contiene los instantes de tiempo correspondientes a la señal de salida.
 @param Ts Tiempo de muestreo.
 @param valor_entrada Valor de la entrada escalón.
 @param unidades Unidades del valor de entrada.
 @param pert Número de personas perturbando el sistema (0 si no hay perturbación).

 @return km Ganancia estática del sistema.
 @return Tau Constante de tiempo del sistema.
 @return salida_interes Señal de salida dentro del tiempo de interés.
 @return tiempo_interes Instantes de tiempo dentro del tiempo de interés.

 La funcion realiza los siguientes pasos:
 1. Encuentra el tiempo inicial y final donde la salida es diferente de cero.
 2. Extrae el tiempo y la señal de salida dentro del tiempo de interés.
 3. Limita el tiempo de interés a los primeros 5 segundos.
 4. Grafica la señal de salida y una línea horizontal en el 63.2% del valor final de la salida.
 5. Calcula la ganancia estática (km) y la constante de tiempo (Tau) del sistema.
 %}
function [km,Tau,salida_interes,tiempo_interes] = salida(salida, tiempo, Ts, valor_entrada, unidades, pert)

    figure; 

    t_ini = tiempo(find(salida ~= 0, 1));               % Encontrar el tiempo inicial donde la salida no es cero
    t_fin = tiempo(end);                                % Asignar el tiempo final
    x_ini = find(tiempo==t_ini);                        % Encontrar el índice del tiempo inicial
    x_fin = find(tiempo==t_fin);                        % Encontrar el índice del tiempo final
    tiempo_interes = tiempo(x_ini:x_fin)-tiempo(x_ini); % Extraer el intervalo de tiempo de interés
    salida_interes = salida(x_ini:x_fin);               % Extraer la salida correspondiente al intervalo de tiempo de interés

    % Limitar el tiempo de interés a los primeros 5 segundos
    limite = find(tiempo_interes <= 5);
    tiempo_interes = tiempo_interes(limite);
    salida_interes = salida_interes(limite);

    plot(tiempo_interes,salida_interes) 
    hold on
    plot([0 tiempo_interes(end)], [1 1]*salida_interes(end)*0.632, 'r:') % Dibujar una línea horizontal en el 63.2% del valor final de la salida
    hold off
    xlim([0 5]);

    if(pert == 0)
        title(sprintf('Respuesta a la entrada escalón %.2f %s', valor_entrada, unidades))
        xlabel('Tiempo (s)')
        ylabel(sprintf('Amplitud (%s)', unidades))
        grid on;
    else
        title(sprintf('Respuesta a la entrada escalón %.2f %s con %d personas', valor_entrada, unidades, pert))
        xlabel('Tiempo (s)')
        ylabel(sprintf('Amplitud (%s)', unidades))
        grid on;
    end

    muestras = round(size(find(salida_interes >= 0))/2);        % Calcular el número de muestras para el promedio
    c_inf = mean(salida_interes(end-muestras, end));            % Calcular el valor final de la salida
    muestra = find(abs(salida_interes) >= abs(c_inf)*0.632, 1); % Encontrar la muestra donde la salida alcanza el 63.2% del valor final
    Tau = (muestra+muestra-1)/2*Ts;                             % Calcular la constante de tiempo Tau
    km = c_inf/valor_entrada;                                   % Calcular la ganancia estática km

end

