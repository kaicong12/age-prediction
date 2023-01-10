library(mice)
library(missForest)
set.seed(123)
setwd("~/Desktop/NUS Y4S1/BN4101/UK_Biobank")
data <- read.csv('master.csv')


# Remove Inf value in dataframe
# Drop subject id
subject_id <- subset(data, select=c(subject_id))
data2 <- subset(data, select = -c(subject_id))
data3 <- data2[!is.infinite(rowSums(data2)),]
imp <- mice(data3, m=5, method="cart")


# Update predictor matrix to not use age as predictor
pred <- imp$pred
pred[,"age"] <- 0


# Change data imputation method for categorical variable (use PMM for FI score) 
# Run imputation again
# meth <- imp$meth
# meth["FI_score"] <- "pmm"
my_imp <- mice(data3, pred=pred, print=F)


# check the imputed dataset
plot(imp, layout=c(1,2))


# quick way of checking the imputed values would be to plot their statistics
apply(imp$imp$Total.time..numeric.trail.,2,quantile)
boxplot(imp$imp$Total.time..numeric.trail.)


# even quicker way is to do a stripplot to make sure that all the imputed data are plausible values
# most imputed colums are 
# 1. Total.time..numeric.trail. (13375)
# 2. Total.error..numeric.path. (13375)
# 3. Total.time..alphanumeric.trail. (13375)
# 4. Total.error..alphanumeric.path. (13375)
# 5. Maximum.digits.remembered.correctly (6768)
# 6. FI_score (1303)
# 7. Symbol.Digit.Substitution.Accuracy (1949)
stripplot(imp$FI_score)


# pool the results over the imputed dataset
fitmodel <- with(imp, lm(age  ~  Mean.Completion.Time + gender + Pair.Matching.Accuracy + 
                              FI_score + Symbol.Digit.Substitution.Accuracy + 
                              Maximum.digits.remembered.correctly + Total.time..numeric.trail. + Total.time..alphanumeric.trail. + 
                              Total.error..numeric.path. + Total.error..alphanumeric.path.
                              ))
pool_mice <- pool(fitmodel)
summary(pool_mice)


# output imputed dataframe to CSV
write.csv(pool_mice, "imputed_master.csv")
