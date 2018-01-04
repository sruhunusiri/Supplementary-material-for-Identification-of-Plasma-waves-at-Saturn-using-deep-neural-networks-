# Supplementary_material_for_Identification_of_Plasma_Waves_at_Saturn_Using_Deep_Neural_Networks

This repository contains supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
using deep neural networks", submitted to IEEE Transactions on Geoscience and 
Remote Sensing, 2018. 

The repository contains MATLAB programs for generating data sets for training and testing a Deep Convolutional Network, 
MATLAB programs for training and testing a Deep Convolutional Network, data sets for training and testing a Deep Convolutional Network, 
and data for figures in the paper. Detail descriptions of the files are provided below:

1. An Excel file with times where Whistler precursor waves are identified in the upstream region of Saturn: 
   Whistler_precursor_wave_event_times [25 KB]

2. A MATLAB program to read Cassini 1-second averaged MAG data file and load data into MATLAB Workspace and 
   save MAG data as .mat file: Cassini_MAG_Reader.m [3 KB]

3. A sample Cassini 1-second averaged calibrated MAG data file in .TAB format 
   (contains MAG data from Nov 08, 2004 to Nov 09, 2004): 04313_04314_0A_FGM_KSO_1S.TAB [11.4MB]

4. Two samples of Cassini 1-second averaged calibrated MAG data files in .mat format 
   (contains MAG data from Nov 08, 2004 to Nov 09, 2004 and Jul 26, 2007 to Jul 28, 2007): 
   Mag_1s_data_2004_Nov_08_to_Nov_09.mat [1.54 MB] & Mag_1s_data_2007_Jul_26_to_Jul_28.mat [2 MB]

5. A MATLAB program to plot Cassini MAG data: Cassini_MAG_Data_Plotter.m [2 KB]

6. A MATLAB program to save MAG time series with waves as 1D JPEG images: Cassini_MAG_Data_to_JPEG_Image_Converter_Wave.m [8 KB]

7. A MATLAB program to save MAG time series with backgroudn turbulence as 1D JPEG images:  
   Cassini_MAG_data_to_JPEG_Image_Converter_Turb.m [10 KB]

8. A folder containing JPEG images for training a Deep Convolutional Network: Deep_train [3.9 MB]

9. A folder containing JPEG images for testing a Deep Convolutional Network: Deep_test [35.6 MB]

10. A MATLAB program for training and testing a Deep Convolutional Network: 
    DCN_train_and_test_for_Saturn_wave_identification.m [7 KB]

12. A trained and tested Deep Convolution Network referred to as DCN1 in the paper [9 KB]. 
    DCN1 has a convolution layer size of 16, 8 filters, and a max-pooling layer size of 4. 

11. A MATLAB program for testing a Deep Convolutional Network that has already been trained: DCN_Test.m [4 KB]

13. A folder containing JPEG images for testing a Deep Convolutional Network for low background turbulence conditions: 
    Low_turb [18.1 MB]

14. A folder containing JPEG images for testing a Deep Convolutional Network for high background turbulence conditions: 
    High_turb [17.7 MB]

15. A folder containing JPEG images for testing a Deep Convolutional Network where only 90% of the wave packet is 
    contained in an image: 90p_Wave_Packet_Test_Set [35.8 MB] 

16. A folder containing JPEG images for testing a Deep Convolutional Network where only 75% of the wave packet is 
    contained in an image: 75p_Wave_Packet_Test_Set [35.8 MB]

17. A folder containing JPEG images for testing a Deep Convolutional Network where only 50% of the wave packet is 
    contained in an image: 50p_Wave_Packet_Test_Set [35.8 MB]

18. A folder containing data depicted in Figure 7 in the paper: Data_for_figure_7 [65.5 KB]

19. A MATLAB program to plot data in the folder Data_for_figure_7: DCN_Accuracy_Plotter.m [2 KB]






