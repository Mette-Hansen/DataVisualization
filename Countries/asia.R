library(readxl)
library(ggplot2)
asia <- read_excel("asia.xlsx")
View(asia)
ggplot(asia) + geom_line(mapping = aes(x = year, y = gdpPercap, group=country))
ggplot(asia) + geom_line(mapping = aes(x = year, y = gdpPercap, color=country))
# Dotted lines + colors
ggplot(asia) + geom_line(mapping = aes(x = year, y = gdpPercap, linetype=country, color = country))
