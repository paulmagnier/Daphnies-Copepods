function [listeX, listeY, listeT] = extractTraj(id, X, Y, T)
    listeX = {};
    listeY = {};
    listeT = {};
    [lenT, j] = size(id);
    i = 1;
    while i < lenT
        j = id(i);
        k = i + j - 1;
        listeX{end + 1} = X(i:k);
        listeY{end + 1} = Y(i:k);
        listeT{end + 1} = T(i:k);
        i = k+1;
    end
end