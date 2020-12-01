# IODS week 6, Kiira Mäklin

library(tidyverse)
#Loading the data sets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
write.table(BPRS, file ="BPRS_data.txt")
str(BPRS)
#'data.frame':	40 obs. of  11 variables:
#  $ treatment: int  1 1 1 1 1 1 1 1 1 1 ...
#$ subject  : int  1 2 3 4 5 6 7 8 9 10 ...
#$ week0    : int  42 58 54 55 72 48 71 30 41 57 ...
#$ week1    : int  36 68 55 77 75 43 61 36 43 51 ...
#$ week2    : int  36 61 41 49 72 41 47 38 39 51 ...
#$ week3    : int  43 55 38 54 65 38 30 38 35 55 ...
#$ week4    : int  41 43 43 56 50 36 27 31 28 53 ...
#$ week5    : int  40 34 28 50 39 29 40 26 22 43 ...
#$ week6    : int  38 28 29 47 32 33 30 26 20 43 ...
#$ week7    : int  47 28 25 42 38 27 31 25 23 39 ...
#$ week8    : int  51 28 24 46 32 25 31 24 21 32 ...

# The data looks like this: head(BPRS)
#treatment subject week0 week1 week2 week3 week4 week5 week6
#1         1       1    42    36    36    43    41    40    38
#2         1       2    58    68    61    55    43    34    28
#So every row has one individual, columns describe the different weeks result

colnames(BPRS)
# [1] "treatment" "subject"   "week0"     "week1"     "week2"    
#[6] "week3"     "week4"     "week5"     "week6"     "week7"    
#[11] "week8" 

summary(BPRS)
#treatment    subject       week0           week1      
#1:20      1      : 2   Min.   :24.00   Min.   :23.00  
#2:20      2      : 2   1st Qu.:38.00   1st Qu.:35.00  
#3      : 2   Median :46.00   Median :41.00  
#4      : 2   Mean   :48.00   Mean   :46.33  
#5      : 2   3rd Qu.:58.25   3rd Qu.:54.25  
#6      : 2   Max.   :78.00   Max.   :95.00 
#And so on, 

#Changing 2 variables to factors
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)

#To long format
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
glimpse((BPRSL))

BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 6)))


#Then for RATS data:
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
write.table(RATS, file ="RATS_data.txt")

head(RATS) #And column names
#ID Group WD1 WD8 WD15 WD22 WD29 WD36 WD43 WD44 WD50 WD57 WD64
#1  1     1 240 250  255  260  262  258  266  266  265  272  278
#2  2     1 225 230  230  232  240  240  243  244  238  247  245

str(RATS) #Structure and dimensions
#'data.frame':	16 obs. of  13 variables:
#  $ ID   : int  1 2 3 4 5 6 7 8 9 10 ...
#$ Group: int  1 1 1 1 1 1 1 1 2 2 ...
#$ WD1  : int  240 225 245 260 255 260 275 245 410 405 ...
#$ WD8  : int  250 230 250 255 260 265 275 255 415 420 ...
#$ WD15 : int  255 230 250 255 255 270 260 260 425 430 ...
#$ WD22 : int  260 232 255 265 270 275 270 268 428 440 ...

#Some variables to factors
RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

#To long format
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3, 4))) 

glimpse(RATSL)
#Rows: 176
#Columns: 5
#$ ID     <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2, ...
#$ Group  <fct> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 1, 1, 1, 1, 1...
#$ WD     <chr> "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1"...
#$ Weight <int> 240, 225, 245, 260, 255, 260, 275, 245, 410, 405, 445, 555, 4...
#$ Time   <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 8, 8, 8, 8, 8...

head(RATSL)
#ID Group  WD Weight Time
#1  1     1 WD1    240    1
#2  2     1 WD1    225    1
#3  3     1 WD1    245    1
#4  4     1 WD1    260    1


#No, the data is in long format, meaning that weeks are combined to one column 
# and the values in another (key and value -arguments), at beginning they were divided in multiple columns)
#E.g. BPRS had 40 obs. of  11 variables, now it has 
str(BPRSL) # 360 obs. of  5 variables:
#'data.frame':	360 obs. of  5 variables:
#  $ treatment: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
#$ subject  : Factor w/ 20 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
#$ weeks    : chr  "week0" "week0" "week0" "week0" ...
#$ bprs     : int  42 58 54 55 72 48 71 30 41 57 ...
#$ week     : int  0 0 0 0 0 0 0 0 0 0 ...

summary(BPRSL)
#treatment    subject       weeks                bprs            week  
#1:180     1      : 18   Length:360         Min.   :18.00   Min.   :0  
#2:180     2      : 18   Class :character   1st Qu.:27.00   1st Qu.:2  
#3      : 18   Mode  :character   Median :35.00   Median :4  
#4      : 18                      Mean   :37.66   Mean   :4  
#5     : 18                      3rd Qu.:43.00   3rd Qu.:6  
#6      : 18                      Max.   :95.00   Max.   :8  
#(Other):252 

write.table(BPRSL, file ="BPRSL_data.txt")
write.table(RATSL, file ="RATSL_data.txt")
