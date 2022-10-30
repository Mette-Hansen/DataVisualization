#Select 500 rows, and try only to work with that
#setwd("C:/Users/Mette/Documents/DataVisualization/Assignment")
library(readxl)
library(readr)
library(data.table)
library(ggplot2)
data <- read_csv("USEnergy.csv", show_col_types = FALSE)
#Just a test
ggplot(data) + geom_line(mapping = aes(x = data[[2]], y = data[[3]]))

#Scatterplot
ggplot(data, aes(x = data[[2]], y = data[[3]])) + geom_point()

#Select columns from csv
#dataTable <- read.table("USEnergy.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#names(dataTable)
#x1 <- dataTable["CoalProduction"]
#y1 <- dataTable["NaturalGasProduction"]
#plot(x1,y1)

#Final scatterplot that actually works
ggplot(data = data, aes(x=Year, y=CoalProduction)) + geom_point()
ggplot(data = data, aes(x=Year, y=WindEnergyProduction)) + geom_col()
