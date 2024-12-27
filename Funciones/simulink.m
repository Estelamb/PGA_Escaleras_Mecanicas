%{
 Función para simular un modelo de Simulink y extraer la salida de interés.

 @param archivo La ruta al archivo del modelo de Simulink.
 @param stop El tiempo de parada para la simulación.
 @return salida_interes Los datos de salida de interés de la simulación.
 @return tiempo_interes Los datos de tiempo de interés de la simulación.

 Esta funcion realiza los siguientes pasos:
 1. Carga el modelo de Simulink especificado.
 2. Establece el tiempo de parada de la simulación.
 3. Ejecuta la simulación.
 4. Extrae los datos de tiempo y salida de los resultados de la simulación.
 5. Encuentra el tiempo inicial donde la salida no es cero.
 6. Extrae los datos de tiempo y salida de interés basados en el tiempo inicial.
 7. Limita el tiempo de interés a los primeros 5 segundos.
 8. Cierra el modelo de Simulink sin guardar cambios.
%}
function [salida_interes,tiempo_interes] = simulink(archivo, stop)
    figure;

    load_system(archivo);                  % Cargar el sistema de Simulink especificado por el archivo
    set_param(archivo, 'StopTime', stop);  % Establecer el tiempo de simulación

    simulacion = sim(archivo);             % Ejecutar la simulación

    tiempo = simulacion.out(:,1);          % Extraer los datos de tiempo de la simulación
    salida = simulacion.out(:,2);          % Extraer los datos de salida de la simulación
    t_ini = tiempo(find(salida ~= 0, 1));  % Encontrar el tiempo inicial donde la salida no es cero

    % Si se encuentra un tiempo inicial no vacío
    if(t_ini~=[])
        t_fin = tiempo(end);                                % Asignar el tiempo final
        x_ini = find(tiempo==t_ini);                        % Encontrar el índice del tiempo inicial
        x_fin = find(tiempo==t_fin);                        % Encontrar el índice del tiempo final
        tiempo_interes = tiempo(x_ini:x_fin)-tiempo(x_ini); % Extraer el intervalo de tiempo de interés
        salida_interes = salida(x_ini:x_fin);               % Extraer la salida correspondiente al intervalo de tiempo de interés
    else
        % Si no se encuentra un tiempo inicial, usar todo el tiempo y salida
        tiempo_interes = tiempo;
        salida_interes = salida;
    end

    % Limitar el tiempo de interés a los primeros 5 segundos
    limite = find(tiempo_interes <= 5);
    tiempo_interes = tiempo_interes(limite);
    salida_interes = salida_interes(limite);

    % Cerrar el sistema de Simulink sin guardar cambios
    close_system(archivo, 0);

end

