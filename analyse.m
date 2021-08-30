function analyse(fileFolder, fileNames, liste_liste_abscisses, ni, nf, n_int, fps)
    %% premiere analyse : trace de la moyenne + ecart type au fil de la video

    moyennes = [];
    ecarts_types = [];

    for i = ni:nf
        ex = liste_liste_abscisses{i};
        moyennes = [moyennes; mean(ex)];
        ecarts_types = [ecarts_types; std(ex)];
    end

    Y = [(moyennes - ecarts_types) (2 .* ecarts_types)];

    colors = [1 1 1; 0.9 0.9 0.9];
    area(Y, 'EdgeColor', 'none')
    colororder(colors);
    hold on
    plot(moyennes, 'color', [0.2 0.2 0.2], 'LineWidth', 2)
    hold on
    ecarts_types_lisses = smooth(ecarts_types, 10);
    plot(ecarts_types_lisses, 'color',[0.4 0.4 0.4] )
    ylim([0 1280])
    set(gca,'ytick',[])
    rainbowcolorbar('westoutside')
    xlabel('time')
    legend("", "mean +- std", "mean", "std")
    hold off
    
    savefig('stat.fig')
    waitforbuttonpress;

    %% seconde analyse : boxplot sur les images par bloc de n_int images

    u = [];
    group = [];

    for i = ni:n_int:nf
        ex = [];
        for j = i:(i + n_int - 1)        
            ex = [ex; liste_liste_abscisses{i}];
        end 
        [n, m] = size(ex);
        u = [u; ex];
        group = [group; repmat({"images " + int2str(i) + " to " + int2str(i + n_int)}, n, 1)];
    end

    boxplot(u, group, 'orientation', 'horizontal', 'DataLim', [0, 1280])
    set(gca,'xtick',[])
    rainbowcolorbar('southoutside')
    hold off

    waitforbuttonpress;

    %% 3eme analyse : distribuation par bloc de n_int images 

    legende = [];
    for i = ni:n_int:nf
        ex = [];
        for j = i:(i + n_int - 1)        
            ex = [ex; liste_liste_abscisses{i}];
        end 
        legende = [legende; "images " + int2str(i) + " to " + int2str(i + n_int)]; 
        h = histfit(ex, 15, 'kernel');% ajouter/retirer le paramètre 'kernel' a la fin
        delete(h(1));
        coul = (nf - i)/(nf + 30);
        h(2).Color = [coul coul coul];
        hold on
    end

    xlim([0 1280])
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    rainbowcolorbar('southoutside')
    legend(legende, 'Location', 'northwest')

    hold off
    
    waitforbuttonpress;
    
    %% 4eme analyse : focus sur l'image correspondant a l'écart type min
    
    [stdmin, idx] = min(ecarts_types_lisses);
    kf = imread(fileFolder + '\' + fileNames{idx});
    lp = pos(kf);
    openfig('stat.fig')
    hold on
    plot([idx idx],[0 1280], 'color', 'r', 'LineWidth', 1.5, 'LineStyle', '--')
    title("Image at min std")
    legendtemp = legend("");
    delete(legendtemp)
    hold off
    
    waitforbuttonpress;
    
    imshow(kf)
    hold on
    plot(lp(:,1), lp(:,2), 'bo')
    title("Image at min std")
    hold off
    
    waitforbuttonpress;
    
    lpx = lp(:,1);
    h = histfit(lpx, 15, 'kernel')
    h(1).EdgeColor = 'none';
    h(1).FaceColor = [0.8 0.8 0.8]
    h(2).LineWidth = 0.8
    title("Image at min std")
    xlim([0 1280])
    set(gca,'xtick',[])
    rainbowcolorbar('southoutside')
    
    waitforbuttonpress;
    
    %% 5eme analyse : nombre de daphnies sur la zone lumineuse au cours du temps
        
    nb_daphnies = [];
    for i = ni:nf
        ex = liste_liste_abscisses{i};
        [m n] = size(ex);
        msansombre = fix(m/2);% m/2 parce qu'il y a l'ombre de la daphnie
        nb_daphnies = [nb_daphnies msansombre];       
    end
    temps = ni:nf;
    temps = (1/fps) * temps;
    f = fit(temps.', nb_daphnies.', 'poly6');
    plot(f, temps, nb_daphnies, 'b.')
    xlabel("time in s")
    ylabel("nb of daphnias in the field")
    title("Daphnias in the fields over time")
    legendtemp = legend("");
    delete(legendtemp)
    
end