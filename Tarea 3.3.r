library("DBI")
library("odbc")
library("dbplyr")
library(dplyr)
library(plotly)
#COnexi�n a la BD
DB_Adreess <- DBI::dbConnect(odbc::odbc(),
                                Driver = "SQL Server",
                                Server = "dbtedamssql.uh.ac.cr",
                                Database = "AdventureWorksLT2017",
                                UID = rstudioapi::askForPassword("Database user"),
                                PWD = rstudioapi::askForPassword("Database password"),
                                Port = 1433)

#Informaci�n del Query a ejecutar
Address<-dbGetQuery(DB_Adreess,"select T1.CustomerID, T1.FirstName, T1.LastName,T3.City,T3.StateProvince,T3.CountryRegion, T1.EmailAddress, T1.Phone from[SalesLT].[Customer] T1 INNER JOIN
[SalesLT].[CustomerAddress] T2 ON T1.CustomerID = T2.CustomerID  INNER JOIN
[SalesLT].[Address] T3 ON T2.AddressID = T3.AddressID")


#Filtraci�n por las 3 principales ciudades
filterCity = filter(Address, Address$City=='San Diego'| Address$City=='Las Vegas'| Address$City=='Austin')

#orden por Apellido
orderLN = arrange(Address, Address$LastName)

#Creacion de columna de nombre completo y de la direcci�n
AddressComplete = Address %>%
  mutate(AddressComplete = paste(Address$City,Address$StateProvince,Address$CountryRegion))%>%
  mutate(NameComplete = paste(Address$FirstName,Address$LastName))

#Selecci�n de los valores m�s importantes
valFin = select(AddressComplete, NameComplete,AddressComplete,EmailAddress,Phone)

#Renombre de las columnas
colnames(valFin) = c("Nombre Completo", "Direcci�n", "Correo Electronico", "Telefono")
View(valFin)