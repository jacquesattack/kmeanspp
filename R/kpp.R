#' Calculate Euclidean distance between two vectors
#'
#' @param v1 First vector
#' @param v2 Second vector
#' @return The Euclidean distance
dist = function(v1,v2) {
  sqrt(sum((v1-v2)^2))
}

#' Calculate initial centers for K-means clustering using the K-means++ algorithm
#'
#' @param data A data.frame of numeric vectors.
#' @param k The desired number of centers to return.
#' @return A data.frame of centers.
#' @export
#' @examples
#' data = faithful
#' kpp_centers = kpp(data,2)
#' kmeans(data,centers = kpp_centers)
kpp = function(data,k) {
  centroids = numeric(k)

  # assign first centroid at random from points
  centroids[1] = sample(1:nrow(data),1)

  for(i in 2:k) {
    # For each data point x, compute D(x), the distance between
    # x and the nearest center that has already been chosen
    d_x = apply(data,1,function(row){
      # find closest center
      d_to_centers = sapply(centroids[1:(i-1)],
                            function(center) {
                              dist(row,data[center,])
                            })
      min(d_to_centers)
    })

    # Choose one new data point at random as a new center,
    # using a weighted probability distribution where a point x
    # is chosen with probability proportional to D(x)^2.
    probs = d_x^2 / sum(d_x)
    zero_prob = which(d_x == 0)
    centroids[i] = sample(seq_along(probs)[-zero_prob],1,prob=probs[-zero_prob])
  }

  return(data[centroids,])
}
