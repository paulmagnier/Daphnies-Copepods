function [listeX, listeY, listeT, bloqueesag1, bloqueesag2] = tronque(listX, listY, listT, agit1, agit2, lim)
    rayon = 0.0129;
    listeX = {};
    listeY = {};
    listeT = {};
    bloqueesag1 = [];
    bloqueesag2 = [];
    [h, n1] = size(listX);
    for i = 1:n1
        Xi = listX{i};
        Yi = listY{i};
        Ti = listT{i};
        [n2, h2] = size(Xi);
        critarret = 1;
        gpe1 = 0;
        gpe2 = 0;
        for j = 1:n2
            bool1 = (Xi(j)-agit1(1))^2 + (Yi(j)-agit1(2))^2 < rayon^2;
            gpe1 = gpe1 | bool1;
            bool2 = (Xi(j)-agit2(1))^2 + (Yi(j)-agit2(2))^2 < rayon^2;
            gpe2 = gpe2 | bool2;
            booleen = bool1 | bool2; 
            if booleen & critarret
                listX{i} = Xi(1:j);
                listY{i} = Yi(1:j);
                listT{i} = Ti(1:j);
                critarret = 0;
            end
            if critarret & (j == n2)
                listX{i} = Xi;
                listY{i} = Yi;
                listT{i} = Ti;
            end
        end
        [n3, h3] = size(listX{i});
        if n3 > lim
            listeX{end + 1} = listX{i};
            [h4, n4] = size(listeX);
            if gpe1
                bloqueesag1 = [bloqueesag1, n4];
            end
            if gpe2
                bloqueesag2 = [bloqueesag2, n4];
            end
            listeY{end + 1} = listY{i};
            listeT{end + 1} = listT{i};
        end
    end
end