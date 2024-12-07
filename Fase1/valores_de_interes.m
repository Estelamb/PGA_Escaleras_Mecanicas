function [km,Tau] = valores_de_interes(archivo, Ts, valor_entrada)

figure('Position', [100, 100, 1000, 400]) 
sgtitle(sprintf('Captura con entrada escalón %dV', valor_entrada))

subplot(1,2,1)

datos = load(archivo);
tiempo = datos(:,1); % Vector columna de los valores del tiempo
entrada = datos(:,2); % Vector columna de los valores de la entrada
salida = datos(:,3); % Vector columna de los valores de la salida
plot(tiempo,entrada) % Representación gráfica X, Y
hold on % Superponer las dos gráficas
plot(tiempo,salida) % Representación gráfica X, Y
hold off

title('Entrada y salida')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')

t_ini = tiempo(min(find(entrada ~= 0)));
t_fin = tiempo(end);
x_ini = find(tiempo==t_ini); 
x_fin = find(tiempo==t_fin); 
tiempo_interes = tiempo(x_ini:x_fin)-tiempo(x_ini); 
salida_interes = salida(x_ini:x_fin); 

limite = find(tiempo_interes <= 5);
tiempo_interes = tiempo_interes(limite);
salida_interes = salida_interes(limite);

subplot(1,2,2)
plot(tiempo_interes,salida_interes) 
hold on
plot([0 tiempo_interes(end)], [1 1]*salida_interes(end)*0.632, 'r:')
hold off
xlim([0 5]);

title('Respuesta a la entrada')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')

muestras = round(size(find(salida_interes >= 0))/2);
c_inf = mean(salida_interes(end-muestras, end));
Tau = (min(find(abs(salida_interes) >= abs(c_inf)*0.632))-1)*Ts;
km = c_inf/valor_entrada;

fprintf('km con entrada escalón de %dV: %.4f.\n', valor_entrada, km)
fprintf('Tau con entrada escalón de %dV: %.4f s.\n', valor_entrada, Tau)


end