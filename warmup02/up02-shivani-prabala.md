warmup02
================

R Markdown
----------

``` r
load("/Users/shivaniprabala/Downloads/nba2017-salary-points.RData")
```

### Inspecting the objects in the .RData file:

``` r
#I have all the objects described in the data dictionary. 
#The classes of the objects are as follows (object:class) : player:character, team:factor, position:character, experience:character, salary:numeric, points:integer, points1:integer, points2:integer, and points3:integer.
#The only non-vector is team. The only factor is team. There are no lists.
#Player, team, and position are categorical while experience, salary, points, points1, points2, and points3 are all quantitative variables.
#All objects have the same length.
```

### Exploratory Data Analysis

#### Quantitative Variable

``` r
summary(salary)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##     5145  1286000  3500000  6187000  9250000 30960000

``` r
mean(salary)
```

    ## [1] 6187014

``` r
sd(salary)
```

    ## [1] 6571890

``` r
min(salary)
```

    ## [1] 5145

``` r
max(salary)
```

    ## [1] 30963450

``` r
median(salary)
```

    ## [1] 3500000

``` r
quantile(salary)
```

    ##       0%      25%      50%      75%     100% 
    ##     5145  1286160  3500000  9250000 30963450

``` r
#The typical values in this vector are integer values that represent the salaries of players in what looks like in millions of dollars. But in general the vectors with numeric/integer values contain numbers. 
#The vector of salaries has a standard deviation of 6571890. 
hist(salary)
```

![](up02-shivani-prabala_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

``` r
boxplot(salary)
```

![](up02-shivani-prabala_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-2.png)

``` r
#DensityPlot
d <- density(salary, )
plot(d)
polygon(d, col="red", border="blue")
```

![](up02-shivani-prabala_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-3.png)

### Analysis:

##### Let's look at the information we have gathered so far:

> -   A quick summary of the salary vector tells us the following information (min, q1, med, mean, q3, max): 5145, 1.28610^{6}, 3.510^{6}, 6.18710^{6}, 9.2510^{6}, 3.09610^{7}.
> -   The mean of the salary vector is $6.187013910^{6}.
> -   The minimum of salary is 5145 and the maximum of salary is 3.09634510^{7}.
> -   The median or center is 3.510^{6}.
> -   The quartiles are as follows: 5145, 1.2861610^{6}, 3.510^{6}, 9.2510^{6}, 3.09634510^{7}.
> -   Looking at the histogram plot, we see that the salary is a right skewed graph, meaning that most people are earning lower salaries as compared to the rest of the data. And that the frequency of higher salaries decreases as salary increases. The boxplot and desity plots reflect the same idea. Another thing to consider is that the standard deviation is quite high because of the few people who earn very large salaries. Their contributions skew this metric. Another notable number is the range, which is also quite large. The highest salary is 3.09634510^{7} while the lowest is 5145 making the range 3.095830510^{7}. The typical measurement is in dollars and the typical interval is about $5000000.

#### Quantitative Variable

``` r
table(team)
```

    ## team
    ## ATL BOS BRK CHI CHO CLE DAL DEN DET GSW HOU IND LAC LAL MEM MIA MIL MIN 
    ##  14  15  15  15  15  15  15  15  15  15  14  14  15  15  15  14  14  14 
    ## NOP NYK OKC ORL PHI PHO POR SAC SAS TOR UTA WAS 
    ##  14  15  15  15  15  15  14  15  15  15  15  14

``` r
prop.table(table(team))
```

    ## team
    ##        ATL        BOS        BRK        CHI        CHO        CLE 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        DAL        DEN        DET        GSW        HOU        IND 
    ## 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 
    ##        LAC        LAL        MEM        MIA        MIL        MIN 
    ## 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 0.03174603 
    ##        NOP        NYK        OKC        ORL        PHI        PHO 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        POR        SAC        SAS        TOR        UTA        WAS 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603

``` r
barplot(prop.table(table(team)))
```

![](up02-shivani-prabala_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

### Analysis:

> ***The numbers in the first table tell us the number of players on each team, and the relative proportions in the second table tells us the number of players on a particular team divided by the total number of players of all teams. So we can see from these numbers that most teams have either 14 or 15 players, and that teams who have 14 players have roughly 3.2% of total players and that teams who have 15 players have roughly 3.4% of total players.***

### Reflection:

> -   Remembering how to write inline code was a little difficult even though we had seen it in class.
> -   Figuring out how to use the different mean, median, min, max, etc. functions was easy even though we hadn't see all of those functions in class. \*I struggled with loading the data because I just copied and pasted the load path from the online Rmd file, but the load file required a full path according to where the file was stored on my computer specifically.
> -   I am not fully understanding the concept of data frames.
> -   The most time consuming part was writing inline code.
> -   No, I did not.
> -   Nope, everything was pretty easy to deal with.

### Experimenting with xtable:

,

``` r
plot(points, salary, type= 'h', col="blue")
```

![](up02-shivani-prabala_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)
