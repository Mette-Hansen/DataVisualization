library(shiny)
library(shinyWidgets)
library(dslabs)
library(tidyverse)
library(plotly)

#####Import Data

#Change working directory
setwd("C:/Users/Mette/Documents/DataVisualization/G2DV")

#Type in your data path
data_app <- read_csv("USEnergy.csv", show_col_types = FALSE, na = "Not Available")
#remove missing values 
na.omit(data_app)



ui <- fluidPage(
  
  # Title
  titlePanel("Energy production in the US 1973-2022"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #Inputs
      checkboxGroupInput("energyProductionInput", "Energy type", 
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
    br(), br(),
    verbatimTextOutput("stats"),
    br(), br(),
    plotlyOutput("distplot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dataInput1 <- reactive({
    data_app %>% 
      filter(
        data_app %in% energyProductionInput,
        year >= input$yearInput[1],
        year <= input$yearInput[2])
  })
  output$energyProdPlot <- renderPlot({
    ggplot(dataInput1(), aes(x=year, y = value, color=data_app)) +
      geom_line() +
      theme_bw() +
      xlab("Year") +
      ylab("Count") +
      ggtitle("Energy production in the US 1973-2022")
  })
  output$stats <- renderPrint({
    aggregate(value ~ data_app, data = d(), sum())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

