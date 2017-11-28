# Custom average merging clustering (UPGMA)
# Some info: https://en.wikipedia.org/wiki/UPGMA
# 
# This implementation does not have a smart way to deal with ties!
# It picks the first element it finds, probably more likely to contain
# singleton(s)
# 
# M: matrix with mean distances (diagonal is ignored)
# rows: meaning of the rows (singletons<0, clusters>0)
# rows_n: weight of each row, i.e. number of samples
# height: cutting points for the dendogram
# merge: merging matrix as in hclust
# labels: rownames of the original matrix
# 
# One only needs to provide M
# Providing rows_n uses custom weights, the idea is to take into account
# how many genes each disease has before starting the clustering!
upgma <- function(M, rows = NULL, rows_n = NULL, 
                  height = NULL, merge = NULL, 
                  labels = rownames(M)) {
  
  # Ignore diagonal
  diag(M) <- Inf
  # Make sure we eval labels before changing M
  force(labels)
  
  # Initialise values if this is the first call
  if (is.null(rows)) rows <- -(1:nrow(M))
  if (is.null(rows_n)) rows_n <-  rep(1, nrow(M))
  if (is.null(height)) height <- numeric(0)
  if (is.null(merge)) merge <- matrix(nrow = 0, ncol = 2)
  
  # Find minimum distance
  inds <- arrayInd(which.min(M), dim(M))
  
  # I reversed them (does not matter) to output the same as hclust
  inds_v <- rev(as.vector(inds))
  ind_1 <- inds[1]
  ind_2 <- inds[2]
  
  # Update height and merge
  height <- c(height, M[inds])
  merge <- rbind(merge, rows[inds_v])
  
  # New row and column
  n_new <- rows_n[ind_1] + rows_n[ind_2] 
  d_new <- (M[ind_1, ]*rows_n[ind_1] + M[ind_2, ]*rows_n[ind_2])/n_new
  # Remove self-distances
  d_self <- d_new[ind_1]
  d_new <- d_new[-inds_v]
  
  # The new cluster id is always positive and equal to the 
  # number of mergings (including this one)
  rows <- c(rows[-inds_v], nrow(merge))
  
  # Update number of elements in each row
  rows_n <- c(rows_n[-inds_v], n_new)
  
  # Update the matrix
  M <- rbind(
    cbind(M[-inds_v, -inds_v], d_new), 
    c(d_new, d_self))
  
  # return
  if (nrow(M) > 1) {
    upgma(M, rows, rows_n, height, merge, labels)
  } else {
    # Clustering is ready
    # Compute order
    ans <- list(merge = merge, height = height)
    
    # compute order
    # browser()
    order_clust <- list()
    for (i in 1:nrow(merge)) {
      n1 <- merge[i, 1]
      n2 <- merge[i, 2]
      order_clust[[i]] <- c(
        # we take adavantage of lazy eval
        # otherwise list[[n1]] can throw an error..
        if (n1 < 0) -n1 else order_clust[[n1]], 
        if (n2 < 0) -n2 else order_clust[[n2]]
      )
    }
    ans$order <- order_clust[[nrow(merge)]]
    ans$labels <- labels
    ans$method <- "average"
    
    class(ans) <- "hclust"
    ans
  }
}

# # Examples
# M <- matrix(runif(100), nrow = 10)
# M <- M + t(M)
# rownames(M) <- colnames(M) <- paste0("D", 1:nrow(M))
# 
# h <- hclust(as.dist(M), method = "average")
# m <- upgma(M)
# # m <- upgma(M, rows_n = sample(1:10))
# 
# 
# h$merge
# m$merge
# 
# h$height
# m$height
# 
# h$order
# m$order
# 
# h$labels
# m$labels
