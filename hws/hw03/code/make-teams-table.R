-------
title: "Data Preparation" 
description: "A file used to store all of the data preparation code."
input(s):"nba2017-roster.csv, nba2017-stats.csv" 
outputs(s):"efficiency-summary.txt, teams, teams_star_plot.pdf, experience_salary.pdf"
-------
library(ggplot2)
library(dplyr)

dat_roster <- read.csv("../data/nba2017-roster.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)
dat_stats <- read.csv("../data/nba2017-stats.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)

dat_stats <- mutate(dat_stats, missed_fg= field_goals_atts - field_goals_made,missed_ft= points1_atts - points1_made, 
points= 3*points3_made + 2*points2_made+ points1_made, rebounds= off_rebounds + def_rebounds,
efficiency= (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers)/games_played)

sink(file= "../output/efficiency-summary.txt")
summary(dat_stats$efficiency)
sink()
  
dat_merge <- merge(dat_roster, dat_stats)
teams <- dat_merge %>%
        group_by(team) %>% 
        summarise(experience= sum(experience), salary=sum(salary/1000000), points3= sum(points3_made), points2= sum(points2_made), free_throws= sum(points1_made), points= sum(points1_made+ 2*points2_made+ 3*points3_made), off_rebounds= sum(off_rebounds), def_rebounds= sum(def_rebounds), assists= sum(assists), steals= sum(steals), blocks= sum(blocks), turnovers= sum(turnovers), fouls= sum(fouls), efficiency= sum(efficiency))
summary(teams)


sink(file= "../output/teams-summary.txt")
summary(teams)
sink()

write.csv(teams, "../data/nba2017-teams.csv")

pdf("../images/teams_star_plot.pdf")
stars(teams[ ,-1], labels=teams$team)
dev.off()

pdf("../images/experience_salary.pdf")
ggplot(teams, aes(x=experience, y=salary)) + geom_point()+geom_text(aes(label=teams$team)) + ggtitle(label="Scatterplot of Experience vs. Salary")
dev.off()





