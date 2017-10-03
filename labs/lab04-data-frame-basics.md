Lab 4: Data Frame Basics
================
Gaston Sanchez

> ### Learning Objectives:
>
> -   Get started with data frames
> -   Understand basic operations
> -   Understand bracket and dollar notations

------------------------------------------------------------------------

Manipulating Data Frames
------------------------

The most common format/structure for a data set is a tabular format: with row and columns (like a spreadsheet). When your data is in this shape, most of the time you will work with R **data frames** (or similar rectangular structures like a `"matrix"`, `"table"`, etc).

Learning how to manipulate data tables is among the most important *data computing* basic skills. The traditional way of manipulating data frames in R is based on bracket notation, e.g. `dat[ , ]`, to select specific rows, columns, or cells. Also, the use of the dollar `$` operator to handle columns is fundamental. In this part of the lab, you will practice a wide array of data wrangling tasks with the so-called bracket notation, and the dollar operator.

I should say that there are alternative ways for manipulating tables in R. Among the most recent paradigms, there is the **plying** framework devised by Hadley Wickham. From his doctoral research, the first *plyr* tools were available in the packages `"plyr"` and `"reshape"`. Nowadays we have the `"reshape2"` package, and the extremely popular package `"dplyr"` (among other packages). You will have time to learn more about `"dplyr"` in the next weeks. In the meantime, take some time to understand more about the bracket notation.

Creating data frames
--------------------

Most of the (raw) data tables you will be working with will already be in some data file. However, from time to time you will face the need of creating some sort of data table in R. In these situations, you will likely have to create such table with a data frame. So let's look at various ways to "manually"" create a data frame.

**Option 1**: The primary option to build a data frame is with `data.frame()`. You pass a series of vectors (or factors), of the same length, separated by commas. Each vector (or factor) will become a column in the generated data frame. Preferably, give names to each column, like `col1`, `col2`, and `col3`, in the example below:

``` r
# creating a basic data frame
my_table1 <- data.frame(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE)
)

my_table1
```

    ##   col1 col2  col3
    ## 1    A   10  TRUE
    ## 2    B   20  TRUE
    ## 3    C   30 FALSE
    ## 4    D   40  TRUE
    ## 5    E   50 FALSE

**Option 2**: Another way to create data frames is with a `list` containing vectors or factors (of the same length), which then you convert to a data.frame with `data.frame()`:

``` r
# another way to create a basic data frame
my_list <- list(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE)
)

my_table2 <- data.frame(my_list)

my_table2
```

    ##   col1 col2  col3
    ## 1    A   10  TRUE
    ## 2    B   20  TRUE
    ## 3    C   30 FALSE
    ## 4    D   40  TRUE
    ## 5    E   50 FALSE

Remember that a `data.frame` is nothing more than a `list`. So as long as the elements in the list (vectors or factors) are of the same length, we can simply convert the list into a data frame.

By default, `data.frame()` converts character vectors into factors. You can check that by exmining the structure of the data frame with `str()`:

``` r
str(my_table2)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ col1: Factor w/ 5 levels "A","B","C","D",..: 1 2 3 4 5
    ##  $ col2: num  10 20 30 40 50
    ##  $ col3: logi  TRUE TRUE FALSE TRUE FALSE

To prevent `data.frame()` from converting strings into factors, you must use the argument `stringsAsFactors = FALSE`

``` r
# strings as strings (not as factors)
my_table3 <- data.frame(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

str(my_table3)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ col1: chr  "A" "B" "C" "D" ...
    ##  $ col2: num  10 20 30 40 50
    ##  $ col3: logi  TRUE TRUE FALSE TRUE FALSE

### Your turn

Here's a table with the starting lineup of the Golden State Warriors:

| Player   | Position | Salary     | Points | PPG  | Rookie |
|----------|----------|------------|--------|------|--------|
| Thompson | SG       | 16,663,575 | 1742   | 22.3 | FALSE  |
| Curry    | PG       | 12,112,359 | 1999   | 25.3 | FALSE  |
| Green    | PF       | 15,330,435 | 776    | 10.2 | FALSE  |
| Durant   | SF       | 26,540,100 | 1555   | 25.1 | FALSE  |
| Pachulia | C        | 2,898,000  | 426    | 6.1  | FALSE  |

-   Start by creating vectors for each of the columns.
-   Use the vectors to create a first data frame with `data.frame()`.
-   Check that this data frame is of class `"data.frame"`, and that it is also a list.
-   Create another data frame by first starting with a `list()`, and then passing the list to `data.frame()`.
-   What would you do to obtain a data frame such that when you check its structure `str()` the variables are:
    -   *Player* as character
    -   *Position* as factor
    -   *Salary* as numeric or real (ignore the commas)
    -   *Points* as integer
    -   *PPG* as numeric or real
    -   *Rookie* as logical
-   Find out how to use the *column binding* function `cbind()` to create a tabular object with the vectors created in step 1 (inspect what class of object is obtained with `cbind()`).
-   How could you convert the object in the previous step into a data frame?

``` r
col1 <- c("Thompson", "Curry", "Green", "Durant", "Pachulia")
col2 <- c("SG", "PG", "PF", "SF", "C")
col3 <- c(16663575, 12112359, 15330435, 26540100, 2898000)
col4 <- c(1742, 1999, 776, 1555, 426)
col5 <- c(22.3, 25.3, 10.2, 25.1, 6.1)
col6 <- c(FALSE, FALSE, FALSE, FALSE, FALSE)

mytable_1 <- data.frame(col1=col1, col2=col2, col3=col3, col4=col4, col5=col5, col6=col6)
class(mytable_1)
```

    ## [1] "data.frame"

``` r
is.list(mytable_1)
```

    ## [1] TRUE

``` r
mytable_2 <- data.frame(list(col1=col1, col2=col2, col3=col3, col4=col4, col5=col5, col6=col6))

#In order to maintain the structures of player as a character, position as a factor, salary as numeric or real, points as integers, PPG as numeric or real, and Rookie as logical, I would set the stringsAsFactors parameter in data.fram to equal FALSE. Then I would apply as.factor to the position column, and as.integer to the points column. 

mytable_3 <- data.frame(list(col1=col1, col2=as.factor(col2), col3=col3, col4=as.integer(col4), col5=col5, col6=col6), stringsAsFactors = FALSE)
str(mytable_3)
```

    ## 'data.frame':    5 obs. of  6 variables:
    ##  $ col1: chr  "Thompson" "Curry" "Green" "Durant" ...
    ##  $ col2: Factor w/ 5 levels "C","PF","PG",..: 5 3 2 4 1
    ##  $ col3: num  16663575 12112359 15330435 26540100 2898000
    ##  $ col4: int  1742 1999 776 1555 426
    ##  $ col5: num  22.3 25.3 10.2 25.1 6.1
    ##  $ col6: logi  FALSE FALSE FALSE FALSE FALSE

``` r
table_cbind <- cbind(col1=col1, col2=col2, col3=col3, col4=col4, col5=col5, col6=col6)
class(table_cbind)
```

    ## [1] "matrix"

``` r
table_dataf <- as.data.frame(table_cbind)
class(table_dataf)
```

    ## [1] "data.frame"

------------------------------------------------------------------------

Basic Operations with Data Frames
---------------------------------

Now that you have seen some ways to create data frames, let's discuss a number of basic manipulations of data frames. I will show you some examples and then you'll have the chance to put in practice the following operations:

-   Selecting table elements:
    -   select a given cell
    -   select a set of cells
    -   select a given row
    -   select a set of rows
    -   select a given column
    -   select a set of columns
-   Adding a new column
-   Deleting a new column
-   Renaming a column
-   Moving a column
-   Transforming a column

Let's say you have a data frame `tbl` with the lineup of the Golden State Warriors:

        player position   salary points  ppg rookie
    1 Thompson       SG 16663575   1742 22.3  FALSE
    2    Curry       PG 12112359   1999 25.3  FALSE
    3    Green       PF 15330435    776 10.2  FALSE
    4   Durant       SF 26540100   1555 25.1  FALSE
    5 Pachulia        C  2898000    426  6.1  FALSE

#### Selecting elements

The data frame `tbl` is a 2-dimensional object: the 1st dimension corresponds to the rows, while the 2nd dimension corresponds to the columns. Because `tbl` has two dimensions, the bracket notation involves working with the data frame in this form: `tbl[ , ]`. In other words, you have to specify values inside the brackets for the 1st index, and the 2nd index: `tbl[index1, index2]`.

``` r
# select value in row 1 and column 1
tbl[1,1]
```

    ## [1] "Thompson"

``` r
# select value in row 2 and column 5
tbl[2,5]
```

    ## [1] 25.3

``` r
# select values in these cells
tbl[1:3,3:5]
```

    ##     salary points  ppg
    ## 1 16663575   1742 22.3
    ## 2 12112359   1999 25.3
    ## 3 15330435    776 10.2

If no value is specified for `index1` then all rows are included. Likewise, if no value is specified for `index2` then all columns are included.

``` r
# selecting first row
tbl[1, ]
```

    ##     player position   salary points  ppg rookie
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE

``` r
# selecting third row
tbl[3, ]
```

    ##   player position   salary points  ppg rookie
    ## 3  Green       PF 15330435    776 10.2  FALSE

``` r
# selecting second column
tbl[ ,2]
```

    ## [1] "SG" "PG" "PF" "SF" "C"

``` r
# selecting columns 3 to 5
tbl[ ,3:5]
```

    ##     salary points  ppg
    ## 1 16663575   1742 22.3
    ## 2 12112359   1999 25.3
    ## 3 15330435    776 10.2
    ## 4 26540100   1555 25.1
    ## 5  2898000    426  6.1

#### Adding a column

Perhaps the simplest way to add a column is with the dollar operator `$`. You just need to give a name for the new column, and assign a vector (or factor):

``` r
# adding a column
tbl$new_column <- c('a', 'e', 'i', 'o', 'u')
tbl
```

    ##     player position   salary points  ppg rookie new_column
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE          a
    ## 2    Curry       PG 12112359   1999 25.3  FALSE          e
    ## 3    Green       PF 15330435    776 10.2  FALSE          i
    ## 4   Durant       SF 26540100   1555 25.1  FALSE          o
    ## 5 Pachulia        C  2898000    426  6.1  FALSE          u

Another way to add a column is with the *column binding* function `cbind()`:

``` r
# vector of weights
weight <- c(215, 190, 230, 240, 270)

# adding weights to tbl
tbl <- cbind(tbl, weight)
tbl
```

    ##     player position   salary points  ppg rookie new_column weight
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE          a    215
    ## 2    Curry       PG 12112359   1999 25.3  FALSE          e    190
    ## 3    Green       PF 15330435    776 10.2  FALSE          i    230
    ## 4   Durant       SF 26540100   1555 25.1  FALSE          o    240
    ## 5 Pachulia        C  2898000    426  6.1  FALSE          u    270

#### Deleting a column

The inverse operation of adding a column consists of **deleting** a column. This is possible with the `$` dollar operator. For instance, say you want to remove the column `new_column`. Use the `$` operator to select this column, and assign it the value `NULL` (think of this as *NULLifying* a column):

``` r
# deleting a column
tbl$new_column <- NULL
tbl
```

    ##     player position   salary points  ppg rookie weight
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE    215
    ## 2    Curry       PG 12112359   1999 25.3  FALSE    190
    ## 3    Green       PF 15330435    776 10.2  FALSE    230
    ## 4   Durant       SF 26540100   1555 25.1  FALSE    240
    ## 5 Pachulia        C  2898000    426  6.1  FALSE    270

#### Renaming a column

What if you want to rename a column? There are various options to do this. One way is by changing the column`names` attribute:

``` r
# attributes
attributes(tbl)
```

    ## $names
    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rookie"  
    ## [7] "weight"  
    ## 
    ## $row.names
    ## [1] 1 2 3 4 5
    ## 
    ## $class
    ## [1] "data.frame"

which is more commonly accessed with the `names()` function:

``` r
# column names
names(tbl)
```

    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rookie"  
    ## [7] "weight"

Notice that `tbl` has a list of attributes. The element `names` is the vector of column names.

You can directly modify the vector of `names`; for example let's change `rookie` to `rooky`:

``` r
# changing rookie to rooky
attributes(tbl)$names[6] <- "rooky"

# display column names
names(tbl)
```

    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rooky"   
    ## [7] "weight"

By the way: this way of changing the name of a variable is very low level, and probably unfamiliar to most useRs.

#### Moving a column

A more challenging operation is when you want to move a column to a different position. What if you want to move `salary` to the last position (last column)? One option is to create a vector of column names in the desired order, and then use this vector (for the index of columns) to reassign the data frame like this:

``` r
reordered_names <- c("player", "position", "points", "ppg", "rooky", "weight", "salary")

# moving salary at the end
tbl <- tbl[ ,reordered_names]
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16663575
    ## 2    Curry       PG   1999 25.3 FALSE    190 12112359
    ## 3    Green       PF    776 10.2 FALSE    230 15330435
    ## 4   Durant       SF   1555 25.1 FALSE    240 26540100
    ## 5 Pachulia        C    426  6.1 FALSE    270  2898000

#### Transforming a column

A more common operation than deleting or moving a column, is to transform the values in a column. This can be easily accomplished with the `$` operator. For instance, let's say that we want to transform `salary` from dollars to millions of dollars:

``` r
# converting salary in millions of dollars
tbl$salary <- tbl$salary / 1000000
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

Likewise, instead of using the `$` operator, you can refer to the column using bracket notation. Here's how to transform weight from pounds to kilograms (1 pound = 0.453592 kilograms):

``` r
# weight in kilograms
tbl[ ,"weight"] <- tbl[ ,"weight"] * 0.453592
tbl
```

    ##     player position points  ppg rooky    weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE  97.52228 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE  86.18248 12.11236
    ## 3    Green       PF    776 10.2 FALSE 104.32616 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE 108.86208 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE 122.46984  2.89800

There is also the `transform()` function which transform values *interactively*, that is, temporarily:

``` r
# transform weight to inches
transform(tbl, weight = weight / 0.453592)
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

`transform()` does its job of modifying the values of `weight` but only temporarily; if you inspect `tbl` you'll see what this means:

``` r
# did weight really change?
tbl
```

    ##     player position points  ppg rooky    weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE  97.52228 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE  86.18248 12.11236
    ## 3    Green       PF    776 10.2 FALSE 104.32616 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE 108.86208 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE 122.46984  2.89800

To make the changes permanent with `transform()`, you need to reaassign them to the data frame:

``` r
# transform weight to inches (permanently)
tbl <- transform(tbl, weight = weight / 0.453592)
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

------------------------------------------------------------------------

NBA Players Data
----------------

Now that you've seen some of the most basic operations to maipulate data frames, let's apply them on a data set about NBA players. The corresponding data file is `nba2017-players.csv`, located in the `data/` folder of the course github repository. This file contains 15 variables measured on 441 players.

First download a copy of the csv file to your computer.

``` r
# download csv file into your working directory
csv <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv"
download.file(url = csv, destfile = 'nba2017-players.csv')
```

To import the data in R you can use the function `read.csv()`:

``` r
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)
```

Notice that I'm specifying the argument `stringsAsFactors = FALSE` to avoid the conversion of characters into R factors. Why do you think this is a good practice?

All the default reading table functions generate a data frame. Typically, everytime I read a new data set which I'm not familiar with, or a data set that I haven't worked on in a long time, I always like to call a couple of functions to inspect its contents:

-   `dim()`
-   `head()`
-   `tail()`
-   `str()`
-   `summary()`

A first check-up is to examine the dimensions of the data frame with `dim()`:

``` r
# dimensions (# of rows, # of columns)
dim(dat)
```

    ## [1] 441  15

If you know in advanced how many rows and columns are in the data table, this is a good way to make sure that R was able to read all the records.

Then, depending on the size of the data, you may want to take a peek at its contents with `head()` or `tail()`, just to get an idea of what the data looks like:

``` r
# display first few rows
head(dat)
```

    ##              player team position height weight age experience
    ## 1        Al Horford  BOS        C     82    245  30          9
    ## 2      Amir Johnson  BOS       PF     81    240  29         11
    ## 3     Avery Bradley  BOS       SG     74    180  26          6
    ## 4 Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5      Gerald Green  BOS       SF     79    205  31          9
    ## 6     Isaiah Thomas  BOS       PG     69    185  27          5
    ##                         college   salary games minutes points points3
    ## 1         University of Florida 26540100    68    2193    952      86
    ## 2                               12000000    80    1608    520      27
    ## 3 University of Texas at Austin  8269663    55    1835    894     108
    ## 4      University of Notre Dame  1450000     5      17     10       1
    ## 5                                1410598    47     538    262      39
    ## 6      University of Washington  6587132    76    2569   2199     245
    ##   points2 points1
    ## 1     293     108
    ## 2     186      67
    ## 3     251      68
    ## 4       2       3
    ## 5      56      33
    ## 6     437     590

For a more detailed description of how R is treating the data type in each column, you should use the structure function `str()`.

``` r
# check the structure
str(dat, vec.len = 1)
```

    ## 'data.frame':    441 obs. of  15 variables:
    ##  $ player    : chr  "Al Horford" ...
    ##  $ team      : chr  "BOS" ...
    ##  $ position  : chr  "C" ...
    ##  $ height    : int  82 81 ...
    ##  $ weight    : int  245 240 ...
    ##  $ age       : int  30 29 ...
    ##  $ experience: int  9 11 ...
    ##  $ college   : chr  "University of Florida" ...
    ##  $ salary    : num  26540100 ...
    ##  $ games     : int  68 80 ...
    ##  $ minutes   : int  2193 1608 ...
    ##  $ points    : int  952 520 ...
    ##  $ points3   : int  86 27 ...
    ##  $ points2   : int  293 186 ...
    ##  $ points1   : int  108 67 ...

This function `str()` displays the dimensions of the data frame, and then a list with the name of all the variables, and their data types (e.g. `chr` character, `num` real, etc). The argument `vec.len = 1` indicates that just the first element in each column should be displayed.

When working with data frames, remember to always take some time inspecting the contents, and checking how R is handling the data types. It is in these early stages of data exploration that you can catch potential issues in order to avoid disastrous consequences or bugs in subsequent stages.

------------------------------------------------------------------------

### Your turn:

Use bracket notation, the dollar operator, as well as concepts of logical subsetting and indexing to:

-   Display the last 5 rows of the data.

-   Display those rows associated to players having height less than 70 inches tall.

-   Of those players that are centers (position `C`), display their names and salaries.

-   Create a data frame `durant` with Kevin Durant's information (i.e. row).

-   Create a data frame `ucla` with the data of players from college UCLA ("University of California, Los Angeles").

-   Create a data frame `rookies` with those players with 0 years of experience.

-   Create a data frame `rookie_centers` with the data of Center rookie players.

-   Create a data frame `top_players` for players with more than 50 games and more than 100 minutes played.

-   What's the largest height value?

-   What's the minimum height value?

-   What's the overall average height?

-   Who is the tallest player?

-   Who is the shortest player?

-   Which are the unique teams?

-   How many different teams?

-   Who is the oldest player?

-   What is the median salary of all players?

-   What is the median salary of the players with 10 years of experience or more?

-   What is the median salary of Shooting Guards (SG) and Point Guards (PG)?

-   What is the median salary of Power Forwards (PF), 29 years or older, and 74 inches tall or less?

-   How many players scored 4 points or less?

-   Who are those players who scored 4 points or less?

-   Who is the player with 0 points?

-   How many players are from "University of California, Berkeley"?

-   Are there any players from "University of Notre Dame"? If so how many and who are they?

-   Are there any players with weight greater than 260 pounds? If so how many and who are they?

-   How many players did not attend a college in the US?

-   Who is the player with the maximum rate of points per minute?

-   Who is the player with the maximum rate of three-points per minute?

-   Who is the player with the maximum rate of two-points per minute?

-   Who is the player with the maximum rate of one-points (free-throws) per minute?

-   Create a data frame `gsw` with the name, height, weight of Golden State Warriors (GSW)

-   Display the data in `gsw` sorted by height in increasing order (hint: see `?sort` and `?order`)

-   Display the data in gsw by weight in decreasing order (hint: see `?sort` and `?order`)

-   Display the player name, team, and salary, of the top 5 highest-paid players (hint: see `?sort` and `?order`)

-   Display the player name, team, and points3, of the top 10 three-point players (hint: see `?sort` and `?order`)

``` r
dat[437:441, ] #last 5 rows of the data 
```

    ##              player team position height weight age experience
    ## 437 Marquese Chriss  PHO       PF     82    233  19          0
    ## 438    Ronnie Price  PHO       PG     74    190  33         11
    ## 439     T.J. Warren  PHO       SF     80    230  23          2
    ## 440      Tyler Ulis  PHO       PG     70    150  21          0
    ## 441  Tyson Chandler  PHO        C     85    240  34         15
    ##                             college   salary games minutes points points3
    ## 437        University of Washington  2941440    82    1743    753      72
    ## 438       Utah Valley State College   282595    14     134     14       3
    ## 439 North Carolina State University  2128920    66    2048    951      26
    ## 440          University of Kentucky   918369    61    1123    444      21
    ## 441                                 12415000    47    1298    397       0
    ##     points2 points1
    ## 437     212     113
    ## 438       1       3
    ## 439     377     119
    ## 440     163      55
    ## 441     153      91

``` r
dat[dat$height< 70, ]
```

    ##           player team position height weight age experience
    ## 6  Isaiah Thomas  BOS       PG     69    185  27          5
    ## 24    Kay Felder  CLE       PG     69    176  21          0
    ##                     college  salary games minutes points points3 points2
    ## 6  University of Washington 6587132    76    2569   2199     245     437
    ## 24       Oakland University  543471    42     386    166       7      55
    ##    points1
    ## 6      590
    ## 24      35

``` r
cbind( dat[dat$position =='C', 1], dat[dat$position =='C', 9])
```

    ##       [,1]                   [,2]      
    ##  [1,] "Al Horford"           "26540100"
    ##  [2,] "Kelly Olynyk"         "3094014" 
    ##  [3,] "Tyler Zeller"         "8e+06"   
    ##  [4,] "Channing Frye"        "7806971" 
    ##  [5,] "Edy Tavares"          "5145"    
    ##  [6,] "Tristan Thompson"     "15330435"
    ##  [7,] "Jakob Poeltl"         "2703960" 
    ##  [8,] "Jonas Valanciunas"    "14382022"
    ##  [9,] "Lucas Nogueira"       "1921320" 
    ## [10,] "Daniel Ochefu"        "543471"  
    ## [11,] "Ian Mahinmi"          "15944154"
    ## [12,] "Jason Smith"          "5e+06"   
    ## [13,] "Marcin Gortat"        "1.2e+07" 
    ## [14,] "Dwight Howard"        "23180275"
    ## [15,] "Mike Muscala"         "1015696" 
    ## [16,] "Greg Monroe"          "17100000"
    ## [17,] "John Henson"          "12517606"
    ## [18,] "Thon Maker"           "2568600" 
    ## [19,] "Al Jefferson"         "10230179"
    ## [20,] "Myles Turner"         "2463840" 
    ## [21,] "Cristiano Felicio"    "874636"  
    ## [22,] "Joffrey Lauvergne"    "1709720" 
    ## [23,] "Robin Lopez"          "13219250"
    ## [24,] "Hassan Whiteside"     "22116750"
    ## [25,] "Udonis Haslem"        "4e+06"   
    ## [26,] "Willie Reed"          "1015696" 
    ## [27,] "Andre Drummond"       "22116750"
    ## [28,] "Aron Baynes"          "6500000" 
    ## [29,] "Boban Marjanovic"     "7e+06"   
    ## [30,] "Frank Kaminsky"       "2730000" 
    ## [31,] "Miles Plumlee"        "12500000"
    ## [32,] "Joakim Noah"          "1.7e+07" 
    ## [33,] "Kyle O'Quinn"         "3900000" 
    ## [34,] "Marshall Plumlee"     "543471"  
    ## [35,] "Willy Hernangomez"    "1375000" 
    ## [36,] "Bismack Biyombo"      "1.7e+07" 
    ## [37,] "Nikola Vucevic"       "11750000"
    ## [38,] "Stephen Zimmerman"    "950000"  
    ## [39,] "Jahlil Okafor"        "4788840" 
    ## [40,] "Joel Embiid"          "4826160" 
    ## [41,] "Richaun Holmes"       "1025831" 
    ## [42,] "Shawn Long"           "89513"   
    ## [43,] "Tiago Splitter"       "8550000" 
    ## [44,] "Brook Lopez"          "21165675"
    ## [45,] "Justin Hamilton"      "3e+06"   
    ## [46,] "Damian Jones"         "1171560" 
    ## [47,] "David West"           "1551659" 
    ## [48,] "JaVale McGee"         "1403611" 
    ## [49,] "Kevon Looney"         "1182840" 
    ## [50,] "Zaza Pachulia"        "2898000" 
    ## [51,] "Dewayne Dedmon"       "2898000" 
    ## [52,] "Joel Anthony"         "165952"  
    ## [53,] "Pau Gasol"            "15500000"
    ## [54,] "Chinanu Onuaku"       "543471"  
    ## [55,] "Clint Capela"         "1296240" 
    ## [56,] "Montrezl Harrell"     "1e+06"   
    ## [57,] "DeAndre Jordan"       "21165675"
    ## [58,] "Diamond Stone"        "543471"  
    ## [59,] "Marreese Speights"    "1403611" 
    ## [60,] "Jeff Withey"          "1015696" 
    ## [61,] "Rudy Gobert"          "2121288" 
    ## [62,] "Enes Kanter"          "17145838"
    ## [63,] "Steven Adams"         "3140517" 
    ## [64,] "Deyonta Davis"        "1369229" 
    ## [65,] "Marc Gasol"           "21165675"
    ## [66,] "Jusuf Nurkic"         "1921320" 
    ## [67,] "Mason Plumlee"        "2328530" 
    ## [68,] "Nikola Jokic"         "1358500" 
    ## [69,] "Roy Hibbert"          "5e+06"   
    ## [70,] "Alexis Ajinca"        "4600000" 
    ## [71,] "Anthony Davis"        "22116750"
    ## [72,] "DeMarcus Cousins"     "16957900"
    ## [73,] "Omer Asik"            "9904494" 
    ## [74,] "A.J. Hammons"         "650000"  
    ## [75,] "Dwight Powell"        "8375000" 
    ## [76,] "Nerlens Noel"         "4384490" 
    ## [77,] "Salah Mejri"          "874636"  
    ## [78,] "Georgios Papagiannis" "2202240" 
    ## [79,] "Kosta Koufos"         "8046500" 
    ## [80,] "Willie Cauley-Stein"  "3551160" 
    ## [81,] "Cole Aldrich"         "7643979" 
    ## [82,] "Jordan Hill"          "3911380" 
    ## [83,] "Karl-Anthony Towns"   "5960160" 
    ## [84,] "Ivica Zubac"          "1034956" 
    ## [85,] "Tarik Black"          "6191000" 
    ## [86,] "Timofey Mozgov"       "1.6e+07" 
    ## [87,] "Alan Williams"        "874636"  
    ## [88,] "Alex Len"             "4823621" 
    ## [89,] "Tyson Chandler"       "12415000"

``` r
KD <- data.frame(c(dat[dat$player=='Kevin Durant', ]))
ucla <- data.frame(c(dat[dat$college=="University of California, Los Angeles", ]))
rookies <- data.frame(c(dat[dat$experience==0, ]))
rookie_centers <- data.frame(c(rookies[rookies$position=='C', ]))
top_players <- data.frame(c(dat[dat$games>50 & dat$minutes>100, ]))
max(dat$height)
```

    ## [1] 87

``` r
min(dat$height) 
```

    ## [1] 69

``` r
mean(dat$height)
```

    ## [1] 79.1542

``` r
dat$player[dat$height==max(dat$height)]
```

    ## [1] "Edy Tavares"        "Boban Marjanovic"   "Kristaps Porzingis"

``` r
dat$player[dat$height==min(dat$height)]
```

    ## [1] "Isaiah Thomas" "Kay Felder"

``` r
unique_teams <- unique(c(dat[ , 'team']), incomparables=FALSE)
length(unique_teams)
```

    ## [1] 30

``` r
dat$player[dat$age==max(dat$age)]
```

    ## [1] "Vince Carter"

``` r
median(dat$salary)
```

    ## [1] 3500000

``` r
median(dat[dat$experience>9, 'salary'])
```

    ## [1] 5644034

``` r
median(dat[dat$position=='SG'|dat$position=='PG', 'salary'])
```

    ## [1] 3230690

``` r
median(dat[dat$position=='PF'|dat$age>28|dat$height<75, 'salary']) 
```

    ## [1] 4276320

``` r
length(c(dat[dat$points<5, 'player']))
```

    ## [1] 7

``` r
dat[dat$points<5, 'player']
```

    ## [1] "Chris McCullough" "Michael Gbinije"  "Patricio Garino" 
    ## [4] "Isaiah Taylor"    "Brice Johnson"    "Roy Hibbert"     
    ## [7] "Elijah Millsap"

``` r
dat[dat$points==0, 'player']
```

    ## [1] "Patricio Garino"

``` r
length(c(dat[dat$college=="University of California, Berkeley", 'player']))
```

    ## [1] 0

``` r
#Are there players from University of Notre Dame?  
length(c(dat[dat$college=="University of Notre Dame",'player'])) >0
```

    ## [1] TRUE

``` r
length(dat[dat$college=="University of Notre Dame",'player']) 
```

    ## [1] 3

``` r
dat[dat$college=="University of Notre Dame",'player']
```

    ## [1] "Demetrius Jackson" "Jerian Grant"      "Pat Connaughton"

``` r
#Are there players with weight greater than 260 pounts? 
length(dat[dat$weight>260, 'player']) > 0 
```

    ## [1] TRUE

``` r
length(dat[dat$weight>260, 'player'])
```

    ## [1] 21

``` r
dat[dat$weight>260, 'player']
```

    ##  [1] "Jonas Valanciunas" "Dwight Howard"     "Greg Monroe"      
    ##  [4] "Al Jefferson"      "Kevin Seraphin"    "Cristiano Felicio"
    ##  [7] "Hassan Whiteside"  "Andre Drummond"    "Boban Marjanovic" 
    ## [10] "Jahlil Okafor"     "Brook Lopez"       "JaVale McGee"     
    ## [13] "Zaza Pachulia"     "DeAndre Jordan"    "Derrick Favors"   
    ## [16] "Jusuf Nurkic"      "Roy Hibbert"       "DeMarcus Cousins" 
    ## [19] "Kosta Koufos"      "Ivica Zubac"       "Timofey Mozgov"

``` r
length(dat[dat$college == "", 'player'])
```

    ## [1] 85

``` r
dat$ptspermin <- c(dat$points/dat$minutes)
dat[dat$ptspermin==max(dat$ptspermin), 'player']
```

    ## [1] "Russell Westbrook"

``` r
dat$threeptspermin <- c(dat$points3/dat$minutes)
dat[dat$threeptspermin==max(dat$threeptspermin), 'player']
```

    ## [1] "Stephen Curry"

``` r
dat$twoptspermin <- c(dat$points2/dat$minutes)
dat[dat$twoptspermin==max(dat$twoptspermin), 'player']
```

    ## [1] "JaVale McGee"

``` r
dat$oneptspermin <- c(dat$points1/dat$minutes)
dat[dat$oneptspermin==max(dat$oneptspermin), 'player']
```

    ## [1] "Russell Westbrook"

``` r
GSW_table <- data.frame(cbind(dat[dat$team=="GSW",'player'],dat[dat$team=="GSW", 'height'], dat[dat$team=="GSW", 'weight']))
GSW_table_byheight <- transform(GSW_table, X2= sort(X2, decreasing=FALSE))
GSW_table_byweight <- transform(GSW_table, X3= sort(X3, decreasing=TRUE))
```

Group By
--------

Group-by operations are very common in data analytics. Without dedicated functions, these operations tend to be very hard (labor intensive).

**Quick try**: Using just bracket notation, try to create a data frame with two columns: the team name, and the team payroll (addition of all player salaries).

So what functions can you use in R to perform group by operations? In base R, the main function for group-by operations is `aggregate()`.

Here's an example using `aggregate()` to get the median salary, grouped by team:

``` r
aggregate(dat$salary, by = list(dat$team), FUN = median)
```

    ##    Group.1       x
    ## 1      ATL 3279291
    ## 2      BOS 4743000
    ## 3      BRK 1790902
    ## 4      CHI 2112480
    ## 5      CHO 6000000
    ## 6      CLE 5239437
    ## 7      DAL 2898000
    ## 8      DEN 3500000
    ## 9      DET 4625000
    ## 10     GSW 1551659
    ## 11     HOU 1508400
    ## 12     IND 4000000
    ## 13     LAC 3500000
    ## 14     LAL 5281680
    ## 15     MEM 3332940
    ## 16     MIA 3449000
    ## 17     MIL 4184870
    ## 18     MIN 3650000
    ## 19     NOP 3789125
    ## 20     NYK 2898000
    ## 21     OKC 3140517
    ## 22     ORL 5000000
    ## 23     PHI 2318280
    ## 24     PHO 2941440
    ## 25     POR 4943123
    ## 26     SAC 5200000
    ## 27     SAS 2898000
    ## 28     TOR 5300000
    ## 29     UTA 2433334
    ## 30     WAS 4365326

The same example above can also be obtained with `aggreagte()` using formula notation like this:

``` r
aggregate(salary ~ team, data = dat, FUN = median)
```

    ##    team  salary
    ## 1   ATL 3279291
    ## 2   BOS 4743000
    ## 3   BRK 1790902
    ## 4   CHI 2112480
    ## 5   CHO 6000000
    ## 6   CLE 5239437
    ## 7   DAL 2898000
    ## 8   DEN 3500000
    ## 9   DET 4625000
    ## 10  GSW 1551659
    ## 11  HOU 1508400
    ## 12  IND 4000000
    ## 13  LAC 3500000
    ## 14  LAL 5281680
    ## 15  MEM 3332940
    ## 16  MIA 3449000
    ## 17  MIL 4184870
    ## 18  MIN 3650000
    ## 19  NOP 3789125
    ## 20  NYK 2898000
    ## 21  OKC 3140517
    ## 22  ORL 5000000
    ## 23  PHI 2318280
    ## 24  PHO 2941440
    ## 25  POR 4943123
    ## 26  SAC 5200000
    ## 27  SAS 2898000
    ## 28  TOR 5300000
    ## 29  UTA 2433334
    ## 30  WAS 4365326

Here's another example using `aggregate()` to get the average height and average weight, grouped by position:

``` r
aggregate(dat[ ,c('height', 'weight')], by = list(dat$position), FUN = mean)
```

    ##   Group.1   height   weight
    ## 1       C 83.25843 250.7978
    ## 2      PF 81.50562 235.8539
    ## 3      PG 74.30588 188.5765
    ## 4      SF 79.63855 220.4699
    ## 5      SG 77.02105 204.7684

The same example above can also be obtained with `aggreagte()` using formula notation like this:

``` r
aggregate(. ~ position, data = dat[ ,c('position', 'height', 'weight')],
          FUN = mean)
```

    ##   position   height   weight
    ## 1        C 83.25843 250.7978
    ## 2       PF 81.50562 235.8539
    ## 3       PG 74.30588 188.5765
    ## 4       SF 79.63855 220.4699
    ## 5       SG 77.02105 204.7684

### Your turn

-   Create a data frame with the average height, average weight, and average age, grouped by position

-   Create a data frame with the average height, average weight, and average age, grouped by team

-   Create a data frame with the average height, average weight, and average age, grouped by team and position.

-   Difficult: Create a data frame with the minimum salary, median salary, mean salary, and maximum salary, grouped by team and position.

------------------------------------------------------------------------
