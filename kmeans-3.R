library("cluster")
library("factoextra")
library("magrittr")
# Load  and prepare the data
data("USArrests")
my_data <- USArrests %>%
  na.omit() %>%          # Remove missing values (NA)
  scale()                # Scale variables
# View the firt 3 rows
head(my_data, n = 3)
# get_dist(): for computing a distance matrix between the rows of a data matrix. Compared to the standard dist() function, it supports correlation-based distance measures including “pearson”, “kendall” and “spearman” methods.
# fviz_dist(): for visualizing a distance matrix
res.dist <- get_dist(USArrests, stand = TRUE, method = "pearson")
fviz_dist(res.dist, 
          gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
#Determining the optimal number of clusters: use factoextra::fviz_nbclust()
fviz_nbclust(my_data, kmeans, method = "gap_stat")
#Suggested number of cluster: 3
#Determining the optimal number of clusters
set.seed(123)
# Compute
library("NbClust")
res.nbclust <- USArrests %>%
  scale() %>%
  NbClust(distance = "euclidean",
          min.nc = 2, max.nc = 10, 
          method = "complete", index ="all") 
# Visualize
library(factoextra)
fviz_nbclust(res.nbclust, ggtheme = theme_minimal())
#Compute and visualize k-means clustering
set.seed(123)
km.res <- kmeans(my_data, 2, nstart = 25)
# Visualize
library("factoextra")
fviz_cluster(km.res, data = my_data,
             ellipse.type = "convex",
             palette = "jco",
             ggtheme = theme_minimal())





