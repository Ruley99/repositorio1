library(readxl)
library(NLP)
library(ggplot2)
library(dplyr)
library(plotly)
library("dbplyr")

#Carga de archivo Excel
Data_PIB<- read_excel("C:/RStudio/BD_PIB.xlsx")
View(Data_PIB)

#Visualizacion de datos
#Creación de data Frame
df_PIB <- data.frame(
  "year" = (Data_PIB$Year),
  "inflacion" = Data_PIB$Y,
  "pobreza" = Data_PIB$X2,
  "PIB" = Data_PIB$X5,
  "Desempleo" = Data_PIB$X4
)
################################################################################
p1 <- ggplot(df_PIB, aes(x=year, y=inflacion)) +
  geom_point() +
  geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE) +
  labs(x = "Año", y="Inflación") 
p1

################################################################################

p2 <- df_PIB %>% 
  ggplot( aes(x=as.double(year), y=pobreza)) +
  geom_line(color="#69b3a2") +
  labs(x = "Año", y="Nivel de Pobreza") +
  geom_point() +
  theme_classic()
p2

################################################################################
x <- df_PIB$year
y <- df_PIB$Desempleo
x <- factor(x, levels = unique(x)[order(y, decreasing = TRUE)])

p3 <- data.frame(x, y)
p3 <- plot_ly(p3, x = ~x, y = ~y, type = 'bar',
                   text = y, textposition = 'auto',
                   marker = list(color = 'rgb(50,75,85)',
                                 line = list(color = 'rgb(10,15,125)', width = 1)))
p3 <- p3 %>% layout(title = "Tasa de desempleo por año")

p3
################################################################################

