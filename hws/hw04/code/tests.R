

#Tests for remove_missing()
vector1 <- c(1,2,NA,6,7)
vector1solution <- c(1,2,6,7)

vector2 <- c(1,2,4,NA)
vector2solution <- c(1,2,4)

vector3 <- c(1,3,4,5,6,7,8,3,4)
vector3solution <- c(1,3,4,5,6,7,8,3,4)

vector4 <- c(NA, NA, NA, NA, NA, NA, 1)
vector4solution <- 1

context("Tests for remove missing")

test_that("remove missing values - check with expect equal", {
  expect_equal(remove_missing(vector1), vector1solution)
  expect_equal(remove_missing(vector2), vector2solution)
  expect_equal(remove_missing(vector3), vector3solution)
  expect_equal(remove_missing(vector4), vector4solution)
})

test_that("remove missing values- check with expect length", {
  expect_length(remove_missing(vector1), 4)
})

#Tests for get_minimum()
vector5 <- c(2,3,4,34,5,6)
vector6 <- c(101,401,405,3)
vector7 <- c(0,0,0,0,0,0)
vector8 <- c(4,89,2,0,56)

context("Tests for get minimum")

test_that("get minimum values- check with expect equal", {
  expect_equal(get_minimum(vector5), 2)
  expect_equal(get_minimum(vector6), 3)
  expect_equal(get_minimum(vector7), 0)
  expect_identical(get_minimum(vector8), 0)
})

#Tests for get_maximum() 
vector9 <- c(100,3,4,5,6,2,2,3,4)
vector10 <- c(23,24,35,34,23,23,56)
vector11 <- c(NA,NA,NA,NA,NA)
vector12 <- c(1,3,4,NA,6,10)

context("Tests for get maximum")

test_that("get maximum values- check with expect identical",{
  expect_identical(get_maximum(vector9), 100)
  expect_identical(get_maximum(vector10), 56)
  expect_identical(get_maximum(vector11, na.rm=TRUE), NA)
  expect_identical(get_maximum(vector12, na.rm=TRUE), 10)
})

#Tests for get_range()
context("Tests for get range")

test_that("get range interval-check with expect equal",{
  expect_equal(get_range(vector9), 98)
  expect_equal(get_range(vector10),33)
  expect_equal(get_range(vector12, na.rm=TRUE), 9)
  expect_equal(get_range(vector8), 89)
})

#Tests for get_median()
med_vec1 <- c(1,2,3,4,5,6,7)
med_vec2 <- c(23,4,5,67,56,2,4,5,6,7,4,2,4,56)
med_vec3 <- c(3435,45424,5636,56356)
med_vec4 <- c(0,-3,4,56,-1,NA)

context("Tests for get median")

test_that("get median of vector - check with expect equal",{
  expect_equal(get_median(med_vec1), 4)
  expect_equal(get_median(med_vec2), 5)
  expect_equal(get_median(med_vec3), 25530)
  expect_equal(get_median(med_vec4), 0)
})


#Tests for get_average()
avg_vec1 <- c(3,4,5,6,45)
avg_vec2 <- c(0,0,0,0,0,0,NA)
avg_vec3 <- c(NA,NA)
avg_vec4 <- c(-2,3,4,5,4,-4)

context("Tests for get average")

test_that("calculates the average of a numeric vector - check with expect equal and expect null", {
  expect_equal(get_average(avg_vec1), 12.6)
  expect_equal(get_average(avg_vec2, na.rm=TRUE), 0)
  expect_null(get_average(avg_vec3, na.rm=TRUE))
  expect_equal(get_average(avg_vec4), (10/6))
})


#Tests for get_stdev()
st_vec1 <- c(1,2,3,4,0,5,4)
st_vec2 <- c(0,304,5,-1,2,3,NA)
st_vec3 <- c(23,4,5,67,3)
st_vec4 <- c(-4,5,6,90,3,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

context("Tests for get_stdev()")

test_that("gets standard deviation of a numeric vector- check with expect less than or equal to and greater than or equal to", {
  expect_lte(get_stdev(st_vec1), 1.799471)
  expect_gte(get_stdev(st_vec2, na.rm=TRUE), 123.3911)
  expect_gte(get_stdev(st_vec3), 27.32764)
  expect_gte(get_stdev(st_vec4), 18.33934)
})

#Tests for get_quartile1()
#using the same test vectors as the standard deviation function 

context("Tests for get_quartile1()")

test_that("gets the first quartile of a numeric vector - check with expect equal", {
  expect_equal(get_quartile1(st_vec1), 1.5 )
  expect_equal(get_quartile1(st_vec2, na.rm=TRUE), 0.5)
  expect_equal(get_quartile1(st_vec3), 4)
  expect_equal(get_quartile1(st_vec4), 0)
})

#Tests for get_quartile3()
#using the same test vectors as the standard deviation function 

context("Tests for get_quartile3()")

test_that("gets the third quartile of a numeric vector- check with expect equal and greater than or equal to", {
  expect_equal(get_quartile3(st_vec1), 4)
  expect_equal(get_quartile3(st_vec2, na.rm=TRUE),  4.5)
  expect_equal(get_quartile3(st_vec3), 23)
  expect_gte(get_quartile3(st_vec3), 1.25)
})


#Tests for count_missing()
na_vec1 <- c(1,2,3,4,5,6,5)
na_vec2 <- c(NA,NA,NA,NA,NA)
na_vec3 <- c(0,0,0,NA)
na_vec4 <- c(102,3,4,NA,NA,NA)

context("Tests for count_missing()")

test_that("counts the number of missing values in a numeric vector- check with expect equal", {
  expect_equal(count_missing(na_vec1), 0)
  expect_equal(count_missing(na_vec2), 5)
  expect_equal(count_missing(na_vec3), 1)
  expect_equal(count_missing(na_vec4), 3)
})
          

#Tests for summary_stats()
ss_vec1 <- c(1,2,3,4,5,6)
ss_vec2 <- c(10,39,28,384,NA)
ss_vec3 <- c(202,30,NA)
ss_vec4 <- c(394,203,454,23,1,2,3,4,2,1,4)

ss_vec1stats <- summary_stats(ss_vec1)
ss_vec2stats <- summary_stats(ss_vec2)
ss_vec3stats <- summary_stats(ss_vec3)
ss_vec4stats <- summary_stats(ss_vec4)

context("Tests for summary_stats()")

test_that("outputs correct summary stats for given numeric vector", {
  expect_equal(ss_vec1stats$minimum, 1)
  expect_equal(ss_vec1stats$percent10, 1.5)
  expect_equal(ss_vec1stats$quartile1, 2.25)
  expect_equal(ss_vec2stats$median, 33.5)
  expect_lte(ss_vec2stats$median, 115.25)
  expect_equal(ss_vec2stats$quartile3, 125.25)
  expect_equal(ss_vec3stats$minimum, 30)
  expect_equal(ss_vec3stats$percent10, 47.2)
  expect_equal(ss_vec4stats$maximum, 454)
  expect_equal(ss_vec4stats$range, 453)
}) 


#Tests for rescale100()
a <- 1
amax <- 30
amin <- 34

b <- 0
bmax <- 202
bmin <- 89

c <- 6 
cmax <- 34
cmin <- 45

d <- 23
dmax <- 23213
dmin <- 23



context("Tests for rescale100()")

test_that("rescale100() correctly computes a rescaled numeric vector", {
  expect_equal(rescale100(a, amax, amin), -725)
  expect_lte(rescale100(b, bmax, bmin), 178.7611)
  expect_gte(rescale100(c, cmax, cmin), -254.5455)
  expect_equal(rescale100(d, dmax, dmin), 100)
})


#Tests for drop_lowest()

ss_vec1 <- c(1,2,3,4,5,6)
ss_vec2 <- c(10,39,28,384)
ss_vec3 <- c(202,30)
ss_vec4 <- c(394,203,454,23,1,2,3,4,2,1,4)

context("Tests for drop_lowest()")

test_that("drop_lowest() correctly drops the lowest score", {
  expect_equal(drop_lowest(ss_vec1), c(2,3,4,5,6))
  expect_equal(drop_lowest(ss_vec2), c(39,28,384))
  expect_equal(drop_lowest(ss_vec3), c(202))
  expect_equal(drop_lowest(ss_vec4), c(394,203,454,23,1,2,3,4,2,4))
})


#Tests for score_homework()
#using the same vectors as drop_lowest()

context("Tests for score_homework()")

test_that("correctly computes the average of the given scores", {
  expect_equal(score_homework(ss_vec1, drop=TRUE), 4)
  expect_equal(score_homework(ss_vec2, drop=FALSE), 115.25)
  expect_equal(score_homework(ss_vec3, drop=TRUE), 202)
  expect_lte(score_homework(ss_vec4, drop=FALSE), 99.18182)
})

#Tests for score_quiz()
quiz1 <- c(90,23,89,76,54,100)
quiz2 <- c(12,45,76,100,56,87,54,32,45,67,98,76,54)
quiz3 <- c(90,100,80,70)
quiz4 <- c(78,89,98,100)

context("Tests for score_quiz()")

test_that("correctly computes averages of quiz scores", {
  expect_equal(score_quiz(quiz1, drop=TRUE), 81.8)
  expect_lte(score_quiz(quiz2, drop=FALSE), 61.69231)
  expect_equal(score_quiz(quiz3, drop=TRUE), 90)
  expect_lte(score_quiz(quiz4, drop=TRUE), 95.66667)
})

#Tests for score_lab()

context("Tests for score_lab()")

test_that("correctly computes the lab index", {
  expect_equal(score_lab(12), 100 )
  expect_equal(score_lab(10), 80)
  expect_equal(score_lab(6), 0)
  expect_equal(score_lab(3), 0)
})













          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          