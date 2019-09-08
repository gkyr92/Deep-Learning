library(tidyr)
library(stringr)
library(stringi)
options(scipen = 999) # force R not to use exponential notations on numbers

df = read.csv('unbalanced_train_segments.csv',skip=2)
labels = read.csv('class_labels_indices.csv')

df$positive_labels <- as.character(df$positive_labels)

df<- as.data.frame(df) %>% separate(positive_labels,into = paste("Label", 1:15, sep = "_"),  sep = ",",extra='drop')

df <- df %>% gather(df, 'Label', 4: colnames(df)[ncol(df)])

df$Label <- gsub(" ", "", df$Label)

length(table(df$Label))

temp<- as.data.frame(table(df$Label))

hist(table(df$Label), breaks=527 )



library(RMySQL) 
# ALTER USER 'root'@'localhost'
# IDENTIFIED WITH mysql_native_password BY '****'
df = read.csv('eval_segments.csv',skip=2, encoding = 'UTF-8')
df$file <- gsub("-","_", df$X..YTID)
df$file <-tolower(df$file)
df$file <- paste(df$file, ".mp3", sep="")
df$id <- 1:nrow(df)
df$file_downloaded <-0
colnames(df) <- c('url', 'start_time', 'end_time', 'labels', 'filename', 'id', 'file_downloaded')

mydb<-dbConnect(MySQL(), user='root', password='****', dbname='dl_project', host='127.0.0.1')   

dbWriteTable(mydb,name= 'evaluation_files', value=df , append = T, row.names=F) 
