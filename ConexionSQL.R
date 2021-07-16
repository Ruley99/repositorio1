


install.packages("DBI")
install.packages("odbc")
install.packages("dbplyr")

library("DBI")
library("odbc")
library("dbplyr")
DB_BikeStores <- DBI::dbConnect(odbc::odbc(),
                                Driver = "SQL Server",
                                Server = "dbtedamssql.uh.ac.cr",
                                Database = "BikeStores",
                                UID = rstudioapi::askForPassword("Database user"),
                                PWD = rstudioapi::askForPassword("Database password"),
                                Port = 1433)
Stores<-dbGetQuery(DB_BikeStores,"select * from [sales].[order_items]")
View(Stores)