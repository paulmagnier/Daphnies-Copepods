function affichegroupes(gpe, listeX, listeY, agit1, agit2)
    plot(agit1(1), agit1(2), '*', 'color', 'r');
    xlabel('m', 'Interpreter', 'latex');
    ylabel('m', 'Interpreter', 'latex');
    set(gca,'TickLabelInterpreter','latex')
    xlim([0 0.265])%0.265
    ylim([0 0.355])
    hold on
    text(agit1(1) + 0.005, agit1(2), '1', 'Interpreter', 'latex', 'color', 'r');
    hold on
    plot(agit2(1), agit2(2), '*', 'color', 'b');
    hold on
    text(agit2(1) + 0.005, agit2(2), '2', 'Interpreter', 'latex', 'color', 'b');
    hold on
    for i = gpe
        plot(listeX{i}, 0.355 - listeY{i}, '-')
        hold on
        %waitforbuttonpress;
    end
    %hold off
end