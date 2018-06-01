library('stringr')
library(NbClust)
library(factoextra)
setwd('/home/yashwanth/Downloads')
rd=read.csv('glasses.csv')
rd=as.data.frame(rd)#Converting to a DataFrame 
rd=rd[1:ncol(rd)-1]#Removing the label
rd=scale(rd)#Scaling of objects to improve accuracy
# dat = attitude[,c(3,4)]
# Check for the optimal number of clusters given the data
#factoextra to determine the optimal number clusters for a given clustering methods and for data visualization.
#NbClust for computing about 30 methods at once, in order to find the optimal number of clusters.
# Elbow method
fviz_nbclust(rd, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")
# Silhouette method
fviz_nbclust(rd, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")
# Gap statistic
# nboot = 50 to keep the function speedy. 
# recommended value: nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(rd, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")


nb <- NbClust(rd, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "kmeans")
a= fviz_nbclust(nb)
s=a$labels$title
no_of_clusters=as.integer(str_sub(s,-1,-1))
set.seed(7)
km2 = kmeans(rd, no_of_clusters, nstart=100)
plot(rd, col =(km2$cluster +1) , main=paste("K-Means result with",no_of_clusters,"clusters"), pch=20, cex=1.6)
