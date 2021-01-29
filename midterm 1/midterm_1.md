---
title: "Midterm 1"
author: "Derrick Tran"
date: "2021-01-28"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---





## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  
so Rstudio is basically a more convenient way to code things into the R console, this way we can use packages and other useful tools to make our work easier. how this works in tandem with github is that your work will be backed up to a repository other then your hard drive, so if someone else needs to look at your work its there and you can look at other peoples work too. It is good to use RMarkdown in this context so we can see your "work" from your code, its so we can see the outputs and dont have to run the code chunks again since you already would've done so
**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**
We are using data frames, data matrices, and vectors. We are using data frames for BIS 15L because it seems a lot more efficient and easier finding and pulling up specific data from files. it is convenient to find and do stuff with the data stored in a data frame. Furthermore, I think most of the files that we would download (data files) seem to have their data stored in a data frame or this is what i have noticed when downloading stuff 

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

```r
getwd()
```

```
## [1] "C:/Users/Derrick/Documents/GitHub/BIS15W2021_dtran/midterm 1"
```

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants<-readr::read_csv("ElephantsMF.csv", na = c("", "-99", "-"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
names(elephants)
```

```
## [1] "Age"    "Height" "Sex"
```



```r
elephants<-rename(elephants, age="Age",height="Height",sex="Sex")
```


```r
#elephants<-as.factor(elephants$sex)
data.frame(sex<-as.factor(elephants$sex))
```

```
##     sex....as.factor.elephants.sex.
## 1                                 M
## 2                                 M
## 3                                 M
## 4                                 M
## 5                                 M
## 6                                 M
## 7                                 M
## 8                                 M
## 9                                 M
## 10                                M
## 11                                M
## 12                                M
## 13                                M
## 14                                M
## 15                                M
## 16                                M
## 17                                M
## 18                                M
## 19                                M
## 20                                M
## 21                                M
## 22                                M
## 23                                M
## 24                                M
## 25                                M
## 26                                M
## 27                                M
## 28                                M
## 29                                M
## 30                                M
## 31                                M
## 32                                M
## 33                                M
## 34                                M
## 35                                M
## 36                                M
## 37                                M
## 38                                M
## 39                                M
## 40                                M
## 41                                M
## 42                                M
## 43                                M
## 44                                M
## 45                                M
## 46                                M
## 47                                M
## 48                                M
## 49                                M
## 50                                M
## 51                                M
## 52                                M
## 53                                M
## 54                                M
## 55                                M
## 56                                M
## 57                                M
## 58                                M
## 59                                M
## 60                                M
## 61                                M
## 62                                M
## 63                                M
## 64                                M
## 65                                M
## 66                                M
## 67                                M
## 68                                M
## 69                                M
## 70                                M
## 71                                M
## 72                                M
## 73                                M
## 74                                M
## 75                                M
## 76                                M
## 77                                M
## 78                                M
## 79                                M
## 80                                M
## 81                                M
## 82                                M
## 83                                M
## 84                                M
## 85                                M
## 86                                M
## 87                                M
## 88                                M
## 89                                M
## 90                                M
## 91                                M
## 92                                M
## 93                                M
## 94                                M
## 95                                M
## 96                                M
## 97                                M
## 98                                M
## 99                                M
## 100                               M
## 101                               M
## 102                               M
## 103                               M
## 104                               M
## 105                               M
## 106                               M
## 107                               M
## 108                               M
## 109                               M
## 110                               M
## 111                               M
## 112                               F
## 113                               M
## 114                               M
## 115                               F
## 116                               F
## 117                               F
## 118                               F
## 119                               F
## 120                               M
## 121                               F
## 122                               M
## 123                               F
## 124                               F
## 125                               F
## 126                               F
## 127                               F
## 128                               F
## 129                               F
## 130                               M
## 131                               F
## 132                               M
## 133                               F
## 134                               F
## 135                               M
## 136                               F
## 137                               M
## 138                               F
## 139                               F
## 140                               F
## 141                               F
## 142                               F
## 143                               F
## 144                               M
## 145                               F
## 146                               F
## 147                               F
## 148                               F
## 149                               F
## 150                               F
## 151                               F
## 152                               F
## 153                               F
## 154                               F
## 155                               F
## 156                               F
## 157                               F
## 158                               F
## 159                               F
## 160                               F
## 161                               F
## 162                               F
## 163                               F
## 164                               F
## 165                               F
## 166                               M
## 167                               F
## 168                               F
## 169                               M
## 170                               F
## 171                               F
## 172                               F
## 173                               F
## 174                               F
## 175                               F
## 176                               F
## 177                               F
## 178                               M
## 179                               F
## 180                               F
## 181                               F
## 182                               F
## 183                               F
## 184                               F
## 185                               F
## 186                               F
## 187                               F
## 188                               M
## 189                               F
## 190                               F
## 191                               F
## 192                               F
## 193                               F
## 194                               F
## 195                               F
## 196                               F
## 197                               F
## 198                               F
## 199                               F
## 200                               F
## 201                               F
## 202                               F
## 203                               F
## 204                               F
## 205                               F
## 206                               F
## 207                               F
## 208                               F
## 209                               F
## 210                               F
## 211                               F
## 212                               F
## 213                               F
## 214                               F
## 215                               F
## 216                               F
## 217                               F
## 218                               F
## 219                               M
## 220                               F
## 221                               F
## 222                               F
## 223                               F
## 224                               F
## 225                               F
## 226                               M
## 227                               F
## 228                               F
## 229                               F
## 230                               F
## 231                               M
## 232                               F
## 233                               F
## 234                               F
## 235                               F
## 236                               F
## 237                               F
## 238                               F
## 239                               M
## 240                               M
## 241                               F
## 242                               F
## 243                               F
## 244                               M
## 245                               F
## 246                               F
## 247                               F
## 248                               M
## 249                               F
## 250                               F
## 251                               M
## 252                               F
## 253                               F
## 254                               F
## 255                               F
## 256                               F
## 257                               F
## 258                               F
## 259                               F
## 260                               M
## 261                               F
## 262                               M
## 263                               F
## 264                               F
## 265                               M
## 266                               F
## 267                               F
## 268                               F
## 269                               F
## 270                               F
## 271                               F
## 272                               M
## 273                               M
## 274                               F
## 275                               F
## 276                               F
## 277                               F
## 278                               M
## 279                               F
## 280                               F
## 281                               F
## 282                               F
## 283                               F
## 284                               F
## 285                               F
## 286                               F
## 287                               F
## 288                               F
```

**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants%>%
  select(age,height,sex)%>%
  group_by(sex)%>%
  count(sex)
```

```
## # A tibble: 2 x 2
## # Groups:   sex [2]
##   sex       n
##   <chr> <int>
## 1 F       150
## 2 M       138
```


**6. (2 points) What is the average age all elephants in the data?**

```r
elephants%>%
  select(age)%>%
  summarise(avg_age=mean(age,na.rm=T))
```

```
## # A tibble: 1 x 1
##   avg_age
##     <dbl>
## 1    11.0
```


**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
#avg_AH_male<-elephants%>%
  #select(age,height,sex)%>%
  #filter(sex=="M")%>%
  #summarise(avg_age=mean(age,na.rm=T),avg_height=mean(height,na.rm=T))
```


```r
elephants%>%
  select(age,height,sex)%>%
  group_by(sex)%>%
summarise(avg_age=mean(age,na.rm=T),avg_height=mean(height,na.rm=T))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 3
##   sex   avg_age avg_height
##   <chr>   <dbl>      <dbl>
## 1 F       12.8        190.
## 2 M        8.95       185.
```


**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants%>%
  select(age,height,sex)%>%
  filter(age>25)%>%
  group_by(sex)%>%
  summarise(avg_age=mean(age,na.rm=T),avg_height=mean(height,na.rm=T),min_height=min(height),max_height=max(height))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 5
##   sex   avg_age avg_height min_height max_height
##   <chr>   <dbl>      <dbl>      <dbl>      <dbl>
## 1 F        27.3       233.       206.       278.
## 2 M        26.6       273.       237.       304.
```


For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
defauna<- readr::read_csv("IvindoData_DryadVersion.csv", na = c("", "-99", "-"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i Use `spec()` for the full column specifications.
```


**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
structure(defauna)
```

```
## # A tibble: 24 x 26
##    TransectID Distance HuntCat NumHouseholds LandUse Veg_Rich Veg_Stems
##         <dbl>    <dbl> <chr>           <dbl> <chr>      <dbl>     <dbl>
##  1          1     7.14 Modera~            54 Park        16.7      31.2
##  2          2    17.3  None               54 Park        15.8      37.4
##  3          2    18.3  None               29 Park        16.9      32.3
##  4          3    20.8  None               29 Logging     12.4      29.4
##  5          4    16.0  None               29 Park        17.1      36  
##  6          5    17.5  None               29 Park        16.5      29.2
##  7          6    24.1  None               29 Park        14.8      31.2
##  8          7    19.8  None               54 Logging     13.2      32.6
##  9          8     5.78 High               25 Neither     12.6      23.7
## 10          9     5.13 High               73 Logging     16        27.1
## # ... with 14 more rows, and 19 more variables: Veg_liana <dbl>, Veg_DBH <dbl>,
## #   Veg_Canopy <dbl>, Veg_Understory <dbl>, RA_Apes <dbl>, RA_Birds <dbl>,
## #   RA_Elephant <dbl>, RA_Monkeys <dbl>, RA_Rodent <dbl>, RA_Ungulate <dbl>,
## #   Rich_AllSpecies <dbl>, Evenness_AllSpecies <dbl>,
## #   Diversity_AllSpecies <dbl>, Rich_BirdSpecies <dbl>,
## #   Evenness_BirdSpecies <dbl>, Diversity_BirdSpecies <dbl>,
## #   Rich_MammalSpecies <dbl>, Evenness_MammalSpecies <dbl>,
## #   Diversity_MammalSpecies <dbl>
```

```r
defauna <- janitor::clean_names(defauna)
```


```r
defauna%>%
  select(transect_id,hunt_cat,diversity_bird_species,diversity_mammal_species)%>%
  filter(hunt_cat=="Moderate"|hunt_cat=="High")%>%
  group_by(hunt_cat)%>%
  summarise(avg_diversity_bird=mean(diversity_bird_species),avg_div_mam=mean(diversity_mammal_species))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 3
##   hunt_cat avg_diversity_bird avg_div_mam
##   <chr>                 <dbl>       <dbl>
## 1 High                   1.66        1.74
## 2 Moderate               1.62        1.68
```

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

```r
defauna%>%
  select(transect_id,ra_apes,ra_birds,ra_elephant,ra_monkeys,ra_rodent,ra_ungulate,distance)%>%
  filter(distance<"5"|distance>"20")%>%
  group_by(distance<"5"&distance>"20")%>%
  summarise(across(contains("ra"),mean,na.rm=T))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 8
##   `distance < "5"~ transect_id ra_apes ra_birds ra_elephant ra_monkeys ra_rodent
##   <lgl>                  <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>
## 1 FALSE                   13.7    1.37     60.8       0.570       29.7      3.37
## 2 TRUE                    12.5    5.40     47.8       0.418       39.5      2.81
## # ... with 1 more variable: ra_ungulate <dbl>
```

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**
I am going to look at how  use of land compares to the average diversity of mammals, birds and all species, this time distance being greater then 5km

```r
defauna%>%
  select(distance,land_use,diversity_bird_species,diversity_mammal_species,diversity_all_species)%>%
  filter(distance>=5)%>%
  group_by(land_use)%>%
  summarise(avg_mam_div=mean(diversity_mammal_species,na.rm=T),avg_bird_div=mean(diversity_bird_species,na.rm=T),
            avg_all_div=mean(diversity_all_species,na.rm=T))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 3 x 4
##   land_use avg_mam_div avg_bird_div avg_all_div
##   <chr>          <dbl>        <dbl>       <dbl>
## 1 Logging         1.67         1.54        2.22
## 2 Neither         1.71         1.84        2.36
## 3 Park            1.75         1.77        2.43
```

