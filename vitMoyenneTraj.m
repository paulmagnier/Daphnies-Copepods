function v = vitMoyenneTraj(X, Y, T)
    [n, h] = size(T);
    b1 = fix(0.01 * n);
    b2 = fix(0.8 * n);
    X2 = X(b1:b2);
    Y2 = Y(b1:b2);
    T2 = T(b1:b2);
    U = (X2(2:end) - X2(1:end-1)) ./ (T2(2:end) - T2(1:end-1));
    V = (Y2(2:end) - Y2(1:end-1)) ./ (T2(2:end) - T2(1:end-1));
    N = sqrt(U.*U + V.*V);
    v = N.*100;% on repasse en cm/s
end