library(ggplot2)
library(plotly)
library(dplyr)

data <- starwars

server <- function(input, output) {
  
  output$boxeFixe <- renderValueBox({
    valueBox("42", "Box fixe", icon = icon("bars"), color = "aqua")
  })
  
  output$nbIndividusBox <- renderValueBox({
    valueBox(count(data), "Individus", icon = icon("list"), color = "red")
  })
  
  output$dimensions <- renderValueBox({
    valueBox(ncol(data), "Dimensions", icon = icon("bars"), color = "yellow")
  })
  
  output$avgHeight <- renderInfoBox({
    data <- data %>% slice(1:(input$slide))
    infoBox("AVERAGE HEIGHT (CM)", 
            data %>% select(height) %>% sapply(mean, na.rm = TRUE) %>% round(1) %>% format(nsmall = 1)
             , icon = icon("long-arrow-alt-up"), color = "purple")
  })
  
  output$medianMass <- renderInfoBox({
    data <- data %>% slice(1:(input$slide))
    infoBox("MEDIAN MASS (KG)", 
            data %>% select(mass) %>% sapply(median, na.rm = TRUE) %>% round(1) %>% format(nsmall = 1)
             , icon = icon("long-arrow-alt-up"), color = "purple")
  })
}
