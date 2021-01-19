---
title: "Lab 4 Homework"
author: "Derrick Tran"
date: "2021-01-19"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

##Load the tidyverse

```r
library(tidyverse)
```


```r
getwd()
```

```
## [1] "C:/Users/Derrick/Documents/GitHub/BIS15W2021_dtran/lab4"
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

```r
homerange <-readr::read_csv("Tamburelloetal_HomeRangeDatabase.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
## i Use `spec()` for the full column specifications.
```

**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
structure(homerange)
```

```
## # A tibble: 569 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <chr> <chr>       <chr> <chr> <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake~ american e~ acti~ angu~ angui~ angu~ rostra~ telemetry     16   
##  2 rive~ blacktail ~ acti~ cypr~ catos~ moxo~ poecil~ mark-recaptu~ <NA> 
##  3 rive~ central st~ acti~ cypr~ cypri~ camp~ anomal~ mark-recaptu~ 20   
##  4 rive~ rosyside d~ acti~ cypr~ cypri~ clin~ fundul~ mark-recaptu~ 26   
##  5 rive~ longnose d~ acti~ cypr~ cypri~ rhin~ catara~ mark-recaptu~ 17   
##  6 rive~ muskellunge acti~ esoc~ esoci~ esox  masqui~ telemetry     5    
##  7 mari~ pollack     acti~ gadi~ gadid~ poll~ pollac~ telemetry     2    
##  8 mari~ saithe      acti~ gadi~ gadid~ poll~ virens  telemetry     2    
##  9 mari~ lined surg~ acti~ perc~ acant~ acan~ lineat~ direct obser~ <NA> 
## 10 mari~ orangespin~ acti~ perc~ acant~ naso  litura~ telemetry     8    
## # ... with 559 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

```r
homerange
```

```
## # A tibble: 569 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <chr> <chr>       <chr> <chr> <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake~ american e~ acti~ angu~ angui~ angu~ rostra~ telemetry     16   
##  2 rive~ blacktail ~ acti~ cypr~ catos~ moxo~ poecil~ mark-recaptu~ <NA> 
##  3 rive~ central st~ acti~ cypr~ cypri~ camp~ anomal~ mark-recaptu~ 20   
##  4 rive~ rosyside d~ acti~ cypr~ cypri~ clin~ fundul~ mark-recaptu~ 26   
##  5 rive~ longnose d~ acti~ cypr~ cypri~ rhin~ catara~ mark-recaptu~ 17   
##  6 rive~ muskellunge acti~ esoc~ esoci~ esox  masqui~ telemetry     5    
##  7 mari~ pollack     acti~ gadi~ gadid~ poll~ pollac~ telemetry     2    
##  8 mari~ saithe      acti~ gadi~ gadid~ poll~ virens  telemetry     2    
##  9 mari~ lined surg~ acti~ perc~ acant~ acan~ lineat~ direct obser~ <NA> 
## 10 mari~ orangespin~ acti~ perc~ acant~ naso  litura~ telemetry     8    
## # ... with 559 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

```r
taxon_var <- homerange$taxon
```



```r
glimpse(taxon_var)
```

```
##  chr [1:569] "lake fishes" "river fishes" "river fishes" "river fishes" ...
```



```r
order_var <- homerange$order
```



```r
taxon_factors<- as.factor(taxon_var)
class(taxon_factors)
```

```
## [1] "factor"
```

```r
order_var <- as.factor(order_var)
```



```r
levels(taxon_factors)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```



```r
levels(order_var)
```

```
##  [1] "accipitriformes"    "afrosoricida"       "anguilliformes"    
##  [4] "anseriformes"       "apterygiformes"     "artiodactyla"      
##  [7] "caprimulgiformes"   "carnivora"          "charadriiformes"   
## [10] "columbidormes"      "columbiformes"      "coraciiformes"     
## [13] "cuculiformes"       "cypriniformes"      "dasyuromorpha"     
## [16] "dasyuromorpia"      "didelphimorphia"    "diprodontia"       
## [19] "diprotodontia"      "erinaceomorpha"     "esociformes"       
## [22] "falconiformes"      "gadiformes"         "galliformes"       
## [25] "gruiformes"         "lagomorpha"         "macroscelidea"     
## [28] "monotrematae"       "passeriformes"      "pelecaniformes"    
## [31] "peramelemorphia"    "perciformes"        "perissodactyla"    
## [34] "piciformes"         "pilosa"             "proboscidea"       
## [37] "psittaciformes"     "rheiformes"         "roden"             
## [40] "rodentia"           "salmoniformes"      "scorpaeniformes"   
## [43] "siluriformes"       "soricomorpha"       "squamata"          
## [46] "strigiformes"       "struthioniformes"   "syngnathiformes"   
## [49] "testudines"         "tetraodontiformes<U+00A0>" "tinamiformes"
```

**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**  

```r
taxa <- homerange %>% select(taxon,common.name,class,order,family,genus,species)
structure(taxa)
```

```
## # A tibble: 569 x 7
##    taxon     common.name       class      order     family    genus    species  
##    <chr>     <chr>             <chr>      <chr>     <chr>     <chr>    <chr>    
##  1 lake fis~ american eel      actinopte~ anguilli~ anguilli~ anguilla rostrata 
##  2 river fi~ blacktail redhor~ actinopte~ cyprinif~ catostom~ moxosto~ poecilura
##  3 river fi~ central stonerol~ actinopte~ cyprinif~ cyprinid~ campost~ anomalum 
##  4 river fi~ rosyside dace     actinopte~ cyprinif~ cyprinid~ clinost~ funduloi~
##  5 river fi~ longnose dace     actinopte~ cyprinif~ cyprinid~ rhinich~ cataract~
##  6 river fi~ muskellunge       actinopte~ esocifor~ esocidae  esox     masquino~
##  7 marine f~ pollack           actinopte~ gadiform~ gadidae   pollach~ pollachi~
##  8 marine f~ saithe            actinopte~ gadiform~ gadidae   pollach~ virens   
##  9 marine f~ lined surgeonfish actinopte~ percifor~ acanthur~ acanthu~ lineatus 
## 10 marine f~ orangespine unic~ actinopte~ percifor~ acanthur~ naso     lituratus
## # ... with 559 more rows
```

**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.**  

```r
table(taxa$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```

**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
trophic_guild <- homerange$trophic.guild
table(trophic_guild)
```

```
## trophic_guild
## carnivore herbivore 
##       342       227
```

**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  

```r
herbi<- filter(homerange, trophic.guild == "herbivore")
herbi
```

```
## # A tibble: 227 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <chr> <chr>       <chr> <chr> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mari~ lined surg~ acti~ perc~ acant~ acan~ lineat~ direct obser~ <NA> 
##  2 mari~ orangespin~ acti~ perc~ acant~ naso  litura~ telemetry     8    
##  3 mari~ bluespine ~ acti~ perc~ acant~ naso  unicor~ telemetry     7    
##  4 mari~ redlip ble~ acti~ perc~ blenn~ ophi~ atlant~ direct obser~ 20   
##  5 mari~ bermuda ch~ acti~ perc~ kypho~ kyph~ sectat~ telemetry     11   
##  6 mari~ cherubfish  acti~ perc~ pomac~ cent~ argi    direct obser~ <NA> 
##  7 mari~ damselfish  acti~ perc~ pomac~ chro~ chromis direct obser~ <NA> 
##  8 mari~ twinspot d~ acti~ perc~ pomac~ chry~ biocel~ direct obser~ 18   
##  9 mari~ wards dams~ acti~ perc~ pomac~ poma~ wardi   direct obser~ <NA> 
## 10 mari~ australian~ acti~ perc~ pomac~ steg~ apical~ direct obser~ <NA> 
## # ... with 217 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

```r
carni<-filter(homerange,trophic.guild == "carnivore")
carni
```

```
## # A tibble: 342 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <chr> <chr>       <chr> <chr> <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake~ american e~ acti~ angu~ angui~ angu~ rostra~ telemetry     16   
##  2 rive~ blacktail ~ acti~ cypr~ catos~ moxo~ poecil~ mark-recaptu~ <NA> 
##  3 rive~ central st~ acti~ cypr~ cypri~ camp~ anomal~ mark-recaptu~ 20   
##  4 rive~ rosyside d~ acti~ cypr~ cypri~ clin~ fundul~ mark-recaptu~ 26   
##  5 rive~ longnose d~ acti~ cypr~ cypri~ rhin~ catara~ mark-recaptu~ 17   
##  6 rive~ muskellunge acti~ esoc~ esoci~ esox  masqui~ telemetry     5    
##  7 mari~ pollack     acti~ gadi~ gadid~ poll~ pollac~ telemetry     2    
##  8 mari~ saithe      acti~ gadi~ gadid~ poll~ virens  telemetry     2    
##  9 mari~ giant trev~ acti~ perc~ caran~ cara~ ignobi~ telemetry     4    
## 10 lake~ rock bass   acti~ perc~ centr~ ambl~ rupest~ mark-recaptu~ 16   
## # ... with 332 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  

```r
herbi_hra <-herbi$mean.hra.m2
mean(herbi_hra)
```

```
## [1] 34137012
```

```r
carni_hra<-carni$mean.hra.m2

mean(carni_hra)
```

```
## [1] 13039918
```
herbivores have a larger mean hra then carnivores

```r
anyNA(herbi_hra)
```

```
## [1] FALSE
```



```r
anyNA(carni_hra)
```

```
## [1] FALSE
```


**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?**  

```r
deer<-filter(homerange, family == "cervidae")
deer
```

```
## # A tibble: 12 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <chr> <chr>       <chr> <chr> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mamm~ moose       mamm~ arti~ cervi~ alces alces   telemetry*    <NA> 
##  2 mamm~ chital      mamm~ arti~ cervi~ axis  axis    telemetry*    <NA> 
##  3 mamm~ roe deer    mamm~ arti~ cervi~ capr~ capreo~ telemetry*    <NA> 
##  4 mamm~ red deer    mamm~ arti~ cervi~ cerv~ elaphus telemetry*    <NA> 
##  5 mamm~ sika deer   mamm~ arti~ cervi~ cerv~ nippon  telemetry*    <NA> 
##  6 mamm~ fallow deer mamm~ arti~ cervi~ dama  dama    telemetry*    <NA> 
##  7 mamm~ Reeves's m~ mamm~ arti~ cervi~ munt~ reevesi telemetry*    <NA> 
##  8 mamm~ mule deer   mamm~ arti~ cervi~ odoc~ hemion~ telemetry*    <NA> 
##  9 mamm~ white-tail~ mamm~ arti~ cervi~ odoc~ virgin~ telemetry*    <NA> 
## 10 mamm~ pampas deer mamm~ arti~ cervi~ ozot~ bezoar~ telemetry*    <NA> 
## 11 mamm~ pudu        mamm~ arti~ cervi~ pudu  puda    telemetry*    <NA> 
## 12 mamm~ reindeer    mamm~ arti~ cervi~ rang~ tarand~ telemetry*    <NA> 
## # ... with 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```

```r
deer_data<- deer%>% select("mean.mass.g", "log10.mass", "family", "genus", "species")
structure(deer_data)
```

```
## # A tibble: 12 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2      62823.       4.80 cervidae axis       axis       
##  3      24050.       4.38 cervidae capreolus  capreolus  
##  4     234758.       5.37 cervidae cervus     elaphus    
##  5      29450.       4.47 cervidae cervus     nippon     
##  6      71450.       4.85 cervidae dama       dama       
##  7      13500.       4.13 cervidae muntiacus  reevesi    
##  8      53864.       4.73 cervidae odocoileus hemionus   
##  9      87884.       4.94 cervidae odocoileus virginianus
## 10      35000.       4.54 cervidae ozotoceros bezoarticus
## 11       7500.       3.88 cervidae pudu       puda       
## 12     102059.       5.01 cervidae rangifer   tarandus
```

```r
deer_data[order(deer_data$log10.mass),desce=TRUE]
```

```
## # A tibble: 12 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1       7500.       3.88 cervidae pudu       puda       
##  2      13500.       4.13 cervidae muntiacus  reevesi    
##  3      24050.       4.38 cervidae capreolus  capreolus  
##  4      29450.       4.47 cervidae cervus     nippon     
##  5      35000.       4.54 cervidae ozotoceros bezoarticus
##  6      53864.       4.73 cervidae odocoileus hemionus   
##  7      62823.       4.80 cervidae axis       axis       
##  8      71450.       4.85 cervidae dama       dama       
##  9      87884.       4.94 cervidae odocoileus virginianus
## 10     102059.       5.01 cervidae rangifer   tarandus   
## 11     234758.       5.37 cervidae cervus     elaphus    
## 12     307227.       5.49 cervidae alces      alces
```


```r
deer_data
```

```
## # A tibble: 12 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2      62823.       4.80 cervidae axis       axis       
##  3      24050.       4.38 cervidae capreolus  capreolus  
##  4     234758.       5.37 cervidae cervus     elaphus    
##  5      29450.       4.47 cervidae cervus     nippon     
##  6      71450.       4.85 cervidae dama       dama       
##  7      13500.       4.13 cervidae muntiacus  reevesi    
##  8      53864.       4.73 cervidae odocoileus hemionus   
##  9      87884.       4.94 cervidae odocoileus virginianus
## 10      35000.       4.54 cervidae ozotoceros bezoarticus
## 11       7500.       3.88 cervidae pudu       puda       
## 12     102059.       5.01 cervidae rangifer   tarandus
```

```r
#this is now sorted such that log10.mass is ordered by descending order
```
#The largest deer would be alces alces otherwise known as Moose or Elk


**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column**    

```r
snake<-filter(homerange, taxon =="snakes")
snake
```

```
## # A tibble: 41 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <chr> <chr>       <chr> <chr> <chr>  <chr> <chr>   <chr>         <chr>
##  1 snak~ western wo~ rept~ squa~ colub~ carp~ vermis  radiotag      1    
##  2 snak~ eastern wo~ rept~ squa~ colub~ carp~ viridis radiotag      10   
##  3 snak~ racer       rept~ squa~ colub~ colu~ constr~ telemetry     15   
##  4 snak~ yellow bel~ rept~ squa~ colub~ colu~ constr~ telemetry     12   
##  5 snak~ ringneck s~ rept~ squa~ colub~ diad~ puncta~ mark-recaptu~ <NA> 
##  6 snak~ eastern in~ rept~ squa~ colub~ drym~ couperi telemetry     1    
##  7 snak~ great plai~ rept~ squa~ colub~ elap~ guttat~ telemetry     12   
##  8 snak~ western ra~ rept~ squa~ colub~ elap~ obsole~ telemetry     18   
##  9 snak~ hognose sn~ rept~ squa~ colub~ hete~ platir~ telemetry     8    
## 10 snak~ European w~ rept~ squa~ colub~ hier~ viridi~ telemetry     32   
## # ... with 31 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

```r
snake_data <- snake%>%select("mean.hra.m2","mean.mass.g", "log10.mass", "family", "genus", "species")
```



```r
snake_data[order(snake_data$mean.hra.m2), descending =TRUE]
```

```
## # A tibble: 41 x 6
##    mean.hra.m2 mean.mass.g log10.mass family     genus       species     
##          <dbl>       <dbl>      <dbl> <chr>      <chr>       <chr>       
##  1        200        17.0       1.23  viperidae  bitis       schneideri  
##  2        253         3.65      0.562 colubridae carphopis   viridis     
##  3        600        21.5       1.33  colubridae thamnophis  butleri     
##  4        700         3.46      0.539 colubridae carphopis   vermis      
##  5       2400        97.4       1.99  viperidae  vipera      latastei    
##  6       2614.      197.        2.29  viperidae  gloydius    shedaoensis 
##  7       6476         9         0.954 colubridae diadophis   punctatus   
##  8      10655       188         2.27  viperidae  agkistrodon piscivorous 
##  9      15400        62.5       1.80  colubridae oocatochus  rufodorsatus
## 10      17400       375         2.57  colubridae pituophis   catenifer   
## # ... with 31 more rows
```

```r
snake_data %>% slice_min(mean.hra.m2)
```

```
## # A tibble: 1 x 6
##   mean.hra.m2 mean.mass.g log10.mass family    genus species   
##         <dbl>       <dbl>      <dbl> <chr>     <chr> <chr>     
## 1         200        17.0       1.23 viperidae bitis schneideri
```
According to wikipedia, bitis schneideri's common name is  Namaqua dwarf adder,spotted dwarf adder, Schneider's adder. this is a venomous snake and it is native to a small coastal region that straddle the border between namibia and south africa. its average length comes in at about 7-10 inches. One fun fact is that they actually have a high mortality rate and they make up for that by have a high reproductive rate, and also there is no anti venom for this species though its venom repportedly is painful(a range of things will happen to you) but you will most likely recover with no long term damage
## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   














