# Import install.packages
install.packages("rtweet")
install.packages("dplyr")
install.packages("tidyr")
install.packages("NLP")
install.packages("tm")
install.packages("stringr")
install.packages("ROAuth")
install.packages("twitteR")
install.packages("caret")
install.packages("devtools")
install.packages("katadasaR")
install.packages("tau")
install.packages("parallel")
install.packages("twitteR")
install.packages("RCurl")
install.packages("ggplot2")
install.packages("SnowballC")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("tokenizers")

# Import Library
library(rtweet)
library(dplyr)
library(tidyr)
library(NLP)
library(tm)
library(stringr)
library(ROAuth)
library(twitteR)
library(caret)
library(devtools)
install_github("nurandi/katadasaR")
library(katadasaR)
library(tau)
library(parallel)
library(twitteR)
library(RCurl)
library(ggplot2)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
library(tokenizers)

setwd("E:/UNDIP/smt 6/data mining/praktikum")


token <- create_token(
  consumer_key  = "43EPqgTZSiuuDtOXuJfvbf4He",
  consumer_secret = "mBrOUJrkqnTk4zjz0kg2DvkhEeuhs2ax72F9kI7IarQIClW3Ld",
  access_token = "1244010865214406656-9fTBqgOg4rfTm4I22mez8SYfvvTtLP",
  access_secret = "HDBJDXCOJoVO7UVRc244I5gPjhsBbqUey2JYQMK5FSTFZ")


crawling <- search_tweets("#vaksincovid",
                          lang = "id", include_rts = TRUE)

View(crawling)

#save sebagai CSV
write_as_csv(crawling,"vaksin covid.csv", prepend_ids = TRUE, na="", fileEncoding= "UTF-8")

#Memasukkan file ke dalam Corpus
corpusdata <- Corpus(VectorSource(crawling$text))
View(corpusdata)

#Mengubah seluruh huruf kapital menjadi huruf kecil
data_casefolding <- tm_map(corpusdata, content_transformer(tolower))
inspect(data_casefolding[1:10])

#Data Cleansing
## Remove URL
removeURL <- function(x)gsub("http[^[:space:]]*","",x)
data_URL <- tm_map(data_casefolding, content_transformer(removeURL))
inspect(data_URL[1:10])

##Remove Mention
remove.mention <- function(x)gsub("@\\S+","",x)
data_mention <- tm_map(data_URL, remove.mention)
inspect(data_mention[1:10])

##Remove hastag
remove.hastag <- function(x)gsub("#\\S+","",x)
data_hastag <- tm_map(data_mention, remove.hastag)
inspect(data_hastag[1:10])

##Remove NL
remove.NL <- function(x)gsub("\n","",x)
data_NL <- tm_map(data_hastag, remove.NL)
inspect(data_NL[1:10])

##Replace Comma
replace.comma <- function(x)gsub(",","",x)
data_comma <- tm_map(data_NL, replace.comma)
inspect(data_comma[1:10])

##remove colon
remove.colon <- function(x)gsub(":","",x)
data_colon <- tm_map(data_comma, remove.colon)
inspect(data_colon[1:10])

##remove semicolon
remove.semicolon <- function(x)gsub(";","",x)
data_semicolon <- tm_map(data_colon, remove.semicolon)
inspect(data_semicolon[1:10])

#remove Punctuation
data_punctuation <- tm_map(data_semicolon, content_transformer(removePunctuation))
inspect(data_punctuation[1:10])


#cleaning number
data_number <- tm_map(data_punctuation, content_transformer(removeNumbers))
inspect(data_number[1:10])

#remove emoticon (\u12414)
removeEmoticon <- function(x){gsub("[^\x01-\x7F]", "", x)}
data_emoticon <- tm_map(data_number, content_transformer(removeEmoticon))
inspect(data_emoticon[1:10])

#stopword
stopwordID <- "E:/UNDIP/smt 6/data mining/praktikum/stopwords.txt"
cStopwordID<-readLines(stopwordID)
data_stopword <- tm_map(data_emoticon, removeWords, cStopwordID)
inspect(data_stopword[1:10])

#remove strip whitespace
data_strip<-tm_map(data_stopword,stripWhitespace)
inspect(data_strip[1:10])

##Data stemming
stem_text <- function(text,mc.cores=1)
{
  stem_string <- function(str)
  {str <- tokenize (x=str)
  str <- sapply(str, katadasaR)
  str <- paste(str, collapse = '')
  return(str)}
  x<- mclapply(X=text, FUN = stem_string,mc.cores=mc.cores)
}
data_stemming <- tm_map(data_strip, stem_text)
inspect(data_stemming[1:10])

#check dokumen
myCorpusTokenized <- lapply(data_number, scan_tokenizer)


#DocumentTermMatrix
tdm<-DocumentTermMatrix(data_stemming)
TDMmat<-as.matrix(tdm)
View(TDMmat)


#Pembobotan TF IDF
tfidf<-weightTfIdf(m=tdm,normalize=TRUE)
tfidfmat<-as.matrix(tfidf)
View(tfidfmat)

#Wordcloud
m<-sort(colSums(TDMmat),decreasing = TRUE)
Warna<-brewer.pal(6,"Dark2")
graylevels<-gray((m+10)/(max(m)+10))
d<-data.frame(word=names(m),freq=m)
head(d,10)
wc<-wordcloud(words=d$word,freq=d$freq,min.freq=1,random.order=F,colors=Warna,scale=c(4,0.3),rot.per=0.5)

