
# 25.11.2018
# Veera Nenonen
# This is the data wrangling exercise for the week 4 in IODS course. The data wrangling part for the 5th week is below.


# read the data sets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

dim(hd) # dataset 'hd' has 8 variables and 195 observations
str(hd) # it has both quantitative and qualitative variables, apparently one observations represents one country
summary(hd) 

dim(gii) # 'gii' has 10 variables and 195 observations
str(gii) # it also has both kind of vaiables, and many of them seems to be some kind of rates and ratios
summary(gii)

colnames(hd) <- c("hdi_rank", "cntry", "hdi", "life_exp", "edu_exp", "edu_mean", "gni", "gni_wo_hdi") # changing column names for 'hd'
colnames(gii) <- c("gii_rank", "cntry", "gi_indx", "mmr", "birth", "parl", "edu_f", "edu_m", "lab_f", "lab_m") # same with 'gii'

gii$edu_ratio <- (gii$edu_f / gii$edu_m) # new variable for the ratio of education
gii$lab_ratio <- (gii$lab_f / gii$lab_m) # and another one

human <- merge(hd, gii, by = "cntry") # join the two datasets
str(human) # now we have 19 variables and 195 observations

write.csv(human, file = "data/human.csv", row.names = FALSE)  # save the dataset in data folder


# 1.12.2018
# This is the data wrangling part for week 5.

human <- read.csv("~/IODS-project/data/human.csv") # Load the human dataset

dim(human) # This dataset has 19 variables and 195 observations
str(human) # All the variables are in numeric (or integer) form except country (cntry) and the Gross National Icome (gni). 
           # There are variables for example about education and labour.
           # The variables are called cntry, hdi, rank, hdi, life_exp, edu_exp, edu_mean, gni, gni_wo_hdi, gii_rank, gi_indx, mmr, birth, parl, edu_f, edu_m,
           # lab_f, lab_m, edu_ratio, lab_ratio.
summary(human) # This shows the summary statistics of the variables.

human$gni <- gsub(",", "", human$gni)
human$gni <- as.numeric(as.character(human$gni)) # Mutate variable 'gni' to numeric

keep_cols <- c("cntry", "edu_ratio", "lab_ratio", "edu_exp", "life_exp", "gni", "mmr", "birth", "parl")
human <- human[, keep_cols] # Keep only certain columns

human <- human[complete.cases(human), ] # Remove all the rows with NA's

remove_regions <- c("Arab States", "East Asia and the Pacific", "Europe and Central Asia", "Latin America and the Caribbean", "South Asia", "Sub-Saharan Africa", "World")
human <- human[!(human$cntry %in% remove_regions),] # Remove rows with regions instead of countries

rownames(human) <- human$cntry # Change the row names
human$cntry <- NULL # Remove country column
dim(human) # Now we'll have 8 variables and 155 observations

write.csv(human, file = "data/human2.csv", row.names = TRUE)  # save the dataset in data folder (I don't want to overwrite old data, so I'll name it as 'human2')


