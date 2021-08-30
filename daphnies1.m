%% lecture

ima = imread("D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-06-03 premanips\2021-06-03_daphnies_arcenciel_40-30_fluo_17fps_8(a la main)\3eme cycle\2021-06-03_daphnies_arcenciel_40-30_fluo_17fps_8 0127.jpg");

%% essai 1

%imshow(ima)
%[L,Centers] = imsegkmeans(ima,2);
%B = labeloverlay(ima,L);
%imshow(B)

%% traitement image

thresholded = im2bw(ima, 0.9);

sensibilite = 5;% entier
y1 = 2*ima - imdilate(ima, strel('square',sensibilite));% filtrage
y1(y1<0) = 0;
y1(y1>1) = 1;
y2 = imdilate(y1, strel('square',sensibilite)) - y1;
th = multithresh(y2);% seuillage
im_traitee = (y2 <= th*0.7);

% subplot(1, 3, 1)
% imshow(ima)
% subplot(1, 3, 2)
% imshow(thresholded)
% subplot(1, 3, 3)
%imshow(im_traitee)
% hold off

%% recherche centroides sur l'image de base

% stats = regionprops(ima, 'centroid');% calul des centroides
% centroids = cat(1,stats.Centroid);
% 
% imshow(ima);
% hold on
% plot(centroids(:,1),centroids(:,2),'b*')

%% recherche centroides sur l'image filtree

stats = regionprops(im_traitee, 'centroid');% calul des centroides
centroids = cat(1,stats.Centroid);

% imshow(ima);
% hold on
% plot(centroids(:,1),centroids(:,2),'b*')

%% recherche de centroides sur l'image seuillee

% stats = regionprops(thresholded, 'centroid');% calul des centroides
% centroids = cat(1,stats.Centroid);
% 
% imshow(ima);
% hold on
% plot(centroids(:,1),centroids(:,2),'b*')


%% autre methode

% hblob = vision.BlobAnalysis( ...
%                 'AreaOutputPort', false, ...
%                 'BoundingBoxOutputPort', false, ...
%                 'OutputDataType', 'single', ...
%                 'MinimumBlobArea', 1, ...
%                 'MaximumBlobArea', 100, ...
%                 'MaximumCount', 1500);
% Centroid = step(hblob, im_traitee);   % recherche des centres des daphnies
% numBlobs = size(Centroid,1)  % nombre de daphnies
% imshow(im_traitee)
% hold on
% plot(Centroid(:,1),Centroid(:,2),'b*')

%% regroupement des centroides trop proches

X = centroids;
n = size(X(:,1));
for i = 1:n
    for j= (i + 1):n
        if distance(X(i, 1), X(i, 2), X(j, 1), X(j, 2)) < 20
            X(j, 1) = 0;
            X(j, 2) = 0;
        end
    end
end
X2 = X;
X2( ~any(X2,2), : ) = [];

imshow(ima)
hold on
plot(X2(:,1), X2(:,2), 'bo')

%% fonctions

function d = distance(x1, y1, x2, y2)
    d = sqrt((x1 - x2)^2 + (y1 - y2)^2);
end 
