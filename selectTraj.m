function gpe = selectTraj(listeX, listeY, listeT, centre, cote)

    gpe = [];
    xmin = centre(1) - (cote/2);
    xmax = centre(1) + (cote/2);
    ymin = (0.355 - centre(2)) - (cote/2);
    ymax = (0.355 - centre(2)) + (cote/2);
    
    [h1, n1] = size(listeX);
    for i = 1:n1
        Xi = listeX{i};
        Yi = listeY{i};
        Ti = listeT{i};
        booleen = 0;
        
        [n2, h2] = size(Xi);
        for j = size(Xi)
            if (Xi(j) > xmin) & (Xi(j) < xmax) & (Yi(j) > ymin) & (Yi(j) < ymax)
                booleen = 1;
            end
        end
        
        if booleen
            gpe = [gpe i];
        end
    end
end