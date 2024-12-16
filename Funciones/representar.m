function [salida,tiempo] = representar(archivo, valor_entrada, unidades, pert)

figure;

datos = load(archivo);
tiempo = datos(:,1); % Vector columna de los valores del tiempo
entrada = datos(:,2); % Vector columna de los valores de la entrada
salida = datos(:,3); % Vector columna de los valores de la salida

plot(tiempo,entrada) % Representación gráfica X, Y
hold on % Superponer las dos gráficas
plot(tiempo,salida) % Representación gráfica X, Y
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

