#Select 500 rows, and try only to work with that
setwd("C:/Users/Mette/Documents/DataVisualization/Assignment")
library(readxl)
library(readr)
library(data.table)
library(ggplot2)
library(rcartocolor)
library(dplyr)
library(gganimate)
library(tidyr)
library(treemapify)

#-----------------------Reads the data and removes NA data -----------------------------------------
data <- read_csv("USEnergy.csv", show_col_types = FALSE, na = "Not Available")
na.omit(data)
#summary(data)
#----------------------------------1. Scatterplot----------------------------------------------------
data1 <- data[,12]
data2 <- data[,14]
data3 <- data[,1]
data4 <- bind_cols(data2,data1)
data5 <- bind_cols(data3,data4)
data6 <-bind_cols(data5,data[,6])
totalPlusNuclear <- gather(data6, key = "Type", value = "Value",-Year)

ggplot(totalPlusNuclear, aes(x = Year, y = Value, color = Type)) +
  geom_point(alpha = .7, size = 3) +
  geom_smooth(method = "lm")
#----------------------------------2 & 3 Treemaps-------------------------------------------------------
data1 <- data[-1:-49,-12:-14]
head(data1)
data2 <- data[-2:-50,-12:-14]
head(data2)
total2022 <- gather(data1, key = "Type", value = "Value", -Year)
total1973 <- gather(data2, key = "Type", value = "Value", -Year)
#this should preserve single bars
ggplot(total2022, aes(fill = Type, area = Value, label = Value)) + geom_treemap() + geom_treemap_text(colour = "white", place = "centre") + labs(title = "Energy Production in 2022")
ggplot(total1973, aes(fill = Type, area = Value, label = Value)) + geom_treemap() + geom_treemap_text(colour = "white", place = "centre") + labs(title = "Energy Production in 1973")

#----------------------------------3,4,5  charts-------------------------------------------------------
ggplot(data = data, aes(x=Year, y=CoalProduction)) + geom_line(color="#D55E00", size=2) + 
  labs(title = "Coal Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw()

ggplot(data = data, aes(x=Year, y=WindEnergyProduction)) + geom_line(color="#0072B2", size=2) + 
  labs(title = "Wind Energy Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw()

ggplot(data = data, aes(x=Year, y=NuclearElectricPowerProduction)) + geom_line(color="#009e73", size=2) + 
  labs(title = "Nuclear Energy Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw()

#----------------------------------6 Stacked horizontal bar chart graphs-------------------------------
#Column 12-14
ggplot(totalPlusNuclear, aes(x = Year, y = Value, color = Type)) +
  geom_col(aes(fill=Type), width = 0.7) + coord_flip()

#----------------------------------7. Scatterplot animated----------------------------------------------
data <- data[,-12:-14]
test <- gather(data, key = "Type", value = "Value", -Year)

ggplot(test, aes(x=Year,y=Value, size = 2, color = Type)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  labs(title = 'Year: {frame_time}', 
       x = 'Year', 
       y = 'Quadrillion Btu') +
  transition_time(Year) +
  ease_aes('linear')







