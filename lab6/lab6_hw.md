---
title: "Lab 6 Homework"
author: "Derrick Tran"
date: "2021-01-25"
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

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries<-readr::read_csv("FAO_1950to2012_111914.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
## i Use `spec()` for the full column specifications.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
structure(fisheries)
```

```
## # A tibble: 17,692 x 71
##    Country `Common name` `ISSCAAP group#` `ISSCAAP taxono~ `ASFIS species#`
##    <chr>   <chr>                    <dbl> <chr>            <chr>           
##  1 Albania Angelsharks,~               38 Sharks, rays, c~ 10903XXXXX      
##  2 Albania Atlantic bon~               36 Tunas, bonitos,~ 1750100101      
##  3 Albania Barracudas n~               37 Miscellaneous p~ 17710001XX      
##  4 Albania Blue and red~               45 Shrimps, prawns  2280203101      
##  5 Albania Blue whiting~               32 Cods, hakes, ha~ 1480403301      
##  6 Albania Bluefish                    37 Miscellaneous p~ 1702021301      
##  7 Albania Bogue                       33 Miscellaneous c~ 1703926101      
##  8 Albania Caramote pra~               45 Shrimps, prawns  2280100117      
##  9 Albania Catsharks, n~               38 Sharks, rays, c~ 10801003XX      
## 10 Albania Common cuttl~               57 Squids, cuttlef~ 3210200202      
## # ... with 17,682 more rows, and 66 more variables: `ASFIS species name` <chr>,
## #   `FAO major fishing area` <dbl>, Measure <chr>, `1950` <chr>, `1951` <chr>,
## #   `1952` <chr>, `1953` <chr>, `1954` <chr>, `1955` <chr>, `1956` <chr>,
## #   `1957` <chr>, `1958` <chr>, `1959` <chr>, `1960` <chr>, `1961` <chr>,
## #   `1962` <chr>, `1963` <chr>, `1964` <chr>, `1965` <chr>, `1966` <chr>,
## #   `1967` <chr>, `1968` <chr>, `1969` <chr>, `1970` <chr>, `1971` <chr>,
## #   `1972` <chr>, `1973` <chr>, `1974` <chr>, `1975` <chr>, `1976` <chr>,
## #   `1977` <chr>, `1978` <chr>, `1979` <chr>, `1980` <chr>, `1981` <chr>,
## #   `1982` <chr>, `1983` <chr>, `1984` <chr>, `1985` <chr>, `1986` <chr>,
## #   `1987` <chr>, `1988` <chr>, `1989` <chr>, `1990` <chr>, `1991` <chr>,
## #   `1992` <chr>, `1993` <chr>, `1994` <chr>, `1995` <chr>, `1996` <chr>,
## #   `1997` <chr>, `1998` <chr>, `1999` <chr>, `2000` <chr>, `2001` <chr>,
## #   `2002` <chr>, `2003` <chr>, `2004` <chr>, `2005` <chr>, `2006` <chr>,
## #   `2007` <chr>, `2008` <chr>, `2009` <chr>, `2010` <chr>, `2011` <chr>,
## #   `2012` <chr>
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries<-janitor::clean_names(fisheries)
structure(fisheries)
```

```
## # A tibble: 17,692 x 71
##    country common_name isscaap_group_n~ isscaap_taxonom~ asfis_species_n~
##    <chr>   <chr>                  <dbl> <chr>            <chr>           
##  1 Albania Angelshark~               38 Sharks, rays, c~ 10903XXXXX      
##  2 Albania Atlantic b~               36 Tunas, bonitos,~ 1750100101      
##  3 Albania Barracudas~               37 Miscellaneous p~ 17710001XX      
##  4 Albania Blue and r~               45 Shrimps, prawns  2280203101      
##  5 Albania Blue whiti~               32 Cods, hakes, ha~ 1480403301      
##  6 Albania Bluefish                  37 Miscellaneous p~ 1702021301      
##  7 Albania Bogue                     33 Miscellaneous c~ 1703926101      
##  8 Albania Caramote p~               45 Shrimps, prawns  2280100117      
##  9 Albania Catsharks,~               38 Sharks, rays, c~ 10801003XX      
## 10 Albania Common cut~               57 Squids, cuttlef~ 3210200202      
## # ... with 17,682 more rows, and 66 more variables: asfis_species_name <chr>,
## #   fao_major_fishing_area <dbl>, measure <chr>, x1950 <chr>, x1951 <chr>,
## #   x1952 <chr>, x1953 <chr>, x1954 <chr>, x1955 <chr>, x1956 <chr>,
## #   x1957 <chr>, x1958 <chr>, x1959 <chr>, x1960 <chr>, x1961 <chr>,
## #   x1962 <chr>, x1963 <chr>, x1964 <chr>, x1965 <chr>, x1966 <chr>,
## #   x1967 <chr>, x1968 <chr>, x1969 <chr>, x1970 <chr>, x1971 <chr>,
## #   x1972 <chr>, x1973 <chr>, x1974 <chr>, x1975 <chr>, x1976 <chr>,
## #   x1977 <chr>, x1978 <chr>, x1979 <chr>, x1980 <chr>, x1981 <chr>,
## #   x1982 <chr>, x1983 <chr>, x1984 <chr>, x1985 <chr>, x1986 <chr>,
## #   x1987 <chr>, x1988 <chr>, x1989 <chr>, x1990 <chr>, x1991 <chr>,
## #   x1992 <chr>, x1993 <chr>, x1994 <chr>, x1995 <chr>, x1996 <chr>,
## #   x1997 <chr>, x1998 <chr>, x1999 <chr>, x2000 <chr>, x2001 <chr>,
## #   x2002 <chr>, x2003 <chr>, x2004 <chr>, x2005 <chr>, x2006 <chr>,
## #   x2007 <chr>, x2008 <chr>, x2009 <chr>, x2010 <chr>, x2011 <chr>,
## #   x2012 <chr>
```


```r
fisheries$country <- as.factor(fisheries$country)
fisheries$isscaap_group_number <- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area <- as.factor(fisheries$fao_major_fishing_area)
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
fisheries%>%
  count(country,sort=T)
```

```
## # A tibble: 204 x 2
##    country                      n
##    <fct>                    <int>
##  1 Spain                      915
##  2 Portugal                   763
##  3 United States of America   627
##  4 Korea, Republic of         620
##  5 Japan                      611
##  6 Russian Federation         523
##  7 Un. Sov. Soc. Rep.         515
##  8 France                     489
##  9 United Kingdom             362
## 10 Taiwan Province of China   310
## # ... with 194 more rows
```



4. Refocus the data only to include only: country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
refocus_fisheries<-fisheries_tidy%>%
  select(country,isscaap_taxonomic_group,asfis_species_name,asfis_species_number,year,catch)
refocus_fisheries
```

```
## # A tibble: 376,771 x 6
##    country isscaap_taxonomic_g~ asfis_species_na~ asfis_species_num~  year catch
##    <fct>   <chr>                <chr>             <fct>              <dbl> <dbl>
##  1 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1995    NA
##  2 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1996    53
##  3 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1997    20
##  4 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1998    31
##  5 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          1999    30
##  6 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2000    30
##  7 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2001    16
##  8 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2002    79
##  9 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2003     1
## 10 Albania Sharks, rays, chima~ Squatinidae       10903XXXXX          2004     4
## # ... with 376,761 more rows
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
refocus_fisheries%>%
  count(isscaap_taxonomic_group,asfis_species_name)
```

```
## # A tibble: 1,548 x 3
##    isscaap_taxonomic_group   asfis_species_name          n
##    <chr>                     <chr>                   <int>
##  1 Abalones, winkles, conchs Babylonia spirata           9
##  2 Abalones, winkles, conchs Buccinum undatum          331
##  3 Abalones, winkles, conchs Busycon spp                89
##  4 Abalones, winkles, conchs Concholepas concholepas    85
##  5 Abalones, winkles, conchs Cymbium cymbium             3
##  6 Abalones, winkles, conchs Cymbium spp                20
##  7 Abalones, winkles, conchs Gastropoda                513
##  8 Abalones, winkles, conchs Haliotis gigantea          63
##  9 Abalones, winkles, conchs Haliotis midae             62
## 10 Abalones, winkles, conchs Haliotis rubra            115
## # ... with 1,538 more rows
```

6. Which country had the largest overall catch in the year 2000?

```r
fisheries_tidy%>%
  select(country,year,catch)%>%
  filter(year==2000,catch!=0)%>%
  group_by(country)%>%
  summarise(max_catch_2k=max(catch,na.rm=T))%>%
  arrange(desc(max_catch_2k))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 184 x 2
##    country                  max_catch_2k
##    <fct>                           <dbl>
##  1 China                            9068
##  2 Peru                             5717
##  3 Russian Federation               5065
##  4 Viet Nam                         4945
##  5 Chile                            4299
##  6 United States of America         2438
##  7 Philippines                       999
##  8 Japan                             988
##  9 Bangladesh                        977
## 10 Senegal                           970
## # ... with 174 more rows
```

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
fisheries_tidy%>%
  select(country,catch,year,asfis_species_name)%>%
  filter(year>=1990,year<=2000)%>%
  group_by(country)%>%
  filter(asfis_species_name=="Sardina pilchardus")%>%
  summarise(max_sardines=max(catch,na.rm = T))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 37 x 2
##    country  max_sardines
##    <fct>           <dbl>
##  1 Albania            50
##  2 Algeria            95
##  3 Belize              9
##  4 Bulgaria           48
##  5 China               8
##  6 Croatia            94
##  7 Cyprus             12
##  8 Denmark            96
##  9 Estonia            20
## 10 France             97
## # ... with 27 more rows
```

8. Which five countries caught the most cephalopods between 2008-2012?

```r
fisheries_tidy%>%
  select(country,asfis_species_name,year,catch)%>%
  filter(year>=2008,year<=2012,catch!=0)%>%
  filter(asfis_species_name=="Cephalopoda")%>%
  group_by(country)%>%
  summarise(max_ceph=max(catch,na.rm = T))%>%
  arrange(desc(max_ceph))%>%
  head(arrange(max_ceph,desc(catch)),n=5)
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   country max_ceph
##   <fct>      <dbl>
## 1 India         94
## 2 China         86
## 3 Italy         66
## 4 Spain         57
## 5 Algeria       54
```

```r
fisheries_tidy%>%
  select(country,asfis_species_name,isscaap_taxonomic_group,catch,year)%>%
  filter(isscaap_taxonomic_group=="Squids, cuttlefishes, octopuses")%>%
  filter(year>=2008,year<=2012,catch!=0)%>%
  group_by(country)%>%
  summarise(max_ceph=max(catch,na.rm = T))%>%
  arrange(desc(max_ceph))%>%
  head(arrange(max_ceph,desc(catch)),n=5)
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   country                  max_ceph
##   <fct>                       <dbl>
## 1 Indonesia                     991
## 2 China                         981
## 3 Chile                         965
## 4 United States of America      901
## 5 Japan                         832
```
I am using to different ways of trying to find the top 5 countries but i am not sure which one is correct i got different things for both


9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
fisheries_tidy%>%
  select(catch,asfis_species_name,year)%>%
  filter(year>=2008,year<=2012,catch!=0)%>%
  filter(asfis_species_name!="Osteichthyes")%>%
  group_by(asfis_species_name)%>%
  summarise(max_spec_catch=max(catch, na.rm = T))%>%
  arrange(desc(max_spec_catch))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 1,350 x 2
##    asfis_species_name       max_spec_catch
##    <chr>                             <dbl>
##  1 Trichiurus lepturus                8221
##  2 Theragra chalcogramma              8188
##  3 Engraulis ringens                  7981
##  4 Clupea harengus                    7873
##  5 Katsuwonus pelamis                  997
##  6 Micromesistius poutassou            996
##  7 Decapterus spp                      994
##  8 Selaroides leptolepis               993
##  9 Loligo spp                          991
## 10 Oncorhynchus gorbuscha              991
## # ... with 1,340 more rows
```

10. Use the data to do at least one analysis of your choice.
My familys from vietnam and one of the most well known exports is fish sauce so lets see what fish species was caught the most during 2008( random year ). we want to ignore species that dont count and ones with 0 because i think they mess up the max function

```r
fisheries_tidy%>%
  select(country,year,asfis_species_name,catch)%>%
  filter(country=="Viet Nam",catch!=0,year==2008,asfis_species_name!="Osteichthyes")%>%
  group_by(asfis_species_name)%>%
  summarise(viet_fish_2k8=max(catch,na.rm = T))%>%
  arrange(desc(viet_fish_2k8))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   asfis_species_name viet_fish_2k8
##   <chr>                      <dbl>
## 1 Natantia                     300
## 2 Katsuwonus pelamis            79
## 3 Thunnus albacares             54
## 4 Thunnus alalunga              15
## 5 Thunnus obesus                 5
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
