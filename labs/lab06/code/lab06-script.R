# =========================================================================
# Title: Lab 06 - Working With Dplyer More and Learning Ggplot 
# Description: This script will be my attempt to familiarize myself with the functions of dplyer and ggplot. 
# Input (s): 
# Output (s): 
# Author: 
# Date: 10-06-2017
# =========================================================================

#packages 
library(readr) # importing data 
library(dplyr) # data wrangling 
library(ggplot2) # graphics

dat <- data.frame( read_csv("Desktop/stat133/stat133-fall-2017/labs/lab06/data/nba2017-players.csv") ) 
warriors <- data.frame(filter(dat, team=='GSW'))
write.csv(warriors, file="Desktop/stat133/stat133-fall-2017/labs/lab06/data/warriors.csv", row.names=FALSE)
lak1 <- filter(dat, team=='LAL')
lakers <- arrange(lak1, desc(experience))
write_csv(lakers, path="Desktop/stat133/stat133-fall-2017/labs/lab06/data/lakers.csv")

sink(file='Desktop/stat133/stat133-fall-2017/labs/lab06/output/data-structure.txt')
str(dat)
sink()

sink(file='Desktop/stat133/stat133-fall-2017/labs/lab06/output/summary-warriors.txt')
summary(warriors)
sink()

sink(file='Desktop/stat133/stat133-fall-2017/labs/lab06/output/summary-lakers.txt')
summary(lakers)
sink()

png(filename = "Desktop/stat133/stat133-fall-2017/labs/lab06/images/scatterplot-height-weight.png")
plot(dat$height, dat$weight, pch=20, xlab = 'Height', ylab = 'Weight')
dev.off()

png(filename = "Desktop/stat133/stat133-fall-2017/labs/lab06/images/scatterplot-height-weight2.png", width = 768, height = 768, res =100)
plot(dat$height, dat$weight, pch=20, xlab = 'Height', ylab = 'Weight')
dev.off()

jpeg(filename= "Desktop/stat133/stat133-fall-2017/labs/lab06/images/histogram-age.jpeg", width=600, height = 400)
hist(dat$age, xlab="Number of People", ylab="Age", main='Histogram of Age in the NBA')
dev.off()

pdf(file="Desktop/stat133/stat133-fall-2017/labs/lab06/images/histogram-age1.pdf", width = 7, height = 5)
hist(dat$age, xlab="Number of People", ylab="Age", main='Histogram of Age in the NBA')
dev.off() 

df1 <- data.frame(dat$points, dat$salary)
gg_pts_salary <- ggplot(df1, aes(x=dat.points, y=dat.salary)) + geom_point(size=2, shape=16)
ggsave(filename="Desktop/stat133/stat133-fall-2017/labs/lab06/images/points_salary.pdf", gg_pts_salary, width = 7, height = 5)

df2<- data.frame(dat$height, dat$weight, dat$position)
names(df2) <- c("height", "weight", "position")
gg_ht_wt_position <- ggplot(df2, aes(x=df2$height, y=df2$weight)) + geom_point(size=2, shape=16)  + labs(x="Height", y="Weight") + facet_grid(df2$position ~ .)
ggsave(filename="Desktop/stat133/stat133-fall-2017/labs/lab06/images/height_weight_by_position.pdf", gg_ht_wt_position, width = 6, height = 4)

#display the nams of Lakers 'LAL'
dat %>%
  filter(team=='LAL') %>%
  select(player)

#display the name and salary of GSW point guard 'PG' 
dat%>%
  filter(team=='GSW') %>%
  select(player, salary)

#dislay the name, age, and team, of players with more than 10 years of experience, making 10 million dollars or less
dat %>% 
  filter(experience>10) %>%
  filter(salary<= 10000000) %>%
  select(player, age, team)

#select the name, team, height, and weight, of rookie players, 20 years old, displaying only the first five occurrences (i.e. rows)
dat %>%
  filter(experience==0) %>%
  filter(age ==20) %>%
  select(player, team, height, weight) %>%
  slice(1:5)

#create a data frame gsw_mpg of GSW players, that contains variables for player name, experience, and min_per_game (minutes per game), sorted by min_per_game (in descending order)
gsw_mpg <-(dat %>% 
            mutate(min_per_game = minutes/games) %>% 
            select(player, experience, min_per_game) %>%
            arrange(desc(min_per_game)))
view(gsw_mpg)

#display the average triple points by team, in ascending order, of the bottom-5 teams (worst 3pointer teams)
dat %>% 
  group_by(team) %>%
  summarise(avg_points3= mean(points3)) %>%
  arrange(avg_points3) %>%
  slice (1:5)

#obtain the mean and standard deviation of age, for Power Forwards, with 5 and 10 years (including) years of experience
dat %>%
  filter(position=='PF') %>%
  filter(experience>=5 & experience <=10) %>%
  summarise(avg_age= mean(age), std_age= sd(age))
  

 
            
  

                       



