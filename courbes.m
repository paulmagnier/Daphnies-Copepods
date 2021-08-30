exp = [14, 15, 16, 17];
vitmoymoy = [1.3137, 1.2899, 1.3349, 1.2637];
vitmoymoy = vitmoymoy / 2.93;
tempsmoy = [28.8829, 27.9870, 30.6290, 27.7500];
tempsmoy = tempsmoy * 2.93;
vitmoymed = [1.2885, 1.2155, 1.2262, 1.2071];
vitmoymed = vitmoymed / 2.93;
tempsmed = [30.4091, 29.5000, 33.4545, 29.3636];
tempsmed = tempsmed * 2.93;
lenDest = [33, 35, 37, 38];

subplot(1,3,1)
plot(exp, vitmoymoy, '-o')
hold on
plot(exp, vitmoymed, '-o')
title("Vitesse moyenne au cours des experiences", 'Interpreter', 'latex')
xlabel('Experience', 'Interpreter', 'latex');
ylabel('Vitesse moyenne (cm/s)', 'Interpreter', 'latex');
set(gca,'TickLabelInterpreter','latex')
legend("Vitesse moyenne", "Vitesse mediane", 'Interpreter', 'latex', 'Location', 'southoutside')

subplot(1,3,2)
plot(exp, tempsmoy, '-o')
hold on
plot(exp, tempsmed, '-o')
title("Temps moyen pour atteindre la ligne", 'Interpreter', 'latex')
xlabel('Experience', 'Interpreter', 'latex');
ylabel('Temps moyen (s)', 'Interpreter', 'latex');
set(gca,'TickLabelInterpreter','latex')
legend("Temps moyen", "Temps median", 'Interpreter', 'latex', 'Location', 'southoutside')

subplot(1,3,3)
plot(exp, lenDest, '-o')
title("Nombre de daphnies qui atteignent la ligne", 'Interpreter', 'latex')
xlabel('Experience', 'Interpreter', 'latex');
ylabel('Nb', 'Interpreter', 'latex');
set(gca,'TickLabelInterpreter','latex')