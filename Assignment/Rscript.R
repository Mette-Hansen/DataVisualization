#Select 500 rows, and try only to work with that
#setwd("C:/Users/Mette/Documents/DataVisualization/Assignment")
library(readxl)
library(readr)
library(data.table)
library(ggplot2)
#Reads the data and removes NA data
data <- read_csv("USEnergy.csv", show_col_types = FALSE, na = "Not Available")
na.omit(data)
summary(data)

#Just a test
#ggplot(data) + geom_line(mapping = aes(x = data[[2]], y = data[[3]]))

#Scatterplot
#ggplot(data, aes(x = data[[2]], y = data[[3]])) + geom_point()

#Select columns from csv
#dataTable <- read.table("USEnergy.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#names(dataTable)
#x1 <- dataTable["CoalProduction"]
#y1 <- dataTable["NaturalGasProduction"]
#plot(x1,y1)
#ggplot(data = data, aes(x=Year, y=WindEnergyProduction)) + geom_col()
#ggplot(data = data, aes(x=CoalProduction)) + geom_histogram()


#-------------Final scatterplot that actually works---------------------
#Scatterplot over coal production
ggplot(data = data, aes(x=Year, y=CoalProduction)) + geom_point()
#Timeseries over coal production -> answer to first question
coalProd <- data[[2]]
timeSeriesCoal <- ts(coalProd, start = c(1973,1))

windEn <- data[[10]]
timeSeriesWind <- ts(windEn, start = c(1973,1))
#bind <- cbind(timeSeriesCoal,timeSeriesWind)
#plot.ts(bind)


