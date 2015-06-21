# TidyData

This R script does the following

1. Reads the Activity labels and Feature Labels into 2 data frames activity_labels 
and feature_labels

2. Read the training and test data for X, Y and subject into x*, y* and z* variables

3. Merge the training data and test data in x3, y3 and z3 variables

4. Update the column Names in x3 with Feature_labels.

5. Updare the column Names in y3 and z3 with Activity_id and Subject_id

6. Do column merge of x3, y3 and z3 into Single_Data_Set

7. Subset Single_Data_set to include only those measurements which include mean,
std deviation, activity_id and subject_id

8. Merge(Join) the Single Data Set on Activity_id so that Activity_Description is added

9. Do gsub (find and replace) to expand the column names for measurements to more descriptive names

10. Now we have the Single_data_Set


11.  Now reshape the data to find the mean measurements for each activity_id and subjecT_id.

12. Create a second data_frame "Reshaped_Date_Set" while dropping the activity_description.

13. Aggregate the Reshaped_Data_Set means for each group of subjecT_id and activity_id

14. Write the Reshaped_Data_set onto a text file

