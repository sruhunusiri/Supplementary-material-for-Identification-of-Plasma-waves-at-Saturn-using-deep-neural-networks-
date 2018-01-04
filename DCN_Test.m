% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% using deep neural networks", to be published in IEEE Transactions on Geoscience and 
% Remote Sensing, 2018.

% This program has been tested with MATLAB R2017a using a NVDIA GeForce GTX 750 Ti GPU on Windows 10.

% This program tests a Deep Convolutional Network that has already been trained and computes the
% accuracies for wave and turbulence identification.

% Before executing this program, the user will need to specify INPUT1 in 
% addition to loading an already trained Deep Convolutional Network 
% (The user may use DCN1 which is provided with this repository).

%INPUT1:test_data_folder
% folder location of testing image set
% A testing set of images can be found in the folder "Deep_test"
% which is provided with this repository.
test_data_folder = 'C:\Cassini\Deep_test\';

imds_test=imageDatastore(fullfile(strcat(test_data_folder,'Bx\'), {'wave','noise'}),...
     'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

net_test_performance = zeros(1,4);
testDigitDataBx = imds_test;
convnetT = convnetA;
YTest2Bx = classify(convnetT, testDigitDataBx);
TTest2Bx =  testDigitDataBx.Labels;
TargetBx = zeros(length(TTest2Bx),1);
OutputBx = zeros(length(TTest2Bx),1);
wwat=find(TTest2Bx == 'wave');
wwao = find(YTest2Bx == 'wave');
TargetBx(wwat,1) = 1;
OutputBx(wwao,1) = 1;
TargetBx = transpose(TargetBx);
OutputtBx = transpose(OutputBx);

imds_test=imageDatastore(fullfile(strcat(test_data_folder,'By\'), {'wave','noise'}),...
     'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

testDigitDataBy = imds_test;
    
YTest2By = classify(convnetT, testDigitDataBy);
TTest2By =  testDigitDataBy.Labels;
TargetBy = zeros(length(TTest2By),1);
OutputBy = zeros(length(TTest2By),1);
wwat=find(TTest2By == 'wave');
wwao = find(YTest2By == 'wave');
TargetBy(wwat,1) = 1;
OutputBy(wwao,1) = 1;
TargetBy = transpose(TargetBy);
OutputtBy = transpose(OutputBy);

imds_test=imageDatastore(fullfile(strcat(test_data_folder,'Bz\'), {'wave','noise'}),...
     'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});


testDigitDataBz = imds_test;
    
YTest2Bz = classify(convnetT, testDigitDataBz);
TTest2Bz =  testDigitDataBz.Labels;
TargetBz = zeros(length(TTest2Bz),1);
OutputBz = zeros(length(TTest2Bz),1);
wwat=find(TTest2Bz == 'wave');
wwao = find(YTest2Bz == 'wave');
TargetBz(wwat,1) = 1;
OutputBz(wwao,1) = 1;
TargetBz = transpose(TargetBz);
OutputtBz = transpose(OutputBz);

new_len = length(TargetBz);

GlobTarget = zeros(1,new_len);
track =(find(TargetBz ==1 & TargetBx ==1 & TargetBy==1));
GlobTarget(1,track) = 1;
GlobOutput = zeros(1,new_len);
Output_add = OutputtBx + OutputtBy+OutputtBz;
track = find(Output_add >=2);
GlobOutput(1,track) = 1;

net_test_performance(1,1) = length(find(GlobTarget ==1 & GlobOutput ==1));
net_test_performance(1,2) = length(find(GlobTarget ==1 & GlobOutput ==0));
net_test_performance(1,3) = length(find(GlobTarget ==0 & GlobOutput ==0));
net_test_performance(1,4) = length(find(GlobTarget ==0 & GlobOutput ==1));

Wave_identification_accuracy_test = net_test_performance(1,1)*100.0/(net_test_performance(1,1)+net_test_performance(1,2))
Background_turbulence_identification_accuracy_test = net_test_performance(1,3)*100.0/(net_test_performance(1,3)+net_test_performance(1,4))

clearvars -except convnetA net_train_performance net_test_performance Wave_identification_accuracy_test Background_turbulence_identification_accuracy_test;