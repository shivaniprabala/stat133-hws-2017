--------------
title:"clean-data-script.R"
author:"Shivani Prabala"
date: "11/26/2017"
--------------
#Loading readr package
library("readr")
library("dplyr")


#Linking source file of functions.R
source('functions.R')

dat <- read_csv('../data/rawdata/rawscores.csv') #reading the rawscores csv file
dat <- data.frame(dat) #making the csv file into a dataframe 


sink('../output/summary-rawscores.txt')
str(dat)

for (i in 1:length(dat)){
  print(summary_stats(dat[ , i]))
}

for (i in 1:length(dat)){
  print(print_stats(summary_stats(dat[ , i])))
}

sink()

#Replacing all the NA values in dat with 0
for (i in 1:length(dat)){ 
  for (j in 1:length(dat[ , 1])){
    if(is.na(dat[j,i])){
      dat[j,i] <- 0
    }else{
      
    }
  }
}

#Using rescale100() to rescale QZ1: 0 is the minimum and 12 is the max 
dat$QZ1 <- rescale100(dat$QZ1, 0, 12)

#Using rescale100 to rescale QZ2: 0 is the minimum and 18 is the max 
dat$QZ2 <- rescale100(dat$QZ2, 0, 18)

#Using rescale100 to rescale QZ3: 0 is the minimum and 20 is the max 
dat$QZ3 <- rescale100(dat$QZ3, 0, 20)

#Using rescale100 to rescale QZ4: 0 is the minimum and 20 is the max 
dat$QZ4 <- rescale100(dat$QZ4, 0, 20)

#Using rescale100() to add a variable Test1 by rescaling EX1: 0 is the minimum, and 80 is the max 
Test1 <- rescale100(dat$EX1, 0, 80)
dat <- mutate(dat, Test1)

#Using rescale100() to add a variable Test2 by rescaling EX2: 0 is the minimum, and 90 is the max 
Test2 <- rescale100(dat$EX2, 0, 90)
dat <- mutate(dat, Test2)

#Adding variable Homework to the data frame of scores
Homework <- rep(0, 334)
temp <- rep(0,9)
for (i in 1:length(dat[ , 1])){
  temp <- c(dat$HW1[i], dat$HW2[i], dat$HW3[i], dat$HW4[i], dat$HW5[i], dat$HW6[i], dat$HW7[i], dat$HW8[i], dat$HW9[i])
  Homework[i] <- score_homework(temp, drop = TRUE)
}

dat <- mutate(dat, Homework)

#Adding variable Quiz to data frame of scores 
Quiz <- rep(0, 334)
temp <- rep(0,4)
for (i in 1:length(dat[ , 1])){
  temp <- c(dat$QZ1[i], dat$QZ2[i], dat$QZ3[i], dat$QZ4[i])
  Quiz[i] <- score_quiz(temp, drop = TRUE)
}

dat <- mutate(dat, Quiz)

#Adding variable Lab to data frame of scores 
Lab <- c()
for (i in 1:length(dat[ , 1])){ 
  Lab <- c(Lab, score_lab(dat$ATT[i]))
}

dat <- mutate(dat, Lab)

#Adding a variable Overall to the data frame of scores 
Overall <- c()

for (i in 1: length(dat[ ,1])){
  Overall<- c(Overall, ((0.10*(dat$Lab[[i]]))+(0.30 * (dat$Homework[[i]])) + (0.15*(dat$Quiz[[i]])) + (0.20*(dat$Test1[[i]]))+ (0.25*(dat$Test2[[i]]))))
}

for (i in 1: length(Overall)){
  Overall[i] <- round(Overall[i], digits=1)
}

dat <- mutate(dat, Overall)


#Adding a variable Grade 

Grade <- c()
for (i in 1: length(dat[ , 1])){
  if (dat$Overall[i] >= 0 & dat$Overall[i] < 50){
    Grade <- c(Grade, 'F')
  }else if(dat$Overall[i] >= 50 & dat$Overall[i] < 60){
    Grade <- c(Grade, 'D')
  }else if(dat$Overall[i]>=60 & dat$Overall[i] < 70){
    Grade <- c(Grade, 'C-')
  }else if(dat$Overall[i]>=70 & dat$Overall[i]<77.5){
    Grade <- c(Grade, 'C')
  }else if(dat$Overall[i]>=77.5 & dat$Overall[i]<79.5){
    Grade <- c(Grade, 'C+')
  }else if(dat$Overall[i] >= 79.5 & dat$Overall[i]< 82){
    Grade <- c(Grade, 'B-')
  }else if(dat$Overall[i]>=82 & dat$Overall[i]<86){
    Grade <- c(Grade, 'B')
  }else if(dat$Overall[i]>=86 & dat$Overall[i]<88){
    Grade <- c(Grade, 'B+')
  }else if(dat$Overall[i]>=88 & dat$Overall[i]<90){
    Grade <- c(Grade, 'A-')
  }else if(dat$Overall[i]>=90 & dat$Overall[i]<95){
    Grade <- c(Grade, 'A')
  }else if(dat$Overall[i]>=95 & dat$Overall[i]<=100){
    Grade <- c(Grade, 'A+')
  }
}

dat <- mutate(dat, Grade)

#Sinking Lab stats 
sink('../output/Lab-stats.txt')
summary_stats(Lab)
print_stats(summary_stats(Lab))
sink()

#Sinking Homework stats 
Homework <- as.numeric(Homework)

sink('../output/Homework-stats.txt')
summary_stats(Homework)
print_stats(summary_stats(Homework))
sink()


#Sinking Quiz stats 
Quiz <- as.numeric(Quiz)

sink('../output/Quiz-stats.txt')
summary_stats(Quiz)
print_stats(summary_stats(Quiz))
sink()

#Sinking Test1 stats 
Test1 <- c()
for (i in 1:length(dat[ ,1])){
  Test1 <- c(Test1, dat$Test1[i])
}

sink('../output/Test1-stats.txt')
summary_stats(Test1)
print_stats(summary_stats(Test1))
sink()

#Sinking Test2 stats 
Test2 <- c()
for (i in 1:length(dat[ ,1])){
  Test2 <- c(Test2, dat$Test2[i])
}

sink('../output/Test2-stats.txt')
summary_stats(Test2)
print_stats(summary_stats(Test2))
sink()

#Sinking Overall stats 
Overall <- as.numeric(Overall)

sink('../output/Overall-stats.txt')
summary_stats(Overall)
print_stats(summary_stats(Overall))
sink()

#Sinking str() of the data frame of clean scores to summary-cleanscores.txt
sink('../output/summary-cleanscores.txt')
str(dat)
sink()

#Exporting the data 
for (i in 1:length(dat)){ 
  for (j in 1:length(dat[ , 1])){
    if(is.list(dat[j,i])){
      print(c(j,i))
    }else{
      
    }
  }
}
write_csv(dat, '../data/cleandata/cleanscores.csv')


