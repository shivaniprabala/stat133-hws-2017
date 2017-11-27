-----------------
title: "Functions for Homework 4" 
description: "This script will contain code for a series of functions."
input(s):"vectors, values, etc." 
outputs(s):"designated output based on the function"
-----------------
library(stringr)

#Function remove_missing(): This function takes a vector in a prints the same vector with all NA values removed. 
remove_missing <- function (x) {
  b <- c()
  for (i in 1:length(x)) {
    if (is.na(x[i])) { 
      b <- c(b, -i)
    }else {
    } 
  }
  if (is.null(b)){
  return(x)
  }else{
  x <- x[b]
  return(x)
  }
}

#Example 1
vec <- c(0,0,0,0,NA)
remove_missing(vec)
#Example 2 
a <- c(1,4,7, NA, 10)
remove_missing(a)


#Function get_minimum(): This function takes a numeric vector and an optional logical na.rm argument, to find the minimum value. 
get_minimum <- function(x, na.rm=TRUE) {
  if (na.rm==TRUE){
    x <- remove_missing(x) }
  x <- sort(x, decreasing=FALSE)
  return (x[1])
}

#Example 1 
a <- c(1, 4, 7, NA, 10)
get_minimum(a, na.rm=TRUE)


#Function get_maximum(): This function takes a numeric vector and option logical na.rm argument, to find the maximum value 
get_maximum <- function(x, na.rm=TRUE) {
  if (na.rm==TRUE){
    x <- remove_missing(x) }
  x <- sort(x, decreasing=TRUE)
  return (x[1])
}

#Example 1
a <- c(1,4,7, NA, 10)
get_maximum(a, na.rm=TRUE)


#Function get_range(): This function takes a numeric vector and an option logical na.rm argument to compute the overall range of the input vector.
get_range <- function(x, na.rm=TRUE){
  if(na.rm==TRUE){
    x <- remove_missing(x)
  }
  
  fin_min <- get_minimum(x)
  fin_max <- get_maximum(x)
  fin_range <- fin_max - fin_min 
  
  return (fin_range)
}

#Example 1
a <- c(1,4,7, NA, 10)
get_range(a, na.rm=TRUE)



#Function get_median(): This function takes a numeric vector and an optional logical na.rm argument to compute the median. 
get_median <- function(x, na.rm=TRUE) {
  if (na.rm==TRUE){
    x <- remove_missing(x)
  }
  x <- sort(x, decreasing=FALSE)
  x_len <- length(x)
  if ((x_len %% 2) == 0){
    i <- (x_len / 2) 
    j <- i + 1 
    med <- ((x[i] + x[j]) / 2)
    return (med)
  } else {
    i <- length(x) / 2 
    i <- ceiling(i) 
    med <- x[i]
    return(med)
  }
}

#Example 1
a <- c(1,4,7, NA, 10)
get_median(a, na.rm=TRUE)



#Function get_average(): This function takes a numeric vector, and an optional logical na.rm argument to compute the average. 
get_average <- function(x, na.rm=TRUE) {
  if (na.rm==TRUE){
    x <- remove_missing(x)
  }
  if (length(x)==0){
    return(NULL)
  }
  sum <- 0 
  for (i in 1: length(x)) {
    sum <- sum + x[i]
  }
  sum <- (sum/length(x))
  return(sum)
}

#Example 1 
a <- c(1,4, 7, NA, 10)
get_average(a, na.rm = TRUE)




#Function get_stdev(): This function takes a numeric vector and an optional logical na.rm argument to compute the standard deviation. 
get_stdev <- function(x, na.rm=TRUE){
  if (na.rm==TRUE){
    x <- remove_missing(x)
  }
  sum <- 0 
  avg <- get_average(x)
  for (i in 1: length(x)){
    sum <- sum + (x[i] - avg)^2 
  }
  SD <- sum/ (length(x)-1)
  SD <- sqrt(SD)
  return (SD)
}

#Example 1 
a <- c(1, 4, 7, NA, 10)
get_stdev(a, na.rm=TRUE)




#Function get_quartile1(): This is a function that takes a numeric vector and an optional na.rm argument to compute the first quartile. 
get_quartile1 <- function(x, na.rm=TRUE){
  if (na.rm==TRUE){
    x <- remove_missing(x)
  }
  quantile <- quantile(x, 0.25)
  quantile <- quantile[[1]]
  return (quantile)
}

#Example 1 
a <- c(1, 4, 7, NA, 10)
get_quartile1(a, na.rm = TRUE)



#Function get_quartile3():
get_quartile3 <- function(x, na.rm=TRUE){
 if(na.rm==TRUE){ 
   x <- remove_missing(x)
 }
  quantile <- quantile(x, 0.75)
  quantile <- quantile[[1]]
  return(quantile)
}
  
#Example 1 
a <- c(1, 4, 7, NA, 10)
get_quartile3(a, na.rm= TRUE)


#Function count_missing(): This is a function that takes a numeric vector and calculates the number of missing values. 
count_missing <- function (x){
  if (length(x)==0){
    return (0)
  }
  sum <- 0 
  for ( i in 1: length(x)){
    if (is.na(x[i])){ 
      sum <- sum + 1 
    }else{
       
     }
  }
  return (sum)
}


#Example 1 
a <- c(1, 4, 7, NA, 10)
count_missing(a)

#Function summary_stats(): This is function that takes a numeric vector and returns a list of summary statistics.

summary_stats <- function(x){
  minimum <- get_minimum(x, na.rm=TRUE)
  percent10 <- unname(quantile(x, 0.10, na.rm=TRUE))
  quartile1 <- get_quartile1(x, na.rm=TRUE)
  median <- get_median(x, na.rm=TRUE)
  mean <- get_average(x, na.rm=TRUE)
  quartile3 <- get_quartile3(x, na.rm=TRUE)
  percent90 <- unname(quantile(x, 0.90, na.rm=TRUE))
  maximum <- get_maximum(x, na.rm=TRUE)
  range <- get_range(x, na.rm=TRUE)
  stdev <- get_stdev(x, na.rm=TRUE)
  missing <- count_missing(x)
  return(list(minimum=minimum, percent10=percent10, quartile1=quartile1, median=median, mean=mean, quartile3=quartile3, percent90=percent90, maximum=maximum, range=range, stdev=stdev, missing=missing))
  }

#Example 1 
a <- c(1,4, 7, NA, 10)
stats <- summary_stats(a)
stats



#Function print_stats(): This is function that takes a list of summary statistics, and prints the values in a nice format. 

print_stats <- function(x){
  for (i in 1:length(x)){
    if (nchar(names(x)[i]) == 5) {
      cat(" ",'\n', names(x)[i], str_pad(':', 5, "left"),format(as.numeric(stats[[i]]), nsmall=4))
    } else if(nchar(names(x)[i]) ==6) { 
      cat(" ",'\n', names(x)[i], str_pad(':', 4, "left"),format(as.numeric(stats[[i]]), nsmall=4))
    } else if(nchar(names(x)[i]) ==7) {
      cat(" ",'\n', names(x)[i], str_pad(':', 3, "left"),format(as.numeric(stats[[i]]), nsmall=4))
    } else if(nchar(names(x)[i]) ==8) {
      cat(" ",'\n', names(x)[i], ':',format(as.numeric(stats[[i]]), nsmall=4))
    } else if(nchar(names(x)[i]) ==9) {
      cat(" ",'\n', names(x)[i], ':',format(as.numeric(stats[[i]]), nsmall=4))
    }
  }
}
    

#Example 1 
print_stats(stats)

#Function rescale100(): This function takes three arguments and computes a rescaled vector with potential scale from 0 to 100.
rescale100 <- function(x, xmin, xmax){
  z <- 100 * ((x-xmin)/(xmax-xmin))
  return(z)
}

#Example of rescale100()
b <- c(18, 15, 16, 4, 17, 9)
rescale100(b, xmin=0, xmax=20)



#Function drop_lowest(): This function takes a numeric vector of length n and returns a vector of n-1 length by dropping the lowest value.

drop_lowest <- function(x){
  lowest <- 1 
  for (i in 1:length(x)){
    if (x[i]<= x[lowest]){
      lowest <- i
    }else{
    }
  }
  return(x[-lowest])
}

#Example of drop_lowest()
b <- c(10, 10, 8.5, 4, 7, 9)
drop_lowest(b)



#Function score_homework() is a function that takes a numeric vector of homework scores and an optional logical argument drop to compute a single homework value. 

score_homework <- function(x, drop=TRUE){
  if (drop==TRUE){
    x <- drop_lowest(x)
    return(get_average(x))
  } else{
    return(get_average(x))
  } 
}

#Example of score_homework()
hws <- c(100, 80, 30, 70, 75, 85)
score_homework(hws, drop=TRUE)

score_homework(hws, drop=FALSE)



#Function score_quiz() is a function that takes a numeric vector and computes a single quiz value. 

score_quiz <- function(x, drop=TRUE){
  if (drop==TRUE){
    x <- drop_lowest(x)
    return(get_average(x))
    }else{
    return(get_average(x))
  }
}

#Example of score_quiz()
quizzes <- c(100, 80, 70, 0)
score_quiz(quizzes, drop=TRUE)

score_quiz(quizzes, drop=FALSE)



#Function score_lab() is a function that takes a numeric value of lab attendance, and returns the lab score. 

score_lab<- function(x){
    if (x <= 6){
      return (0)
    }else if (7 >= x | x<= 11) {
      return ((x-6) * 20) 
    }else {
      return (100)
  }
}

#Example of score_lab()
score_lab(12)
score_lab(10)
score_lab(6)





