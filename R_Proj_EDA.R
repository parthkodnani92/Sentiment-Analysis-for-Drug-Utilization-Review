
library(tidyverse)
library(DataExplorer)
meds<- read.csv("C:\\Users\\Safal\\Downloads\\drugsComTest_raw.csv", header=TRUE, stringsAsFactors = FALSE)
str(meds)
#glimpse(meds)
dim(meds)
length(unique(meds$condition))
length(unique(meds$drugName))
#Summary 
summary(meds)

#Most Useful Drugs
uniqueruc= meds %>% 
  group_by(drugName) %>% 
  summarise(mean_r = mean(rating), mean_uc = mean(usefulCount)) 
uniqueruc
#write.csv(x=uniqueruc, file="C:\\Users\\Safal\\Downloads\\DrugsRating&UsefulCount.csv")
meds %>% summarise(mean_r = mean(rating), mean_uc = mean(usefulCount))
mostusefulcount= uniqueruc[order(-uniqueruc$mean_uc),]
mud=mostusefulcount$mean_uc[1:25]
mudn=mostusefulcount$drugName[1:25]
barplot(mud,names.arg=mudn,las=2, ylab="Useful Count",main="25 Most Useful Drugs as per Customers",col="Orange")



plot_str(meds)
plot_missing(meds)
plot_histogram(meds$rating)
plot_density(meds)

#Some rows of dataset
dfirst25=meds$drugName[1000:1025]

rfirst25=meds$rating[1000:1025]
xfirst25=meds$X[1000:1025]
confirst25=meds$condition[1000:1025]
ucfirst25=meds$usefulCount[1000:1025]

#pie(table(first25),main="Pie Chart of Some Common Drugs")
#frequent = meds %>% arrange(desc(meds$drugName))
#first252=frequent$drugName[1:100]
#pie(table(first252), main="Pie Chart of Some Common Drugs")

#Plots
plot_correlation(meds, type = 'continuous','Review.Date')
boxplot(meds$rating, main="BoxPlot for Ratings of Drugs")
ggplot(meds, aes(x=rating)) +ggtitle("Histogram for Drug Ratings") + geom_histogram( col="red",fill="green", alpha = .4, binwidth = 3)
#plot(meds$usefulCount)
barplot(ucfirst25,names.arg=confirst25,las=2,main="Useful count of some Drugs as per their Condition",col="violet")
#library(lattice)
#dotplot(meds$usefulCount,binwidth = 3)

#Scatter Plots
plot(meds, main="Scatter Plot of all Attributes in the Dataset ")
#plot(meds$rating,meds$usefulCount, main="Scatter Plot of Drug Ratings vs Useful Count ")



#3D Plot
library(plot3D)
data(meds)
with(meds, text3D(ucfirst25,xfirst25,rfirst25,
                        labels=dfirst25,colvar = rfirst25,
                       col = gg.col(100), theta = 60, phi = 20,
                       xlab = "Useful Count", ylab = "Review Number", zlab = "Rating", 
                       main = "Drug Review and Their Ratings and Useful Count", cex = 0.6, 
                       bty = "g", ticktype = "detailed", d = 2,
                       clab = c("Ratings"), adj = 0.5, font = 2))





