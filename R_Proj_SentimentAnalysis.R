library(tm)
library(wordcloud)
library(syuzhet)
meds<- read.csv("C:\\Users\\Safal\\Downloads\\drugsComTest_raw.csv", header=TRUE, stringsAsFactors = FALSE)
str(meds)
corpus <- iconv(meds$review)
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)
inspect(corpus[1:5])
reviews_final <- corpus

length(reviews_final)
tdm <- TermDocumentMatrix(reviews_final[1:"10000"])
tdm <- as.matrix(tdm)
tdm[12:39,1:20]


#5 most common words
tdm_v <- sort(rowSums(tdm),decreasing=TRUE)
tdm_d <- data.frame(word = names(tdm_v),freq=tdm_v)
# Display the top 5 most frequent words
head(tdm_d, 5)
barplot(tdm_d[1:5,]$freq, las = 2, names.arg = tdm_d[1:5,]$word,
        col ="yellow", main ="Top 5 most frequent words",
        ylab = "Word frequencies")

#Association
tdms <- TermDocumentMatrix(reviews_final[1:"10000"])
findAssocs(tdms, terms = c("effect","fever","birth","depress","cough"), corlimit = 0.25)		
#findAssocs(tdms, terms = findFreqTerms(tdms, lowfreq = 1000), corlimit = 0.25)

w <- rowSums(tdm)
w <- subset(w, w>=500)
barplot(w,las=2, col="green", ylab="Count", main="Bar Graph of occurences of frequent words")


w<-sort(rowSums(tdm),decreasing=TRUE)
set.seed(2000)
wordcloud(words=names(w), freq=w, max.words=70, random.order=T, min.freq=5, colors=brewer.pal(25,"Dark2"), scale=c(3,0.3))



sentiment_data <- iconv(meds$review)
s <- get_nrc_sentiment(sentiment_data)
s[1:10,]


s$score <- s$positive-s$negative
s[1:10,]

#write.csv(x=s, file="C:\\Users\\Safal\\Downloads\\FinalScores.csv")

review_score <- colSums(s[,])
print(review_score)

barplot(colSums(s), las=2, col=rainbow(10), ylab='Count', main='Sentiment')

total <- colSums(ab[2])
total
pospercent=round(((colSums(s[10])/total)*100), digits=2)
negpercent=round(((colSums(s[9])/total)*100), digits=2)
postring= paste(c("Positive (",pospercent,") %"), collapse="")
negstring= paste(c("Negative (",negpercent,") %"), collapse="")


ab <- data.frame(group=c(postring,negstring), value=c(colSums(s[10]),colSums(s[9])))

library(ggplot2)
bp <- ggplot(ab, aes(x="", y=value, fill=group)) + geom_bar(width=1, stat="identity")
pie <- bp + coord_polar("y", start=0)
pie




