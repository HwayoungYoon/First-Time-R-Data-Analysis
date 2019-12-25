#mtcars의 행 개수 확인
nrow(mtcars)
#mtcars 데이터의 속성 확인
str(mtcars)

#dplyr 패키지 설치 및 로드
install.packages("dplyr")
library(dplyr)

#데이터 추출: filter(데이터, 조건절)
#mtcars에서 cyl 값이 4인 행 추출
filter(mtcars, cyl == 4)
#mtcars에서 cyl 값이 6 이상이고, mpg 값이 20 초과인 행 추출
filter(mtcars, cyl >= 6 & mpg > 20)

#오름차순 정렬: arrange(데이터 셋, 열1, 열2, ...)
#(head()로 상위 데이터만 출력)
#mtcars에서 wt를 기준으로 오름차순 정렬
head(arrange(mtcars, wt))
#이중 정렬: mtcars에서 mpg를 기준으로 오름차순 정렬 후 wt를 기준으로 내림차순 정렬
head(arrange(mtcars, mpg, desc(wt)))

#변수 선택: select(데이터 셋, 추출 열)
#mtcars에서 am, gear 열 추출
head(select(mtcars, am, gear))

#열 추가: mutate(데이터 셋, 열 = 조건)
#mtcars에 years 열 추가, 데이터 값은 1974
head(mutate(mtcars, years = "1974"))
#mtcars에 mpg_rank 열 추가, 데이터 값은 mpg 열의 순위(rank() 이용)
head(mutate(mtcars, mpg_rank = rank(mpg)))

#중복 값 제거: distinct(데이터 셋, 열)
#mtcars의 cyl 열에서 중복 값 제거
distinct(mtcars, cyl)
#mtcars의 gear 열에서 중복 값 제거
distinct(mtcars, gear)
#mtcars의 cyl, gear 열에서 중복 값 제거
distinct(mtcars, cyl, gear)

#데이터 요약: summarise(데이터 셋, 요약 결과 저장 = 통계 함수)
#summarize()=summarise()
#mtcars의 cyl 열의 평균, 최솟값, 최댓값 반환(반환할 열 지정)
summarise(mtcars, cyl_mean = mean(cyl), cyl_min = min(cyl), cyl_max = max(cyl))
summarize(mtcars, cyl_mean = mean(cyl), cyl_min = min(cyl), cyl_max = max(cyl))
#mtcars의 cyl 열의 평균, 최솟값, 최댓값 반환
summarise(mtcars, mean(cyl), min(cyl), max(cyl))

#그룹별 요약: group_by(데이터 셋, 묶을 열)
#mtcars의 cyl 열 별로 묶은 뒤 gr_cyl로 반환
gr_cyl <- group_by(mtcars, cyl)
#n() : 개수 구할 때 사용
#gr_cyl에서 cyl별 개수 요약
summarise(gr_cyl, n())
#n_distinct() : 중복 값을 제외한 개수 구할 때 사용
#gr_cyl에서 중복 값을 제외하고 cyl별 개수 요약
summarise(gr_cyl, n_distinct(gear))

#샘플 추출: sample_n(데이터 셋, 추출할 샘플 개수)
#mtcars에서 샘플 데이터 10개 추출
sample_n(mtcars, 10)
#샘플 추출: sample_frac(데이터 셋, 추출할 샘플 비율)
#mtcars에서 20%를 샘플 데이터로 추출
sample_frac(mtcars, 0.2)

#함수 연결 연산자: %>%
#mtcars에서 cyl 그룹별로 묶은 후 개수로 요약
group_by(mtcars, cyl) %>% summarise(n())
#mtcars에서 mpg의 순위를 mpg_rank 열에 추가한 뒤 mp_rank에 반환, mp_rank에서 mpg_rank를 기준으로 정렬
mp_rank <- mutate(mtcars, mpg_rank = rank(mpg))
arrange(mp_rank, mpg_rank)
#mtcars에서 mpg의 순위를 mpg_rank 열에 추가한 뒤 mpg_rank를 기준으로 정렬
mutate(mtcars, mpg_rank = rank(mpg)) %>% arrange(mpg_rank)