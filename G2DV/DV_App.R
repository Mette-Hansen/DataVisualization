library(shiny)
library(shinyWidgets)
library(dslabs)
library(tidyverse)
library(plotly)
library(tidyr)

#####Import Data

#Change working directory
setwd("C:/Users/Mette/Documents/DataVisualization/G2DV")

#Type in your data path
data_app <- read_csv("USEnergy.csv", show_col_types = FALSE, na = "Not Available")
#remove missing values 
na.omit(data_app)
data_app <- data_app[,-14]
data_app <- data_app[,-13]
data_app <- data_app[,-12]
head(data_app)

#d<-data.frame(x=rnorm(10),y=rnorm(10),z=1:10)
#gather(d,key = c("x","y"), value = "xy")

test <- gather(data_app, key = "Type", value = "Value", -Year)

ggplot(test, aes(x=Year, y=Value, color = Type)) + geom_line(size = 1) + xlab("Year") +
  ylab("Quadrillion Btu") +
  ggtitle("Energy production in the US 1973-2022") + theme_bw()





ggplot(data_app, aes(x=Year)) +
  geom_line(aes(y=CoalProduction), color = "darkred") +
  geom_line(aes(y=NaturalGasProduction), color = "blue") +
  theme_bw() +
  xlab("Year") +
  ylab("Values") +
  ggtitle("Energy production in the US 1973-2022")


ui <- fluidPage(
  
  # Title
  titlePanel("Energy production in the US 1973-2022"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #Inputs
      checkboxGroupInput("energyProductionInput", "CoalProduction", 
                         choices = c("CoalProduction", 
                                     "NaturalGasProduction",
                                     "CrudeOilProduction",
                                     "NaturalGasPlantLiquidsProduction",
                                     "NuclearElectricPowerProduction",
                                     "HydroelectricPowerProduction",
                                     "GeothermalEnergyProduction",
                                     "SolarEnergyProduction",
                                     "WindEnergyProduction",
                                     "BioMassEnergyProduction"), 
                         selected = c("CoalProduction", 
                                      "NaturalGasProduction",
                                      "CrudeOilProduction",
                                      "NaturalGasPlantLiquidsProduction",
                                      "NuclearElectricPowerProduction",
                                      "HydroelectricPowerProduction",
                                      "GeothermalEnergyProduction",
                                      "SolarEnergyProduction",
                                      "WindEnergyProduction",
                                      "BioMassEnergyProduction")),
      sliderInput("yearInput", "Year", min = 1973, max = 2022, 
                  value = c(1973,2022), sep = "")
    ),
  mainPanel(
    plotOutput("energyProdPlot"),
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dataInput1 <- reactive({ data_app %>% filter(
    data_app == input$energyProductionInput,
    year >= input$yearInput[1],
    year <= input$yearInput[2])
  })
  output$energyProdPlot <- renderPlot({
    ggplot(dataInput1(), aes(x=Year, y = value, color=data_app)) +
      geom_line() +
      theme_bw() +
      xlab("Year") +
      ylab("Values") +
      ggtitle("Energy production in the US 1973-2022")
  })
}

# Run the application 
#shinyApp(ui = ui, server = server)

