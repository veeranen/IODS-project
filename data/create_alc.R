
# 15.11.2018
# Veera Nenonen
# This is the data wrangling exercise for the third week in IODS course.
# The data is from UCI Machine Learning repository (https://archive.ics.uci.edu/ml/datasets/Student+Performance)

library(dplyr) # We'll use the package dplyr in here

mat <- read.csv("~/IODS-project/data/student-mat.csv", sep=";") # Import the firs dataset and name it as mat
por <- read.csv("~/IODS-project/data/student-por.csv", sep=";") # Import the second dataset and name it as por

dim(mat)
str(mat) # mat has 33 variables and 395 observations and the variables are factors and integers
dim(por)
str(por) # por has same 33 variables but more observations, 649


join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet") # Make a list of the identifying variables
mat_por <- merge(mat, por, by = join_by) # Join the two datasets by the identifier variables 
dim(mat_por)  # In the joined data there are 53 variables and 382 observations. The non-identifying variables are in the data twice because there can be two 
              # different values for one student from both datasets.
stra(mat_por) # The variables are named as variable_name.x and variable_name.y

alc <- select(mat_por, one_of(join_by)) # We'll make a new dataframe called alc for further use. We select only the distinct rows from the identifier columns.
colnames(alc)

notjoined_columns <- colnames(mat)[!(colnames(mat) %in% join_by)]

# We'll use the if-else -structure to decrease the number of columns to the original so that we don't have to deal with duplicate columns
for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))   # select two columns from 'mat_por' with the same original name
  first_column <- select(two_columns, 1)[[1]]   # select the first column vector of those two columns
  
  if(is.numeric(first_column)) {   # for numeric columns we'll use the rounded average
    alc[column_name] <- round(rowMeans(two_columns))
  } else {   # and for factors the first column
    alc[column_name] <- first_column
  }
}

dim(alc)  # Now the 'alc' dataframe has 33 variables and 382 observations 
str(alc)

alc$alc_use <- (alc$Dalc + alc$Walc) / 2  # The new column for average usage of alcohol
alc$high_use <- ifelse(alc$alc_use > 2, TRUE, FALSE)  # Another column for high usage

str(alc)  # Now the dataset has 35 variables and 382 observations

write.csv(alc, file = "data/alc.csv", row.names = FALSE)  # Save the dataset in data folder




