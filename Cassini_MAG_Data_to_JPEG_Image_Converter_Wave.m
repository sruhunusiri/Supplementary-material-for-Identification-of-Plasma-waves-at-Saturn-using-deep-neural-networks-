% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% using deep neural networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a on Windows 10.

% This program generates 1D JPEG images from Cassini time series data for
% DCN training and testing. This code was specifically used to generate
% JPEG images containing wave packets similar to the ones in the folder
% "Deep_train/waves/" provided with this repository.

% Before executing this program, the user will need to load Cassini MAG data to 
% the MATLAB workspace (for example load Mag_1s_data_2004_Nov_08_to_Nov_09.mat provide with this repository)
% and specify INPUT1-INPUT7 below.

%INPUT1:train_folder 
%location to save the training image set
train_folder = 'C:\Cassini\Deep_train\wave\';

%INPUT2:test_folder 
%location to save the testing image set
test_folder  = 'C:\Cassini\Deep_test\'

%INPUT3:train_or_test
% specify 1 for this variable to create a training set of images with the folder structure 
% appropriate for DCN training similar to the folder "Deep_train" provided
% with this repository 
% specify 0 for this variable to create a testing set of images with the folder structure 
% appropriate for DCN testing similar to the folder "Deep_test" provided
% with this repository 
train_or_test = 1; 

%INPUT4:st_fil
% variable for specifying the start index for image file name. 
% If you want to start the file name index with 1 use the default value of 0.
st_fil=0; 

%INPUT5:shift_time
% variable for specifying time in seconds to create JPEG image containing a 
% fraction of the wave packet. 
% Use the default value of 0 for creating JPEG images with no such shift.
% The JPEG images in the subfolders "waves" in the
% folders "Deep_train" and "Deep_test" were constructed
% using a default value of 0 for the "shift_time" variable.
% For example, if you need to create a JPEG image with only 90% of
% the wave packet use (1-0.9)*120 = 12. The "waves" subfolders within the folders "90p_Wave_Packet_Test_Set",
% "75p_Wave_Packet_Test_Set", and "75p_Wave_Packet_Test_Set" provided with this repository contain JPEG images of waves that only 
% contain 90%, 75%, and 50% of the wave packets. These JPEG
% images were constructed by using shift times of 12, 30, and 60,
% respectively. 
shift_time = 0.0;                
             
%INPUT6:SDate
%Matrix of start times for the waves of interest
%The following example times are specified assuming that Mag_1s_data_2004_Nov_08_to_Nov_09.mat has
%been loaded into the MATLAB workspace
SDate = [   [2004,11,8,2,32,0];...  
            [2004,11,8,10,9,30];...
            [2004,11,8,11,24,30];...
            [2004,11,8,17,45,30];...
            [2004,11,8,20,37,30];...
            [2004,11,9,10,12,30];...
            [2004,11,9,15,9,30];...
            [2004,11,9,15,20,0];...
            [2004,11,9,15,50,30];...
            [2004,11,9,18,50,0];...
            [2004,11,9,19,28,0];...
            [2004,11,9,22,13,30];...
            [2004,11,9,23,42,30];...
            [2004,11,8,21,13,0];... 
            [2004,11,8,21,59,0];... 
            [2004,11,9,13,59,50];...
            [2004,11,9,20,23,0];... 
            [2004,11,9,21,7,50];... 
            [2004,11,9,23,9,0];...  
            [2004,11,9,23,31,0];... 
            ];
            
%INPUT7:EDate     
%Matrix of end times for the waves of interest
%The following times are specified assuming that Mag_1s_data_2004_Nov_08_to_Nov_09.mat has
%been loaded into the MATLAB workspace
EDate = [   [2004,11,8,2,34,0];... 
            [2004,11,8,10,11,30];...
            [2004,11,8,11,26,30];...
            [2004,11,8,17,47,30];...
            [2004,11,8,20,39,30];... 
            [2004,11,9,10,14,30];...
            [2004,11,9,15,11,30];...
            [2004,11,9,15,22,0];...
            [2004,11,9,15,52,30];...
            [2004,11,9,18,52,0];...
            [2004,11,9,19,30,0];...
            [2004,11,9,22,15,30];...
            [2004,11,9,23,44,30];...
            [2004,11,8,21,15,0];... 
            [2004,11,8,22,1,0];...  
            [2004,11,9,14,1,50];...  
            [2004,11,9,20,25,0];...  
            [2004,11,9,21,9,50];...  
            [2004,11,9,23,11,0];...  
            [2004,11,9,23,33,0];...  
             
            ];
        
        num_wav = length(SDate(:,1));
        holder  =zeros(1,num_wav);
        
        if train_or_test ==1 
            mkdir(train_folder);
        else
            
            temp_test_folder=strcat(test_folder,'Bx\wave\');
            mkdir(temp_test_folder);
            temp_test_folder=strcat(test_folder,'By\wave\');
            mkdir(temp_test_folder);
            temp_test_folder=strcat(test_folder,'Bz\wave\');
            mkdir(temp_test_folder);
        end
   
        
for i=1: num_wav
            
    row_select = i;
    
    start_date = datenum(SDate(row_select,1),SDate(row_select,2),SDate(row_select,3),SDate(row_select,4),SDate(row_select,5),SDate(row_select,6)+shift_time);
    end_date = datenum(EDate(row_select,1),EDate(row_select,2),EDate(row_select,3),EDate(row_select,4),EDate(row_select,5),EDate(row_select,6)+shift_time);

    indices = find(Date_num > start_date & Date_num < end_date); 
    Date_now = Date_num(indices,1);
    Bx_now = Bx(indices,1);
    By_now = By(indices,1);
    Bz_now = Bz(indices,1);
    Bmag_now = B_mag(indices,1);
    Bz_now = transpose(Bz_now);
    Bx_now = transpose(Bx_now);
    By_now = transpose(By_now);

    Wave_now = Bx_now-min(Bx_now);
    Wave_now = Wave_now/max(Wave_now);
   
    if length(Wave_now) == 120 
        
        if train_or_test ==1
            
        file_ex = char(strcat(train_folder,'wave',string((i-1)*3+1),'.jpg'));
        
        else
            
        temp_test_folder=strcat(test_folder,'Bx\wave\');   
        file_ex = char(strcat(temp_test_folder,'wave',string(i+st_fil),'.jpg'));
        
        end
        
        I=mat2gray(Wave_now,[0,1]);
        imwrite(I,file_ex);

    end

    Wave_now = By_now-min(By_now);
    Wave_now = Wave_now/max(Wave_now);

    if length(Wave_now) == 120 
        
       if train_or_test ==1
           
        file_ex = char(strcat(train_folder,'wave',string((i-1)*3+2),'.jpg'));
        
       else
        
        temp_test_folder=strcat(test_folder,'By\wave\');   
        file_ex = char(strcat(temp_test_folder,'wave',string(i+st_fil),'.jpg'));
        
       end
       
        I=mat2gray(Wave_now,[0,1]);
        imwrite(I,file_ex);

    end


    Wave_now = Bz_now-min(Bz_now);
    Wave_now = Wave_now/max(Wave_now);
   
    if length(Wave_now) == 120
        
       if train_or_test ==1
           
        file_ex = char(strcat(train_folder,'wave',string((i-1)*3+3),'.jpg'));
        
       else
        temp_test_folder=strcat(test_folder,'Bz\wave\');   
        file_ex = char(strcat(temp_test_folder,'wave',string(i+st_fil),'.jpg'));
       
       end
       
        I=mat2gray(Wave_now,[0,1]);
        imwrite(I,file_ex);

    end

    

end

clearvars -except Bx By Bz B_mag Date_num;
