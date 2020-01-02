#readxl 패키지 설치 및 로드
install.packages("readxl")
library("readxl")


  #1. 소재지 전체 주소 가공하기
#서울시 서대문구 치킨집 데이터를 ck에 할당
ck <- read_excel("E:/R/치킨집_가공_서울시_서대문구.xlsx")
#ck 데이터 확인
head(ck)

#소재지 전체 주소 열에서 11번째 글자부터 16번째 글자 앞까지 추출하여 addr에 할당
addr <- substr(ck$소재지전체주소, 11, 16)
#addr 데이터 확인
head(addr)

#3글자인 동의 숫자를 제거하여 addr_num에 할당
addr_num <- gsub("[0-9]", "", addr)
#addr_num 데이터의 공백을 제거하여 addr_trim에 할당
addr_trim <- gsub(" ", "", addr_num)
#addr_trim 데이터 확인
head(addr_trim)


  #2. 동별 업소 개수 확인하기
#dplyr 패키지 설치 및 로드
install.packages("dplyr")
library(dplyr)

#addr_trim 데이터의 도수분포표 작성 후 데이터프레임으로 변환하여 addr_count에 할당
addr_count <- addr_trim %>% table() %>% data.frame()
head(addr_count)


  #3.트리맵으로 표현하기
#treemap 패키지 설치 및 로드
install.packages("treemap")
library(treemap)

#동이름 열(.)과 치킨집 개수 열(Freq)로 트리 맵 표현
treemap(addr_count, index = ".", vSize = "Freq", title = "서대문구 동별 치킨집 분포")

#내림차순으로 실제 데이터 확인
arrange(addr_count, desc(Freq)) %>% head()



################################
#인천시 부평구에서 치킨집이 가장 많은 지역 찾기

  #1. 소재지 전체 주소 가공하기
#인천시 부평구 치킨집 데이터를 ick에 할당
ick <- read_excel("E:/R/치킨집_가공_인천시_부평구.xlsx")
#ick 데이터 확인
head(ick)

#소재지 전체 주소 열에서 10번째 글자부터 15번째 글자 앞까지 추출하여 iaddr에 할당
iaddr <- substr(ick$소재지전체주소, 10, 15)
#iaddr 데이터 확인
head(iaddr)

#숫자를 제거하여 iaddr_num에 할당
iaddr_num <- gsub("[0-9]", "", iaddr)
#iaddr_num 데이터의 공백을 제거하여 iaddr_trim에 할당
iaddr_trim <- gsub(" ", "", iaddr_num)
#iaddr_trim 데이터 확인
head(iaddr_trim)


  #2. 동별 업소 개수 확인하기
#iaddr_trim 데이터의 도수분포표 작성 후 데이터프레임으로 변환하여 iaddr_count에 할당
iaddr_count <- iaddr_trim %>% table() %>% data.frame()
head(iaddr_count)


  #3.트리맵으로 표현하기
#동이름 열(.)과 치킨집 개수 열(Freq)로 트리 맵 표현
treemap(iaddr_count, index = ".", vSize = "Freq", title = "부평구 동별 치킨집 분포")

#내림차순으로 실제 데이터 확인
arrange(iaddr_count, desc(Freq)) %>% head()