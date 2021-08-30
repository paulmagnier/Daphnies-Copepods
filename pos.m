function liste_points = pos(ima)
    % filtrage/seuillage de l'image
    sensibilite = 5;% entier
    y1 = 2*ima - imdilate(ima, strel('square',sensibilite));
    y1(y1<0) = 0;
    y1(y1>1) = 1;
    y2 = imdilate(y1, strel('square',sensibilite)) - y1;
    th = multithresh(y2);
    im_traitee = (y2 <= th*0.7);
    % recherche des centres
    stats = regionprops(im_traitee, 'centroid');
    centroids = cat(1,stats.Centroid);
    % regroupement des centres trop proches
    n = size(centroids(:,1));
    for i = 1:n
        for j= (i + 1):n% il ne faut pas traiter 2 fois le meme cluster
            if distance(centroids(i, 1), centroids(i, 2), centroids(j, 1), centroids(j, 2)) < 20
                centroids(j, 1) = 0;
                centroids(j, 2) = 0;
            end
        end
    end
    centroids( ~any(centroids,2), : ) = [];
    liste_points = centroids;
    % distance algebrique
    function d = distance(x1, y1, x2, y2)
        d = sqrt((x1 - x2)^2 + (y1 - y2)^2);
    end
end