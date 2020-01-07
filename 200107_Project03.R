  #Twitter API Key
#https://imasoftwareengineer.tistory.com/96
#API key                Ky0stCCfZeEe3qZr5rGOgIAtX
#API secret key         GUiOAHmM3RZA4U6MS3OsRoOGRpLIMW1CWPJsWo0b5t268vN5Ow
#Access token           1214457143404810240-qbyzfvGNHtZ5gvWRV6LUSzL5RKUFlt
#Access token secret    7CpSIrc9j8l5g2oYgLVLXtsGlqKA4seJeEbajz8slNU9T


  #1. twitteR 패키지 설치 및 OAuth 인증하기
#twitteR 패키지 설치 및 로드
install.packages("twitteR")
library(twitteR)

#4개의 API 키를 각 변수에 할당
consumerKey = "Ky0stCCfZeEe3qZr5rGOgIAtX"
consumerSecret = "GUiOAHmM3RZA4U6MS3OsRoOGRpLIMW1CWPJsWo0b5t268vN5Ow"
accessToken = "1214457143404810240-qbyzfvGNHtZ5gvWRV6LUSzL5RKUFlt"
accessTokenSecret = "7CpSIrc9j8l5g2oYgLVLXtsGlqKA4seJeEbajz8slNU9T"

#각 변수에 저장한 키 값으로 OAuth 인증
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)


  #2. 키워드 검색 및 결과 값 가져오기
#한국어 검색을 위해 데이터 형을 utf8로 변환 후 keyword에 할당
keyword <- enc2utf8("월드컵")
#keyword에 있는 키워드로 결과 값을 100개 검색하여 bigdata에 할당
bigdata <- searchTwitter(keyword, n = 100, lang = "ko")

#크롤링 데이터를 데이터 프레임으로 변환하고 bigdata_df에 할당
bigdata_df <- twListToDF(bigdata)

#bigdata_df 데이터셋의 구조 확인
str(bigdata_df)

#text 열 추출 후 bigdata_text에 할당
bigdata_text <- bigdata_df$text
#bigdata_text 데이터 확인
head(bigdata_text)


  #3. 텍스트에서 명사만 추출하기
#KoNLP 패키지 설치 및 로드
install.packages("KoNLP")
library(KoNLP)
#세종 사전 설정
useSejongDic()

#bigdata_text에서 명사 추출해 bigdata_noun에 할당
bigdata_noun <- sapply(bigdata_text, extractNoun, USE.NAMES = F)
#bigdata_noun을 벡터로 변환
bigdata_noun <- unlist(bigdata_noun)

#2글자 이상인 단어만 추출하여 저장
bigdata_noun <- Filter(function(x) { nchar(x) >= 2 }, bigdata_noun)
#영어, 숫자 제거하여 저장
bigdata_noun <- gsub("[A-Za-z0-9]", "", bigdata_noun)
#특수문자 제거하여 저장
bigdata_noun <- gsub("[~!@#$%^&*()-_|=+?:]", "", bigdata_noun)
#ㄱ부터 ㅎ까지 자음 제거하여 저장
bigdata_noun <- gsub("[ㄱ-ㅎ]", "", bigdata_noun)
#한 개 이상의 ㅜ와 ㅠ 제거하여 저장
bigdata_noun <- gsub("(ㅜ|ㅠ)+", "", bigdata_noun)

#데이터셋 형태로 저장
word_table <- table(bigdata_noun)


  #4. 워드클라우드로 표현하기
#wordcloud2 패키지 설치 및 로드
install.packages("wordcloud2")
library(wordcloud2)

#워드클라우드로 표현
wordcloud2(word_table, size = 3)
