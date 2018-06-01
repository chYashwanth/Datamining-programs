setwd('/home/yashwanth/Downloads')
rd=read.csv('glasses.csv')
df=as.data.frame(rd)#Converting to a DataFrame 
df=rd[2:ncol(rd)-1]#Removing the label
library(cluster)
library(factoextra)
head(df, n = 3)        # View the first 3 rows of the data
#Determining the optimal number of clusters: use factoextra::fviz_nbclust()
a=fviz_nbclust(df, kmeans, method = "silhouette")+theme_classic()
#Computing PAM clustering
pam.res <- pam(df,3)
print(pam.res)
#Add the point classifications to the original data
dd <- cbind(rd, cluster = pam.res$cluster)
head(dd, n = 3)
# Cluster medoids: New Mexico, Nebraska
pam.res$medoids
#Visualizing PAM clusters
fviz_cluster(pam.res, 
             palette = c("#00AFBB", "#FC4E07","#AAAAAA"), # color palette
             ellipse.type = "t", # Concentration ellipse
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_classic()
)
