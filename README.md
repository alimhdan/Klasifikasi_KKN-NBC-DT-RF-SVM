# Perbandingan Kinerja Klasifikasi Water Potability
Pada kali ini, saya akan berbagi mengenai tugas kelompok mata kuliah data mining yaitu perbandingan kinerja berbagai metode klasifikasi. Metode yang digunakan yaitu K-Nearest Neighbor (KKN), Naive Bayes, Decisio Trees, Random Forest, dan Support Vector Machine (SVM). Data yang digunakan pada kali ini berjumlah 3276 observasi dan 10 variabel. Data tersebut dibagi menjadi data training (insample) dan data testing (outsample) dengan pembagian 70% untuk data training dan 30% untuk data testing. Berikut hasil evaluasi kerja masing-masing metode klasifikasi menggunakan data testing (out sample):

# KKN      
           Accuracy    Recall Specificity Precision
    Accuracy 0.6448087 0.9367589   0.1795276  0.645337

Diperoleh nilai akurasi sebesar 64,48%

# Naive Bayes
> hasil2
Confusion Matrix and Statistics
  prediksi      Not Potable Potable
  Not Potable         896     503
  Potable             116     132
                                          
               Accuracy : 0.6242          
                 95% CI : (0.6003, 0.6476)
    No Information Rate : 0.6145          
    P-Value [Acc > NIR] : 0.2165          
                                          
                  Kappa : 0.1052          
       Mcnemar's Test P-Value : <2e-16          
                                          
            Sensitivity : 0.8854          
            Specificity : 0.2079          
         Pos Pred Value : 0.6405          
         Neg Pred Value : 0.5323          
             Prevalence : 0.6145          
         Detection Rate : 0.5440
    Detection Prevalence : 0.8494          
      Balanced Accuracy : 0.5466          
                                          
       'Positive' Class : Not Potable
Diperoleh nilai akurasi sebesar 62,42%

# Decision Tree
![image](https://user-images.githubusercontent.com/102334577/161410164-196fa48a-9982-4956-b21b-6c0049d3ee04.png)
> #prediksi
> preds <- predict(model, testing, type = "class")
> hasil3=confusionMatrix(table(preds,testing$Potability))
> hasil3
    Confusion Matrix and Statistics
           
    preds         Not Potable Potable
    Not Potable         850     454
    Potable             162     181
                                          
               Accuracy : 0.626           
                 95% CI : (0.6021, 0.6494)
    No Information Rate : 0.6145          
    P-Value [Acc > NIR] : 0.1746          
                                          
                  Kappa : 0.1367          
                                          
    Mcnemar's Test P-Value : <2e-16          
                                          
            Sensitivity : 0.8399          
            Specificity : 0.2850          
         Pos Pred Value : 0.6518          
         Neg Pred Value : 0.5277          
             Prevalence : 0.6145          
         Detection Rate : 0.5161          
    Detection Prevalence : 0.7917          
      Balanced Accuracy : 0.5625          
                                          
       'Positive' Class : Not Potable     
Diperoleh nilai akurasi sebesar 62,6%

# Random Forest
    > hasil4
      Confusion Matrix and Statistics

             
     pred          Not Potable Potable
    Not Potable         879     430
    Potable             133     205
                                          
               Accuracy : 0.6582          
                 95% CI : (0.6347, 0.6811)
    No Information Rate : 0.6145          
    P-Value [Acc > NIR] : 0.0001332       
                                          
                  Kappa : 0.2097          
                                          
    Mcnemar's Test P-Value : < 2.2e-16       
                                          
            Sensitivity : 0.8686          
            Specificity : 0.3228          
         Pos Pred Value : 0.6715          
         Neg Pred Value : 0.6065          
             Prevalence : 0.6145          
         Detection Rate : 0.5337          
    Detection Prevalence : 0.7948          
      Balanced Accuracy : 0.5957          
                                          
       'Positive' Class : Not Potable       
Diperoleh nilai akurasi sebesar 65,82%

# SVM
    > hasil5
    Confusion Matrix and Statistics

             
     predr         Not Potable Potable
    Not Potable         921     453
    Potable              91     182
                                          
               Accuracy : 0.6697          
                 95% CI : (0.6464, 0.6924)
    No Information Rate : 0.6145          
    P-Value [Acc > NIR] : 1.863e-06       
                                          
                  Kappa : 0.2201          
                                          
     Mcnemar's Test P-Value : < 2.2e-16       
                                          
            Sensitivity : 0.9101          
            Specificity : 0.2866          
         Pos Pred Value : 0.6703          
         Neg Pred Value : 0.6667          
             Prevalence : 0.6145          
         Detection Rate : 0.5592          
    Detection Prevalence : 0.8342          
      Balanced Accuracy : 0.5983          
                                          
       'Positive' Class : Not Potable
Diperoleh hasil akurasi sebesar 66,97%

# Perbandingan Kinerja Model
Berdasarkan hasil tingkat akurasi kinerja model pada data testing maka dapat dilihat bahwa nilai akurasi tertinggi berada pada metode SVM sehingga metode SVM lebih tepat untuk digunakan dalam klasifikasi pada kasus ini.
