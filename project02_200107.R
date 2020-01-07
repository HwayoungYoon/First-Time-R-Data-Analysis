#readxl 패키지 설치 및 로드
install.packages("readxl")
library(readxl)
#dplyr 패키지 설치 및 로드
install.packages("dplyr")
library(dplyr)

  #1. 원시 데이터 가져오기
#dustdata.xlsx 파일을 dustdata에 할당
dustdata <- read_excel("E:/R/dustdata.xlsx")
#dustdata 확인
View(dustdata)
#dustdata 속성 확인
str(dustdata)

  #2. 비교할 지역 데이터만 추출하기
#성북구와 중구 데이터만 추출 및 확인
dustdata_anal <- dustdata %>% filter(area %in% c("성북구", "중구"))
View(dustdata_anal)

  #3. 데이터 현황 파악하기
#dustdata_anal의 yyyymmdd에 따른 데이터 수 파악
count(dustdata_anal, yyyymmdd) %>% arrange(desc(n))
#dustdata_anal의 area에 따른 데이터 수 파악
count(dustdata_anal, area) %>% arrange(desc(n))

#area값이 성북구인 데이터를 dust_anal_area_sb에 할당
dust_anal_area_sb <- subset(dustdata_anal, area == "성북구")
#area값이 중구인 데이터를 dust_anal_area_jg에 할당
dust_anal_area_jg <- subset(dustdata_anal, area == "중구")
#데이터 확인
dust_anal_area_sb
dust_anal_area_jg

#psych 패키지 설치 및 로드
install.packages("psych")
library(psych)

#성북구의 미세먼지량에 대한 기초 통계량 도출
describe(dust_anal_area_sb$finedust)
#중구의 미세먼지량에 대한 기초 통계량 도출
describe(dust_anal_area_jg$finedust)

  #4. 분포 확인 및 가설 검정
#성북구와 중구의 미세먼지 농도에 대해 boxplot을 통해 분포 차이 확인
boxplot(dust_anal_area_sb$finedust, dust_anal_area_jg$finedust,
        main = "finedust_compare", xlab = "AREA", ylab = "FINEDUST_PM",
        names = c("성북구", "중구"), col = c("blue", "green"))
#dustdata_anal에서 측정소명(area)에 따라 미세먼지 농도 평균에 대한 차이에 대한 검증
t.test(data = dustdata_anal, finedust ~ area, var.equal = T)
  # 귀무가설: 2018년 9월 1일부터 2018년 12월 31일 사이일 때 성북구와 중구의 미세먼지 평균은 차이가 나지 않는다.
  # p-value=0.3671 > 0.05 이므로 귀무가설을 기각할 수 없다.
  # 따라서 유의수준 0.05하에서 2018년 9월 1일부터 2018년 12월 31일 사이일 때 
  # 성북구와 중구의 미세먼지 평균은 차이가 나지 않는다고 할 수 있다.