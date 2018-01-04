% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% using deep neural networks", to be published in IEEE Transactions on Geoscience and 
% Remote Sensing, 2018.

% This program has been tested with MATLAB R2017a using a NVDIA GeForce GTX 750 Ti GPU on Windows 10.

% This program trains and tests a Deep Convolution Network (convnetA) for
% identification of plasma waves at Saturn and computes the training and
% testing accuracies for identification of waves and turbulence separately.

% Before executing this code, the user will need to specify INPUT1-7.

%INPUT1:test_data_folder
% folder location of training image set
% A traininig set of images can be found in the folder "Deep_train"
% provided with this repository
train_data_folder = 'C:\Users\Suranga\Documents\Research\Cassini\Cas_matlab_programs\Man_ready\Pros\GitHub_files_and_supp_files\Deep_train\';

%INPUT2:test_data_folder
% folder location of testing image set
% A testing set of images can be found in the folder "Deep_test"
% provided with this repository
test_data_folder = 'C:\Users\Suranga\Documents\Research\Cassini\Cas_matlab_programs\Man_ready\Pros\GitHub_files_and_supp_files\Deep_test\';

%INPUT3:con_layer_size
% size of convolution layer
% Note this must be smaller than the image input size or 120
con_layer_size = 10;

%INPUT4:Num_of_filters
% Number of filters in convolution layer
% Note that the GPU memory will determine the largest number of filter that
% the user can specify here
Num_of_filters = 40;

%INPUT5:Max_pool_layer_size
% Size of max pool layer
% Note that this must be smaller than 120-con_layer_size
Max_pool_layer_size = 10;

%INPUT6:Epochs_to_train
%Number of epochs to train the DCN
Epochs_to_train = 300;

%INPUT7:Init_learn_rate
%Initial learning rate for training the DCN
Init_learn_rate=0.0001;

inc_select = 1;
net_train_performance = zeros(inc_select,4);
net_test_performance = zeros(inc_select,4);

imds_temp=imageDatastore(fullfile(train_data_folder, {'wave','noise'}),...
    'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

          trainDigitData = imds_temp;
         
          layers = [imageInputLayer([1 120 1])
          convolution2dLayer([1,con_layer_size],Num_of_filters)
          reluLayer
          maxPooling2dLayer([1,Max_pool_layer_size],'Stride',1)
          fullyConnectedLayer(2)
          softmaxLayer
          
          classificationLayer()];
      
          options = trainingOptions('sgdm','MaxEpochs',Epochs_to_train, ...
          'InitialLearnRate',Init_learn_rate);

convnetA = trainNetwork(trainDigitData,layers,options);

YTest2 = classify(convnetA, trainDigitData);
TTest2 =   trainDigitData.Labels;
TargetTr = zeros(length(TTest2),1);
OutputTr = zeros(length(TTest2),1);
wwat=find(TTest2 == 'wave');
wwao = find(YTest2 == 'wave');
TargetTr(wwat,1) = 1;
OutputTr(wwao,1) = 1;
net_train_performance(1,1) = length(find(TargetTr ==1 & OutputTr ==1));
net_train_performance(1,2) = length(find(TargetTr ==1 & OutputTr ==0));
net_train_performance(1,3) = length(find(TargetTr ==0 & OutputTr ==0));
net_train_performance(1,4) = length(find(TargetTr ==0 & OutputTr ==1));

Wave_identification_accuracy_train = net_train_performance(1,1)*100.0/(net_train_performance(1,1)+net_train_performance(1,2))
Background_turbulence_identification_accuracy_train = net_train_performance(1,3)*100.0/(net_train_performance(1,3)+net_train_performance(1,4))

imds_test=imageDatastore(fullfile(strcat(test_data_folder,'Bx\'), {'wave','noise'}),...
     'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});


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

clearvars -except convnetA net_train_performance net_test_performance Wave_identification_accuracy_train Wave_identification_accuracy_test Background_turbulence_identification_accuracy_train Background_turbulence_identification_accuracy_test;