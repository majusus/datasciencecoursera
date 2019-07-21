install.packages("ElemStatLearn")
install.packages("pgmm")
install.packages("rpart")
install.packages("gbm")
install.packages("lubridate")
install.packages("forecast")
install.packages("e1071")
install.packages("randomForest")
install.packages("elasticnet")

######-----------------------Question 1---------------
##loading the vowel data
library(ElemStatLearn)

data(vowel.train)

data(vowel.test)

##setting the factor variable

vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)
set.seed(33833)

##train the data method "rf"
library(caret)
rfvowel <- train(y ~ ., vowel.train, method = "rf")
predrf <- predict(rfvowel, newdata = vowel.test)
confusionMatrix(predrf, vowel.test$y)$overall['Accuracy']

##train the data method "gbm"
library(gbm)
gbmvowel <- train(y ~ ., vowel.train, method = "gbm", verbose = FALSE)
predgbm <- predict(gbmvowel, vowel.test)
confusionMatrix(predgbm, vowel.test$y)$overall['Accuracy']


##compare accuracy between two methods
modelagreed <- (predrf == predgbm)
confusionMatrix(vowel.test$y[modelagreed], predrf[modelagreed])$overall['Accuracy']

######-----------------------Question 2---------------
##loading alzeheimers data
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

##predicting using different methods to find the best accuracy
set.seed(62433)
mod_rf <- train(diagnosis ~ ., training, method = "rf")
mod_gbm <- train(diagnosis ~ ., training, method = "gbm", verbose = FALSE)
mod_lda <- train(diagnosis ~ ., training, method = "lda")

rfpred <- predict(mod_rf, testing)
gbmpred <- predict(mod_gbm, testing)
ldapred <- predict(mod_lda, testing)

##getting accuracy for the different methods individually and together
confusionMatrix(rfpred, testing$diagnosis)$overall['Accuracy'] ##rf --79
confusionMatrix(gbmpred, testing$diagnosis)$overall['Accuracy'] ##gbm --78
confusionMatrix(ldapred, testing$diagnosis)$overall['Accuracy'] ##lda --76

#combine prediction models
combine <- data.frame(rfpred, gbmpred, ldapred, diagnosis = testing$diagnosis)
mod_comb <- train(diagnosis ~ ., combine, method = "rf")
combpred <- predict(mod_comb, testing)
confusionMatrix(testing$diagnosis, combpred)$overall['Accuracy'] ##--80


######-----------------------Question 3---------------
##loading Conrete data
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

##applying method lasso
set.seed(233)
modlasso <- train(CompressiveStrength ~ ., training, method = "lasso")

##plotting
library(elasticnet)
plot.enet(modlasso$finalModel, xvar="penalty", use.color=TRUE) ##-cement


######-----------------------Question 4---------------

##downloading data
url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
download.file(url, destfile = "gaData.csv")
dat = read.csv("gaData.csv")
library(lubridate)
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

##method bats
library(forecast)
modfc <- bats(tstrain)
predts <- forecast(modfc, level = 95, nrow(testing))
fslower95 <- predts$lower
fsupper95 <- predts$upper
tbl<-table ((testing$visitsTumblr>fslower95) & (testing$visitsTumblr<fsupper95))
tbl/nrow(testing)

######-----------------------Question 5---------------

##loading concrete data
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

##method svm from e1071 pkg
library(e1071)
set.seed(325)
fit <- svm(CompressiveStrength ~ ., training)
predsvm <- predict(fit, testing)
error = predsvm - testing$CompressiveStrength
mse <- sqrt(mean(error^2))
mse




