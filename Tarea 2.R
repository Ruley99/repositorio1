#Librerias a utilizar
library("DBI")
library("odbc")
library(dplyr)
library(plotly)
library(plotly)
library("dbplyr")

#####################################################################################################################################
#Conexion SQL
DB_Coneccion <- DBI::dbConnect(odbc::odbc(),
                                Driver = "SQL Server",
                                Server = "dbtedamssql.uh.ac.cr",
                                Database = "Northwind",
                                UID = rstudioapi::askForPassword("Database user"),
                                PWD = rstudioapi::askForPassword("Database password"),
                                Port = 1433)
#Productos en Stocks
stocks<-dbGetQuery(DB_Coneccion,"select T1.product_id,T1.product_name,T2.quantity,T1.list_price,T1.model_year,T3.brand_name from [production].[products] T1 inner join
[production].[stocks] T2 on T1.product_id = T2.product_id INNER JOIN [production].[brands] T3 ON T1.brand_id=T3.brand_id")
View(stocks)
#Ordenes de ventas
orderDetails<-dbGetQuery(DB_Coneccion,"select T1.OrderID,T1.ProductID,T1.UnitPrice,T1.Quantity,T2.OrderDate,T2.ShipCountry from [dbo].[Order Details] T1 INNER JOIN [dbo].[Orders] T2 
ON T1.OrderID = T2.OrderID")
View(orderDetails)

#####################################################################################################################################
#Creacion de Data
df_stocks <- data.frame(
  "nombre" = stocks$product_name, 
  "cantidad" = stocks$quantity,  
  "year" = stocks$model_year,
  "categoria" = stocks$brand_name
)
#Grafica de Cantidad de productos que existen
plot(stocks$product_id, stocks$quantity, xlab = "Producto", ylab = "Cantidad")

#####################################################################################################################################

#Data Agrupada por la cantidad de productos que se encuentran en stock por cada categoria
dataAgrupada <- df_stocks %>% group_by(categoria)
groupData = dataAgrupada %>% summarise(
  Disponible = sum(cantidad)
)

#Creacion de Data
df_categoria <- data.frame(
  nombre=groupData$categoria[1:8],
  valor=groupData$Disponible[1:8]
)

#Color de graficos
barplot(height=df_categoria$valor, names=df_categoria$nombre, 
        col=rgb(0.8,0.1,0.1,0.6),
        xlab="Categoria", 
        ylab="Cantidades", 
        main="Cantidades por categorias", 
        ylim=c(0,5000)
)
#####################################################################################################################################
#Productos con menos stocks

dataCant <- df_stocks %>% group_by(nombre)
groupCant = dataCant %>% summarise(
  DispoCant = sum(cantidad)
)

df_cant <- data.frame(
  nombre = groupCant$DispoCant[1:10],
  valor = groupCant$nombre[1:10]
)
View(df_cant)
filtrarCantidad = filter(df_cant, df_cant$nombre<=150)
View(filtrarCantidad)

y = filtrarCantidad$nombre
x = filtrarCantidad$valor


#####################################################################################################################################
#Data Agrupada por la cantidad que existen en cada categoria
dataYears <- df_stocks %>% group_by(year)
groupYears = dataYears %>% summarise(
  dispYear = sum(cantidad)
)
View(groupYears)

plot_ly(data = dataYears, x = as.character(groupYears$year), y = groupYears$dispYear ,type = "bar" )

#####################################################################################################################################
#Creacion del total de la factura
df_orderDetails <- data.frame(
  "ProductID"= as.integer(orderDetails$ProductID),
  "UnitPrice" = as.integer(orderDetails$UnitPrice), 
  "Quantity" = orderDetails$Quantity,
  "ShipCountry" = orderDetails$ShipCountry
  
) 
View(df_orderDetails)

totalOrder = mutate(df_orderDetails, Total = (df_orderDetails$UnitPrice*df_orderDetails$Quantity))
View(totalOrder)

Cantidad <-df_orderDetails$Quantity
Precio <- df_orderDetails$UnitPrice
pairs(Cantidad ~ Precio,col = 5)

#Se calcula la cantidad total del precio de los productos comprados por cada pais al que se envio
dataPais <- df_orderDetails %>% group_by(ShipCountry)
groupPais = dataPais %>% summarise(
  precioTotal = sum(UnitPrice*Quantity)
)

#Se crea la data para la creacion del grafico

x <- groupPais$ShipCountry
y <- groupPais$precioTotal
x <- factor(x, levels = unique(x)[order(y, decreasing = TRUE)])
figPais <- data.frame(x, y)
figPais <- plot_ly(figPais, x = ~x, y = ~y, type = 'bar',
               text = y, textposition = 'auto',
               marker = list(color = 'rgb(10,200,150)',
                             line = list(color = 'rgb(10,15,125)', width = 1.5)))
figPais <- figPais %>% layout(title = "Dinero vendido por paises")

figPais





