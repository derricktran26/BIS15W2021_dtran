---
title: "Lab 7 Homework"
author: "Derrick Tran"
date: "2021-02-03"
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
library(skimr)
```

## Data
**1. For this homework, we will use two different data sets. Please load `amniota` and `amphibio`.**  

`amniota` data:  
Myhrvold N, Baldridge E, Chan B, Sivam D, Freeman DL, Ernest SKM (2015). “An amniote life-history
database to perform comparative analyses with birds, mammals, and reptiles.” _Ecology_, *96*, 3109.
doi: 10.1890/15-0846.1 (URL: https://doi.org/10.1890/15-0846.1).

```r
amniota<- readr::read_csv("amniota.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   common_name = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
amphibio<- readr::read_csv("amphibio.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   id = col_character(),
##   Order = col_character(),
##   Family = col_character(),
##   Genus = col_character(),
##   Species = col_character(),
##   Seeds = col_logical(),
##   OBS = col_logical()
## )
## i Use `spec()` for the full column specifications.
```

```
## Warning: 125 parsing failures.
##  row col           expected                                                           actual           file
## 1410 OBS 1/0/T/F/TRUE/FALSE Identified as P. appendiculata in Boquimpani-Freitas et al. 2002 'amphibio.csv'
## 1416 OBS 1/0/T/F/TRUE/FALSE Identified as T. miliaris in Giaretta and Facure 2004            'amphibio.csv'
## 1447 OBS 1/0/T/F/TRUE/FALSE Considered endangered by Soto-Azat et al. 2013                   'amphibio.csv'
## 1448 OBS 1/0/T/F/TRUE/FALSE Considered extinct by Soto-Azat et al. 2013                      'amphibio.csv'
## 1471 OBS 1/0/T/F/TRUE/FALSE nomem dubitum                                                    'amphibio.csv'
## .... ... .................. ................................................................ ..............
## See problems(...) for more details.
```

`amphibio` data:  
Oliveira BF, São-Pedro VA, Santos-Barrera G, Penone C, Costa GC (2017). “AmphiBIO, a global database
for amphibian ecological traits.” _Scientific Data_, *4*, 170123. doi: 10.1038/sdata.2017.123 (URL:
https://doi.org/10.1038/sdata.2017.123).


## Questions  
**2. Do some exploratory analysis of the `amniota` data set. Use the function(s) of your choice. Try to get an idea of how NA's are represented in the data.**  


```r
amniota%>%
  summarise_all(~sum(is.na(.)))
```

```
## # A tibble: 1 x 36
##   class order family genus species subspecies common_name female_maturity~
##   <int> <int>  <int> <int>   <int>      <int>       <int>            <int>
## 1     0     0      0     0       0          0           0                0
## # ... with 28 more variables: litter_or_clutch_size_n <int>,
## #   litters_or_clutches_per_y <int>, adult_body_mass_g <int>,
## #   maximum_longevity_y <int>, gestation_d <int>, weaning_d <int>,
## #   birth_or_hatching_weight_g <int>, weaning_weight_g <int>, egg_mass_g <int>,
## #   incubation_d <int>, fledging_age_d <int>, longevity_y <int>,
## #   male_maturity_d <int>, inter_litter_or_interbirth_interval_y <int>,
## #   female_body_mass_g <int>, male_body_mass_g <int>, no_sex_body_mass_g <int>,
## #   egg_width_mm <int>, egg_length_mm <int>, fledging_mass_g <int>,
## #   adult_svl_cm <int>, male_svl_cm <int>, female_svl_cm <int>,
## #   birth_or_hatching_svl_cm <int>, female_svl_at_maturity_cm <int>,
## #   female_body_mass_at_maturity_g <int>, no_sex_svl_cm <int>,
## #   no_sex_maturity_d <int>
```

```r
amniota_tidy<-amniota%>%
  na_if("-999")%>%
  mutate(female_maturity_dnew= ifelse(female_maturity_d<0,NA,female_maturity_d))%>%
  select(-female_maturity_d)%>%
  na_if("0")
  
amniota_tidy%>%
  summarise(number_nas=sum(is.na(amniota_tidy)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     528200
```


```r
amniota_tidy%>%
  summarise_all(~sum(is.na(.)))
```

```
## # A tibble: 1 x 36
##   class order family genus species subspecies common_name litter_or_clutc~
##   <int> <int>  <int> <int>   <int>      <int>       <int>            <int>
## 1     0     0      0     0       0      21322        1641             8244
## # ... with 28 more variables: litters_or_clutches_per_y <int>,
## #   adult_body_mass_g <int>, maximum_longevity_y <int>, gestation_d <int>,
## #   weaning_d <int>, birth_or_hatching_weight_g <int>, weaning_weight_g <int>,
## #   egg_mass_g <int>, incubation_d <int>, fledging_age_d <int>,
## #   longevity_y <int>, male_maturity_d <int>,
## #   inter_litter_or_interbirth_interval_y <int>, female_body_mass_g <int>,
## #   male_body_mass_g <int>, no_sex_body_mass_g <int>, egg_width_mm <int>,
## #   egg_length_mm <int>, fledging_mass_g <int>, adult_svl_cm <int>,
## #   male_svl_cm <int>, female_svl_cm <int>, birth_or_hatching_svl_cm <int>,
## #   female_svl_at_maturity_cm <int>, female_body_mass_at_maturity_g <int>,
## #   no_sex_svl_cm <int>, no_sex_maturity_d <int>, female_maturity_dnew <int>
```

```r
amphibio%>%
 summarise_all(~sum(is.na(.)))
```

```
## # A tibble: 1 x 38
##      id Order Family Genus Species   Fos   Ter   Aqu   Arb Leaves Flowers Seeds
##   <int> <int>  <int> <int>   <int> <int> <int> <int> <int>  <int>   <int> <int>
## 1     0     0      0     0       0  6053  1104  2810  4347   6752    6772  6772
## # ... with 26 more variables: Fruits <int>, Arthro <int>, Vert <int>,
## #   Diu <int>, Noc <int>, Crepu <int>, Wet_warm <int>, Wet_cold <int>,
## #   Dry_warm <int>, Dry_cold <int>, Body_mass_g <int>,
## #   Age_at_maturity_min_y <int>, Age_at_maturity_max_y <int>,
## #   Body_size_mm <int>, Size_at_maturity_min_mm <int>,
## #   Size_at_maturity_max_mm <int>, Longevity_max_y <int>,
## #   Litter_size_min_n <int>, Litter_size_max_n <int>,
## #   Reproductive_output_y <int>, Offspring_size_min_mm <int>,
## #   Offspring_size_max_mm <int>, Dir <int>, Lar <int>, Viv <int>, OBS <int>
```

```r
  amphibio%>%
 summarise_all(~sum(is.na(.)))
```

```
## # A tibble: 1 x 38
##      id Order Family Genus Species   Fos   Ter   Aqu   Arb Leaves Flowers Seeds
##   <int> <int>  <int> <int>   <int> <int> <int> <int> <int>  <int>   <int> <int>
## 1     0     0      0     0       0  6053  1104  2810  4347   6752    6772  6772
## # ... with 26 more variables: Fruits <int>, Arthro <int>, Vert <int>,
## #   Diu <int>, Noc <int>, Crepu <int>, Wet_warm <int>, Wet_cold <int>,
## #   Dry_warm <int>, Dry_cold <int>, Body_mass_g <int>,
## #   Age_at_maturity_min_y <int>, Age_at_maturity_max_y <int>,
## #   Body_size_mm <int>, Size_at_maturity_min_mm <int>,
## #   Size_at_maturity_max_mm <int>, Longevity_max_y <int>,
## #   Litter_size_min_n <int>, Litter_size_max_n <int>,
## #   Reproductive_output_y <int>, Offspring_size_min_mm <int>,
## #   Offspring_size_max_mm <int>, Dir <int>, Lar <int>, Viv <int>, OBS <int>
```

**3. Do some exploratory analysis of the `amphibio` data set. Use the function(s) of your choice. Try to get an idea of how NA's are represented in the data.**  


```r
naniar::miss_var_summary(amphibio)
```

```
## # A tibble: 38 x 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 OBS        6776    100  
##  2 Fruits     6774    100. 
##  3 Flowers    6772     99.9
##  4 Seeds      6772     99.9
##  5 Leaves     6752     99.6
##  6 Dry_cold   6735     99.4
##  7 Vert       6657     98.2
##  8 Wet_cold   6625     97.8
##  9 Crepu      6608     97.5
## 10 Dry_warm   6572     97.0
## # ... with 28 more rows
```

**4. How many total NA's are in each data set? Do these values make sense? Are NA's represented by values?**   


```r
amniota_tidy%>%
  summarise(number_nas=sum(is.na(amniota_tidy)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     528200
```


```r
amphibio%>%
  summarise(number_nas=sum(is.na(amphibio)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     170691
```

**5. Make any necessary replacements in the data such that all NA's appear as "NA".**   

```r
amniota_tidy<-amniota%>%
  na_if("-999")%>%
  mutate(female_maturity_dnew= ifelse(female_maturity_d<0,NA,female_maturity_d))%>%
  select(-female_maturity_d)
  
amniota_tidy%>%
  summarise(number_nas=sum(is.na(amniota_tidy)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     528200
```
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">


```r
amphibio_tidy<-amphibio%>%
  na_if("0")

amphibio_tidy%>%
  summarise(number_nas=sum(is.na(amphibio_tidy)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     182085
```
</div>

**6. Use the package `naniar` to produce a summary, including percentages, of missing data in each column for the `amniota` data.**  

```r
naniar::miss_var_summary(amniota_tidy)
```

```
## # A tibble: 36 x 3
##    variable                       n_miss pct_miss
##    <chr>                           <int>    <dbl>
##  1 subspecies                      21322    100  
##  2 female_body_mass_at_maturity_g  21318    100. 
##  3 female_svl_at_maturity_cm       21120     99.1
##  4 fledging_mass_g                 21111     99.0
##  5 male_svl_cm                     21040     98.7
##  6 no_sex_maturity_d               20860     97.8
##  7 egg_width_mm                    20727     97.2
##  8 egg_length_mm                   20702     97.1
##  9 weaning_weight_g                20258     95.0
## 10 female_svl_cm                   20242     94.9
## # ... with 26 more rows
```




**7. Use the package `naniar` to produce a summary, including percentages, of missing data in each column for the `amphibio` data.**

```r
naniar::miss_var_summary(amphibio_tidy)
```

```
## # A tibble: 38 x 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 OBS        6776    100  
##  2 Fruits     6774    100. 
##  3 Flowers    6772     99.9
##  4 Seeds      6772     99.9
##  5 Leaves     6752     99.6
##  6 Dry_cold   6735     99.4
##  7 Viv        6722     99.2
##  8 Vert       6657     98.2
##  9 Wet_cold   6625     97.8
## 10 Crepu      6608     97.5
## # ... with 28 more rows
```

```r
amphibio_tidy%>%
purrr::map_df(~ sum(is.na(.))) %>% 
  pivot_longer(everything(),
    names_to= "variables",
    values_to = "num_nas") %>% 
  arrange(desc(num_nas))
```

```
## # A tibble: 38 x 2
##    variables num_nas
##    <chr>       <int>
##  1 OBS          6776
##  2 Fruits       6774
##  3 Flowers      6772
##  4 Seeds        6772
##  5 Leaves       6752
##  6 Dry_cold     6735
##  7 Viv          6722
##  8 Vert         6657
##  9 Wet_cold     6625
## 10 Crepu        6608
## # ... with 28 more rows
```
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">

**8. For the `amniota` data, calculate the number of NAs in the `egg_mass_g` column sorted by taxonomic class; i.e. how many NA's are present in the `egg_mass_g` column in birds, mammals, and reptiles? Does this results make sense biologically? How do these results affect your interpretation of NA's?**  


```r
amniota_tidy%>%
  select(class,species,egg_mass_g)%>%
  count(class,species,egg_mass_g,sort = TRUE)
```

```
## # A tibble: 16,576 x 4
##    class    species       egg_mass_g     n
##    <chr>    <chr>              <dbl> <int>
##  1 Reptilia elegans               NA    18
##  2 Reptilia guentheri             NA    16
##  3 Aves     superciliaris         NA    15
##  4 Aves     viridis               NA    15
##  5 Mammalia australis             NA    15
##  6 Reptilia gracilis              NA    15
##  7 Aves     affinis               NA    14
##  8 Mammalia thomasi               NA    14
##  9 Reptilia intermedius           NA    14
## 10 Aves     sclateri              NA    13
## # ... with 16,566 more rows
```
</div>

**9. The `amphibio` data have variables that classify species as fossorial (burrowing), terrestrial, aquatic, or arboreal.Calculate the number of NA's in each of these variables. Do you think that the authors intend us to think that there are NA's in these columns or could they represent something else? Explain.**

```r
amphibio_tidy%>%
  select(Fos,Ter,Aqu,Arb)%>%
  summarise_all(~sum(is.na(.)))
```

```
## # A tibble: 1 x 4
##     Fos   Ter   Aqu   Arb
##   <int> <int> <int> <int>
## 1  6053  1104  2810  4347
```

```r
skimr::skim(short_amphibio_tidy<-amphibio_tidy)
```


Table: Data summary

|                         |                             |
|:------------------------|:----------------------------|
|Name                     |short_amphibio_tidy <- am... |
|Number of rows           |6776                         |
|Number of columns        |38                           |
|_______________________  |                             |
|Column type frequency:   |                             |
|character                |5                            |
|logical                  |2                            |
|numeric                  |31                           |
|________________________ |                             |
|Group variables          |None                         |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|id            |         0|             1|   7|   7|     0|     6776|          0|
|Order         |         0|             1|   5|  11|     0|        3|          0|
|Family        |         0|             1|   7|  20|     0|       61|          0|
|Genus         |         0|             1|   4|  17|     0|      531|          0|
|Species       |         0|             1|   9|  34|     0|     6776|          0|


**Variable type: logical**

|skim_variable | n_missing| complete_rate| mean|count  |
|:-------------|---------:|-------------:|----:|:------|
|Seeds         |      6772|             0|    1|TRU: 4 |
|OBS           |      6776|             0|  NaN|:      |


**Variable type: numeric**

|skim_variable           | n_missing| complete_rate|    mean|      sd|    p0|  p25|    p50|    p75|    p100|hist  |
|:-----------------------|---------:|-------------:|-------:|-------:|-----:|----:|------:|------:|-------:|:-----|
|Fos                     |      6053|          0.11|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Ter                     |      1104|          0.84|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Aqu                     |      2810|          0.59|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Arb                     |      4347|          0.36|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Leaves                  |      6752|          0.00|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Flowers                 |      6772|          0.00|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Fruits                  |      6774|          0.00|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Arthro                  |      5534|          0.18|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Vert                    |      6657|          0.02|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Diu                     |      5876|          0.13|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Noc                     |      5156|          0.24|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Crepu                   |      6608|          0.02|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Wet_warm                |      5997|          0.11|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Wet_cold                |      6625|          0.02|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Dry_warm                |      6572|          0.03|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Dry_cold                |      6735|          0.01|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Body_mass_g             |      6185|          0.09|   94.56| 1093.77|  0.16|  2.6|   9.29|  31.83| 26000.0|▇▁▁▁▁ |
|Age_at_maturity_min_y   |      6392|          0.06|    2.14|    1.18|  0.25|  1.0|   2.00|   3.00|     7.0|▇▇▆▁▁ |
|Age_at_maturity_max_y   |      6392|          0.06|    2.96|    1.69|  0.30|  2.0|   3.00|   4.00|    12.0|▇▇▂▁▁ |
|Body_size_mm            |      1549|          0.77|   66.65|   91.47|  8.40| 29.0|  43.00|  69.15|  1520.0|▇▁▁▁▁ |
|Size_at_maturity_min_mm |      6529|          0.04|   56.63|   55.57|  8.80| 27.5|  43.00|  58.00|   350.0|▇▁▁▁▁ |
|Size_at_maturity_max_mm |      6528|          0.04|   67.46|   66.34| 10.10| 32.0|  50.00|  75.50|   400.0|▇▁▁▁▁ |
|Longevity_max_y         |      6417|          0.05|   11.68|    9.86|  0.17|  6.0|  10.00|  15.00|   121.8|▇▁▁▁▁ |
|Litter_size_min_n       |      5153|          0.24|  530.87| 1575.73|  1.00| 18.0|  80.00| 300.00| 25000.0|▇▁▁▁▁ |
|Litter_size_max_n       |      5153|          0.24| 1033.70| 2955.30|  1.00| 30.0| 186.00| 700.00| 45054.0|▇▁▁▁▁ |
|Reproductive_output_y   |      2344|          0.65|    1.03|    0.43|  0.08|  1.0|   1.00|   1.00|    15.0|▇▁▁▁▁ |
|Offspring_size_min_mm   |      5446|          0.20|    2.45|    1.57|  0.20|  1.4|   2.00|   3.00|    20.0|▇▁▁▁▁ |
|Offspring_size_max_mm   |      5446|          0.20|    2.86|    1.94|  0.40|  1.6|   2.30|   3.50|    25.0|▇▁▁▁▁ |
|Dir                     |      5076|          0.25|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Lar                     |      2833|          0.58|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |
|Viv                     |      6722|          0.01|    1.00|    0.00|  1.00|  1.0|   1.00|   1.00|     1.0|▁▁▇▁▁ |

**10. Now that we know how NA's are represented in the `amniota` data, how would you load the data such that the values which represent NA's are automatically converted?**
if we wanted them to be automaticaly converted we would run this when we read the csv file

```r
cleaned_up_amniota <- readr::read_csv(file = "amniota.csv", 
                  na = c("NA", " ", ".", "-999"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   subspecies = col_logical(),
##   common_name = col_character(),
##   gestation_d = col_logical(),
##   weaning_d = col_logical(),
##   weaning_weight_g = col_logical(),
##   male_svl_cm = col_logical(),
##   female_svl_cm = col_logical(),
##   birth_or_hatching_svl_cm = col_logical(),
##   female_svl_at_maturity_cm = col_logical(),
##   female_body_mass_at_maturity_g = col_logical(),
##   no_sex_svl_cm = col_logical()
## )
## i Use `spec()` for the full column specifications.
```

```
## Warning: 13577 parsing failures.
##  row                      col           expected actual          file
## 9803 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'amniota.csv'
## 9804 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'amniota.csv'
## 9805 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'amniota.csv'
## 9806 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'amniota.csv'
## 9807 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'amniota.csv'
## .... ........................ .................. ...... .............
## See problems(...) for more details.
```

```r
skimr::skim(cleaned_up_amniota)
```


Table: Data summary

|                         |                   |
|:------------------------|:------------------|
|Name                     |cleaned_up_amniota |
|Number of rows           |21322              |
|Number of columns        |36                 |
|_______________________  |                   |
|Column type frequency:   |                   |
|character                |6                  |
|logical                  |10                 |
|numeric                  |20                 |
|________________________ |                   |
|Group variables          |None               |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|class         |         0|          1.00|   4|   8|     0|        3|          0|
|order         |         0|          1.00|   6|  19|     0|       72|          0|
|family        |         0|          1.00|   6|  19|     0|      465|          0|
|genus         |         0|          1.00|   2|  20|     0|     4336|          0|
|species       |         0|          1.00|   2|  21|     0|    11548|          0|
|common_name   |      1641|          0.92|   2| 306|     0|    19624|          0|


**Variable type: logical**

|skim_variable                  | n_missing| complete_rate| mean|count  |
|:------------------------------|---------:|-------------:|----:|:------|
|subspecies                     |     21322|             0|  NaN|:      |
|gestation_d                    |     21322|             0|  NaN|:      |
|weaning_d                      |     21322|             0|  NaN|:      |
|weaning_weight_g               |     21322|             0|  NaN|:      |
|male_svl_cm                    |     21322|             0|  NaN|:      |
|female_svl_cm                  |     21322|             0|  NaN|:      |
|birth_or_hatching_svl_cm       |     21321|             0|    1|TRU: 1 |
|female_svl_at_maturity_cm      |     21322|             0|  NaN|:      |
|female_body_mass_at_maturity_g |     21322|             0|  NaN|:      |
|no_sex_svl_cm                  |     21322|             0|  NaN|:      |


**Variable type: numeric**

|skim_variable                         | n_missing| complete_rate|     mean|         sd|        p0|    p25|    p50|     p75|        p100|hist  |
|:-------------------------------------|---------:|-------------:|--------:|----------:|---------:|------:|------:|-------:|-----------:|:-----|
|female_maturity_d                     |     17849|          0.16|   691.17|    1358.20| -30258.71| 288.37| 365.00|  819.34| 9.13125e+03|▁▁▁▇▂ |
|litter_or_clutch_size_n               |      8244|          0.61|     3.83|       5.17|      0.90|   2.00|   2.80|    4.15| 1.56000e+02|▇▁▁▁▁ |
|litters_or_clutches_per_y             |     16374|          0.23|     1.75|       1.83|      0.12|   1.00|   1.05|    2.00| 5.20000e+01|▇▁▁▁▁ |
|adult_body_mass_g                     |      4645|          0.78| 37492.72| 1445681.23|      0.10|  14.90|  44.35|  238.00| 1.49000e+08|▇▁▁▁▁ |
|maximum_longevity_y                   |     15822|          0.26|    16.47|      16.29|      0.08|   6.00|  12.31|   22.00| 2.11000e+02|▇▁▁▁▁ |
|birth_or_hatching_weight_g            |     17779|          0.17|  4480.02|   64785.04|      0.00|   1.31|   5.89|   43.86| 2.25000e+06|▇▁▁▁▁ |
|egg_mass_g                            |     15907|          0.25|    22.25|      53.44|      0.22|   2.10|   5.10|   20.10| 1.50000e+03|▇▁▁▁▁ |
|incubation_d                          |     17682|          0.17|    46.67|      71.11|      2.00|  17.00|  29.25|   59.50| 1.76200e+03|▇▁▁▁▁ |
|fledging_age_d                        |     19478|          0.09|    36.80|      31.27|      1.00|  16.50|  27.50|   46.00| 3.45000e+02|▇▁▁▁▁ |
|longevity_y                           |     15822|          0.26|    13.52|      11.69|      0.08|   5.50|  10.70|   18.20| 1.77000e+02|▇▁▁▁▁ |
|male_maturity_d                       |     19278|          0.10|   787.16|     904.06|     30.44| 365.00| 365.25|  913.00| 9.13125e+03|▇▁▁▁▁ |
|inter_litter_or_interbirth_interval_y |     19904|          0.07|     0.91|       0.74|      0.05|   0.32|   1.00|    1.00| 4.85000e+00|▇▁▁▁▁ |
|female_body_mass_g                    |     14113|          0.34|  2075.77|   47293.18|      0.30|  14.00|  40.70|  220.00| 3.70000e+06|▇▁▁▁▁ |
|male_body_mass_g                      |     14679|          0.31|  6196.82|  111002.20|      0.30|  16.50|  48.40|  245.52| 4.54500e+06|▇▁▁▁▁ |
|no_sex_body_mass_g                    |     11663|          0.45| 68952.04| 2179569.11|      0.10|  13.10|  34.60|  164.00| 1.36000e+08|▇▁▁▁▁ |
|egg_width_mm                          |     20727|          0.03|    22.99|      20.30|      2.50|   8.00|  13.00|   35.90| 1.25000e+02|▇▂▁▁▁ |
|egg_length_mm                         |     20702|          0.03|    36.40|      38.67|      2.50|  10.94|  19.98|   58.92| 4.55000e+02|▇▁▁▁▁ |
|fledging_mass_g                       |     21111|          0.01|   452.27|    1563.53|      4.85|  14.60|  24.80|  107.00| 9.99200e+03|▇▁▁▁▁ |
|adult_svl_cm                          |     14274|          0.33|    38.20|      91.29|      1.79|   9.50|  18.50|   40.50| 3.04900e+03|▇▁▁▁▁ |
|no_sex_maturity_d                     |     20860|          0.02|  1604.51|    1831.96|     33.00| 365.26| 913.10| 2008.88| 1.46100e+04|▇▁▁▁▁ |

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
