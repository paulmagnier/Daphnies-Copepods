function analysekf(liste_liste_liste_abscisses, nb_dossiers, fps)

    %% premiere analyse : temps de reactions au fil des sequences
    
    t_reac = [];
    for k = 1:nb_dossiers
        
        liste_liste_abscisses = liste_liste_liste_abscisses{k};
        [p n] = size(liste_liste_abscisses);
        ecarts_types = [];

        for i = 5:(n - 5)
            ex = liste_liste_abscisses{i};
            ecarts_types = [ecarts_types; std(ex)];
        end

        ecarts_types_lisses = smooth(ecarts_types, 10);
        [stdmin, idx] = min(ecarts_types_lisses);
        t_reac = [t_reac idx];
        t_reac_2 = (1/fps) * t_reac;
    end
    
    plot(t_reac_2)
    title("Reaction time")
    xlabel("N° sequence")
    ylabel("reaction time in s")
    
    waitforbuttonpress;

    %% 2eme analyse : distribution aux images clefs 
    
    for k = 1:nb_dossiers
        ex = liste_liste_liste_abscisses{k}{t_reac(k)};
        h = histfit(ex, 15);% ajouter/retirer le paramètre 'kernel' a la fin
        delete(h(1));
        coul = (nb_dossiers - k) / nb_dossiers;
        h(2).Color = [coul coul coul];
        hold on
    end
    
    xlim([0 1280])
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    rainbowcolorbar('southoutside')
    legend('Location', 'northwest')
    title("repartition evolution at keyframes")

    hold off
    waitforbuttonpress;
    
    %% 3eme analyse : nombre de daphnies dans la lumiere au cours des séries
    
    legende = [];
    
    for k = 1:nb_dossiers
        
        legende = [legende; ""; "cycle " + int2str(k)];
        liste_liste_abscisses = liste_liste_liste_abscisses{k};
        [p n] = size(liste_liste_abscisses);
        nb_daphnies = [];
        
        for i = 5:(n - 5)
            ex = liste_liste_abscisses{i};
            [q m] = size(ex);
            qsansombre = fix(q/2);% q/2 parce qu'il y a l'ombre de la daphnie
            nb_daphnies = [nb_daphnies qsansombre];
        end
        
        temps = 5:(n - 5);
        temps = (1/fps) * temps;
        
        f = fit(temps.', nb_daphnies.', 'poly6');
        coul = (nb_dossiers - k) / nb_dossiers;
        h = plot(f, temps, nb_daphnies)
        h(1).Color = [0 coul coul]
        h(1).MarkerSize = 4
        h(2).Color = [0 coul coul]
        h(2).LineWidth = 2
        hold on
        
    end
    
    xlabel("time in s")
    ylabel("nb of daphnias in the field")
    ylim([0 70]);
    xlim([0 40]);
    title("Daphnias in the fields over cycles")
    legend(legende, 'Location', 'eastoutside')
    hold off
    
    
end