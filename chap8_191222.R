install.packages("XLConnect")
library(XLConnect)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_231')
install.packages("rJava")
library(rJava)

install.packages("KoNLP")
install.packages("wordcloud2")
library(KoNLP)
useSejongDic()
readLines("E:\\R\\애국가(가사).txt")
word_data <- readLines("E:\\R\\애국가(가사).txt")
word_data
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
add_words <- c("백두산","남산","철갑","가을","하늘","달")
buildDictionary(user_dic = data.frame(add_words, rep("ncn", length(add_words))), replace_usr_dic = T)
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
undata <- unlist(word_data2)
undata
word_table <- table(undata)
word_table
undata2 <- Filter(function(x) { nchar(x) >= 2 }, undata)
undata2
word_table2 <- table(undata2)
word_table2
sort(word_table2, decreasing = T)

library(wordcloud2)
wordcloud2(word_table2)
wordcloud2(word_table2, color = "random-light", backgroundColor = "black")
wordcloud2(word_table2, fontFamily = "궁서체", size = 1.2, color = "random-light", backgroundColor = "black", shape = "star")

wordcloud2(demoFreq, size = 1.6, color = rep_len(c("yellow", "green"), nrow(demoFreq)), shape = "cardioid")
wordcloud2(demoFreq, size = 1.6, color = rep_len(c("pink", "purple"), nrow(demoFreq)), shape = "diamond")
wordcloud2(demoFreq, size = 1.6, shape = "triangle-forward")
wordcloud2(demoFreq, color = "random-light", shape = "star")
wordcloud2(demoFreq, minRotation = -pi / 6, maxRotation = -pi / 6, rotateRatio = 1)
wordcloud2(demoFreq, figPath = "E:\\R\\dog.jpg")
