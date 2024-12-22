function [] = comparacion(salida1,tiempo1,salida2,tiempo2,salida3,tiempo3,texto)

figure;

plot(tiempo1,salida1);
hold on;

plot(tiempo2,salida2);

if (salida3 ~= 'null')
    stairs(tiempo3,salida3);
end

hold off;
title(texto); 
xlabel('Tiempo (s)'); 
ylabel('Amplitud (V)');
xlim([0 5]);
grid on;

end

