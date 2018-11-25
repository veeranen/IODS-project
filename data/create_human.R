
# 25.11.2018
# Veera Nenonen
# This is the data wrangling exercise for the week 4 in IODS course.


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