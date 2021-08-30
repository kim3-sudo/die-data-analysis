## Sejin Kim
## Die Data Analysis

# Import libraries
library(dplyr)
library(ggpubr)

# Import data
dataset1 <- readRDS(url("https://github.com/kim3-sudo/die-data-analysis/blob/main/data/die_dataset_1.rds?raw=true"))
dataset2 <- readRDS(url("https://github.com/kim3-sudo/die-data-analysis/blob/main/data/die_dataset_2.rds?raw=true"))
View(dataset1)
View(dataset2)

# Change the data format to a vector so they can be combined into one dataframe for analysis
## Column 1 is the value, column 0 is the roll ID
dataset1 <- as.vector(dataset1[,1])
dataset2 <- as.vector(dataset2[,1])

# Make some histograms
hist(dataset1, breaks=seq.int(1, 6, 1), xlab = "Value", ylab = "Frequency", main = "Dataset 1 Values")
hist(dataset2, breaks=seq.int(1, 6, 1), xlab = "Value", ylab = "Frequency", main = "Dataset 2 Values")
## hist(a, breaks=x, xlab="string", ylab="string", main="string")
## a is the dataset as a vector
## breaks is how many breaks in the x-axis to make
## xlab, ylab, and main are labels for the plot

# Combine the datasets into one
diedata <- data.frame(
  group = rep(c("die1", "die2"), each = 25),
  value = c(dataset1, dataset2)
)

# Test for equal variance using Fligner-Killeen test
fligner.test(value ~ group, data = diedata)
## There is no evidence to suggest that the variance in values (dice rolls)
## are significantly different between the two different treatment groups

# EDA
## Makes a table with counts, medians, and IQRs
group_by(diedata, group) %>%
  summarise(
    count = n(),
    median = median(value, na.rm = TRUE),
    IQR = IQR(value, na.rm = TRUE)
  )


# Wilcoxon Rank Sum Test
## H_0 = The two datasets are derived from the same die
## H_1 = There is some force acting on one of the die
wtest <- wilcox.test(value ~ group, data = diedata, exact = FALSE, alternative="less")
# View the test results
wtest
## A large p-value means that we fail to reject the null hypothesis
## It would appear the two datasets were derived from the same die
