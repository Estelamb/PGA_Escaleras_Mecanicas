%{
 Funcion para comparar y representar tres conjuntos de datos.

 @param salida1 Array de datos de salida de la primera señal.
 @param tiempo1 Array de datos de tiempo para la primera señal.
 @param salida2 Array de datos de salida para la segunda señal.
 @param tiempo2 Array de datos de tiempo para la segunda señal.
 @param salida3 Array de datos de salida para la tercera señal. Si es 'null', no se representará.
 @param tiempo3 Array de datos de tiempo para la tercera señal. Si es 'null', no se representará.
 @param texto Texto del título para la gráfica.

 Esta funcion crea una figura y grafica los conjuntos de datos proporcionados en el mismo gráfico.
 Tambien establece el título, las etiquetas para los ejes x e y, los límites para el eje x y habilita la cuadrícula.
 %}
function [] = comparacion(salida1,tiempo1,salida2,tiempo2,salida3,tiempo3,texto)

figure;

plot(tiempo1,salida1);
hold on;

plot(tiempo2,salida2);

if (salida3 ~= 'null')
    plot(tiempo3,salida3);
end

hold off;
title(texto); 
xlabel('Tiempo (s)'); 
ylabel('Amplitud (m/s)');
xlim([0 5]);
grid on;

end

