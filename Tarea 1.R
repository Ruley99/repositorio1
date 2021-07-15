#Instalamos solo un paquete dplyr
install.packages("dplyr")
library(dplyr)


#Instalamos todos los paquetes de la colección 
install.packages("tidyverse")
library(tidyverse)


Productos = data.frame(Productos)
class(Productos)


#Tarea 1

#Punto1
notasEstudiantes = c(9,9.2,8.5,10,8.4,9,6.2,7.5,8,7,5.5)
names(notasEstudiantes) <- "Notas"
plot(notasEstudiantes)



#Punto 2.A
library(readxl)
BD_Pruebas <- read_excel("C:/RStudio/BD Pruebas.xlsx")
View(BD_Pruebas)

#Maximo, minimo y la media de las ventas de los empleados
#Punto 2.B
totalComisiones = ((BD_Pruebas$Total_Ventas/BD_Pruebas$Comision)+BD_Pruebas$Total_Ventas)
view(totalComisiones)
max(BD_Pruebas$Total_Ventas)
min(BD_Pruebas$Total_Ventas)
mean(BD_Pruebas$Total_Ventas)


View(arrange(BD_Pruebas,desc(BD_Pruebas$Total_Ventas)))
#Punto 2.C

dataFiltrada <-filter(BD_Pruebas, BD_Pruebas$Total_Ventas >= 4500 & BD_Pruebas$Comision >= 3)
view(dataFiltrada)

#Punto 2.D
varGroup = BD_Pruebas%>% group_by(Comision) %>% summarise(Total_Ventas=n())
varGroup = data.frame(varGroup)
view(varGroup)

#Punto 2.E
ordenVentas <- BD_Pruebas %>% arrange(desc(BD_Pruebas$Ventas))
ordenVentas = data.frame(ordenVentas)
view(ordenVentas)

#Punto 2.F
colComision <- mutate(BD_Pruebas, comision = (BD_Pruebas$Total_Ventas/BD_Pruebas$Comision)+BD_Pruebas$Total_Ventas)
colComision = data.frame(colComision)
view(colComision)

#Punto 2.G

#Punto 3
salarios = c(432.21,239.48,249.94,373.22,233.86,366,331.11,258.86,349.20,31.60)


mean(salarios)
max(salarios)
min(salarios)
sd(salarios)

#Punto 4
library(readxl)
BD_Empleado <- read_excel("C:/RStudio/BD_Empleado.xlsx")
View(BD_Empleado)

library(readxl)
BD_Facturas <- read_excel("C:/RStudio/BD_FacturaS.xlsx")
View(BD_Facturas)

bdFact = data.frame(BD_Facturas)

bdEmpl = data.frame(BD_Empleado)
joinFacturas <- merge(bdFact,bdEmpl, by = "EmployeeID")
view (joinFacturas)



varFacturas = joinFacturas%>% group_by(EmployeeID,LastName) %>% summarise(ID.order=n())
view(varFacturas)

#Punto 5
cafe = c(7, 6, 5, 8, 7, 7, 7, 5, 6, 8)
sd(cafe)
#Punto 6
percent = quantile(cafe, probs = seq(0, 1, 0.25))
percent


Nota:96
