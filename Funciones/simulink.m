function [salida_interes,tiempo_interes] = simulink(archivo, stop)

figure;

load_system(archivo);
set_param(archivo, 'StopTime', stop);

simulacion = sim(archivo);

tiempo = simulacion.out(:,1);
salida = simulacion.out(:,2);

t_ini = tiempo(find(salida ~= 0, 1));

if(t_ini~=[])
    t_fin = tiempo(end);
    x_ini = find(tiempo==t_ini); 
    x_fin = find(tiempo==t_fin); 
    tiempo_interes = tiempo(x_ini:x_fin)-tiempo(x_ini); 
    salida_interes = salida(x_ini:x_fin); 
else
    tiempo_interes = tiempo;
    salida_interes = salida;
end

limite = find(tiempo_interes <= 5);
tiempo_interes = tiempo_interes(limite);
salida_interes = salida_interes(limite);

close_system(archivo, 0);

end

