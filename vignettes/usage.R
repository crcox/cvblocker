# Simulate an unbalanced set of item labels
x <- rep(c(0,1,2), c(49,949,874))
x <- x[sample(length(x))]

# Use cvblocker() to break it into 10 folds that are as balanced as possible
blocks <- cvblocker(x, k=10)

# Use check_cvblocks() to see how the item labels are distributed over the 10
# groups.
check_cvblocks(x, blocks)
