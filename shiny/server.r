library(tidyverse)
library(rworldmap)
library(geosphere)
library(gpclib)
library(mapproj)
library(rnaturalearth)
library(plotly)
library(sf)
data <- read_csv('../data/Meteo_Station.csv')
dataSeaIce <- read_csv('../data/Sea_Ice.csv')
tempColor <- '#ec7c73'

### Data preparation ###

data$`YEAR-MONTH` <- as.Date(paste(data$`YEAR-MONTH`,"-01",sep=""))
data$`MEAN SEA LEVEL PRESSURE HEIGHT FLAG` <- as.character(data$`MEAN SEA LEVEL PRESSURE HEIGHT FLAG`)
data$`MAXIMUM TEMPERATURE (deg C)` <- (data$`MAXIMUM TEMPERATURE (deg C)`)/10
data$`MINIMUM TEMPERATURE (deg C)` <- (data$`MINIMUM TEMPERATURE (deg C)`)/10
data$`MEAN TEMPERATURE (deg C)` <- (data$`MEAN TEMPERATURE (deg C)`)/10

#################

server <- function(input, output) {
  output$nbReleves <- renderValueBox({
    valueBox(count(data), "Relevés", icon = icon("list"), color = "red")
  })
  
  output$nbStations <- renderValueBox({
    valueBox(count(
      data %>%
        distinct(`WMO ID`)
      ), "Stations", icon = icon("bars"), color = "yellow")
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
