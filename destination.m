function [dest, temps, tleg] = destination(listX, listY, listT, ligne)
    dest = [];
    tleg = {"", "", ""};
    temps = [];
    [h, n1] = size(listX);
    for i = 1:n1
        Xi = listX{i};
        Yi = listY{i};
        Ti = listT{i};
        if (Yi(1) > ligne) & (Yi(end) < ligne)
            dest = [dest i];
            [n2, h2] = size(Xi);
            j = 1;
            temp = Yi(n2 - j);
            ligner = 0.355-ligne;
            while (temp < ligner) & (j < (n2-1))
                j = j+1;
                temp = Yi(n2 - j);
            end
            temps = [temps Ti(j)];
            tleg{end + 1} = strcat(strcat("t = ", num2str(Ti(j))), " s");
        end  
    end           
end