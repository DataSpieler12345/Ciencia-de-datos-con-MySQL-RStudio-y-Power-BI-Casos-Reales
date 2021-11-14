rm(list =  ls())
options(scipen=999)

## Carga de Librerias 
library(DBI)
library(RMySQL)
library(RJDBC)

library(factoextra)
library(ggplot2)

library(dplyr)

# Llamar al archivo de conexion

source("E:/E-PLATTTFORMS/UDEMY/Ciencia de datos con MySQL, RStudio y Power BI Casos Reales/conexion.R")

# Desarrollo del clustering 

dbGetQuery(conn, "set names utf8")

cluster <-dbGetQuery(conn, statement = "SELECT transa.customer_id as customer, SUM(transa.price) as ventas,
                      COUNT(DISTINCT transa.invoice) as transacciones, SUM(transa.price)/ COUNT(DISTINCT transa.invoice) as ticket_medio 
                      FROM `transa` JOIN clientes on transa.customer_id = clientes.customer_id WHERE transa.price>0 
                      GROUP BY transa.customer_id ORDER BY `transacciones` DESC")

# Escalar los datos para esstandarizar

data_cluster <- data.frame(cluster[,-1], row.names =cluster[,1])
data_escalada <- scale(data_cluster)
#head(data_escalada)

#Explorar la cantidad optima de clusteres

fviz_nbclust(data_escalada, kmeans, method ="wss")+
 # labs(subtitle = "wss method")

fviz_nbclust(data_escalada, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")


# Aplicacion de Kmedia para clusterizar
set.seed(123)
kmediasclientes<-kmeans(data_escalada,2, nstart = 25)
#print(kmediasclientes)


aggregate(data_cluster, by=list(cluster=kmediasclientes$cluster), mean)

dd <- cbind(data_cluster, cluster = kmediasclientes$cluster)

#exploracion de resultados
#head(dd)

kmediasclientes$centers
kmediasclientes$size
kmediasclientes$cluster

fviz_cluster(kmediasclientes, data = data_escalada,
             palette = c("#2E9FDF", "#FC4E07"),
             ellipse.type = "euclid", # Elipses de concentracion
             star.plot = TRUE, # Coloca lineas desde los centrides a los items
             repel = TRUE, # Evita la sobre impresion de etiquetas
             ggtheme = theme_minimal()
)      

########## Creacion de la tabla a guardar en la base de datos

df <- tibble::rownames_to_column(dd, "customer")
df <- df[,c(1,5)]

dbWriteTable(conn, name='cluster_retail', value=df, row.names=FALSE, append=TRUE, field.types= c(customer="varchar(10)", cluster="numeric"))

dbDisconnect(conn) 
