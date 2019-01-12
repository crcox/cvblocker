#' Split labels into k blocks for cross validation
#'
#' @param x A vector of labels.
#' @param k Number of blocks to compose.
#' @return A vector of block labels 1:\code{k}, of for each element of \code{x}.
#' @examples
#' x <- rep(c(0,1,2), c(49,949,874))
#' x <- x[sample(length(x))]
#' blocks <- cvblocker(x, k=10)
#' M <- check_cvblocks(x, blocks)
#' print(M)
cvblocker <- function(x, k) {
  N <- length(x)
  u <- unique(sort(x))
  m <- length(u)
  blocks <- numeric(N)
  M <- matrix(nrow = k+1, ncol = (m + 1), dimnames = list(c(1:k,"total"), c(u,"total")))
  q <- 1:k
  for (i in 1:m) {
    z <- x==u[i]
    n <- sum(z)
    if (n < k) {
      stop("One of the levels of x has fewer members than k.")
    }
    blocks[z] <- c(q,rep(1:k, ceiling((n-1)/k)))[sample.int(n)]
    M[1:k,i] <- tabulate(blocks[z])
    y <- rowSums(M[1:k,1:i,drop=FALSE])
    q <- which(y == min(y))
  }
  M[,"total"] <- rowSums(M[,1:m])
  M["total",] <- colSums(M[1:k,])
  print(M)
  return(blocks)
}
check_cvblocks <- function(x, blocks) {
  N <- length(x)
  u <- unique(sort(x))
  m <- length(u)
  k <- max(blocks)

  M <- matrix(
    nrow = (k + 1),
    ncol = (m + 1),
    dimnames = list(c(1:k,"total"), c(u,"total")))
  for (i in 1:k) {
    tab <- vapply(u, function(j) sum(blocks==i & x == j), FUN.VALUE = numeric(1))
    M[i,1:m] <- tab
    M[i,m+1] <- sum(tab)
  }
  M["total",] <- colSums(M[1:k,])
  return(M)
}
