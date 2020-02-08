# kmeanspp
R package to choose initial centers for K-means via K-means++ algorithm.

## Installation
```
library(devtools)
install_github("jacquesattack/kmeanspp")
```

## Usage
```
library(kmeanspp)
d = faithful %>% rename(x = eruptions, y = waiting)
kpp_centers = kpp(d,2)
kmeans(d,centers = kpp_centers)
```
