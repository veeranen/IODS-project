
# 8.11.2018
# Veera Nenonen
# This script is part of the second week's exercise set. The data can be found from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

df <- read.delim('C:/Users/F2530951/Documents/IODS-project/data/JYTOPKYS3-data.txt', header = TRUE, sep = "\t") # read the text file and save it as dataframe called 'df'
View(df)  # with view we can take a look at the data. We can also see in the Environment (that is usually on the right ->) the details about the size of the data.
          # This dataset has 183 observations and 60 variables.

dim(df) # also the dim() function tells the number of observations and variables

str(df) # the str() function shows all the variables and their datatypes. All the variables seem to be integers except the last one which is a factor with two levels.

summary(df) # from summary we can see more details about the variables. Summary shows for example minimum and maximum values from each variable.
            # All the variables except last four ones are on a scale 1 to 5 and their means and medians can differ a lot. Age has values from 17 to 55, Attitude from 14 to 50 and
            # Points from 0 to 33. From 183 obseravtions 122 were females and 61 were males so the genders are not divided equally.

df$d_sm <- df$D03 + df$D11 + df$D19 + df$D27 # We'll create new variabls so that we can get the needed variables for our new dataset which will be a subset of the original data.
df$d_ri <- df$D07 + df$D14 + df$D22 + df$D30
df$d_ue <- df$D06 + df$D15 + df$D23 + df$D31

df$su_lp <- df$SU02 + df$SU10 + df$SU18 + df$SU26
df$su_um <- df$SU05 + df$SU13 + df$SU21 + df$SU29
df$su_sb <- df$SU08 + df$SU16 + df$SU24 + df$SU32

df$st_os <- df$ST01 + df$ST09 + df$ST17 + df$ST25
df$st_tm <- df$ST04 + df$ST12 + df$ST20 + df$ST28

df$deep <- df$d_sm + df$d_ri + df$d_ue
df$surf <- df$su_lp + df$su_um + df$su_sb
df$stra <- df$st_os + df$st_tm

df$deep_adj <- df$deep / 12
df$surf_adj <- df$surf / 12
df$stra_adj <- df$stra / 8

vars <- c("gender", "Age", "Attitude", "deep_adj", "stra_adj", "surf_adj", "Points") # Here we create a subset of the original data that includes the wanted variables and observations.
ds <- subset(df, Points > 0, 
                  select = vars)

# The working directory is already set to the right one, but if it wasn't the right command for this is setwd(path_of_the_directory)
setwd('C:/Users/F2530951/Documents/IODS-project/data')
write.csv(ds, file = "learning2014.csv", row.names = FALSE)

learn <- read.csv('C:/Users/F2530951/Documents/IODS-project/data/learning2014.csv')
str(learn)
head(learn)

# Everything seems to be working!




