function [km,Tau,salida_interes,tiempo_interes] = salida(salida, tiempo, Ts, valor_entrada, unidades, pert)

figure;

t_ini = tiempo(find(salida ~= 0, 1));
t_fin = tiempo(end);
x_ini = find(tiempo==t_ini); 
x_fin = find(tiempo==t_fin); 
tiempo_interes = tiempo(x_ini:x_fin)-tiempo(x_ini); 
salida_interes = salida(x_ini:x_fin); 

limite = find(tiempo_interes <= 5);
tiempo_interes = tiempo_interes(limite);
salida_interes = salida_interes(limite);

plot(tiempo_interes,salida_interes) 
hold on
plot([0 tiempo_interes(end)], [1 1]*salida_interes(end)*0.632, 'r:')
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

muestras = round(size(find(salida_interes >= 0))/2);
c_inf = mean(salida_interes(end-muestras, end));
muestra = find(abs(salida_interes) >= abs(c_inf)*0.632, 1);
Tau = (muestra+muestra-1)/2*Ts;
km = c_inf/valor_entrada;

end

