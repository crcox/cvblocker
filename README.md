# cvblocker

The goal of cvblocker is to provide a simple interface for spliting datasets for k-fold cross validation. The cross validation itself is left up to you, but cvblocker will help split factorial data into balanced groups to iterate over.

## Installation
This project is not release on [CRAN](https://CRAN.R-project.org) at the moment.

You can install the development version of cvblocker directly from [GitHub](https://github.com/crcox/cvblocker) with:

``` r
install.packages("devtools")
devtools::install_github("crcox/cvblocker")
```

## Example
The factorial input can be coded as numeric, character, or factor.

``` r
## basic example code
y.num <- sample.int(3, size = 100, replace = TRUE)
cv <- cvblocker(y.num, k = 6)

y.char <- LETTERS[y.num]
cv <- cvblocker(y.char, k = 6)

y.factor <- factor(y.num, levels = 1:3, labels = c("cow","duck","pig"))
cv <- cvblocker(y.factor, k = 6)
```

Each time cvblocker runs, it will produce different assignments due to random assignment to groups. Set a random seed for reproducable results. Or, better yet, generate the cross validation blocks one time and save them to a file to be reloaded as needed.

