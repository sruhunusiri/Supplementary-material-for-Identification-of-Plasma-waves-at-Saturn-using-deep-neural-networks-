% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% using deep neural networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a.

% This program generates 1D JPEG images from Cassini time series data for
% DCN training and testing. This program was specifically used to generate
% JPEG images of background turbulence in the folder "Deep_train/noise" provided with this repository.


% Before executing this program, the user will need to load Cassini MAG data to 
% the MATLAB workspace (for example load Mag_1s_data_2007_Jul_26_to_Jul_28.mat provided with this repository)
% and specify INPUT1-INPUT7 below.

%INPUT1:train_folder 
%location to save the training image set
train_folder = 'C:\Cassini\Deep_train\noise\';

%INPUT2:test_folder 
%location to save the testing image set
test_folder  = 'C:\Cassini\Deep_test\';

%INPUT3:train_or_test
% specify 1 for this variable to create a training set of images with the folder structure 
% appropriate for DCN training similar to the folder "Deep_train" provided
% with this repository
% specify 0 for this variable to create a testing set of images with the folder structure 
% appropriate for DCN testing similar to the folder "Deep_test" provided
% with this repository 
train_or_test = 1; 

%INPUT4:rms_class
% set this variable to 1 if turbulence images need to be categorized based
% on rms magnetic field fluctuation. These images can be used to test the
% DCNs ability to identify JPEG images corresponding to background
% turbulence under different rms fluctuation conditions. JPEG images
% categorized in this method can be found in "Low_turb" and "High_turb"
% folders provided with this repository.
% If rms_class is set to 1, images with high vs. low turbulence will be saved in the
% "High_turb" and "Low_turb" subfolders within the "test_folder" specified above.
rms_class = 0;

%INPUT4:rms_threshold
% Set this variable to the desired threshold rms value for classification of JPEG
% images based on the rms fluctuation levels of the magnetic field.
% Note: In selecting this value the user can use the median rms value for the magnetic
% field fluctuations.
% Images corresponding to turbulence levels less than the "rms_threshold" will be saved in the
% "Low_turb" folder within the "test_folder" specified above. 
% Similary, images corresponding to turbulence levels higher than or equal to the "rms_threshold" will be saved in the
% "High_turb" folder within the "test_folder" specified above. 
rms_threshold = 0.0071;

%INPUT4:SDate
%Matrix of start times corresponding to background turbulence 
%The following example times are specified assuming that Mag_1s_data_2007_Jul_26_to_Jul_28.mat has
%been loaded into the MATLAB workspace
SDate = [   [2007,7,26,1,0,0];...
            %[2007,7,28,0,0,0];...
            
         ];
            
%INPUT4:EDate
%Matrix of end times corresponding to background turbulence  
%The following example times are specified assuming that Mag_1s_data_2007_Jul_26_to_Jul_28.mat has
%been loaded into the MATLAB workspace
EDate = [   [2007,7,26,24,0,0];...
            %[2007,7,28,24,0,0];...
            
            ];

       if train_or_test ==1 && rms_class==0 
            mkdir(train_folder);
       end
       if train_or_test ==0 && rms_class==0
            
            temp_test_folder=strcat(test_folder,'Bx\noise\');
            mkdir(temp_test_folder);
            temp_test_folder=strcat(test_folder,'By\noise\');
            mkdir(temp_test_folder);
            temp_test_folder=strcat(test_folder,'Bz\noise\');
            mkdir(temp_test_folder);
       end
       if rms_class==1 
           temp_test_folder=strcat(test_folder,'Low_turb\Bx\noise\');
           mkdir(temp_test_folder);
           temp_test_folder=strcat(test_folder,'Low_turb\By\noise\');
           mkdir(temp_test_folder);
           temp_test_folder=strcat(test_folder,'Low_turb\Bz\noise\');
           mkdir(temp_test_folder);
           temp_test_folder=strcat(test_folder,'High_turb\Bx\noise\');
           mkdir(temp_test_folder);
           temp_test_folder=strcat(test_folder,'High_turb\By\noise\');
           mkdir(temp_test_folder);
           temp_test_folder=strcat(test_folder,'High_turb\Bz\noise\');
           mkdir(temp_test_folder);
       end
      
index_begin = 0;
for row_select=1:length(EDate(:,1))
        
    
    num_wav = length(row_select);
        
       
            
      
        start_date = datenum(SDate(row_select,1),SDate(row_select,2),SDate(row_select,3),SDate(row_select,4),SDate(row_select,5),SDate(row_select,6));
        end_date = datenum(EDate(row_select,1),EDate(row_select,2),EDate(row_select,3),EDate(row_select,4),EDate(row_select,5),EDate(row_select,6));

        indices = find(Date_num > start_date & Date_num < end_date); 

        Date_now = Date_num(indices,1);
        Bx_now = Bx(indices,1);
        By_now = By(indices,1);
        Bz_now = Bz(indices,1);
        Bmag_now = B_mag(indices,1);
        Bx_now = transpose(Bx_now);
        By_now = transpose(By_now);
        Bz_now = transpose(Bz_now);
        Bmag_now = transpose(Bmag_now);
        sampl = length(indices)/120;
        sampl = sampl-mod(sampl,1);
        
        for i=1:(sampl)
            
            st_in = 1+(i-1)*120;
            en_in = st_in + 119;
            
            if length(Bz_now(1,st_in:en_in)) == 120 
    
                Wave_nowx = Bx_now(1,st_in:en_in)-mean(Bx_now(1,st_in:en_in));
                Wave_nowy = By_now(1,st_in:en_in)-mean(By_now(1,st_in:en_in));
                Wave_nowz = Bz_now(1,st_in:en_in)-mean(Bz_now(1,st_in:en_in));
                rms_holder_now = sqrt((rms(Wave_nowx))^2 +(rms(Wave_nowy))^2+(rms(Wave_nowz))^2)/3.0;
 
    
                Wave_now = Bx_now(1,st_in:en_in)-min(Bx_now(1,st_in:en_in));
                Wave_now = Wave_now/max(Wave_now);
    
                if train_or_test ==1 && rms_class == 0
                    
                file_ex = char(strcat(train_folder,'noise',string((i-1)*3+index_begin+1),'.jpg'));
                
                else
                                    
                        temp_test_folder=strcat(test_folder,'Bx\noise\');   
                        file_ex = char(strcat(temp_test_folder,'noise',string(i+index_begin),'.jpg'));
                    
                end
                
                if rms_class == 1
                        
                        if rms_holder_now < rms_threshold
                            
                            file_ex = char(strcat(test_folder,'Low_turb\Bx\noise\','noise',string(i+index_begin),'.jpg'));
      
                        else
                            
                            file_ex = char(strcat(test_folder,'High_turb\Bx\noise\','noise',string(i+index_begin),'.jpg'));
        
                        end
                 end
                
                I=mat2gray(Wave_now,[0,1]);
                imwrite(I,file_ex);
    
                Wave_now = By_now(1,st_in:en_in)-min(By_now(1,st_in:en_in));
                Wave_now = Wave_now/max(Wave_now);
    
                if train_or_test ==1 && rms_class == 0
                    
                file_ex = char(strcat(train_folder,'noise',string((i-1)*3+index_begin+2),'.jpg'));
                
                else
                       
                        temp_test_folder=strcat(test_folder,'By\noise\');   
                        file_ex = char(strcat(temp_test_folder,'noise',string(i+index_begin),'.jpg'));
                    
                end
                
                if rms_class == 1
                        
                        if rms_holder_now < rms_threshold
                            
                            file_ex = char(strcat(test_folder,'Low_turb\By\noise\','noise',string(i+index_begin),'.jpg'));
      
                        else
                            
                            file_ex = char(strcat(test_folder,'High_turb\By\noise\','noise',string(i+index_begin),'.jpg'));
        
                        end
                 end
                    
                I=mat2gray(Wave_now,[0,1]);
                imwrite(I,file_ex);
      
                Wave_now = Bz_now(1,st_in:en_in)-min(Bz_now(1,st_in:en_in));
                Wave_now = Wave_now/max(Wave_now);
    
                if train_or_test ==1 && rms_class == 0
                    
                file_ex = char(strcat(train_folder,'noise',string((i-1)*3+index_begin+3),'.jpg'));
                
                else
        
                        temp_test_folder=strcat(test_folder,'Bz\noise\');   
                        file_ex = char(strcat(temp_test_folder,'noise',string(i+index_begin),'.jpg'));
                end
                
                if rms_class == 1 
                        
                        if rms_holder_now < rms_threshold
                            
                            file_ex = char(strcat(test_folder,'Low_turb\Bz\noise\','noise',string(i+index_begin),'.jpg'));
      
                        else
                            
                            file_ex = char(strcat(test_folder,'High_turb\Bz\noise\','noise',string(i+index_begin),'.jpg'));
        
                        end
                end
              
                
                I=mat2gray(Wave_now,[0,1]);
                imwrite(I,file_ex);
    
        
            end
    end

index_begin =index_begin+sampl;
end
