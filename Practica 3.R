
#Practica 3

#1.Grafico de barras

df <- read.csv("C:/RStudio/bestsellers.csv",
               header = TRUE,
               sep = ",")


Punto1 = df
view(Punto1)
plot(x=as.factor(Punto1$Genre))


DataName = data.frame(Punto1$Name)
DataUser = data.frame(Punto1$User.Rating)

data = c(DataName,DataUser)

pairs(data)

pairs(~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iris)


mis_fechas <- seq(as.Date(Punto1$Year), by = "year", length = 50 )
plot(mis_fechas,rnorm(50), type = "l")