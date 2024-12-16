function [c_inf, a_inf] = escalera(BoG, Fz, entrada, pert)

g_inf = dcgain(BoG);
Mz_esc = minreal(feedback(series(Fz, BoG), 1));
Mz_pert = minreal(1/(1+series(Fz, BoG)));

c_inf = entrada * dcgain(Mz_esc) - pert * dcgain(Mz_pert);
a_inf = (c_inf + pert)/g_inf;

fprintf('La salida con entrada escalón %d m/s y perturbación %.1f m/s es: %.4f m/s.\n', entrada, pert, c_inf)
fprintf('La señal de acción con entrada escalón %d m/s y perturbación %.1f m/s es: %.4f V.\n', entrada, pert, a_inf)

end