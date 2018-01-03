# Supplementary-material-for-Identification-of-Plasma-waves-at-Saturn-using-deep-neural-networks-
This repository contains supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn  using deep neural networks", submitted to  IEEE Transactions on Geoscience and  Remote Sensing, 2018. The repository contains following files:

1. An Excel file with times where Whistler precursor waves are identified in the upstream region of Saturn: Whistler_precursor_wave_event_times

2. A MATLAB program to read Cassini 1-second averaged MAG data file and load data into MATLAB Workspace and save MAG data as .mat file: Cassini_MAG_reader.m

3. A sample Cassini 1-second averaged calibrated MAG data file in .TAB format (contains MAG data from Aug 27, 2004 to Nov 21, 2004): 04240_04326_0A_FGM_KSO_1S.TAB

4. Two samples of Cassini 1-second averaged calibrated MAG data files in .mat format (contains MAG data from Aug 27, 2004 to Nov 21, 2004 and Jul 09, 2007 to Aug 09, 2007): Mag_1s_data_2004_Aug_27_to_Nov_21.mat & Mag_1s_data_2007_Jul_09_to_Aug_09.mat

5. A MATLAB program to plot Cassini MAG data: Cassini_MAG_data_plotter.m

6. A MATLAB program to save MAG time series with waves as 1D JPEG images: Cassini_MAG_data_to_JPEG_image_converter_wave.m

7. A MATLAB program to save MAG time series with backgroudn turbulence as 1D JPEG images: Cassini_MAG_data_to_JPEG_image_converter_turb.m

8. A folder containing JPEG images for training a Deep Convolutional Network: Deep_train

9. A folder containing JPEG images for testing a Deep Convolutional Network: Deep_test

10. A MATLAB program for training and testing a Deep Convolutional Network: DCN_train_and_test_for_Saturn_wave_identification.m

11. A trained and tested Deep Convolution Network referred to as DSN1 in the paper

12. A folder containing JPEG images for testing a Deep Convolutional Network for low background turbulence conditions: Low_turb

13. A folder containing JPEG images for testing a Deep Convolutional Network for high background turbulence conditions: High_turb

14. A folder containing JPEG images for testing a Deep Convolutional Network where only 90% of the wave packet is contained in an image: 90_p_wave

15. A folder containing JPEG images for testing a Deep Convolutional Network where only 75% of the wave packet is contained in an image: 75_p_wave

16. A folder containing JPEG images for testing a Deep Convolutional Network where only 50% of the wave packet is contained in an image: 50_p_wave

17. A folder containing data for Figure 7 in the paper 

18. A folder containing trained and tested Deep Convolutional Networks with different architectures used to generate results in Figure 7
