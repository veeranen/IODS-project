
# 8.12.2018
# Veera Nenonen
# This is the Data Wrangling exercise of week 6 in IODS course

library(dplyr)
library(tidyr)

# Load the datasets
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE)
rats <- read.delim("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")

str(bprs) # bprs data has 11 variables and 40 observations
str(rats) # rats data has 13 variables and 16 observations

summary(bprs) # the summary of bprs
summary(rats) # the summary of rats

# The difference between wide and long data is that in wide form the keys are combined with the values in variables.
# In bprs data the key is the week number and in rats it's the WD number.
# In long form there would be separate variables called 'week' and 'WD' or similar, and then the values would be the numbers.

# Categorical variables as factors
bprs$treatment <- as.factor(bprs$treatment)
bprs$subject <- as.factor(bprs$subject)
rats$ID <- as.factor(rats$ID)
rats$Group <- as.factor(rats$Group)

str(bprs)
str(rats)

# Changing from wide form to long form
bprs_l <-  bprs %>% gather(key = weeks, value = score, - treatment, - subject)
rats_l <- rats %>% gather(key = days, value = weight, - ID, - Group)

# Remove the 'week' and 'WD'
bprs_l <- bprs_l %>% mutate(week = as.integer(substr(weeks,5,5)))
rats_l <- rats_l %>% mutate(day = as.integer(substr(days,3,4)))  

bprs_l$weeks <- NULL
rats_l$days <- NULL

str(bprs_l) # Now bprs_l(ong) has 4 variables and 360 observations
str(rats_l) # And rats_l(ong) has 4 variables and 176 observations

# Here are the summaries
summary(bprs_l) 
summary(rats_l)

# Save these datasets in the data file
save(bprs_l, file = "data/BPRSL.Rdata")
save(rats_l, file = "data/RATSL.Rdata")

