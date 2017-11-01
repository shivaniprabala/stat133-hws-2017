<span style="color:burlywood">Post 1- Statistics 133 (Fall 2017)</span>
================
Shivani Prabala
10/31/2017

**<span style="color:burlywood">More Plotting Functions in R: Dygraph and HighCharter</span>**
==============================================================================================

### **<span style="color:burlywood">Introduction:</span>**

###### This post will explore the intersection of plotting and data frames and how to create different kinds of plots depending on the type of data we are looking at. In class so far we have learned about several graphing functions including plot, ggplot, barplot, hist, etc. The goal of this post is to reiterate the usefulness of those functions we have already learned about and then to explore two new graphing functions in R which include **dygraph** and **highchart**. These functions have many different features which are useful in visually representing other forms of data. My hope is that the information in this post can equip my fellow students with more tools to represent data in different ways.

### **<span style="color:burlywood">Motivation:</span>**

###### The motivation behind this post comes from a desire to learn new plotting functions in R. The importance of representing data visually in other data science classes and technical positions gives this topic its relevance. I want to learn more ways in which I can present my findings not only in this class, but also in any professional role I may have as well as to share this knowledge with my classmates in Statistics 133.

### **<span style="color:burlywood">Background:</span>**

###### We have learned quite a bit about data frames in class so far including how to manipulate, access, and create tables of data. We have even looked at visual representations of various forms of data. As part of the Statistics 133 cirriculum we have already looked at several plotting functions such as:

-   **plot()**
-   **barplot()**
-   **ggplot()**
-   **lines()**
-   **hist()**
-   **density()**

### **<span style="color:burlywood">Examples:</span>**

### <span style="color:burlywood">Familiar plotting functions:</span>

#### <span style="color:burlywood">(Example 1) Automobile Land Speed Records from automobile races:</span>

###### Let's begin by creating a sample data frame and then using familiar functions to plot this data:

``` r
#load all necessary packages into the R session 
library(ggplot2)
library(scatterplot3d)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(dygraphs)
library(magrittr)
library(highcharter)
```

    ## Highcharts (www.highcharts.com) is a Highsoft software product which is

    ## not free for commercial and Governmental use

``` r
library("forecast")

#creating vectors with each set of data 
speed <- c(407.447, 413.199, 434.22, 468.719, 526.277, 536.712, 555.127, 576.553, 600.601, 622.407, 633.468, 763.035)
driver <- c('Craig Breedlove', 'Tom Green', 'Art Arfons', 'Craig Breedlove', 'Craig Breedlove', 'Art Arfons', 'Craig Breedlove','Art Arfons','Craig Breedlove', 'Gary Gabelich', 'Richard Noble', 'Andy Green')
car <- c('Spirit of America', 'Wingfoot Express', 'Green Monster', 'Spirit of America', 'Spirit of America', 'Green Monster', 'Spirit of America, Sonic 1', 'Green Monster', 'Spirit of America, Sonic 1', 'Blue Flame', 'Thrust 2', 'Thrust SSC')
engine <- c('GE J47', 'WE J46', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'Rocket', 'RR RG 146', 'RR Spey')

date <- c(1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971,1972,1973, 1974)
num_races<- c(190,200,160,190,190,160,190,160,190,110, 150, 130) # number of races driven by a driver 
#compiling the vectors into a data frame 
auto_dat <- data.frame(speed, driver, car, engine, date, num_races)
#displaying the data frame 
auto_dat 
```

    ##      speed          driver                        car    engine date
    ## 1  407.447 Craig Breedlove          Spirit of America    GE J47 1963
    ## 2  413.199       Tom Green           Wingfoot Express    WE J46 1964
    ## 3  434.220      Art Arfons              Green Monster    GE J79 1965
    ## 4  468.719 Craig Breedlove          Spirit of America    GE J79 1966
    ## 5  526.277 Craig Breedlove          Spirit of America    GE J79 1967
    ## 6  536.712      Art Arfons              Green Monster    GE J79 1968
    ## 7  555.127 Craig Breedlove Spirit of America, Sonic 1    GE J79 1969
    ## 8  576.553      Art Arfons              Green Monster    GE J79 1970
    ## 9  600.601 Craig Breedlove Spirit of America, Sonic 1    GE J79 1971
    ## 10 622.407   Gary Gabelich                 Blue Flame    Rocket 1972
    ## 11 633.468   Richard Noble                   Thrust 2 RR RG 146 1973
    ## 12 763.035      Andy Green                 Thrust SSC   RR Spey 1974
    ##    num_races
    ## 1        190
    ## 2        200
    ## 3        160
    ## 4        190
    ## 5        190
    ## 6        160
    ## 7        190
    ## 8        160
    ## 9        190
    ## 10       110
    ## 11       150
    ## 12       130

``` r
#Driver vs. Speed on a Scatterplot
ggplot(auto_dat, aes(x=driver, y=speed)) + geom_text(aes(label=car), size=3) + ggtitle("Drivers VS Speed With Car Names as Labels") + theme(plot.title = element_text(hjust = 0.5))
```

![](post01_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
#Engine vs. Speed on a Barplot 
#select the data frame and the relevant columns we would like explore the relationship between 
eng_dat <- select(auto_dat, speed, engine)
#arranging the data by speed in increasing order 
eng_dat <- arrange(eng_dat, speed)
#plotting the engine type vs speed in ascending order of speed on barplot
barplot(eng_dat$speed, main= "Engine VS Speed Barplot", names.arg = eng_dat$engine, xlab= "Engines", ylab="Speed")
```

![](post01_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-2.png)

###### Here we have created two simple graphs. The first graph is a scatterplot of driver names plotted against speed with the points labeled as the name of the car the driver was using. The second graph is a barplot of engines plotted against speed with the x-axis labeled with engine names. We can use many of the graphing methods we have already learned in class to represent the same data in different ways, depending on which relationships we would like to furthur explore. Next, let's look at a new plotting function that I discovered in doing some furthur research on R. This function is called dygraph and it is a plotting function which allows one to handle large sets of data easily, as well as provides the means to chart time-series data in R.Let's look at an example of how it works:

### <span style="color:burlywood">Dygraph:</span>

#### <span style="color:burlywood">(Example 2) Randomly Generated Weather Data from 1960-2010:</span>

#### Why dygraphs are useful:

###### Dygraph not only allows us to graph multiple numeric sets against one another (which previous functions have also allowed), but it also includes a new feature which is interaction. As you have probably noticed, if you hover your arrow over the graph and move it around, a vertical set of dots will move along the graph allowing you to see all corresponding y values for a particular x value. This adds depth to analysis because it allows one to precisely see both values and furthurmore to track (continuously) how they change over the x values. From this randomly generated weather data we see that tracking for example the temperature and chance of tornadoes over time becomes a lot easier because the tracker allows one to easily see how the values move.

``` r
#creating the variables of the data frame weather_dat: date, temperature, chance of percipitation, cloud coverage, and chance of tornadoes
date <- c(1960:2010)
temp <- sample(30:98, 51, replace=TRUE)
percip_chance<- sample(30:60, 51, replace=TRUE)
cloud_coverage <- sample(1:100, 51, replace=TRUE)
tornado_chance <- sample(10:20, 51, replace=TRUE)
#creating the data frame
weather_dat <- data.frame(date, temp, percip_chance,cloud_coverage, tornado_chance)
#graphing the data using dygraph
dygraph(weather_dat,main= "Randomly Generated Weather Data from 1960-2010", xlab = "Year" )
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-1d265457d731baca92d3">{"x":{"attrs":{"title":"Randomly Generated Weather Data from 1960-2010","xlabel":"Year","labels":["date","temp","percip_chance","cloud_coverage","tornado_chance"],"legend":"auto","retainDateWindow":false,"axes":{"x":{"pixelsPerLabel":60}}},"annotations":[],"shadings":[],"events":[],"format":"numeric","data":[[1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010],[48,92,31,98,95,75,66,81,53,39,95,79,44,66,34,74,58,40,50,96,94,72,64,43,52,74,47,42,48,72,98,72,52,38,73,37,51,73,77,41,84,97,44,54,86,88,44,94,45,86,89],[50,43,44,41,42,55,57,45,44,44,36,38,48,41,43,44,60,41,36,31,59,36,56,53,46,37,50,41,47,49,52,52,45,37,31,51,52,57,51,54,51,36,36,35,32,58,56,51,50,48,45],[50,98,88,55,14,13,58,76,48,96,68,69,32,85,40,84,47,19,100,53,66,60,32,70,67,69,85,59,26,14,76,3,75,56,81,27,16,7,39,21,26,40,4,24,21,17,37,88,52,5,43],[13,16,17,17,20,11,17,16,12,15,20,15,12,15,18,17,18,20,17,20,13,14,15,12,18,17,11,15,13,19,17,12,10,10,16,18,19,20,20,13,13,11,17,12,14,15,16,15,11,16,16]]},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
#### Stacked Graphs:

###### Stacked graphs are a feature of dygraph that allows one to directly compare two variables. As you can see below, one is able to view how temperatures and chance of percipitation change over time. This representation can also be useful in determining what percentage of one variable another variable makes up. For example, if the chance of percipitation was a combination of the amount of cloud coverage and level of humidity then one could graph the two together and see which factor contributes more to the chance of percipitation.

``` r
#creating a data table that includes date, temperature, and chance of percipitation columns from weather_dat
stacked_dat <- select(weather_dat, date, temp,percip_chance)

#using dygraph to graph stacked_dat in a stacked graph format
dygraph(stacked_dat, main = "Time VS Temperature and Percipitation", xlab="Time") %>% 
  dySeries("temp", label="Temperature") %>%
  dySeries("percip_chance", label="Chance of Percipitation") %>%
  dyOptions(stackedGraph= TRUE) %>%
  dyRangeSelector(height=100)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-9737b417722bdcdefd47">{"x":{"attrs":{"title":"Time VS Temperature and Percipitation","xlabel":"Time","labels":["date","Temperature","Chance of Percipitation"],"legend":"auto","retainDateWindow":false,"axes":{"x":{"pixelsPerLabel":60,"drawAxis":true},"y":{"drawAxis":true}},"series":{"Temperature":{"axis":"y"},"Chance of Percipitation":{"axis":"y"}},"stackedGraph":true,"fillGraph":false,"fillAlpha":0.15,"stepPlot":false,"drawPoints":false,"pointSize":1,"drawGapEdgePoints":false,"connectSeparatedPoints":false,"strokeWidth":1,"strokeBorderColor":"white","colorValue":0.5,"colorSaturation":1,"includeZero":false,"drawAxesAtZero":false,"logscale":false,"axisTickSize":3,"axisLineColor":"black","axisLineWidth":0.3,"axisLabelColor":"black","axisLabelFontSize":14,"axisLabelWidth":60,"drawGrid":true,"gridLineWidth":0.3,"rightGap":5,"digitsAfterDecimal":2,"labelsKMB":false,"labelsKMG2":false,"labelsUTC":false,"maxNumberWidth":6,"animatedZooms":false,"mobileDisableYTouch":true,"showRangeSelector":true,"rangeSelectorHeight":100,"rangeSelectorPlotFillColor":" #A7B1C4","rangeSelectorPlotStrokeColor":"#808FAB","interactionModel":"Dygraph.Interaction.defaultModel"},"annotations":[],"shadings":[],"events":[],"format":"numeric","data":[[1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010],[48,92,31,98,95,75,66,81,53,39,95,79,44,66,34,74,58,40,50,96,94,72,64,43,52,74,47,42,48,72,98,72,52,38,73,37,51,73,77,41,84,97,44,54,86,88,44,94,45,86,89],[50,43,44,41,42,55,57,45,44,44,36,38,48,41,43,44,60,41,36,31,59,36,56,53,46,37,50,41,47,49,52,52,45,37,31,51,52,57,51,54,51,36,36,35,32,58,56,51,50,48,45]],"fixedtz":false,"tzone":""},"evals":["attrs.interactionModel"],"jsHooks":[]}</script>
<!--/html_preserve-->
#### StepPlots:

###### StepPlots are another feature of dygraph and are especially useful for discrete data that has sudden jumps in it. If one would like to observe such jumps or even to view otherwise continuous data in a discrete format, stepplot can be employed. In the following graph we will view Temperature and Chance of Percipitation against one another in a stepplot format:

``` r
#referencing stacked_dat under a new variable name 
step_dat <- stacked_dat 
#graphing temperature and chance of percipitation against one another using stepplot function
dygraph(step_dat, main="StepPlot of Temperature and Chance of Percipitation", xlab = "Time") %>% 
  dyOptions(stepPlot= TRUE)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-80c0f84125a06973f548">{"x":{"attrs":{"title":"StepPlot of Temperature and Chance of Percipitation","xlabel":"Time","labels":["date","temp","percip_chance"],"legend":"auto","retainDateWindow":false,"axes":{"x":{"pixelsPerLabel":60,"drawAxis":true},"y":{"drawAxis":true}},"stackedGraph":false,"fillGraph":false,"fillAlpha":0.15,"stepPlot":true,"drawPoints":false,"pointSize":1,"drawGapEdgePoints":false,"connectSeparatedPoints":false,"strokeWidth":1,"strokeBorderColor":"white","colorValue":0.5,"colorSaturation":1,"includeZero":false,"drawAxesAtZero":false,"logscale":false,"axisTickSize":3,"axisLineColor":"black","axisLineWidth":0.3,"axisLabelColor":"black","axisLabelFontSize":14,"axisLabelWidth":60,"drawGrid":true,"gridLineWidth":0.3,"rightGap":5,"digitsAfterDecimal":2,"labelsKMB":false,"labelsKMG2":false,"labelsUTC":false,"maxNumberWidth":6,"animatedZooms":false,"mobileDisableYTouch":true},"annotations":[],"shadings":[],"events":[],"format":"numeric","data":[[1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010],[48,92,31,98,95,75,66,81,53,39,95,79,44,66,34,74,58,40,50,96,94,72,64,43,52,74,47,42,48,72,98,72,52,38,73,37,51,73,77,41,84,97,44,54,86,88,44,94,45,86,89],[50,43,44,41,42,55,57,45,44,44,36,38,48,41,43,44,60,41,36,31,59,36,56,53,46,37,50,41,47,49,52,52,45,37,31,51,52,57,51,54,51,36,36,35,32,58,56,51,50,48,45]],"fixedtz":false,"tzone":""},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
#### Fill Graphs:

###### Another feature of dygraph includes fill graphs which can be used to view continuous or discrete variables and are especially useful if one would like to observe area under the curve. In the following graph, we can view temperature as a continuous variables and see how it varies over time through the fill graph option in dygraph:

``` r
#selected the date and temperature columns of weather_dat to create a new data frame
single_var <- select(weather_dat, date, temp)
#plotting the new data frame using dygraph and the fill graph option 
dygraph(single_var, main="Randomly Generated Temperature Data", xlab = "Time") %>%
  dyOptions(fillGraph = TRUE, fillAlpha= 0.4)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-b83de16322e109ef9a1f">{"x":{"attrs":{"title":"Randomly Generated Temperature Data","xlabel":"Time","labels":["date","temp"],"legend":"auto","retainDateWindow":false,"axes":{"x":{"pixelsPerLabel":60,"drawAxis":true},"y":{"drawAxis":true}},"stackedGraph":false,"fillGraph":true,"fillAlpha":0.4,"stepPlot":false,"drawPoints":false,"pointSize":1,"drawGapEdgePoints":false,"connectSeparatedPoints":false,"strokeWidth":1,"strokeBorderColor":"white","colorValue":0.5,"colorSaturation":1,"includeZero":false,"drawAxesAtZero":false,"logscale":false,"axisTickSize":3,"axisLineColor":"black","axisLineWidth":0.3,"axisLabelColor":"black","axisLabelFontSize":14,"axisLabelWidth":60,"drawGrid":true,"gridLineWidth":0.3,"rightGap":5,"digitsAfterDecimal":2,"labelsKMB":false,"labelsKMG2":false,"labelsUTC":false,"maxNumberWidth":6,"animatedZooms":false,"mobileDisableYTouch":true},"annotations":[],"shadings":[],"events":[],"format":"numeric","data":[[1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010],[48,92,31,98,95,75,66,81,53,39,95,79,44,66,34,74,58,40,50,96,94,72,64,43,52,74,47,42,48,72,98,72,52,38,73,37,51,73,77,41,84,97,44,54,86,88,44,94,45,86,89]],"fixedtz":false,"tzone":""},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
#### Upper/Lower Fill Graphs:

###### Upper/Lower fill graphs allow us to look at how certain data will vary over time with added degrees of freedom. Suppose that we have temperature data which was included in **weather\_dat** and a meterologist determines that in this time period the actual temperatures may vary from the data by 20 degrees. These upper/lower graphs allow for us to account for this variance visually. If we were to graph the aforementioned scenario, it would look something like this:

``` r
#create a new data frame with the temperature variable and two new variables containing upper and lower bounds of temperature 
new <- data.frame(date=c(1960:2010), temp=weather_dat$temp, temp.upper=weather_dat$temp+20, temp.lower=weather_dat$temp-20)
hw <- HoltWinters(new, gamma = FALSE) #creating the variance above and below the temp data 
p <- predict(hw, n.ahead=3, prediction.interval=FALSE)

#graphing the temp data using dygraph with the upper/lower graph option 
dygraph(new, "Temperature with an Upper and Lower Bound", xlab = "Time", ylab="Temperature") %>%
   dySeries("temp") %>%
  dySeries(c("temp.lower", "temp", "temp.upper"), label = "Temperature")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-9d39f11ecf7b04f373e6">{"x":{"attrs":{"title":"Temperature with an Upper and Lower Bound","xlabel":"Time","ylabel":"Temperature","labels":["date","Temperature"],"legend":"auto","retainDateWindow":false,"axes":{"x":{"pixelsPerLabel":60}},"series":{"temp":{"axis":"y"},"Temperature":{"axis":"y"}},"customBars":true},"annotations":[],"shadings":[],"events":[],"format":"numeric","data":[[1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010],[[28,48,68],[72,92,112],[11,31,51],[78,98,118],[75,95,115],[55,75,95],[46,66,86],[61,81,101],[33,53,73],[19,39,59],[75,95,115],[59,79,99],[24,44,64],[46,66,86],[14,34,54],[54,74,94],[38,58,78],[20,40,60],[30,50,70],[76,96,116],[74,94,114],[52,72,92],[44,64,84],[23,43,63],[32,52,72],[54,74,94],[27,47,67],[22,42,62],[28,48,68],[52,72,92],[78,98,118],[52,72,92],[32,52,72],[18,38,58],[53,73,93],[17,37,57],[31,51,71],[53,73,93],[57,77,97],[21,41,61],[64,84,104],[77,97,117],[24,44,64],[34,54,74],[66,86,106],[68,88,108],[24,44,64],[74,94,114],[25,45,65],[66,86,106],[69,89,109]]]},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
###### Another plotting function from R that we haven't seen is highcharter. This function provides some unique features that allow us to get really creative with our graphs:

### <span style="color:burlywood">HighCharter:</span>

#### <span style="color:burlywood">(Example 3) Randomly Generated Weather Data from 1960-2010:</span>

#### Why High Charts are useful:

###### From this randomly generated weather data we see that tracking for example the temperature and chance of tornadoes over time becomes a lot easier because the tracker allows one to easily see how the values move similar to dygraph. Highchart is another useful graphing function that allows one to display time-series data in an easy-to-understand, visually pleasing way. Let's look at a simple example of a scatterplot using highchart:

``` r
#creating the variables of the new data set: teen_stats 
per_hs_grads1990 <- c(65.9, 70.6, 68.5, 76.4, 63.1, 73, 78.5, 68.5, 56.6, 56.2, 60.8, 74.3, 76.7, 72.9, 72.2, 82.7, 78.4, 68.5, 58.7, 76.1, 70.5, 76.6, 62, 89.4, 63.8, 70.3, 86.4, 84.2, 76.5, 71.7, 77.2, 57.3, 60.4, 66.7, 86.9, 76.4, 77.2, 71.1, 71.7, 64.9, 58.2, 79.9, 68.7, 65.4, 79.5, 80.4, 69.9, 74.7, 78, 82.7, 85.1)

standard_score <- per_hs_grads1990/100

total_births_under20 <- c(59736, 12844, 59348, 35221, 470951, 55123, 43988, 9618, 9870, 163816, 96340, 18307, 17567, 180737, 80946, 41221, 39679, 52885, 81458, 16903, 68015, 81780, 138021, 67412, 43449, 76978, 13494, 25551, 15325, 15453, 105566, 27757, 259465, 89397, 11721, 160474, 53137, 39486, 160528, 13033, 51900, 12130, 66757, 308164, 37451, 8036, 86052, 70230, 24132, 73743, 9366)

#compiling the variables into a data frame 
teen_stats <- data.frame(per_hs_grads1990, standard_score, total_births_under20)

#using the highchart function of R to create a simple scatterplot of the total number of births under twenty years of age 
hc <- highchart() %>% 
  hc_title(text = "Total Births Under 20 Years of Age") %>% 
  hc_add_series(data = teen_stats$total_births_under20) %>%
  hc_yAxis(title= list(text="Number of Births")) %>%
  hc_xAxis(title=list(text="Time"))
hc
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-a87931b71accb69687ab">{"x":{"hc_opts":{"title":{"text":"Total Births Under 20 Years of Age"},"yAxis":{"title":{"text":"Number of Births"}},"credits":{"enabled":false},"exporting":{"enabled":false},"plotOptions":{"series":{"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"},"bubble":{"minSize":5,"maxSize":25}},"annotationsOptions":{"enabledButtons":false},"tooltip":{"delayForDisplay":10},"series":[{"data":[59736,12844,59348,35221,470951,55123,43988,9618,9870,163816,96340,18307,17567,180737,80946,41221,39679,52885,81458,16903,68015,81780,138021,67412,43449,76978,13494,25551,15325,15453,105566,27757,259465,89397,11721,160474,53137,39486,160528,13033,51900,12130,66757,308164,37451,8036,86052,70230,24132,73743,9366]}],"xAxis":{"title":{"text":"Time"}}},"theme":{"chart":{"backgroundColor":"transparent"}},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","drillUpText":"Back to {series.name}","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"thousandsSep":" ","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
#### Bubble Charts:

###### Bubble charts allow one to view multiple pieces of data and creates size and color bubbles which correspond to those values. In the following chart, we are graphing three pieces of data from **teen\_stats** which include standard scores of teens, total births under 20 years of age, and number of graduates. Each bubble has and x and y coordinate of the first two variables, and then a size based on the third variable. In this graph we see that there seems to be no distinguishable association between standard scores of teens and number of births under the age of 20 years, but we do observe the bubble getting smaller as we move downwards along the xaxis. What does this mean? The size of the bubble represents the third variable that we are graphing which is **percentage of highschool grads**. So this pattern tells us that as standardized scores increase the number of highschool graduates also increases which logically seems correct. In this way the bubble chart allows us to analyze mutiple associations at once in a visually aethetic way.

``` r
#using highchart to create a bubble chart of standard scores vs. total births under 20 years of age with percentage of high school grads representing bubble size 
highchart() %>% 
  hc_title(text="1984-1993 Teen Statistics") %>%
  hc_yAxis(title= list(text="Total Number of Births Under 20 Years of Age")) %>%
  hc_xAxis(title=list(text="Standardized Scores"))%>%
  hc_add_series_scatter(teen_stats$standard_score, teen_stats$total_births_under20, teen_stats$per_hs_grads1990, color=teen_stats$per_hs_grads1990)%>%
  hc_add_theme(hc_theme_ffx()) #theme create backgroun gradient 
```

    ## Warning: 'hc_add_series_scatter' is deprecated.
    ## Use 'hc_add_series' instead.
    ## See help("Deprecated")

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-ed8e448e2d07c83cd1d4">{"x":{"hc_opts":{"title":{"text":"1984-1993 Teen Statistics"},"yAxis":{"title":{"text":"Total Number of Births Under 20 Years of Age"}},"credits":{"enabled":false},"exporting":{"enabled":false},"plotOptions":{"series":{"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"},"bubble":{"minSize":5,"maxSize":25}},"annotationsOptions":{"enabledButtons":false},"tooltip":{"delayForDisplay":10},"xAxis":{"title":{"text":"Standardized Scores"}},"series":[{"data":[{"x":0.659,"y":59736,"z":65.9,"valuecolor":65.9,"color":"#324870"},{"x":0.706,"y":12844,"z":70.6,"valuecolor":70.6,"color":"#257C84"},{"x":0.685,"y":59348,"z":68.5,"valuecolor":68.5,"color":"#2D5C77"},{"x":0.764,"y":35221,"z":76.4,"valuecolor":76.4,"color":"#67AB6B"},{"x":0.631,"y":470951,"z":63.1,"valuecolor":63.1,"color":"#382E65"},{"x":0.73,"y":55123,"z":73,"valuecolor":73,"color":"#349782"},{"x":0.785,"y":43988,"z":78.5,"valuecolor":78.5,"color":"#ADC74A"},{"x":0.685,"y":9618,"z":68.5,"valuecolor":68.5,"color":"#2D5C77"},{"x":0.566,"y":9870,"z":56.6,"valuecolor":56.6,"color":"#420756"},{"x":0.562,"y":163816,"z":56.2,"valuecolor":56.2,"color":"#440154"},{"x":0.608,"y":96340,"z":60.8,"valuecolor":60.8,"color":"#3A2863"},{"x":0.743,"y":18307,"z":74.3,"valuecolor":74.3,"color":"#3F9B7D"},{"x":0.767,"y":17567,"z":76.7,"valuecolor":76.7,"color":"#7BB361"},{"x":0.729,"y":180737,"z":72.9,"valuecolor":72.9,"color":"#2A9387"},{"x":0.722,"y":80946,"z":72.2,"valuecolor":72.2,"color":"#21908C"},{"x":0.827,"y":41221,"z":82.7,"valuecolor":82.7,"color":"#D5D737"},{"x":0.784,"y":39679,"z":78.4,"valuecolor":78.4,"color":"#A3C34F"},{"x":0.685,"y":52885,"z":68.5,"valuecolor":68.5,"color":"#2D5C77"},{"x":0.587,"y":81458,"z":58.7,"valuecolor":58.7,"color":"#3D1B5E"},{"x":0.761,"y":16903,"z":76.1,"valuecolor":76.1,"color":"#53A374"},{"x":0.705,"y":68015,"z":70.5,"valuecolor":70.5,"color":"#277681"},{"x":0.766,"y":81780,"z":76.6,"valuecolor":76.6,"color":"#71AF66"},{"x":0.62,"y":138021,"z":62,"valuecolor":62,"color":"#382E65"},{"x":0.894,"y":67412,"z":89.4,"valuecolor":89.4,"color":"#FDE725"},{"x":0.638,"y":43449,"z":63.8,"valuecolor":63.8,"color":"#373468"},{"x":0.703,"y":76978,"z":70.3,"valuecolor":70.3,"color":"#286F7F"},{"x":0.864,"y":13494,"z":86.4,"valuecolor":86.4,"color":"#F3E329"},{"x":0.842,"y":25551,"z":84.2,"valuecolor":84.2,"color":"#DFDB33"},{"x":0.765,"y":15325,"z":76.5,"valuecolor":76.5,"color":"#67AB6B"},{"x":0.717,"y":15453,"z":71.7,"valuecolor":71.7,"color":"#21908C"},{"x":0.772,"y":105566,"z":77.2,"valuecolor":77.2,"color":"#8FBB58"},{"x":0.573,"y":27757,"z":57.3,"valuecolor":57.3,"color":"#400E59"},{"x":0.604,"y":259465,"z":60.4,"valuecolor":60.4,"color":"#3C2160"},{"x":0.667,"y":89397,"z":66.7,"valuecolor":66.7,"color":"#304E72"},{"x":0.869,"y":11721,"z":86.9,"valuecolor":86.9,"color":"#FDE725"},{"x":0.764,"y":160474,"z":76.4,"valuecolor":76.4,"color":"#67AB6B"},{"x":0.772,"y":53137,"z":77.2,"valuecolor":77.2,"color":"#8FBB58"},{"x":0.711,"y":39486,"z":71.1,"valuecolor":71.1,"color":"#248386"},{"x":0.717,"y":160528,"z":71.7,"valuecolor":71.7,"color":"#21908C"},{"x":0.649,"y":13033,"z":64.9,"valuecolor":64.9,"color":"#353B6A"},{"x":0.582,"y":51900,"z":58.2,"valuecolor":58.2,"color":"#3F145B"},{"x":0.799,"y":12130,"z":79.9,"valuecolor":79.9,"color":"#B7CB45"},{"x":0.687,"y":66757,"z":68.7,"valuecolor":68.7,"color":"#2C627A"},{"x":0.654,"y":308164,"z":65.4,"valuecolor":65.4,"color":"#34426D"},{"x":0.795,"y":37451,"z":79.5,"valuecolor":79.5,"color":"#B7CB45"},{"x":0.804,"y":8036,"z":80.4,"valuecolor":80.4,"color":"#C1CF41"},{"x":0.699,"y":86052,"z":69.9,"valuecolor":69.9,"color":"#2A697C"},{"x":0.747,"y":70230,"z":74.7,"valuecolor":74.7,"color":"#499F79"},{"x":0.78,"y":24132,"z":78,"valuecolor":78,"color":"#99BF53"},{"x":0.827,"y":73743,"z":82.7,"valuecolor":82.7,"color":"#D5D737"},{"x":0.851,"y":9366,"z":85.1,"valuecolor":85.1,"color":"#E9DF2E"}],"type":"bubble","showInLegend":false,"dataLabels":{"enabled":false}}]},"theme":{"colors":["#00AACC","#FF4E00","#B90000","#5F9B0A","#CD6723"],"chart":{"backgroundColor":{"linearGradient":[0,0,0,150],"stops":[[0,"#CAE1F4"],[1,"#EEEEEE"]]},"style":{"fontFamily":"Open Sans"}},"title":{"align":"left"},"subtitle":{"align":"left"},"legend":{"align":"right","verticalAlign":"bottom"},"xAxis":{"gridLineWidth":1,"gridLineColor":"#F3F3F3","lineColor":"#F3F3F3","minorGridLineColor":"#F3F3F3","tickColor":"#F3F3F3","tickWidth":1},"yAxis":{"gridLineColor":"#F3F3F3","lineColor":"#F3F3F3","minorGridLineColor":"#F3F3F3","tickColor":"#F3F3F3","tickWidth":1}},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","drillUpText":"Back to {series.name}","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"thousandsSep":" ","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":"Open+Sans","debug":false},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
#### Forecast Charts:

###### Forecast Charts are especially useful when analyzing financial data. This feature can be used to project how a stock's value will move. In this scenario our data includes teens standardized scores and I have created the chart so as to display an averaged value of predicted values for the next three years. Depending on what kind of forecast you would like to analyze, you can use forecast charts to estimate how fluctuate in the future.

``` r
#using the forecast function to predict the averaged value of future score predictions
x <- forecast(teen_stats$per_hs_grads1990, h = 36, level = 90)

#using highchart to graph the average prediction on a scatterplot with the real data 
hchart(x)%>% 
  hc_title(text="High School Graduates in 1990") %>%
  hc_yAxis(title= list(text="Percentage of High School Graduates")) %>%
  hc_xAxis(title=list(text="Time"))
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-da71989921957b9b5296">{"x":{"hc_opts":{"title":{"text":"High School Graduates in 1990"},"yAxis":{"title":{"text":"Percentage of High School Graduates"}},"credits":{"enabled":false},"exporting":{"enabled":false},"plotOptions":{"series":{"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"},"bubble":{"minSize":5,"maxSize":25}},"annotationsOptions":{"enabledButtons":false},"tooltip":{"delayForDisplay":10},"xAxis":{"type":"datetime","title":{"text":"Time"}},"series":[{"data":[[-62135596800000,65.9],[-62104060800000,70.6],[-62072524800000,68.5],[-62040988800000,76.4],[-62009366400000,63.1],[-61977830400000,73],[-61946294400000,78.5],[-61914758400000,68.5],[-61883136000000,56.6],[-61851600000000,56.2],[-61820064000000,60.8],[-61788528000000,74.3],[-61756905600000,76.7],[-61725369600000,72.9],[-61693833600000,72.2],[-61662297600000,82.7],[-61630675200000,78.4],[-61599139200000,68.5],[-61567603200000,58.7],[-61536067200000,76.1],[-61504444800000,70.5],[-61472908800000,76.6],[-61441372800000,62],[-61409836800000,89.4],[-61378214400000,63.8],[-61346678400000,70.3],[-61315142400000,86.4],[-61283606400000,84.2],[-61251984000000,76.5],[-61220448000000,71.7],[-61188912000000,77.2],[-61157376000000,57.3],[-61125753600000,60.4],[-61094217600000,66.7],[-61062681600000,86.9],[-61031145600000,76.4],[-60999523200000,77.2],[-60967987200000,71.1],[-60936451200000,71.7],[-60904915200000,64.9],[-60873292800000,58.2],[-60841756800000,79.9],[-60810220800000,68.7],[-60778684800000,65.4],[-60747062400000,79.5],[-60715526400000,80.4],[-60683990400000,69.9],[-60652454400000,74.7],[-60620832000000,78],[-60589296000000,82.7],[-60557760000000,85.1]],"name":"Series","zIndex":3},{"data":[[-60526224000000,72.2036816140781],[-60494601600000,72.2036816140781],[-60463065600000,72.2036816140781],[-60431529600000,72.2036816140781],[-60399993600000,72.2036816140781],[-60368371200000,72.2036816140781],[-60336835200000,72.2036816140781],[-60305299200000,72.2036816140781],[-60273763200000,72.2036816140781],[-60242140800000,72.2036816140781],[-60210604800000,72.2036816140781],[-60179068800000,72.2036816140781],[-60147532800000,72.2036816140781],[-60115910400000,72.2036816140781],[-60084374400000,72.2036816140781],[-60052838400000,72.2036816140781],[-60021302400000,72.2036816140781],[-59989680000000,72.2036816140781],[-59958144000000,72.2036816140781],[-59926608000000,72.2036816140781],[-59895072000000,72.2036816140781],[-59863449600000,72.2036816140781],[-59831913600000,72.2036816140781],[-59800377600000,72.2036816140781],[-59768841600000,72.2036816140781],[-59737219200000,72.2036816140781],[-59705683200000,72.2036816140781],[-59674147200000,72.2036816140781],[-59642611200000,72.2036816140781],[-59610988800000,72.2036816140781],[-59579452800000,72.2036816140781],[-59547916800000,72.2036816140781],[-59516380800000,72.2036816140781],[-59484758400000,72.2036816140781],[-59453222400000,72.2036816140781],[-59421686400000,72.2036816140781]],"name":"ETS(A,N,N)","zIndex":2,"id":"45bcu6qskt"},{"data":[[-60526224000000,85.9691507692948,58.4382124588614],[-60494601600000,85.9691508382503,58.4382123899059],[-60463065600000,85.9691509072058,58.4382123209504],[-60431529600000,85.9691509761613,58.4382122519949],[-60399993600000,85.9691510451168,58.4382121830394],[-60368371200000,85.9691511140723,58.438212114084],[-60336835200000,85.9691511830277,58.4382120451285],[-60305299200000,85.9691512519832,58.438211976173],[-60273763200000,85.9691513209387,58.4382119072175],[-60242140800000,85.9691513898942,58.438211838262],[-60210604800000,85.9691514588497,58.4382117693065],[-60179068800000,85.9691515278052,58.438211700351],[-60147532800000,85.9691515967607,58.4382116313955],[-60115910400000,85.9691516657162,58.4382115624401],[-60084374400000,85.9691517346716,58.4382114934846],[-60052838400000,85.9691518036271,58.4382114245291],[-60021302400000,85.9691518725826,58.4382113555736],[-59989680000000,85.9691519415381,58.4382112866181],[-59958144000000,85.9691520104936,58.4382112176626],[-59926608000000,85.9691520794491,58.4382111487071],[-59895072000000,85.9691521484046,58.4382110797517],[-59863449600000,85.96915221736,58.4382110107962],[-59831913600000,85.9691522863155,58.4382109418407],[-59800377600000,85.969152355271,58.4382108728852],[-59768841600000,85.9691524242265,58.4382108039297],[-59737219200000,85.969152493182,58.4382107349742],[-59705683200000,85.9691525621375,58.4382106660188],[-59674147200000,85.9691526310929,58.4382105970633],[-59642611200000,85.9691527000484,58.4382105281078],[-59610988800000,85.9691527690039,58.4382104591523],[-59579452800000,85.9691528379594,58.4382103901968],[-59547916800000,85.9691529069149,58.4382103212413],[-59516380800000,85.9691529758703,58.4382102522859],[-59484758400000,85.9691530448258,58.4382101833304],[-59453222400000,85.9691531137813,58.4382101143749],[-59421686400000,85.9691531827368,58.4382100454194]],"name":"ETS(A,N,N) level 90","type":"arearange","fillOpacity":0.1,"zIndex":1,"lineWidth":0,"linkedTo":"45bcu6qskt"}]},"theme":{"chart":{"backgroundColor":"transparent"}},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","drillUpText":"Back to {series.name}","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"thousandsSep":" ","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
#### Errorbar Charts:

###### Errorbar charts are likely most useful in analyzing scientific data. This feature of highchart will not only allow one to compare magnitudes across a variable in a visually simple way, but it will also provide an estimated error level represented by the black horizontal line on the graph. If one would like to present complex data this feature can be useful not only in understanding the data but also in ensuring that necessary degrees of freedom are accounted for.

``` r
#creating a vector with the appropriate error levels 
x <- acf(diff(teen_stats$standard_score), plot = FALSE)

#using highchart to graph the data in an errorbar format 
hchart(x)%>%
  hc_title(text="Standardized Scores") %>%
  hc_yAxis(title= list(text="Score")) %>%
  hc_xAxis(title=list(text="Time"))
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-bfc4fa9a9b29e2234787">{"x":{"hc_opts":{"title":{"text":"Standardized Scores"},"yAxis":{"title":{"text":"Score"},"plotLines":[{"width":1,"value":0.277180764869935,"color":"gray"},{"width":1,"value":-0.277180764869935,"color":"gray"}]},"credits":{"enabled":false},"exporting":{"enabled":false},"plotOptions":{"series":{"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"},"bubble":{"minSize":5,"maxSize":25}},"annotationsOptions":{"enabledButtons":false},"tooltip":{"delayForDisplay":10},"series":[{"data":[{"x":1,"y":1},{"x":2,"y":-0.379776885502069},{"x":3,"y":-0.0775818071171209},{"x":4,"y":-0.100982003615145},{"x":5,"y":0.236724852842157},{"x":6,"y":-0.246827993798164},{"x":7,"y":-0.0864732621118743},{"x":8,"y":0.181598422471884},{"x":9,"y":0.0125416964310592},{"x":10,"y":-0.00395073321878762},{"x":11,"y":-0.108574238110519},{"x":12,"y":0.252705804951032},{"x":13,"y":-0.204781990292766},{"x":14,"y":-0.0293028223503139},{"x":15,"y":0.0321437080254889},{"x":16,"y":0.199403873022168},{"x":17,"y":-0.125806554808651}],"type":"column","groupPadding":1,"name":"ACF"}],"xAxis":{"title":{"text":"Time"}}},"theme":{"chart":{"backgroundColor":"transparent"}},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","drillUpText":"Back to {series.name}","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"thousandsSep":" ","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
### <span style="color:burlywood">Conclusion:</span>

###### We see from these functions that graphing data is a matter of understanding what the analyst would like to associate and describe. In class, we have covered several plotting functions such as plot, ggplot, barplot, hist, etc. These have given us a ultilitarian basis for how to plot data and understand its rudimentary make-up. The functions dygraph and highcharter discussed in this post allow us to analyze data on a deeper level. The features of dygraph allow us to track multiple y values as x values change, as well as to represent data with added variance. The features of highchart allow us to forecast and to view multiple associations at once. We can use these new features to improve our analyses in this class and beyond. The take away message from this post is that there is more than one way to represent data, and the most successful data analysis is highly dependent on understanding what you or your client is interested in observing about the data and then using the appropriate graphing devices to create useful summaries and graphs.

###### I hope this post was an interesting read for you and thank you for grading it!

### <span style="color:burlywood">References:</span>

-   <http://www.sedl.org/afterschool/toolkits/science/pdf/ast_sci_data_tables_sample.pdf>
-   <https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2>
-   <http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf>
-   <https://blog.rstudio.com/2015/04/14/interactive-time-series-with-dygraphs/>
-   <https://rstudio.github.io/dygraphs/>
-   <https://rstudio.github.io/dygraphs/gallery-series-options.html>
-   <http://www.htmlwidgets.org/showcase_highcharts.html>
-   <http://mathforum.org/workshops/sum96/data.collections/datalibrary/data.set6.html>
-   <http://jkunst.com/highcharter/highcharts.html>
-   <https://github.com/jbkunst/highcharter/issues/254>
-   <https://www.highcharts.com/>
