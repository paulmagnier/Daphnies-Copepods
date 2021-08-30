clf

chemin = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-07-22 agitateurs remi\trajectoires (17).xlsx";
fps = 7.5;

R = readmatrix(chemin);

id = R(:,1);
T = R(:,2);
T = T ./ fps;
X = R(:,3);
Y = R(:,4);

% on restitue les dimensions reelles de la cuve
ratio = 0.355 / 1326;% obtenu avec la video 5 selon y
X = X .* ratio;
Y = Y .* ratio;

% potentiel decalage de l'image
decalage = 0.001;
X = X + decalage;

%% traitement des trajectoires 

% on retire les trajectoires qui comportent trop peu de points
lim = 100;% 100 pour la video 2
X = X(id > lim);
Y = Y(id > lim);
T = T(id > lim);
id = id(id > lim);

% on retire les trajectoires trop immobiles

deltaXmin = 0.04;%0.06 pour la 2
deltaYmin = 0.04;

[listX0, listY0, listT0] = extractTraj(id, X, Y, T);
[h, nbTraj] = size(listX0);

listX = {};
listY = {};
listT = {};
for i = 1:nbTraj
    Xi = listX0{i};
    Yi = listY0{i};
    Ti = listT0{i};
    deltaXi = max(Xi) - min(Xi);
    deltaYi = max(Yi) - min(Yi);
    if (deltaXi > deltaXmin) & (deltaYi > deltaYmin)
        listX{end + 1} = Xi;
        listY{end + 1} = Yi;
        listT{end + 1} = Ti;
    end
end

%% representation des trajectoires

[h, nbTraj2] = size(listX);

xlabel('m', 'Interpreter', 'latex');
ylabel('m', 'Interpreter', 'latex');
title('Trajectoires identifiees', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')
xlim([0 0.265])
ylim([0 0.355])
hold on
for i = 1:nbTraj2
    plot(listX{i}, 0.355 - listY{i}, '-')
    hold on
    %waitforbuttonpress;
end
hold off
waitforbuttonpress;

% au cours du temps

for i = 1:nbTraj2
    scatter(listX{i}, 0.355 - listY{i}, 30, listT{i}, '.')
    hold on
    %waitforbuttonpress;
end
title('Trajectoires au cours du temps', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')
xlim([0 0.265])
ylim([0 0.355])

colormap('jet')
c = colorbar
c.TickLabelInterpreter = 'latex'
ylabel(c, 'Temps (s)', 'Interpreter', 'latex');
set(gca,'TickLabelInterpreter','latex')

xlabel('m', 'Interpreter', 'latex')
ylabel('m', 'Interpreter', 'latex')

hold off
waitforbuttonpress;

%% groupes

ligneArrivee = 0.33;
[dest, temps, tleg] = destination(listX, listY, listT, 0.355 - ligneArrivee);

plot([0 0.28], [ligneArrivee ligneArrivee], 'LineWidth', 2, 'Color', 'r')
title("Daphnies passant la ligne d'arrivee en y = " + ligneArrivee, 'Interpreter', 'latex')
xlabel('m', 'Interpreter', 'latex');
ylabel('m', 'Interpreter', 'latex');
set(gca,'TickLabelInterpreter','latex')
xlim([0 0.265])
ylim([0 0.355])
hold on
for i = dest
    plot(listX{i}, 0.355 - listY{i}, '-')
    hold on
    %waitforbuttonpress;
end
lgd = legend(tleg, 'Interpreter', 'latex', 'Location', 'eastoutside');
lgd.Title.String = "Temps pour franchir la ligne";
hold off

%% analyse des vitesses et temps

% vitesse moyenne pour celles arrivees a destination

vitmoy = [];
for i = dest
    vi = mean(vitMoyenneTraj(listX{i}, listY{i}, listT{i}));
    vitmoy = [vitmoy vi];
end
vitmoymoy = mean(vitmoy)

% temps moyen pour celles arrivees a destination

tempsmoy = mean(temps)