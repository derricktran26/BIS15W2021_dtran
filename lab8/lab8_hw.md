---
title: "Lab 8 Homework"
author: "Derrick Tran"
date: "2021-02-04"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
```

## Install `here`
The package `here` is a nice option for keeping directories clear when loading files. I will demonstrate below and let you decide if it is something you want to use.  

```r
#install.packages("here")
```

## Data
For this homework, we will use a data set compiled by the Office of Environment and Heritage in New South Whales, Australia. It contains the enterococci counts in water samples obtained from Sydney beaches as part of the Beachwatch Water Quality Program. Enterococci are bacteria common in the intestines of mammals; they are rarely present in clean water. So, enterococci values are a measurement of pollution. `cfu` stands for colony forming units and measures the number of viable bacteria in a sample [cfu](https://en.wikipedia.org/wiki/Colony-forming_unit).   

This homework loosely follows the tutorial of [R Ladies Sydney](https://rladiessydney.org/). If you get stuck, check it out!  

1. Start by loading the data `sydneybeaches`. Do some exploratory analysis to get an idea of the data structure.

```r
sydneybeaches<-readr::read_csv("data/sydneybeaches.csv")%>%
  clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   BeachId = col_double(),
##   Region = col_character(),
##   Council = col_character(),
##   Site = col_character(),
##   Longitude = col_double(),
##   Latitude = col_double(),
##   Date = col_character(),
##   `Enterococci (cfu/100ml)` = col_double()
## )
```

```r
sydneybeaches
```

```
## # A tibble: 3,690 x 8
##    beach_id region    council   site   longitude latitude date  enterococci_cfu~
##       <dbl> <chr>     <chr>     <chr>      <dbl>    <dbl> <chr>            <dbl>
##  1       25 Sydney C~ Randwick~ Clove~      151.    -33.9 02/0~               19
##  2       25 Sydney C~ Randwick~ Clove~      151.    -33.9 06/0~                3
##  3       25 Sydney C~ Randwick~ Clove~      151.    -33.9 12/0~                2
##  4       25 Sydney C~ Randwick~ Clove~      151.    -33.9 18/0~               13
##  5       25 Sydney C~ Randwick~ Clove~      151.    -33.9 30/0~                8
##  6       25 Sydney C~ Randwick~ Clove~      151.    -33.9 05/0~                7
##  7       25 Sydney C~ Randwick~ Clove~      151.    -33.9 11/0~               11
##  8       25 Sydney C~ Randwick~ Clove~      151.    -33.9 23/0~               97
##  9       25 Sydney C~ Randwick~ Clove~      151.    -33.9 07/0~                3
## 10       25 Sydney C~ Randwick~ Clove~      151.    -33.9 25/0~                0
## # ... with 3,680 more rows
```

```r
#janitor::clean_names("data/sydneybeaches.csv")
```

If you want to try `here`, first notice the output when you load the `here` library. It gives you information on the current working directory. You can then use it to easily and intuitively load files.

```r
#library(here)
```

The quotes show the folder structure from the root directory.

```r
#sydneybeaches <-read_csv(here("lab8", "data", "sydneybeaches.csv")) %>% janitor::clean_names()
```

2. Are these data "tidy" per the definitions of the tidyverse? How do you know? Are they in wide or long format?


```r
skimr::skim(sydneybeaches)
```


Table: Data summary

|                         |              |
|:------------------------|:-------------|
|Name                     |sydneybeaches |
|Number of rows           |3690          |
|Number of columns        |8             |
|_______________________  |              |
|Column type frequency:   |              |
|character                |4             |
|numeric                  |4             |
|________________________ |              |
|Group variables          |None          |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|region        |         0|             1|  25|  25|     0|        1|          0|
|council       |         0|             1|  16|  16|     0|        2|          0|
|site          |         0|             1|  11|  23|     0|       11|          0|
|date          |         0|             1|  10|  10|     0|      344|          0|


**Variable type: numeric**

|skim_variable         | n_missing| complete_rate|   mean|     sd|     p0|    p25|    p50|    p75|    p100|hist                                     |
|:---------------------|---------:|-------------:|------:|------:|------:|------:|------:|------:|-------:|:----------------------------------------|
|beach_id              |         0|          1.00|  25.87|   2.08|  22.00|  24.00|  26.00|  27.40|   29.00|▆▃▇▇▆ |
|longitude             |         0|          1.00| 151.26|   0.01| 151.25| 151.26| 151.26| 151.27|  151.28|▅▇▂▆▂ |
|latitude              |         0|          1.00| -33.93|   0.03| -33.98| -33.95| -33.92| -33.90|  -33.89|▆▇▁▇▇ |
|enterococci_cfu_100ml |        29|          0.99|  33.92| 154.92|   0.00|   1.00|   5.00|  17.00| 4900.00|▇▁▁▁▁ |

```r
summary(sydneybeaches)
```

```
##     beach_id        region            council              site          
##  Min.   :22.00   Length:3690        Length:3690        Length:3690       
##  1st Qu.:24.00   Class :character   Class :character   Class :character  
##  Median :26.00   Mode  :character   Mode  :character   Mode  :character  
##  Mean   :25.87                                                           
##  3rd Qu.:27.40                                                           
##  Max.   :29.00                                                           
##                                                                          
##    longitude        latitude          date           enterococci_cfu_100ml
##  Min.   :151.3   Min.   :-33.98   Length:3690        Min.   :   0.00      
##  1st Qu.:151.3   1st Qu.:-33.95   Class :character   1st Qu.:   1.00      
##  Median :151.3   Median :-33.92   Mode  :character   Median :   5.00      
##  Mean   :151.3   Mean   :-33.93                      Mean   :  33.92      
##  3rd Qu.:151.3   3rd Qu.:-33.90                      3rd Qu.:  17.00      
##  Max.   :151.3   Max.   :-33.89                      Max.   :4900.00      
##                                                      NA's   :29
```
#in general, after using the clean names function the data looks somewhat tiddy howeverit does look troublesome to extract data from this table. from the Skimr function it doesnt look like theres any weird values in here, usually they would stick out here so this data is tidy enough I think

3. We are only interested in the variables site, date, and enterococci_cfu_100ml. Make a new object focused on these variables only. Name the object `sydneybeaches_long`

```r
sydneybeaches_long<-sydneybeaches%>%
  select(site,date,enterococci_cfu_100ml)

sydneybeaches_long
```

```
## # A tibble: 3,690 x 3
##    site           date       enterococci_cfu_100ml
##    <chr>          <chr>                      <dbl>
##  1 Clovelly Beach 02/01/2013                    19
##  2 Clovelly Beach 06/01/2013                     3
##  3 Clovelly Beach 12/01/2013                     2
##  4 Clovelly Beach 18/01/2013                    13
##  5 Clovelly Beach 30/01/2013                     8
##  6 Clovelly Beach 05/02/2013                     7
##  7 Clovelly Beach 11/02/2013                    11
##  8 Clovelly Beach 23/02/2013                    97
##  9 Clovelly Beach 07/03/2013                     3
## 10 Clovelly Beach 25/03/2013                     0
## # ... with 3,680 more rows
```


4. Pivot the data such that the dates are column names and each beach only appears once. Name the object `sydneybeaches_wide`

```r
sydneybeaches_wide<-sydneybeaches_long%>%
  pivot_wider(names_from = "date",
              values_from = "enterococci_cfu_100ml")

sydneybeaches_wide
```

```
## # A tibble: 11 x 345
##    site  `02/01/2013` `06/01/2013` `12/01/2013` `18/01/2013` `30/01/2013`
##    <chr>        <dbl>        <dbl>        <dbl>        <dbl>        <dbl>
##  1 Clov~           19            3            2           13            8
##  2 Coog~           15            4           17           18           22
##  3 Gord~           NA           NA           NA           NA           NA
##  4 Litt~            9            3           72            1           44
##  5 Mala~            2            4          390           15           13
##  6 Maro~            1            1           20            2           11
##  7 Sout~            1            0           33            2           13
##  8 Sout~           12            2          110           13          100
##  9 Bond~            3            1            2            1            6
## 10 Bron~            4            2           38            3           25
## 11 Tama~            1            0            7           22           23
## # ... with 339 more variables: `05/02/2013` <dbl>, `11/02/2013` <dbl>,
## #   `23/02/2013` <dbl>, `07/03/2013` <dbl>, `25/03/2013` <dbl>,
## #   `02/04/2013` <dbl>, `12/04/2013` <dbl>, `18/04/2013` <dbl>,
## #   `24/04/2013` <dbl>, `01/05/2013` <dbl>, `20/05/2013` <dbl>,
## #   `31/05/2013` <dbl>, `06/06/2013` <dbl>, `12/06/2013` <dbl>,
## #   `24/06/2013` <dbl>, `06/07/2013` <dbl>, `18/07/2013` <dbl>,
## #   `24/07/2013` <dbl>, `08/08/2013` <dbl>, `22/08/2013` <dbl>,
## #   `29/08/2013` <dbl>, `24/01/2013` <dbl>, `17/02/2013` <dbl>,
## #   `01/03/2013` <dbl>, `13/03/2013` <dbl>, `19/03/2013` <dbl>,
## #   `06/04/2013` <dbl>, `07/05/2013` <dbl>, `14/05/2013` <dbl>,
## #   `25/05/2013` <dbl>, `17/06/2013` <dbl>, `30/06/2013` <dbl>,
## #   `12/07/2013` <dbl>, `30/07/2013` <dbl>, `14/08/2013` <dbl>,
## #   `16/08/2013` <dbl>, `02/09/2013` <dbl>, `28/09/2013` <dbl>,
## #   `04/10/2013` <dbl>, `12/10/2013` <dbl>, `28/10/2013` <dbl>,
## #   `05/11/2013` <dbl>, `29/11/2013` <dbl>, `07/12/2013` <dbl>,
## #   `10/09/2013` <dbl>, `16/09/2013` <dbl>, `22/09/2013` <dbl>,
## #   `20/10/2013` <dbl>, `13/11/2013` <dbl>, `21/11/2013` <dbl>,
## #   `23/12/2013` <dbl>, `13/12/2013` <dbl>, `31/12/2013` <dbl>,
## #   `08/10/2014` <dbl>, `16/10/2014` <dbl>, `25/10/2014` <dbl>,
## #   `02/11/2014` <dbl>, `10/11/2014` <dbl>, `18/11/2014` <dbl>,
## #   `13/12/2014` <dbl>, `19/12/2014` <dbl>, `16/01/2014` <dbl>,
## #   `24/01/2014` <dbl>, `09/02/2014` <dbl>, `25/02/2014` <dbl>,
## #   `05/03/2014` <dbl>, `06/04/2014` <dbl>, `06/05/2014` <dbl>,
## #   `16/05/2014` <dbl>, `22/05/2014` <dbl>, `10/06/2014` <dbl>,
## #   `26/06/2014` <dbl>, `08/07/2014` <dbl>, `14/07/2014` <dbl>,
## #   `24/07/2014` <dbl>, `05/08/2014` <dbl>, `21/08/2014` <dbl>,
## #   `21/10/2014` <dbl>, `26/11/2014` <dbl>, `04/12/2014` <dbl>,
## #   `12/09/2014` <dbl>, `18/09/2014` <dbl>, `24/09/2014` <dbl>,
## #   `28/12/2014` <dbl>, `08/01/2014` <dbl>, `01/02/2014` <dbl>,
## #   `17/02/2014` <dbl>, `13/03/2014` <dbl>, `21/03/2014` <dbl>,
## #   `29/03/2014` <dbl>, `22/04/2014` <dbl>, `14/04/2014` <dbl>,
## #   `30/04/2014` <dbl>, `12/05/2014` <dbl>, `28/05/2014` <dbl>,
## #   `03/06/2014` <dbl>, `19/06/2014` <dbl>, `03/07/2014` <dbl>,
## #   `18/07/2014` <dbl>, `01/08/2014` <dbl>, ...
```


5. Pivot the data back so that the dates are data and not column names.

```r
sydneybeaches_wide%>%
  pivot_longer(-site,
               names_to = "date",
               values_to = "enterococci_cfu_100ml")
```

```
## # A tibble: 3,784 x 3
##    site           date       enterococci_cfu_100ml
##    <chr>          <chr>                      <dbl>
##  1 Clovelly Beach 02/01/2013                    19
##  2 Clovelly Beach 06/01/2013                     3
##  3 Clovelly Beach 12/01/2013                     2
##  4 Clovelly Beach 18/01/2013                    13
##  5 Clovelly Beach 30/01/2013                     8
##  6 Clovelly Beach 05/02/2013                     7
##  7 Clovelly Beach 11/02/2013                    11
##  8 Clovelly Beach 23/02/2013                    97
##  9 Clovelly Beach 07/03/2013                     3
## 10 Clovelly Beach 25/03/2013                     0
## # ... with 3,774 more rows
```


6. We haven't dealt much with dates yet, but separate the date into columns day, month, and year. Do this on the `sydneybeaches_long` data.

```r
sydneybeaches_dates<-sydneybeaches_long%>%
  separate(date, into=c("day","month","year"), sep = "/")
```


7. What is the average `enterococci_cfu_100ml` by year for each beach. Think about which data you will use- long or wide.
#so im not sure yet which format to use first, but lets try using long format first, based on the in class lab it seems long format makes it easier for us to play with the data.


```r
sydneybeaches_dates%>%
  select(site,year,enterococci_cfu_100ml)%>%
  group_by(year,site)%>%
  summarise(entero_avg=mean(enterococci_cfu_100ml,na.rm=T))
```

```
## `summarise()` regrouping output by 'year' (override with `.groups` argument)
```

```
## # A tibble: 66 x 3
## # Groups:   year [6]
##    year  site                    entero_avg
##    <chr> <chr>                        <dbl>
##  1 2013  Bondi Beach                  32.2 
##  2 2013  Bronte Beach                 26.8 
##  3 2013  Clovelly Beach                9.28
##  4 2013  Coogee Beach                 39.7 
##  5 2013  Gordons Bay (East)           24.8 
##  6 2013  Little Bay Beach            122.  
##  7 2013  Malabar Beach               101.  
##  8 2013  Maroubra Beach               47.1 
##  9 2013  South Maroubra Beach         39.3 
## 10 2013  South Maroubra Rockpool      96.4 
## # ... with 56 more rows
```


8. Make the output from question 7 easier to read by pivoting it to wide format.


```r
sydneybeaches_dates%>%
  select(site,year,enterococci_cfu_100ml)%>%
  group_by(year,site)%>%
  summarise(entero_avg=mean(enterococci_cfu_100ml,na.rm=T))%>%
  pivot_wider(names_from = "site",
              values_from = "entero_avg")
```

```
## `summarise()` regrouping output by 'year' (override with `.groups` argument)
```

```
## # A tibble: 6 x 12
## # Groups:   year [6]
##   year  `Bondi Beach` `Bronte Beach` `Clovelly Beach` `Coogee Beach`
##   <chr>         <dbl>          <dbl>            <dbl>          <dbl>
## 1 2013           32.2           26.8             9.28           39.7
## 2 2014           11.1           17.5            13.8            52.6
## 3 2015           14.3           23.6             8.82           40.3
## 4 2016           19.4           61.3            11.3            59.5
## 5 2017           13.2           16.8             7.93           20.7
## 6 2018           22.9           43.4            10.6            21.6
## # ... with 7 more variables: `Gordons Bay (East)` <dbl>, `Little Bay
## #   Beach` <dbl>, `Malabar Beach` <dbl>, `Maroubra Beach` <dbl>, `South
## #   Maroubra Beach` <dbl>, `South Maroubra Rockpool` <dbl>, `Tamarama
## #   Beach` <dbl>
```

9. What was the most polluted beach in 2018?

```r
sydneybeaches_dates%>%
  select(site,year,enterococci_cfu_100ml)%>%
  group_by(year,site)%>%
  summarise(entero_avg=mean(enterococci_cfu_100ml,na.rm=T))%>%
  pivot_wider(names_from = "site",
              values_from = "entero_avg")%>%
  filter(year=="2018")
```

```
## `summarise()` regrouping output by 'year' (override with `.groups` argument)
```

```
## # A tibble: 1 x 12
## # Groups:   year [1]
##   year  `Bondi Beach` `Bronte Beach` `Clovelly Beach` `Coogee Beach`
##   <chr>         <dbl>          <dbl>            <dbl>          <dbl>
## 1 2018           22.9           43.4             10.6           21.6
## # ... with 7 more variables: `Gordons Bay (East)` <dbl>, `Little Bay
## #   Beach` <dbl>, `Malabar Beach` <dbl>, `Maroubra Beach` <dbl>, `South
## #   Maroubra Beach` <dbl>, `South Maroubra Rockpool` <dbl>, `Tamarama
## #   Beach` <dbl>
```


```r
sydneybeaches_dates%>%
  select(site,year,enterococci_cfu_100ml)%>%
  group_by(year,site)%>%
  summarise(entero_avg=mean(enterococci_cfu_100ml,na.rm=T))%>%
  filter(year==2018)%>%
  arrange(desc(entero_avg))
```

```
## `summarise()` regrouping output by 'year' (override with `.groups` argument)
```

```
## # A tibble: 11 x 3
## # Groups:   year [1]
##    year  site                    entero_avg
##    <chr> <chr>                        <dbl>
##  1 2018  South Maroubra Rockpool     112.  
##  2 2018  Little Bay Beach             59.1 
##  3 2018  Bronte Beach                 43.4 
##  4 2018  Malabar Beach                38.0 
##  5 2018  Bondi Beach                  22.9 
##  6 2018  Coogee Beach                 21.6 
##  7 2018  Gordons Bay (East)           17.6 
##  8 2018  Tamarama Beach               15.5 
##  9 2018  South Maroubra Beach         12.5 
## 10 2018  Clovelly Beach               10.6 
## 11 2018  Maroubra Beach                9.21
```

10. Perform one analysis of your choice on the data.
what are the dirtiest beaches in that its less than 10mL in entero concentration for 2018. its not the most informative but you could technically call this an analysis of the dirtiest clean beaches in 2018


```r
sydneybeaches_dates%>%
  select(site,year,enterococci_cfu_100ml)%>%
  filter(enterococci_cfu_100ml<10 &enterococci_cfu_100ml>0,year==2018)%>%
  group_by(site)%>%
  summarise(avg_entero=mean(enterococci_cfu_100ml,na.rm=T))%>%
  arrange(desc(avg_entero))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 11 x 2
##    site                    avg_entero
##    <chr>                        <dbl>
##  1 Coogee Beach                  5.14
##  2 Malabar Beach                 4.6 
##  3 Bronte Beach                  3.73
##  4 South Maroubra Rockpool       3.69
##  5 South Maroubra Beach          3.54
##  6 Little Bay Beach              3.46
##  7 Clovelly Beach                3.38
##  8 Maroubra Beach                3.31
##  9 Tamarama Beach                3.19
## 10 Bondi Beach                   3.12
## 11 Gordons Bay (East)            2.64
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
