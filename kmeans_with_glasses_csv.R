library("cluster")
library("factoextra")
library("magrittr")
# Load  and prepare the data
data("USArrests")
setwd('/home/yashwanth/Downloads')
rd=read.csv('glasses.csv')
rd=as.data.frame(rd)#Converting to a DataFrame 
rd=rd[1:ncol(rd)-1]#Removing the label
my_data <-rd %>%
  na.omit() %>%          # Remove missing values (NA)
  scale()                # Scale variables
# View the firt 3 rows
head(my_data, n = 3)
# get_dist(): for computing a distance matrix between the rows of a data matrix. Compared to the standard dist() function, it supports correlation-based distance measures including “pearson”, “kendall” and “spearman” methods.
# fviz_dist(): for visualizing a distance matrix
res.dist <- get_dist(rd, stand = TRUE, method = "pearson")
fviz_dist(res.dist, 
          gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
#Determining the optimal number of clusters: use factoextra::fviz_nbclust()
fviz_nbclust(my_data, kmeans, method = "gap_stat")
#Suggested number of cluster: 7
#Compute and visualize k-means clustering
set.seed(123)
km.res <- kmeans(my_data, 7, nstart = 25)
# Visualize
library("factoextra")
fviz_cluster(km.res, data = my_data,
             ellipse.type = "convex",
             palette = "jco",
             ggtheme = theme_minimal())





