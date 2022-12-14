library(shiny)
library(shinyWidgets)
library(dslabs)
library(tidyverse)
library(plotly)
library(tidyr)
library(dplyr)
library(scales)

#####Import Data

#Change working directory

#setwd("~/DataVisualization/G2DV")

#Type in your data path
data_app <- read_csv("USEnergy.csv", show_col_types = FALSE, na = "Not Available")
#remove missing values 
data_app <- data_app[,-12:-14]
#setnafill(data_app, fill = 0)
na.omit(data_app)
head(data_app)

test <- gather(data_app, key = "Type", value = "Value", -Year)
head(test)

#Test plot
ggplot(test, aes(x=Year, y=Value, color = Type)) + geom_line(linewidth = 1) + xlab("Year") +
  ylab("Quadrillion Btu") +
  ggtitle("Energy production in the US 1973-2022") + theme_bw() + ylim(c(0,3.2)) + xlim(c(1973,2022)) +
  scale_fill_carto_d(name = "Energy Type: ", palette = "Safe")

ui <- fluidPage(
  titlePanel("Energy production in the US 1973-2022"),
  sidebarLayout(
    sidebarPanel( 
      #Checkboxinput group
      checkboxGroupInput("energyProductionInput", label = "Select types of energy:",
                         choices = c("CoalProduction", 
                                     "NaturalGasProduction",
                                     "CrudeOilProduction",
                                     "NaturalGasPlantLiquidsProduction",
                                     "NuclearElectricPowerProduction",
                                     "HydroelectricPowerProduction",
                                     "GeothermalEnergyProduction",
                                     "SolarEnergyProduction",
                                     "WindEnergyProduction",
                                     "BiomassEnergyProduction"),
                         selected = c("CoalProduction", 
                                      "NaturalGasProduction",
                                      "CrudeOilProduction",
                                      "NaturalGasPlantLiquidsProduction",
                                      "NuclearElectricPowerProduction",
                                      "HydroelectricPowerProduction",
                                      "GeothermalEnergyProduction",
                                      "SolarEnergyProduction",
                                      "WindEnergyProduction",
                                      "BiomassEnergyProduction")),
    #year slider
    sliderInput("yearInput", "Year", min = 1973, max = 2022, value = c(1973,2022), sep = ""),
    downloadButton("downloadReport","Download"),
    ),
    mainPanel(
      plotOutput("timeSeriesPlot"),
      br(),
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dataInput1 <- reactive({ test %>% filter(
    Type %in% input$energyProductionInput,
    Year >= input$yearInput[1],
    Year <= input$yearInput[2])
  })
  #Render functions
  output$timeSeriesPlot <- renderPlot({
    ggplot(dataInput1(), aes(x = Year, y = Value, color = Type)) + geom_line(size = 1) + xlab("Year") +
      ylab("Quadrillion Btu") +
      scale_x_continuous(limits = c(input$yearInput[1], input$yearInput[2])) +
      scale_y_continuous(breaks = scales::breaks_extended()) +
      ggtitle("Energy production in the US 1973-2022") + theme_bw() +
      scale_fill_carto_d(name = "Energy Type: ", palette = "Safe")
    
  })
  output$downloadReport <- downloadHandler(
    filename = "Data_Visualization_Report.pdf",
    content = function(file) {
      file.copy("www/Data_Visualization_Report.pdf", file)
    }
  )
}
#+ ylim(c(0, 3.2)) + xlim(c(1973, 2022)

# Run the application 
shinyApp(ui = ui, server = server)

