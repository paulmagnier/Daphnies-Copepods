% localisation dossiers et fichiers
fileFolder = "D:\Documents Importants\Professionnel\Stage 2A\daphnies\2021-07-02 cycles\2021-07-02_daphnies1_40-30_u3.4_i0.44_10fps_4\cycle 9";
dirOutput = dir(fullfile(fileFolder,'traitee *.jpg'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);

image_interet = 100;

imp = imread(fileFolder + '\' + fileNames{image_interet});
lp = pos(imp);

imshow(imp)
hold on
plot(lp(:,1), lp(:,2), 'bo')