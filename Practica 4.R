library("DBI")
library("odbc")
library("dbplyr")

df_PIB %>% 
  ggplot(aes(x = year,
             y = circumference)) +
  geom_point() +
  geom_abline(intercept = 17.3997,
              slope = 0.1068,
              col = 'blue') +
  geom_vline(xintercept = 800,
             col = 'red')

DB_BikeStores <- DBI::dbConnect(odbc::odbc(),
                                Driver = "SQL Server",
                                Server = "dbtedamssql.uh.ac.cr",
                                Database = "BikeStores",
                                UID = rstudioapi::askForPassword("Database user"),
                                PWD = rstudioapi::askForPassword("Database password"),
                                Port = 1433)


Stores<-dbGetQuery(DB_BikeStores,"select * from [sales].[order_items]")
View(Stores)



##Pentaho_User
##Pentaho_User2021


#install.packages("ggplot2") #1- Instalar el paquete ggplot2
library(ggplot2) #2- Cargar el paquete en memoria

#Datos data
#Ejes aes()
#Geotrias geom()

ggplot(data = iris, aes(iris$Sepal.Length,iris$Petal.Length))+
  geom_point()+stat_smooth()

ggplot(data = iris, aes(iris$Sepal.Length,iris$Petal.Length, color=iris$Species))+
  geom_point(alpha= I(0.7))+stat_smooth()+
  facet_wrap(~ iris$Species)


#Creamos el contenedor
ggplot(data=iris, aes(iris$Species, Petal.Length)) +
  geom_boxplot() # dibujamos el diagrama de cajas


#Creamos el contenedor, preparamos a pintar por grupos de especies
ggplot(data=iris, aes(Petal.Length, fill=Species)) +
  geom_density(alpha=0.7)  # dibujamos el histograma


#Qplot


qplot(Sepal.Length, Petal.Length, data = iris, color=Species, size= Petal.Width,
      xlab="Sepal", ylab="Petal", main="Titulo")

#Plotly

install.packages("plotly") #esto lo hacemos en nuestro entorno RStudio una sola vez
library(plotly) #Cargamos el paquete en memoria
#Creamos el gráfico
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species)
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, symbol = ~Species)

plot_ly(data = iris, x = ~Species, y = ~Petal.Length, color = ~Species, type = "box")

plot_ly(data = iris, x = ~Species, y = ~Petal.Length, color = ~Species, type = "bar" )



ggplot(mpg, aes(hwy)) + geom_area(stat = "bin")