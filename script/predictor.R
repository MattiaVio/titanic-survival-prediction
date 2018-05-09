# Load packages
library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('mice') # imputation
library('randomForest') # classification algorithm


train = read.csv("input/train.csv",header=TRUE,stringsAsFactors = FALSE)
test = read.csv("input/test.csv",header=TRUE,stringsAsFactors = FALSE)
full  <- bind_rows(train, test) # bind training & test data


# Grab title from passenger names
full$Title <- gsub('(.*, )|(\\..*)', '', full$Name)
# Show title counts by sex
table(full$Sex, full$Title)

full$Surname <- gsub( ",.*$", "", full$Name )

data = train 

imp <- mice(data, m = 5)
# m = 1 specifies a single imputation, standard would be m = 5 for multiple imputation
# The imputation method could be specified with 'method = ' - standard is pmm
# The predictor matrix could be specified with 'predictorMatrix'

# Completed data
data_imp <- complete(imp)

# Plot age distributions
par(mfrow=c(1,2))
hist(train$Age, freq=F, main='Age: Original Data', 
     col='darkblue', ylim=c(0,0.04))
hist(data_imp$Age, freq=F, main='Age: MICE Output', 
     col='lightblue', ylim=c(0,0.04))
