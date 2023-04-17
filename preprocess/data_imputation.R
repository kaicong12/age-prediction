library(mice)
library(missForest)
set.seed(123)
setwd("~/Desktop/NUS Y4S1/BN4101/UK_Biobank")
data <- read.csv('master.csv')


# make predictor matrix
allVariables <- c(
  "Total.time..numeric.trail.", "Total.time..alphanumeric.trail.",
  "Total.error..numeric.path.", "Total.error..alphanumeric.path.",
  "Mean.Completion.Time", "Maximum.digits.remembered.correctly",
  "gender", "age", "FI_score", "subject_id",
  "Symbol.Digit.Substitution.Accuracy", "Pair.Matching.Accuracy"
)
n.variables <- length(allVariables)
Mlink <- matrix(1, n.variables, n.variables,
                dimnames = list(allVariables, allVariables))
diag(Mlink) <- 0
Mlink[, c("age", "subject_id")] <- 0


# Remove Inf value in dataframe
data3 <- data[is.finite(data$Pair.Matching.Accuracy),]
imp <- mice(data3, method="pmm", predictorMatrix = Mlink, print=F)


imputationSet1 = complete(my_imp,1)
imputationSet2 = complete(my_imp,2)
imputationSet3 = complete(my_imp,3)
imputationSet4 = complete(my_imp,4)
imputationSet5 = complete(my_imp,5)

write.csv(imputationSet1, "imputed/master1.csv")
write.csv(imputationSet2, "imputed/master2.csv")
write.csv(imputationSet3, "imputed/master3.csv")
write.csv(imputationSet4, "imputed/master4.csv")
write.csv(imputationSet5, "imputed/master5.csv")

# check the imputed dataset
plot(imp, layout=c(1,2))


# quick way of checking the imputed values would be to plot their statistics
# apply(imp$imp$Total.time..numeric.trail.,2,quantile)
# boxplot(imp$imp$Total.time..numeric.trail.)


# even quicker way is to do a stripplot to make sure that all the imputed data are plausible values
# most imputed colums are 
# 1. Total.time..numeric.trail. (13375)
# 2. Total.error..numeric.path. (13375)
# 3. Total.time..alphanumeric.trail. (13375)
# 4. Total.error..alphanumeric.path. (13375)
# 5. Maximum.digits.remembered.correctly (6768)
# 6. FI_score (1303)
# 7. Symbol.Digit.Substitution.Accuracy (1949)
stripplot(my_imp, Total.time..numeric.trail., pch=20, cex=2)
stripplot(my_imp, Total.error..numeric.path., pch=20, cex=2)
stripplot(my_imp, Total.time..alphanumeric.trail., pch=20, cex=2)
stripplot(my_imp, Total.error..alphanumeric.path., pch=20, cex=2)
stripplot(my_imp, Maximum.digits.remembered.correctly, pch=20, cex=2)
stripplot(my_imp, FI_score, pch=20, cex=2)
stripplot(my_imp, Symbol.Digit.Substitution.Accuracy, pch=20, cex=2)


# pool the results over the imputed dataset
# fitmodel <- with(my_imp, lm(age  ~  Mean.Completion.Time + gender + Pair.Matching.Accuracy + 
#                               FI_score + Symbol.Digit.Substitution.Accuracy + 
#                               Maximum.digits.remembered.correctly + Total.time..numeric.trail. + Total.time..alphanumeric.trail. + 
#                               Total.error..numeric.path. + Total.error..alphanumeric.path.
#                               ))
# pool_mice <- pool(fitmodel)
# summary(pool_mice)


# output imputed dataframe to CSV
write.csv(pool_mice, "imputed/master1.csv")
