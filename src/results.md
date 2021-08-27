# Die Roll Data Analysis

## Results

###### Sejin Kim
###### STAT 216 Nonparametric Statistics

### Data

Two die were rolled, one of which was weighted and one of which was not. In the analysis, `die1` is the weighted die, and `die2` is the non-weighted die. The data were stored in a comma-separated value document (`.csv`) and in a R dataset (`.rds`) file, and both are available in this repository.

### Analysis

After the data were imported and formatted as needed, a simple EDA was done visually, and a simple Tibble was created with counts, medians, and IQRs. Interestingly, both datasets look about the same from a summary statistic point of view. However, the data are non-normal, so we cannot use an analysis of variance, which depends on normality. Rather, I used a Wilcoxon rank sum test. The assumptions for a Wilcoxon test are as follows.

- Each data is independent.
- The two populations have equal variance.

The hypotheses for the test are as follows.

- <img src="https://render.githubusercontent.com/render/math?math=H_{0}"> (null hypothesis) = The two datasets are derived from the same die
- <img src="https://render.githubusercontent.com/render/math?math=H_{A}"> (alternative hypothesis) = There is some force acting on one of the die.

A test can be run using the following code.

```R
wtest <- wilcox.test(value ~ group, data = diedata, exact = FALSE, alternative = "less")
```

where `value` represents that value that was rolled, `group` indicates the die that was rolled, `diedata` is the dataset that holds the values for both die, `exact` mutes the warning that a Wilcoxon test's responses are continuous, and `alternative = "less"` indicates a test for whether the median roll value on die 1 is less than the median roll value on die 2.

The results of the Wilcoxon test are as follows, as reported by R (v3.6.3).

```
	Wilcoxon rank sum test with continuity correction

data:  value by group
W = 309, p-value = 0.4759
alternative hypothesis: true location shift is less than 0
```

With a W test statistic of 309 and a *p*-value of 0.4759, it would appear that both of the die were of the same type.

### Conclusion

The test has concluded that the two dies are of the same type, and that statistically, there is no difference between the two. With a *p*-value of 0.4758, we must accept the null hypothesis that the two dies are of the same group.

While we know that the two die are not of the same type, the test has failed us. A more accurate conclusion would require many more die rolls.

