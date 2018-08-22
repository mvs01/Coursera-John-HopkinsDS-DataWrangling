# Coursera-John-HopkinsDS-DataWrangling

R Script:  run_analysis.R

Input: Test and Train datasets by: Subject, X, and Y Datasets 
       Above datasets are merged respectfully
       
Process: Read and merge the input csv files into data.frame
         Extract the std and mean columns from the X dataset containing the measurements
         Combine the above X dataframe with the Subject and Y datsets that contain subject and activity classification data
         
Output: resultsData that is a tidy data.frame containing appropriate labels 
