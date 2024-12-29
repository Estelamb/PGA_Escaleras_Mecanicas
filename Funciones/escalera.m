%{
 Funcion para calcular la salida y la señal de control para una entrada escalon y una perturbacion dadas.

 @param BoG Funcion de transferencia del sistema.
 @param Fz Funcion de transferencia del regulador.
 @param entrada Valor de la entrada escalon en m/s.
 @param pert Valor de la perturbacion en m/s.
 @return [c_inf, a_inf] Una tupla donde c_inf es la salida con entrada escalon y perturbacion en m/s,
                        y a_inf es la señal de control con entrada escalon y perturbacion en V.

 La funcion calcula lo siguiente:
 - g_inf: La ganancia DC del sistema.
 - Mz_esc: La funcion de transferencia en lazo cerrado para la entrada escalon.
 - Mz_pert: La funcion de transferencia en lazo cerrado para la perturbacion.
 - c_inf: La salida con entrada escalón y perturbacion.
 - a_inf: La senal de control con entrada escalón y perturbacion.

 La funcion tambien imprime la salida calculada y la señal de control.

 Ejemplo de uso:
 [c_inf, a_inf] = escalera(BoG, Fz, entrada, pert);
 %}
function [c_inf, a_inf] = escalera(BoG, Fz, entrada, pert)
    
    g_inf = dcgain(BoG);                            % Calcular la ganancia del sistema
    Mz_esc = minreal(feedback(series(Fz, BoG), 1)); % Calcular la función de transferencia en lazo cerrado para la entrada escalón
    Mz_pert = minreal(1/(1+series(Fz, BoG)));       % Calcular la función de transferencia en lazo cerrado para la perturbación

    c_inf = entrada * dcgain(Mz_esc) - pert * dcgain(Mz_pert); % Calcular la salida con entrada escalón y perturbación
    a_inf = (c_inf + pert)/g_inf;                              % Calcular la señal de control con entrada escalón y perturbación

    % Imprimir la salida calculada
    fprintf('La salida con entrada escalón %d m/s y perturbación %.1f m/s es: %.4f m/s.\n', entrada, pert, c_inf)
    % Imprimir la señal de control calculada
    fprintf('La señal de acción con entrada escalón %d m/s y perturbación %.1f m/s es: %.4f V.\n', entrada, pert, a_inf)

end