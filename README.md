Compilation of the above codes can be carried out in any version of Matlab that is compatible with any OS  and Windows, and requires no additional dependencies. However, it is better to use the Matlab 2021a version.

Here, the codes are presented to estimate the parameters.   They are written for Matlab. Other details related to the study and numerical simulations may be found in the Section **Parameter estimation and model calibration** in the  manuscript.

 The experimental data are given in the files "Ch1603_experimental_data.xlsx"  and "Ch1616_experimental_data"   for validation purposes.

 1. For Ch1603 
    1. Ch1603_28_182.m:  parameter estimation for  28 to 182 days.
    2. Ch1603_182_385.m:  parameter estimation for  182 to 385 days.
    3. Ch1603_validation_with_experimental_data.m: Final plots
    4. Ch1603_experimental_data.xlsx:  Experimental data. The corresponding article is mentioned in the manuscript.

     
 2. For Ch1616
    1. Ch1616_28_182.m:  parameter estimation for  28 to 182 days.
    2. Ch1616_182_413.m:  parameter estimation for  182 to 413 days.
    3. Ch1616_validation_with_experimental_data.m: Final plots
    4. Ch1616_experimental_data.xlsx:  Experimental data. The corresponding article is mentioned in the manuscript.

 3. fminsearchbnd.m: Keep this m-file in the same folder. This function minimizes errors in the time of parameter estimation.
