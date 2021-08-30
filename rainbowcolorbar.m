function rainbowcolorbar(or)
    rainbow = imread("D:\Documents Importants\Professionnel\Stage 2A\daphnies\matlab\rainbow.png");
    [x y z] = size(rainbow);
    mymap = [];
    for i = 1:y
        mymap = [mymap; impixel(rainbow, i, fix(x/2))];
    end
    maximum = max(max(mymap));
    mymap = mymap ./ maximum;
    colormap(gca,mymap)
    c = colorbar(or);
    set(c,'XTickLabel', '', 'EdgeColor', 'none')
end