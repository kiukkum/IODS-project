#Script for the exercise 2 data wrangling: learning14, here called "data2"
#  Kiira Mäklin, 2.11.2020
library(dplyr)

#Reading data in, called "data"
data <- read.delim("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = T, sep ="\t")
dim(data)
#[1] 183  60
str(data)
#'data.frame':	183 obs. of  60 variables:
#$ Aa      : int  3 2 4 4 3 4 4 3 2 3 ...
#$ Ab      : int  1 2 1 2 2 2 1 1 1 2 ...
#$ Ac      : int  2 2 1 3 2 1 2 2 2 1 ...


# Creating variables gender, age, attitude, deep, stra, surf and points
#First "attitude" column
data$attitude <- data$Attitude / 10

#Then, deep, surface and strategic
#Combining the questions
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(data, one_of(deep_questions))
head(deep_columns)
#  D03 D11 D19 D27 D07 D14 D22 D30 D06 D15 D23 D31
#1   4   3   4   4   4   4   3   4   4   3   2   4
#2   4   4   3   2   3   2   2   3   2   3   3   4

#Then calculating the row means
data$deep <- rowMeans(deep_columns)

surface_columns <- select(data, one_of(surface_questions))
data$surf <- rowMeans(surface_columns)

strategic_columns <- select(data, one_of(strategic_questions))
data$stra <- rowMeans(strategic_columns)
head(data$stra)
#[1] 3.375 2.750 3.625 3.125 


#Keeping only the columns that were wanted
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
data2 <- select(data, one_of(keep_columns))
str(data2)
#'data.frame':	183 obs. of  7 variables:
#$ gender  : chr  "F" "M" "F" "M" ...
#$ Age     : int  53 55 49 53 49 38 50 37 37 42 ...

#And changing the column names to not-starting with capital letters (age&point)
colnames(data2)[7] <- "points"

#Removing values from points that are 0
data2 <- filter(data2, points >0)

data2[1:2, ]
#gender age attitude     deep  stra     surf points
#1      F  53      3.7 3.583333 3.375 2.583333     25
#2      M  55      3.1 2.916667 2.750 3.166667     12

#Look what the directory is, changing to data-file
getwd()
setwd("C:/Users/kiiramak/OneDrive - University of Eastern Finland/Työt/OPDASC/R/IODS-project/Data")

#Saving the data as .txt file and reading it in to check it

write.table(data2, file ="learning_data2.txt")
test <-read.table("learning_data2.txt")
head(test)
#gender age attitude     deep  stra     surf points
#1      F  53      3.7 3.583333 3.375 2.583333     25
#2      M  55      3.1 2.916667 2.750 3.166667     12