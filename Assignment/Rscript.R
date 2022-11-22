#Select 500 rows, and try only to work with that
setwd("C:/Users/Mette/Documents/DataVisualization/Assignment")
library(readxl)
library(readr)
library(data.table)
library(ggplot2)
library(rcartocolor)


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


#-------------Time Series graphs---------------------
#Scatterplot over coal production
#ggplot(data = data, aes(x=Year, y=CoalProduction)) + geom_point()

#Timeseries over coal production -> answer to first question
#coalProd <- data[[2]]
#plot.ts(timeSeriesCoal, main = "Coal Production troughout the years", 
#        xlab = "Year", ylab = "Quadrillion Btu",
#        col = "#d55e00", lwd=3, type = "l")
#timeSeriesCoal <- ts(coalProd, start = c(1973,1))
#windEn <- data[[10]]
#timeSeriesWind <- ts(windEn, start = c(1973,1))
#plot.ts(timeSeriesWind, main = "Wind Energy Production troughout the years", 
#        xlab = "Year", ylab = "Quadrillion Btu",
#        col = "#0072b2", lwd=3, type = "l")+ abline()

ggplot(data = data, aes(x=Year, y=CoalProduction)) + geom_line(color="#D55E00", size=2) + 
  labs(title = "Coal Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw()

ggplot(data = data, aes(x=Year, y=WindEnergyProduction)) + geom_line(color="#0072B2", size=2) + 
  labs(title = "Wind Energy Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw()

ggplot(data = data) + labs(title = "Wind Energy and Coal Production troughout the years", 
                           x="Year", y="Quadrillion Btu") + theme_bw() +
  geom_line(color ="#D55E00", size = 2, aes(x=Year, y=CoalProduction)) +
  geom_line(color="#0072B2", size=2, aes(x=Year, y=WindEnergyProduction)) 
  







