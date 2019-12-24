#패키지 설치 환경 설정
install.packages("XLConnect")
library(XLConnect)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_231')
install.packages("rJava")
library(rJava)

#KoNLP, wordcloud2 패키지 설치
install.packages("KoNLP")
install.packages("wordcloud2")
#KoNLP 패키지 로드
library(KoNLP)
#세종 사전 설정
useSejongDic()
#애국가 txt파일을 word_data에 할당
readLines("E:\\R\\애국가(가사).txt")
word_data <- readLines("E:\\R\\애국가(가사).txt")
word_data
#명사 추출: word_data의 각 행에서 명사 추출해 word_data2에 할당
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
#단어 추가: 추가할 단어를 add_words에 할당
add_words <- c("백두산","남산","철갑","가을","하늘","달")
#단어 추가: add_words의 데이터를 사용자 정의 단어(user_dic)로 추가
buildDictionary(user_dic = data.frame(add_words, rep("ncn", length(add_words))), replace_usr_dic = T)
#명사 추출: word_data의 각 행에서 명사를 다시 word_data2에 할당
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
#행렬의 벡터 변환: word_data2를 벡터 변환 후 undata에 할당
undata <- unlist(word_data2)
undata
#사용 빈도 확인: undata의 빈도표를 word_table에 할당
word_table <- table(undata)
word_table
#필터링: undata에서 두 글자 이상인 단어 선별 후 undata2에 할당
undata2 <- Filter(function(x) { nchar(x) >= 2 }, undata)
undata2
word_table2 <- table(undata2)
word_table2
#데이터 정렬: word_table2 내림차순 정렬
sort(word_table2, decreasing = T)

#wordcloud2 패키지 로드
library(wordcloud2)
#wordcloud 기본형
wordcloud2(word_table2)
#옵션: color(글자색), backgroudColor(배경색)
wordcloud2(word_table2, color = "random-light", backgroundColor = "black")
#옵션: fontFamily(글꼴), size(글자 크기), color(글자색), backgroudColor(배경색), shape(모양)
wordcloud2(word_table2, fontFamily = "궁서체", size = 1.2, color = "random-light", backgroundColor = "black", shape = "star")

#wordcloud 추가 실습(demoFreq 데이터 이용)
wordcloud2(demoFreq, size = 1.6, shape = "triangle-forward")
wordcloud2(demoFreq, color = "random-light", shape = "star")
#옵션: 선택한 색상만 반복
wordcloud2(demoFreq, size = 1.6, color = rep_len(c("yellow", "green"), nrow(demoFreq)), shape = "cardioid")
wordcloud2(demoFreq, size = 1.6, color = rep_len(c("pink", "purple"), nrow(demoFreq)), shape = "diamond")
#옵션: 일정한 방향으로 정렬
wordcloud2(demoFreq, minRotation = -pi / 6, maxRotation = -pi / 6, rotateRatio = 1)
#옵션: 원하는 이미지에 워드클라우드 표시
wordcloud2(demoFreq, figPath = "E:\\R\\dog.jpg")