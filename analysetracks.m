clf
clear

%chemin = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-07-19 premanips remi\trajectoires (4).xlsx";
chemin = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-07-22 agitateurs remi\trajectoires (11).xlsx";
fps = 10;

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
decalage = -0.005;
X = X + decalage;

%% traitement des trajectoires 

% on retire les trajectoires qui comportent trop peu de points
lim = 50;% 100 pour la video 2
X = X(id > lim);
Y = Y(id > lim);
T = T(id > lim);
id = id(id > lim);

% on retire les trajectoires trop immobiles

deltaXmin = 0.03;%0.06 pour la 2
deltaYmin = 0.03;

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

% on tronque les trajectoires trop proches des agitateurs

agit2 = [0.125, 0.085]%0.125[0.145, 0.09]; pour la 2%[0.13, 0.088];
agit1 = [0.125, 0.27]%[0.145, 0.27]; pour la 2%[0.13, 0.268];
[listeX, listeY, listeT, ag2, ag1] = tronque(listX, listY, listT, agit1, agit2, lim);
% listeX = listX;
% listeY = listY;
% listeT = listT;

%ag1 et ag2 sont les groupes des particules bloquees dans les agitateurs resp 1 et 2

%% representation des trajectoires

[h, nbTraj2] = size(listeX);

plot(agit1(1), agit1(2), '*', 'color', 'r');
xlabel('m', 'Interpreter', 'latex');
ylabel('m', 'Interpreter', 'latex');
title('Trajectoires identifiees', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')
xlim([0 0.265])
ylim([0 0.355])
hold on
text(agit1(1) + 0.005, agit1(2), '1', 'Interpreter', 'latex', 'color', 'r');
hold on
plot(agit2(1), agit2(2), '*', 'color', 'b');
hold on
text(agit2(1) + 0.005, agit2(2), '2', 'Interpreter', 'latex', 'color', 'b');
hold on
for i = 1:nbTraj2
    plot(listeX{i}, 0.355 - listeY{i}, '-')
    hold on
    %waitforbuttonpress;
end
hold off
waitforbuttonpress;

% au cours du temps

plot(agit1(1), agit1(2), '*', 'color', 'r');
hold on
text(agit1(1) + 0.005, agit1(2), '1', 'Interpreter', 'latex', 'color', 'r');
hold on
plot(agit2(1), agit2(2), '*', 'color', 'b');
hold on
text(agit2(1) + 0.005, agit2(2), '2', 'Interpreter', 'latex', 'color', 'b');
hold on
for i = 1:nbTraj2
    scatter(listeX{i}, 0.355 - listeY{i}, 30, listeT{i}, '.')
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

% daphnies qui passent la ligne d'arrivee

bloquees1 = ag1;
bloquees2 = ag2;

ligneArrivee = 0.33;
[temporaire, temps, tleg] = destination(listeX, listeY, listeT, 0.355 - ligneArrivee);
dest = setdiff(setdiff(temporaire, bloquees1), bloquees2);

plot([0 0.28], [ligneArrivee ligneArrivee], 'LineWidth', 2, 'Color', 'r')
title("Daphnies passant la ligne d'arrivee en y = " + ligneArrivee, 'Interpreter', 'latex')
hold on
affichegroupes(dest, listeX, listeY, agit1, agit2)
lgd = legend(tleg, 'Interpreter', 'latex', 'Location', 'eastoutside');
lgd.Title.String = "Temps pour franchir la ligne";
waitforbuttonpress;
clf

% trajectoires theoriques

chemin2 = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\python\";
% 
% % actif
% Xr0_0 = readmatrix(chemin2 + "Xr0_0.csv")*0.01;
% Xr0_1 = readmatrix(chemin2 + "Xr0_1.csv")*0.01;
% Xr0_2 = readmatrix(chemin2 + "Xr0_2.csv")*0.01;
% Xr0_3 = readmatrix(chemin2 + "Xr0_3.csv")*0.01;
% Xr0_4 = readmatrix(chemin2 + "Xr0_4.csv")*0.01;
% Xr0_5 = readmatrix(chemin2 + "Xr0_5.csv")*0.01;
% 
% Yr0_0 = readmatrix(chemin2 + "Yr0_0.csv")*0.01;
% Yr0_1 = readmatrix(chemin2 + "Yr0_1.csv")*0.01;
% Yr0_2 = readmatrix(chemin2 + "Yr0_2.csv")*0.01;
% Yr0_3 = readmatrix(chemin2 + "Yr0_3.csv")*0.01;
% Yr0_4 = readmatrix(chemin2 + "Yr0_4.csv")*0.01;
% Yr0_5 = readmatrix(chemin2 + "Yr0_5.csv")*0.01;
% 
% % naif
% Xr1_0 = readmatrix(chemin2 + "Xr1_0.csv")*0.01;
% Xr1_1 = readmatrix(chemin2 + "Xr1_1.csv")*0.01;
% Xr1_2 = readmatrix(chemin2 + "Xr1_2.csv")*0.01;
% Xr1_3 = readmatrix(chemin2 + "Xr1_3.csv")*0.01;
% Xr1_4 = readmatrix(chemin2 + "Xr1_4.csv")*0.01;
% Xr1_5 = readmatrix(chemin2 + "Xr1_5.csv")*0.01;
% 
% Yr1_0 = readmatrix(chemin2 + "Yr1_0.csv")*0.01;
% Yr1_1 = readmatrix(chemin2 + "Yr1_1.csv")*0.01;
% Yr1_2 = readmatrix(chemin2 + "Yr1_2.csv")*0.01;
% Yr1_3 = readmatrix(chemin2 + "Yr1_3.csv")*0.01;
% Yr1_4 = readmatrix(chemin2 + "Yr1_4.csv")*0.01;
% Yr1_5 = readmatrix(chemin2 + "Yr1_5.csv")*0.01;
% 
% affichegroupes(dest, listeX, listeY, agit1, agit2)
% hold on
% plot(Xr0_0, Yr0_0, 'LineWidth', 2, 'Color', 'r')
% hold on
% plot(Xr0_1, Yr0_1, 'LineWidth', 2, 'Color', 'r')
% hold on
% plot(Xr0_2, Yr0_2, 'LineWidth', 2, 'Color', 'r')
% hold on
% plot(Xr0_3, Yr0_3, 'LineWidth', 2, 'Color', 'r')
% hold on
% plot(Xr0_4, Yr0_4, 'LineWidth', 2, 'Color', 'r')
% hold on
% plot(Xr0_5, Yr0_5, 'LineWidth', 2, 'Color', 'r')
% hold on
% 
% plot(Xr1_0, Yr1_0, 'LineWidth', 2, 'Color', 'b')
% hold on
% plot(Xr1_1, Yr1_1, 'LineWidth', 2, 'Color', 'b')
% hold on
% plot(Xr1_2, Yr1_2, 'LineWidth', 2, 'Color', 'b')
% hold on
% plot(Xr1_3, Yr1_3, 'LineWidth', 2, 'Color', 'b')
% hold on
% plot(Xr1_4, Yr1_4, 'LineWidth', 2, 'Color', 'b')
% hold on 
% plot(Xr1_5, Yr1_5, 'LineWidth', 2, 'Color', 'b')
% leg2 = num2cell(repmat("", size(tleg)));
% leg2{end + 1} = "";
% leg2{end + 1} = "trajectoire active";
% leg2{end + 1} = "";
% leg2{end + 1} = "";
% leg2{end + 1} = "";
% leg2{end + 1} = "";
% leg2{end + 1} = "";
% leg2{end + 1} = "trajectoire naive";
% lgd = legend(leg2, 'Interpreter', 'latex', 'Location', 'southoutside');
% title("Correspondance avec les trajectoires theoriques", 'Interpreter', 'latex')
% hold off
% 
% waitforbuttonpress;
% clf

% daphnies qui passent par le voisinnage du point [x,y]

Xr0_pt = readmatrix(chemin2 + "Xr0_pt.csv")*0.01;
Yr0_pt = readmatrix(chemin2 + "Yr0_pt.csv")*0.01;
Xr1_pt = readmatrix(chemin2 + "Xr1_pt.csv")*0.01;
Yr1_pt = readmatrix(chemin2 + "Yr1_pt.csv")*0.01;

cote = 0.03;
centre = [Xr0_pt(1), Yr0_pt(1)]
carre = selectTraj(listeX, listeY, listeT, centre, cote);
affichegroupes(carre, listeX, listeY, agit1, agit2)
hold on
x = [centre(1)-(cote/2) centre(1)+(cote/2) centre(1)+(cote/2) centre(1)-(cote/2)];
y = [centre(2)-(cote/2) centre(2)-(cote/2) centre(2)+(cote/2) centre(2)+(cote/2)];
patch(x, y, 'red', 'EdgeColor', 'red', 'FaceAlpha', 0.1)
hold on

plot(Xr0_pt, Yr0_pt, 'LineWidth', 2, 'Color', 'r')
hold on
plot(Xr1_pt, Yr1_pt, 'LineWidth', 2, 'Color', 'b')
waitforbuttonpress;
clf

% daphnies piegees dans les agitateurs

subplot(1, 2, 1);
affichegroupes(ag1, listeX, listeY, agit1, agit2)
title("Daphnies piegees dans l'agitateur 1", 'Interpreter', 'latex');
subplot(1, 2, 2);
affichegroupes(ag2, listeX, listeY, agit1, agit2)
title("Daphnies piegees dans l'agitateur 2", 'Interpreter', 'latex');
hold off
waitforbuttonpress;
clf

%% vitesses trajectoires

% % daphnie morte (2, 13, 16, 20, 21, 23, 27)pour la video 2
% 
% numMorte = 1;
% Um = (listeX{numMorte}(2:end) - listeX{numMorte}(1:end-1)) ./ (listeT{numMorte}(2:end) - listeT{numMorte}(1:end-1));
% Vm = (listeY{numMorte}(2:end) - listeY{numMorte}(1:end-1)) ./ (listeT{numMorte}(2:end) - listeT{numMorte}(1:end-1));
% Nm = sqrt(Um.*Um + Vm.*Vm);
% Nm = Nm.*100;% on repasse en cm/s
% plot(listeT{numMorte}(1:end-1), Nm, 'Color', [1 0.5 0.5])
% hold on
% plot(listeT{numMorte}(1:end-1), smooth(Nm, 0.05), 'LineWidth', 2, 'Color', 'r')
% hold on
% 
% % daphnie vivante (1, 9, 10, 11, 12, 14, 17, 22, 25) pour la video 2
% 
% numVivante = 13;
% Uv = (listeX{numVivante}(2:end) - listeX{numVivante}(1:end-1)) ./ (listeT{numVivante}(2:end) - listeT{numVivante}(1:end-1));
% Vv = (listeY{numVivante}(2:end) - listeY{numVivante}(1:end-1)) ./ (listeT{numVivante}(2:end) - listeT{numVivante}(1:end-1));
% Nv = sqrt(Uv.*Uv + Vv.*Vv);
% Nv = Nv.*100;% on repasse en cm/s
% plot(listeT{numVivante}(1:end-1), Nv, 'Color', [0.5 1 0.5])
% hold on
% plot(listeT{numVivante}(1:end-1), smooth(Nv, 0.1), 'LineWidth', 2, 'Color', 'g')
% 
% %xlim([0 6])
% %ylim([0 10])
% legend("", "Morte", "", "Vivante", 'Interpreter', 'latex')
% title('Vitesse des daphnies vivantes vs mortes', 'Interpreter', 'latex')
% xlabel('Temps (en s)', 'Interpreter', 'latex');
% ylabel('Vitesse (en cm/s)', 'Interpreter', 'latex')
% set(gca,'TickLabelInterpreter','latex')