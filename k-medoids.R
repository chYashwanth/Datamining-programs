library(cluster)
library(factoextra)
data("USArrests")      # Load the data set
df <- scale(USArrests) # Scale the data
head(df, n = 3)        # View the firt 3 rows of the data
  #Determining the optimal number of clusters: use factoextra::fviz_nbclust()
  fviz_nbclust(df, pam, method = "silhouette")+theme_classic()
#Computing PAM clustering
  #Suggested number of cluster:2
pam.res <- pam(df, 2)
print(pam.res)
#Add the point classifications to the original data
dd <- cbind(USArrests, cluster = pam.res$cluster)
head(dd, n = 3)
# Cluster medoids: New Mexico, Nebraska
pam.res$medoids
#Visualizing PAM clusters
fviz_cluster(pam.res, 
             palette = c("#00AFBB", "#FC4E07"), # color palette
             ellipse.type = "t", # Concentration ellipse
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_classic()
)
