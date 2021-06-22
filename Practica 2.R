#DATAFRAMES

vectorPelicula

names(vectorPelicula) = c("Peli1","Peli2","Peli3","Peli4")

vectorPelicula

iris
trees
warpbreaks


#Convertir a dataframe
is.data.frame(iris)
iris = data.frame(iris)
class(iris)

iris
View(iris)


# Creamos vectores con los valores 

nombre = c("Juan", "Margarita", "Ruben", "Daniel") 

apellido = c("Sanchez", "Garcia", "Sancho", "Alfara") 

fecha_nacimiento = as.Date(c("1976-06-14", "1974-05-07", "1958-12-25", "1983-09-19") )

sexo = c("HOMBRE", "MUJER", "HOMBRE", "HOMBRE") 

nro_hijos = c(1, 2, 3, 4) 

#Creación con la función data.frame

censo = data.frame(nombre,apellido,fecha_nacimiento,sexo,nro_hijos)
class(censo)
View(censo)

#head()
head(censo)
#tail
tail(censo)
#str
str(censo)

#acceso a variables 
View(data.frame(censo$sexo))
censo$sexo=as.factor(censo$sexo)

quantile(iris$Sepal.Length)

ncol(censo)
names(censo)
View(censo[2:4])

#Ejemplo 1

#a

results=c("A","A", "B", "B", "B", "B", "B","I","I","I","R","I","I","I","R","R",
          "R","R","R","R","R","R","R","R","R", "M", "M", "M", "M", "M", "M",
          "M", "M", "M", "M", "M", "M", "M","A","A")



#frecuencia absoluta

FrecuenciaAbsoluta = table(results)
FrecuenciaAbsoluta

#frecuencia relativa

FrecuenciaRelativa = FrecuenciaAbsoluta/length(results)
FrecuenciaRelativa


#3


nombre = c("Hugo", "Paco", "Luis", "Paty", "Maria", "Ruben", "Gaby") 

edad = c(28L, 26L, 32L, 24L, 33L, 23L, 43L)  

sueldos = c(12.5, 13.5, 14.8, 7.1, 57.7, 45.3, 34.2)  

genero = c("M", "M", "M", "F", "F", "M", "F") 

pasatiempos = c("musica", "musica", "estudio", "videojuegos", "musica", "musica", "videojuegos")

#Creación con la función data.frame

pasatiempos = data.frame(nombre,edad,sueldos,genero,pasatiempos)


#4

int_vec <- c(1,2,3)

char_vec <- c("a", "b", "c")

bool_vec <- c(TRUE, TRUE, FALSE)

Salario <- c(5000,56700,6000)

salario5<-(DataFlair$Salario*1.05)

##salario <- salario * 0.05

DataFlair = data.frame(int_vec,char_vec,bool_vec,salario5)
print(salario5)


#Parte2

gen = c("M", "M", "M", "F", "F", "M", "F", "F", "M", "M") 
years = c(28L, 26L, 32L, 24L, 33L, 23L, 43L, 40L, 28L, 23L) 
glucemia = c(123,230,180,164,210,220,193,202,152,185)
antidiabeticos = c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE)


misPacientes = data.frame(gen,years,glucemia,antidiabeticos)

--------------------------------------------------------------------------
max(misPacientes$years)
min(misPacientes$years)
mean(misPacientes$years)
sd(misPacientes$years)

#frecuencia absoluta
FrecAbs = table(misPacientes$glucemia)
FrecAbs

#frecuencia relativa
FrecAbsGen = table(misPacientes$gen)
FrecRel = FrecAbsGen/length(gen)
FrecRel

#Quartil
cuartil <- (misPacientes$glucemia)
quantile(cuartil)

round(sd(misPacientes$glucemia),2)

plot(as.factor(misPacientes$gen))
hist (misPacientes$glucemia)



