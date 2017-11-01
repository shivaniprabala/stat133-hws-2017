<span style="color:burlywood">Post 1- Statistics 133 (Fall 2017)</span>
================
Shivani Prabala
10/29/2017

### <span style="color:burlywood">Data Frames and Plotting</span>

###### Introduction: This post will explore the intersection of plotting and data frames and how to create different kinds of plots depending on the type of data we are looking at.

#### <span style="color:burlywood">Background:</span>

###### We have learned quite a bit about data frames in class so far including how to manipulate, access, and create tables of data. We have even looked at plotting some data frames and visual representations of various forms of data. In this post, I would like to learn furthur how to plot data frames and in specific which types of visual representation fit particular types of data.

#### <span style="color:burlywood">Examples:</span>

###### Let's start by creating a sample data frame and thinking about how we can represent this in different ways:

##### <span style="color:burlywood">(Example 1) Automobile Land Speed Records from 1898 automobile race:</span>

``` r
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
#creating vectors with each set of data 
speed <- c(407.447, 413.199, 434.22, 468.719, 526.277, 536.712, 555.127, 576.553, 600.601, 622.407, 633.468, 763.035)
driver <- c('Craig Breedlove', 'Tom Green', 'Art Arfons', 'Craig Breedlove', 'Craig Breedlove', 'Art Arfons', 'Craig Breedlove','Art Arfons','Craig Breedlove', 'Gary Gabelich', 'Richard Noble', 'Andy Green')
car <- c('Spirit of America', 'Wingfoot Express', 'Green Monster', 'Spirit of America', 'Spirit of America', 'Green Monster', 'Spirit of America, Sonic 1', 'Green Monster', 'Spirit of America, Sonic 1', 'Blue Flame', 'Thrust 2', 'Thrust SSC')
engine <- c('GE J47', 'WE J46', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'GE J79', 'Rocket', 'RR RG 146', 'RR Spey')

date <- c('8/5/63', '10/2/64', '10/5/64', '10/13/64', '10/15/65', '10/27/65', '11/2/65', '11/7/65', '11/15/65','10/23/70','10/4/83', '10/15/97')
#compiling the vectors into a data frame 
auto_dat <- data.frame(speed, driver, car, engine, date)
#displaying the data frame 
auto_dat 
```

    ##      speed          driver                        car    engine     date
    ## 1  407.447 Craig Breedlove          Spirit of America    GE J47   8/5/63
    ## 2  413.199       Tom Green           Wingfoot Express    WE J46  10/2/64
    ## 3  434.220      Art Arfons              Green Monster    GE J79  10/5/64
    ## 4  468.719 Craig Breedlove          Spirit of America    GE J79 10/13/64
    ## 5  526.277 Craig Breedlove          Spirit of America    GE J79 10/15/65
    ## 6  536.712      Art Arfons              Green Monster    GE J79 10/27/65
    ## 7  555.127 Craig Breedlove Spirit of America, Sonic 1    GE J79  11/2/65
    ## 8  576.553      Art Arfons              Green Monster    GE J79  11/7/65
    ## 9  600.601 Craig Breedlove Spirit of America, Sonic 1    GE J79 11/15/65
    ## 10 622.407   Gary Gabelich                 Blue Flame    Rocket 10/23/70
    ## 11 633.468   Richard Noble                   Thrust 2 RR RG 146  10/4/83
    ## 12 763.035      Andy Green                 Thrust SSC   RR Spey 10/15/97

###### Let's try graphing this data in a few different ways:

``` r
#Driver vs. Speed on a Scatterplot
ggplot(auto_dat, aes(x=driver, y=speed)) + geom_text(aes(label=car), size=3) + ggtitle("Drivers VS Speed With Car Names as Labels") + theme(plot.title = element_text(hjust = 0.5))
```

![](post01_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
#Engine vs. Speed on a Barplot 
eng_dat <- select(auto_dat, speed, engine)
eng_dat <- arrange(auto_dat, speed)
barplot(eng_dat$speed, main= "Engine VS Speed", names.arg = eng_dat$engine)
```

![](post01_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-2.png)

###### In this way we can use many of the graphing methods we have already learned in class to represent the same data in different ways, depending on which relationships we would like to furthur explore. Next, let's look at a new plotting function that I discovered in doing some furthur research on R. This function is called dygraph() and it is a plotting function which allows one to handle large sets of data easily, as well as provides the means to chart time-series data in R.

#### References

-   <http://www.sedl.org/afterschool/toolkits/science/pdf/ast_sci_data_tables_sample.pdf>
-   <https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2>
-   <http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf>
