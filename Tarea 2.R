#Conexion SQL
library("DBI")
library("odbc")
library(dplyr)
library("dbplyr")
DB_stocks <- DBI::dbConnect(odbc::odbc(),
                                Driver = "SQL Server",
                                Server = "dbtedamssql.uh.ac.cr",
                                Database = "BikeStores",
                                UID = rstudioapi::askForPassword("Database user"),
                                PWD = rstudioapi::askForPassword("Database password"),
                                Port = 1433)
stocks<-dbGetQuery(DB_stocks,"select T1.product_id,T1.product_name,T2.quantity,T1.list_price,T1.model_year,T3.brand_name from [production].[products] T1 inner join
[production].[stocks] T2 on T1.product_id = T2.product_id INNER JOIN [production].[brands] T3 ON T1.brand_id=T3.brand_id")
View(stocks)

df_stocks <- data.frame(
  "nombre" = stocks$product_name, 
  "cantidad" = stocks$quantity,  
  "year" = stocks$model_year,
  "categoria" = stocks$brand_name
)

#Cantidad de productos que existen
plot(stocks$product_id, stocks$quantity, xlab = "Producto", ylab = "Cantidad")


#Data Agrupada por la cantidad que existen en cada categoria
dataAgrupada <- df_stocks %>% group_by(categoria)
groupData = dataAgrupada %>% summarise(
  Disponible = sum(cantidad),
)


#dplr
#Productos con menos stocks
filtrarCantidad = filter(df_stocks, df_stocks$cantidad<=20)
View(filtrarCantidad)


barplot(table(stocks$quantity), main = "Tip Histogram", col="lightgreen", xlab="Tipped or not", ylab = "Counts", space=0)




#Creacion de Data
data <- data.frame(
  nombre=groupData$categoria[1:8],
  valor=groupData$Disponible[1:8]
)

#Color de graficos
barplot(height=data$valor, names=data$nombre, 
        col=rgb(0.8,0.1,0.1,0.6),
        xlab="Categoria", 
        ylab="Cantidades", 
        main="Cantidades por categorias", 
        ylim=c(0,5000)
)
