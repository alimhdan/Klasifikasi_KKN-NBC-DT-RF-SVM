#memanggil data
data <- read.csv("E:/UNDIP/smt 6/data mining/Pak Alan/water_potability.csv",sep =",")
dim(data)
View(data)
anyNA(data[,1])
data[,1][is.na(data[,1])]<- mean(data[,1], na.rm = TRUE)
anyNA(data[,1])
anyNA(data[,2])
anyNA(data[,3])
anyNA(data[,4])
anyNA(data[,5])
data[,5][is.na(data[,5])] <- mean(data[,5], na.rm = TRUE)
anyNA(data[,5])
anyNA(data[,6])
anyNA(data[,7])
anyNA(data[,8])
data[,8][is.na(data[,8])] <- mean(data[,8], na.rm = TRUE)
anyNA(data[,8])
anyNA(data[,9])
anyNA(data[,10])
anyNA(data)

#melakukan penyesuaian skala data
data[data$Potability==0,]$Potability<-"Not Potable"
data[data$Potability==1,]$Potability<-"Potable"
data$Potability=as.factor(data$Potability)
str(data)

#pengturan seed
set.seed(0.70*nrow(data))

#membentuk data training dan testing
sample=sample(1:nrow(data),0.70*nrow(data),replace = T)
training=data.frame(data)[sample,]
testing=data.frame(data)[-sample,]

#KNN
library(tidyverse)
library(stringr)
library(GGally)
library(lmtest)
library(car)
library(MLmetrics)
library(effects)
library(magrittr)
library(caret)
library(rsample)
library(class)
#Cek proporsi target
prop.table(table(data$Potability))
#Mencari rekomendasi k terbaik
round(sqrt(nrow(training)),0)
#Scaling Data Numerik
numericIndex <- sapply(X = training, FUN = is.numeric)
training_x <- scale(training[,numericIndex])
training_y <- select(training, Potability)

test_knn_x <- scale(testing[,numericIndex], 
                             center = attr(training_x, "scaled:center"),
                             scale = attr(training_x, "scaled:scale"))
test_knn_y <- select(testing, Potability)
#Klasifikasi dengan KNN
knn_pred <- knn(train = as.data.frame(training_x),
                         test = as.data.frame(test_knn_x),
                         cl = training_y$Potability,
                         k = 49)
#Confusion Matriks
knn_conf <- confusionMatrix(knn_pred, reference = test_knn_y$Potability)
hasil1=knn_conf
hasil1
#melihat hasil evauasi secara singkat
eval_knn <- data.frame(Accuracy = knn_conf$overall[1],
                       Recall = knn_conf$byClass[1],
                       Specificity = knn_conf$byClass[2],
                       Precision = knn_conf$byClass[3])
eval_knn

#naive bayes
library(caret)
library(e1071)
#membentuk model Naive Bayes 
modelNB=naiveBayes(Potability~.,data=training)
modelNB
#melakukan prediksi 
prediksi=predict(modelNB,testing)
hasil2=confusionMatrix(table(prediksi,testing$Potability))
hasil2

#Decision Tree
library(rpart)
library(rpart.plot)
model <- rpart(Potability ~ .,data = training,method = "class")
model
win.graph()
rpart.plot(model,cex=0.95,under = T,fallen.leaves = F)
#prediksi
preds <- predict(model, testing, type = "class")
hasil3=confusionMatrix(table(preds,testing$Potability))
hasil3

#Random Forest
library(randomForest)
library(reprtree)#ini blm bs
rf <- randomForest(Potability ~ .,data=training,type="class")
rf
plot(rf)
reprtree:::plot.getTree(rf) #ini blm bisa krn packages g tersedia di R ku
#Prediksi
pred = predict(rf, testing,type = "class")
hasil4=confusionMatrix(table(pred,testing$Potability))
hasil4

#SVM
data.svm<-svm(Potability ~.,data = training ,method = "class")
data.svm
#prediksi
predr <- predict(data.svm, testing, type = "class")
hasil5=confusionMatrix(table(predr,testing$Potability))
hasil5