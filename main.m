%% film normal

% localisation dossiers et fichiers
fileFolder = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-07-02 cycles\2021-07-02_daphnies1_40-30_u3.4_i0.44_10fps_1\cycle 3";
dirOutput = dir(fullfile(fileFolder,'traitee *.jpg'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);

% variable pour recuperer les donnees 
liste_liste_abscisses = {};

% lecture image par image 
for p = 1:numFrames
    imp = imread(fileFolder + '\' + fileNames{p});
    lp = pos(imp);
    lpx = lp(:,1);
    liste_liste_abscisses{end + 1} = lpx;   
end

%% analyse film normal

analyse(fileFolder, fileNames, liste_liste_abscisses, 5, numFrames - 5, 50, 10)

%% cycles

nb_dossiers = 10;
liste_liste_liste_abscisses = {};

for k = 1:nb_dossiers
    
    % localisation dossiers et fichiers
    fileFolder = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-07-02 cycles\2021-07-02_daphnies1_40-30_u3.4_i0.44_10fps_4\cycle " + k;
    dirOutput = dir(fullfile(fileFolder,'traitee *.jpg'));
    fileNames = {dirOutput.name}';
    numFrames = numel(fileNames);

    % variable pour recuperer les donnees 
    liste_liste_abscisses = {};

    % lecture image par image 
    for p = 1:numFrames
        imp = imread(fileFolder + '\' + fileNames{p});
        lp = pos(imp);
        lpx = lp(:,1);
        liste_liste_abscisses{end + 1} = lpx;   
    end
    
    % on enregistre la sequence
    liste_liste_liste_abscisses{end + 1} = liste_liste_abscisses;
    
end

%% analyse cycles

fps = 10;
analysekf(liste_liste_liste_abscisses, nb_dossiers, fps)
