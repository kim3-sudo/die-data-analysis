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

dataset1 <- as.vector(dataset1[,1])
dataset2 <- as.vector(dataset2[,1])

hist(dataset1, breaks=seq.int(1, 6, 1), xlab = "Value", ylab = "Frequency", main = "Dataset 1 Values")
hist(dataset2, breaks=seq.int(1, 6, 1), xlab = "Value", ylab = "Frequency", main = "Dataset 2 Values")


# Combine the datasets into one
diedata <- data.frame(
  group = rep(c("die1", "die2"), each = 25),
  value = c(dataset1, dataset2)
)

# EDA
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
wtest
