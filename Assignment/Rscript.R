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
data7 <- data6[,-2]
head(data4)
totalPlusNuclear <- gather(data6, key = "Type", value = "Value",-Year)
RenewNuclear <- gather(data7, key = "Type", value = "Value",-Year)

ggplot(totalPlusNuclear, aes(x = Year, y = Value, color = Type)) +
  geom_point(alpha = .7, size = 3) +
  geom_smooth(method = "lm") + 
  theme_bw() +
  labs(title = "Total Production throughout the years", x="Year", y="Quadrillion Btu")

ggplot(RenewNuclear, aes(x = Year, y = Value, color = Type)) +
  geom_point(alpha = .7, size = 3) +
  geom_smooth(method = "lm") + 
  theme_bw() +
  labs(title = "Total Production throughout the years", x="Year", y="Quadrillion Btu")
#----------------------------------2 & 3 Treemaps-------------------------------------------------------
data1 <- data[-1:-49,-12:-14]
head(data1)
data2 <- data[-2:-50,-12:-14]
head(data2)
data3 <-bind_rows(data1,data2)
total1 <- gather(data3, key = "Type", value = "Value", -Year)

ggplot(total1, aes(fill = Type, y = Value, x = Year)) + 
  geom_bar(position ="fill", stat = "identity")+ 
  ggtitle("Energy Production in 1973 and 2022")+ 
  theme(plot.title = element_text(hjust = 0.5)) + 
  labs(y = "Percent", fill="Type") +
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(breaks = c(1973, 2022)) +
  scale_fill_carto_d(name = "Energy Type: ", palette = "Safe")

#----------------------------------3,4,5 time series -------------------------------------------------------
ggplot(data = data, aes(x=Year, y=CoalProduction)) + geom_line(color="#D55E00", size=2) + 
  labs(title = "Coal Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw() + scale_fill_carto_d(palette = "Safe")

ggplot(data = data, aes(x=Year, y=WindEnergyProduction)) + geom_line(color="#0072B2", size=2) + 
  labs(title = "Wind Energy Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw() + scale_fill_carto_d(palette = "Safe")

ggplot(data = data, aes(x=Year, y=NuclearElectricPowerProduction)) + geom_line(color="#009e73", size=2) + 
  labs(title = "Nuclear Energy Production troughout the years", x="Year", y="Quadrillion Btu") +
  theme_bw() + scale_fill_carto_d(palette = "Safe")


#----------------------------------6 Stacked horizontal bar chart graphs-------------------------------
#Column 12-14
ggplot(totalPlusNuclear, aes(x = Year, y = Value)) +
  geom_col(aes(fill=Type), width = 0.7) + coord_flip() + 
  labs(title = "Total Production troughout the years", x="Year", y="Quadrillion Btu") +
  scale_fill_carto_d(name = "Energy Type: ", palette = "Safe")

#----------------------------------7. Scatterplot animated----------------------------------------------
data <- data[,-12:-14]
test <- gather(data, key = "Type", value = "Value", -Year)

ggplot(test, aes(x=Year,y=Value, size = 2, color = Type)) +
  geom_point() +
  theme_bw() +
  labs(title = 'Year: {frame_time}', 
       x = 'Year', 
       y = 'Quadrillion Btu') +
  transition_time(as.integer(Year)) +
  shadow_mark(past = T, future = F, alpha(1), size = 2) +
  ease_aes('linear') +
  scale_fill_carto_d(name = "Energy Type: ", palette = "Safe")







