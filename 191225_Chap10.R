#ggplot2 패키지 설치 및 로드
install.packages("ggplot2")
library(ggplot2)

#airquality 속성 확인
str(airquality)

#그래프 기본 틀 생성: ggplot(데이터셋, aes(데이터 속성))
#airquality에서 x축=Day열, y축=Temp열로 맵핑
ggplot(airquality, aes(x = Day, y = Temp))

#산점도: geom_point()
#airquality에서 x축=Day열, y축=Temp열로 맵핑한 산점도
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point()
#옵션: size(크기), color(색)
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point(size = 3, color = "red")

#꺾은선그래프: geom_line()
#airquality에서 x축=Day열, y축=Temp열로 맵핑한 꺾은선그래프
ggplot(airquality, aes(x = Day, y = Temp)) + geom_line()

#airquality에서 x축=Day열, y축=Temp열로 맵핑한 꺾은선 그래프와 산점도
ggplot(airquality, aes(x = Day, y = Temp)) + geom_line() + geom_point()
#옵션: color(색), size(크기)
ggplot(airquality, aes(x = Day, y = Temp)) + geom_line(color = "blue") + geom_point(size = 2)

#막대그래프: geom_bar()
#mtcars에서 cyl 종류별 빈도 막대그래프
ggplot(mtcars, aes(x = cyl)) + geom_bar()
#옵션: width(막대 두께)
ggplot(mtcars, aes(x = cyl)) + geom_bar(width = 0.5)
#빈 범주를 제외하고 cyl 종류별 빈도 막대그래프
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(width = 0.5)

#누적 막대그래프: geom_bar(aes(fill = 누적할 열 지정))
#빈 범주를 제외하고 cyl 종류별 gear 빈도 누적 막대그래프
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear)))
#선버스트 차트: coord_polar()
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear))) + coord_polar()
#원그래프: coord_polar(theta = "y")
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear))) + coord_polar(theta = "y")

#상자그림: geom_boxplot()
#그룹지을 열 설정해야 함(group = )
#Day열을 그룹지은 날짜별 온도 상자 그림
ggplot(airquality, aes(x = Day, y = Temp, group = Day)) + geom_boxplot()
#히스토그램: geom_histogram()
#Temp의 히스토그램
ggplot(airquality, aes(Temp)) + geom_histogram()
#옵션: binwidth(막대 폭의 비율)
ggplot(airquality, aes(Temp)) + geom_histogram(binwidth = 0.3)

#economics 데이터의 속성 확인
str(economics)

#꺾은선 그래프 위의 사선: geom_abline(intercept = y 절편,slope = 기울기)
#economics에서 x축=date열, y축=psavert열로 맵핑한 꺾은선그래프와 절편 12.18671, 기울기 -0.0005444의 사선
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_abline(intercept = 12.18671, slope = -0.0005444)

#꺾은선 그래프 위의 평행선: geom_hline(yintercept = y 절편)
#economics에서 x축=date열, y축=psavert열로 맵핑한 꺾은선그래프와 psavert의 평균 값인 평행선
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_hline(yintercept = mean(economics$psavert))

#dplyr 패키지 로드
library(dplyr)

#psavert(개인 저축률)가 최솟값일 때 date(날짜)를 x_inter에 할당
x_inter <- filter(economics, psavert == min(economics$psavert))$date
#꺾은선 그래프 위의 수직선: geom_vline(xintercept = x 절편)
#economics에서 x축=date열, y축=psavert열로 맵핑한 꺾은선그래프와 x_inter 값의 수직선
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_vline(xintercept = x_inter)

#텍스트 입력: geom_text(aes(label = 라벨명, vjust = 세로 위치, hjust = 가로 위치))
#airquality에서 x축=Day열, y축=Temp열로 맵핑한 산점도와 각 점에 Temp 값 라벨
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point() + geom_text(aes(label = Temp, vjust = 0, hjust = 0))

#특정 영역 강조: annotate("모양", xmin = x축 시작, xmax = x축 끝, ymin = y축 시작, ymax = y축 끝)
#mtcars에서 x축=wt열, y축=mpg열로 맵핑한 산점도와 x축 3~4, y축 12~21 위치의 사각형
#옵션: aplha(투명도), fill(색)
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + 
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, alpha = 0.5, fill = "skyblue")
#위와 동일, x축 2.5~3.7, y축 10~17 위치의 화살표
#옵션: color(색)
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + 
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, alpha = 0.5, fill = "skyblue") +
  annotate("segment", x = 2.5, xend = 3.7, y = 10, yend = 17, color = "red", arrow = arrow())
#위와 동일, annotate를 이용하여 라벨(point) 표현
#옵션: text(라벨 표시), label(라벨명)
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + 
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, alpha = 0.5, fill = "skyblue") +
  annotate("segment", x = 2.5, xend = 3.7, y = 10, yend = 17, color = "red", arrow = arrow()) +
  annotate("text", x = 2.5, y = 10, label = "point")

#제목 및 축제목: labs(x = "x축 제목", y = "y축제목", title = "그래프 제목")
#mtcars에서 gear 종류별 빈도 막대그래프
#제목: 변속기 기어별 자동차수, x축 제목: 기어수, y축 제목: 자동차수
ggplot(mtcars, aes(x = gear)) + geom_bar() +
  labs(x = "기어수", y = "자동차수", title = "변속기 기어별 자동차수")
#옵션: theme(테마 적용)
#theme_gray(): 회색 바탕과 흰 선
#theme_bw(): 흰 바탕과 회색 선
#theme_linedraw(): 흰 바탕과 가늘고 검은 선
#theme_light(): 밝은 회색 바탕
#theme_dark(): 어두운 바탕
#theme_minimal(): 단순한 배경
#theme_classic(): 눈금과 안내선이 없는 기본 바탕
#theme_void(): 가장 간결한 바탕
ggplot(mtcars, aes(x = gear)) + geom_bar() +
  labs(x = "기어수", y = "자동차수", title = "변속기 기어별 자동차수") +
  theme_linedraw()

#googleVis 패키지 설치 및 로드
install.packages("googleVis")
library(googleVis)

#ggplot2 패키지 로드
library(ggplot2)
#움직이는 차트: gvisMotionChart(데이터셋, idvar = "기준 데이터", timevar = "날짜 데이터")
#date(날짜)별 psavert(개인 저축률의 변화)의 값을 motion에 할당
motion <- gvisMotionChart(economics, idvar = "psavert", timevar = "date")
#motion의 값으로 그린 그래프
plot(motion)

#게이지 차트(계기판형 그래프): gvisGauge(데이터셋, labelvar = "측정 데이터", numvar = "값", options = list(그래프 옵션))
#City(도시명)를 측정 데이터, Popularity(인구수)를 값, 0~1000의 눈금을 옵션 지정해 gauge에 할당
gauge <- gvisGauge(CityPopularity, labelvar = "City", numvar = "Popularity", options = list(min = 0, max = 1000))
#gauge의 값으로 그린 그래프
plot(gauge)

#ggmap 패키지 설치 및 로드
install.packages("ggmap")
library(ggmap)

#https://mrkevinna.github.io/R-%EC%8B%9C%EA%B0%81%ED%99%94-3/
#api 호출 과정 참고
#api 호출 위한 설정
devtools::install_github('dkahle/ggmap')
#api키 등록
register_google(key = 'AIzaSyDMOmdAUjWy0IUi5kf8c_t0XVmzkApPqHg')

#구글 지도 호출: get_googlemap("위치정보", maptype = "지도 형태")
#seoul의 위치 정보를 가져온 후 gg_seoul1, gg_seoul2, gg_seoul3, gg_seoul4에 할당
#gg_seoul1, gg_seoul2, gg_seoul3, gg_seoul4에 따른 구글 지도 호출
#옵션: maptype = "terrain", "satellite", "roadmap", "hybrid"
gg_seoul1 <- get_googlemap("seoul", maptype = "terrain")
ggmap(gg_seoul1)
gg_seoul2 <- get_googlemap("seoul", maptype = "satellite")
ggmap(gg_seoul2)
gg_seoul3 <- get_googlemap("seoul", maptype = "roadmap")
ggmap(gg_seoul3)
gg_seoul4 <- get_googlemap("seoul", maptype = "hybrid")
ggmap(gg_seoul4)

#dplyr, ggplot2 패키지 로드
library(dplyr)
library(ggplot2)

#한글 검색 위해 utf8로 변환 후 위도와 경도 데이터를 geo_code에 할당
geo_code <- enc2utf8("대전역") %>% geocode()
#geo_code 리스트를 숫자로 변환하여 geo_data에 할당
geo_data <- as.numeric(geo_code)
#대전역의 위치 정보 가져온 후 구글 지도 호출 후 geo_code의 lon(경도)과 lat(위도) 값으로 그린 산점도
get_googlemap(center = geo_data, maptype = "roadmap", zoom = 13) %>% ggmap() +
  geom_point(data = geo_code, aes(x = geo_code$lon, y = geo_code$lat))
