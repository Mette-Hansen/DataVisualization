library(shiny)
library(tidyverse)

#####Import Data

#Change working directory
#setwd("C:/Users/Mette/Documents/DataVisualization/G2DV")

#type in your data path
dat<-read_csv("DataExerciseShinyApps.csv")
dat<- dat %>% select(c("pid7","ideo5"))

#remove missing values 
dat<-drop_na(dat)

ui <- fluidPage(
  
  # Title
  titlePanel("Data Excercise"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 20,
                  value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- as.numeric(unlist(dat["pid7"]))
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = '#009E73', border = 'white',
         xlab = 'pid7',
         main = 'Shiny Histogram')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

