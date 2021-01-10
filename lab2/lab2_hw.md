---
title: "Lab 2 Homework"
author: "Derrick Tran"
date: "2021-01-10"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

1. What is a vector in R?  
#a vector is like a collection of values, similar to the example we had in class it can be a bunch of numerical numbers that you can concatinate . Its like adding your values into a list that you can assign a variable name
2. What is a data matrix in R?  
#data matrixes are like tables that organize values for a specific name or value. in other words they can be collection of vectors
3. Below are data collected by three scientists (Jill, Steve, Susan in order) measuring temperatures of eight hot springs. Run this code chunk to create the vectors.  

```r
spring_1 <- c(36.25, 35.40, 35.30)
spring_2 <- c(35.15, 35.35, 33.35)
spring_3 <- c(30.70, 29.65, 29.20)
spring_4 <- c(39.70, 40.05, 38.65)
spring_5 <- c(31.85, 31.40, 29.30)
spring_6 <- c(30.20, 30.65, 29.75)
spring_7 <- c(32.90, 32.50, 32.80)
spring_8 <- c(36.80, 36.45, 33.15)
```

```r
#spring_1 ==36.2
```

```

4. Build a data matrix that has the springs as rows and the columns as scientists.  

```r
 spring_data <- c(spring_1, spring_2, spring_3, spring_4, spring_5, spring_6, spring_7, spring_8)
 #spring_data
 spring_data_matrix <- matrix(spring_data, nrow=8, byrow=T)
 spring_data_matrix
```

```
##       [,1]  [,2]  [,3]
## [1,] 36.25 35.40 35.30
## [2,] 35.15 35.35 33.35
## [3,] 30.70 29.65 29.20
## [4,] 39.70 40.05 38.65
## [5,] 31.85 31.40 29.30
## [6,] 30.20 30.65 29.75
## [7,] 32.90 32.50 32.80
## [8,] 36.80 36.45 33.15
```



5. The names of the springs are 1.Bluebell Spring, 2.Opal Spring, 3.Riverside Spring, 4.Too Hot Spring, 5.Mystery Spring,
6.Emerald Spring, 7.Black Spring, 8.Pearl Spring. Name the rows and columns in the data matrix. Start by making two new vectors with the names, then use `colnames()` and `rownames()` to name the columns and rows.

```r
spring_names <- c("Bluebell Spring", "Opal Spring", "Riverside Spring", "Too Hot Spring", "Mystery Spring", "Emerald Spring","Black Spring", "Pearl Spring" )
scientist_name <- c("jil", "steven", "susan")
#spring_names [2]
colnames(spring_data_matrix)<- scientist_name
```

6. Calculate the mean temperature of all three springs.

7. Add this as a new column in the data matrix.  

8. Show Susan's value for Opal Spring only.

9. Calculate the mean for Jill's column only.  

10. Use the data matrix to perform one calculation or operation of your interest.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  