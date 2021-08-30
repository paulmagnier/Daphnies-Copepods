ima = imread("D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-06-02 premanips arcenciel\2021-06-02_daphnies_arcenciel_17fps_1\contraste réglé\2021-06-02_daphnies_arcenciel_17fps_1 0094.jpg");
rainbow = imread("D:\Documents Importants\Professionnel\Stage 2A\daphnies\matlab\rainbow.png");
lp = pos(ima);
lpx = lp(:,1);
h = histfit(lpx, 20, 'kernel');
ligne = h(2);
x = ligne.XData;
y = ligne.YData;
area(x, y, 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'none')
alpha(.5)
%histogram(lpx,'BinWidth', 50, 'BinLimits', [0 1280], 'FaceColor', 'k')
set(gca,'xtick',[])
rainbowcolorbar('southoutside')