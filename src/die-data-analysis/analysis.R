## Sejin Kim
## Die Data Analysis

# Import libraries
library(dplyr)

# Import data
dataset1 <- readRDS(url("https://github.com/kim3-sudo/die-data-analysis/blob/main/data/die_dataset_1.rds?raw=true"))
dataset2 <- readRDS(url("https://github.com/kim3-sudo/die-data-analysis/blob/main/data/die_dataset_2.rds?raw=true"))
View(dataset1)
View(dataset2)

hist(dataset1$value, breaks=seq.int(1, 6, 1), xlab = "Value", ylab = "Frequency", main = "Dataset 1 Values")
hist(dataset2$value, breaks=seq.int(1, 6, 1), xlab = "Value", ylab = "Frequency", main = "Dataset 2 Values")


# Combine the datasets into one
diedata <- data.frame(
  group = rep(c("set1", "set2"), each = 25),
  weight = c(dataset1, dataset2)
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
