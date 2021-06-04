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

worldMap <- getMap()
world.points <- fortify(worldMap)
world.points$region <- world.points$id
world.df <- world.points[,c("long","lat","group", "region")]

#################

server <- function(input, output) {
  page1SelectedYear <- reactive({
    input$page1YearSlider
  })
  
  page2SelectedYear <- reactive({
    input$page2YearSlider
  })
  
  ##------- Page 1 -------## 
  
  meanTempFromYear <- reactive({
    year <- input$page1YearSlider
    yearStart <- paste(year, "-01-01", sep = "")
    yearEnd <- paste(year + 1, "-01-01", sep = "")
    data %>%
      filter(`MEAN TEMPERATURE (deg C)` > -20, `MEAN TEMPERATURE (deg C)` < 800) %>% # On enlève les relevés sans températures
      filter(`YEAR-MONTH` >= yearStart, `YEAR-MONTH` < yearEnd) %>%
      filter(`LONGITUDE (deg)` < 180, `LONGITUDE (deg)` > -180, `LATITUDE (deg)` < 180, `LATITUDE (deg)` > -180) %>%
      group_by(`WMO ID`) %>%
      summarize(`Temp (°C)` = mean(`MEAN TEMPERATURE (deg C)`), lat = `LATITUDE (deg)`, lon = `LONGITUDE (deg)`) %>%
      distinct()
  })
  
  tempGrowthFromYear <- reactive({
    year <- input$page1YearSlider
    firstYearStart <- paste(year, "-01-01", sep = "")
    firstYearEnd <- paste(year, "-12-01", sep = "")
    secondYearStart <- paste(year + 1, "-01-01", sep = "")
    secondYearEnd <- paste(year + 1, "-12-01", sep = "")
    
    firstYearTemp <- data %>%
      filter(`MEAN TEMPERATURE (deg C)` > -20, `MEAN TEMPERATURE (deg C)` < 800) %>% # On enlève les relevés sans températures
      filter(`YEAR-MONTH` <= firstYearEnd, `YEAR-MONTH` >= firstYearStart) %>%
      filter(`LONGITUDE (deg)` < 180, `LONGITUDE (deg)` > -180, `LATITUDE (deg)` < 180, `LATITUDE (deg)` > -180) %>%
      group_by(`WMO ID`) %>%
      summarize(Temp = mean(`MEAN TEMPERATURE (deg C)`), lat = `LATITUDE (deg)`, lon = `LONGITUDE (deg)`) %>%
      distinct() %>%
      rename(firstTemp = Temp)
    
    secondYearTemp <- data %>%
      filter(`MEAN TEMPERATURE (deg C)` > -20, `MEAN TEMPERATURE (deg C)` < 800) %>% # On enlève les relevés sans températures
      filter(`YEAR-MONTH` <= secondYearEnd, `YEAR-MONTH` >= secondYearStart) %>%
      filter(`LONGITUDE (deg)` < 180, `LONGITUDE (deg)` > -180, `LATITUDE (deg)` < 180, `LATITUDE (deg)` > -180) %>%
      group_by(`WMO ID`) %>%
      summarize(Temp = mean(`MEAN TEMPERATURE (deg C)`), lat = `LATITUDE (deg)`, lon = `LONGITUDE (deg)`) %>%
      distinct() %>%
      rename(secondTemp = Temp)
    
    right_join(secondYearTemp, firstYearTemp) %>%
      mutate(`Temp (°C)` = secondTemp - firstTemp) %>%
      filter(`Temp (°C)` > -4, `Temp (°C)` < 4)
  })
  
  output$nbReleves <- renderValueBox({
    valueBox(count(data), "Relevés", icon = icon("list"), color = "red")
  })
  
  output$nbStations <- renderValueBox({
    valueBox(count(
      data %>%
        distinct(`WMO ID`)
      ), "Stations", icon = icon("bars"), color = "yellow")
  })
  
  output$worldMeanTemperature <- renderPlot({
    ggplot() + 
      geom_jitter(data = meanTempFromYear(), aes(x = lon, y = lat, color = `Temp (°C)`), size = 2, alpha = 0.5) +
      scale_color_gradient2(low = "green", high = "#FF0000", mid = "#3F94FE") +
      geom_path(data = world.df, aes(x = long, y = lat, group = group)) +
      scale_y_continuous(breaks = (-2:2) * 30) +
      scale_x_continuous(breaks = (-4:4) * 45) +
      coord_map(xlim=c(-180,180)) + 
      labs(title ="Températures moyennes dans le monde")
  })
  
  output$worldTemperatureGrowth <- renderPlot({
    year <- page1SelectedYear()
    ggplot() + 
      geom_jitter(data = tempGrowthFromYear(), aes(x = lon, y = lat, color = `Temp (°C)`), size = 4, alpha = 0.5) +
      scale_color_gradient2(low = "#3F94FE", high = "#FF0000") + 
      geom_path(data = world.df, aes(x = long, y = lat, group = group)) +
      coord_map(xlim=c(-180,180)) + 
      labs(title = paste("Evolution des températures moyennes dans le monde entre ", year, " et ", year + 1, sep = ""))
  })
  
  ##------- Page 2 -------## 
  
  output$page2NbReleves <- renderValueBox({
    year <- page2SelectedYear()
    yearStart <- paste(year, "-01-01", sep = "")
    yearEnd <- paste(year + 1, "-01-01", sep = "")
    valueBox(count(
      data %>%
        filter(`YEAR-MONTH` >= yearStart, `YEAR-MONTH` < yearEnd)
      ), "Relevés", icon = icon("list"), color = "red")
  })
  
  output$page2NbStations <- renderValueBox({
    year <- page2SelectedYear()
    yearStart <- paste(year, "-01-01", sep = "")
    yearEnd <- paste(year + 1, "-01-01", sep = "")
    valueBox(count(
      data %>%
        filter(`YEAR-MONTH` >= yearStart, `YEAR-MONTH` < yearEnd) %>%
        distinct(`WMO ID`)
    ), "Stations", icon = icon("bars"), color = "yellow")
  })
  
  releves <- reactive({
    year <- input$page2YearSlider
    yearStart <- paste(year, "-01-01", sep = "")
    yearEnd <- paste(year + 1, "-01-01", sep = "")
    data %>%
      filter(`YEAR-MONTH` >= yearStart, `YEAR-MONTH` < yearEnd) %>%
      filter(`LONGITUDE (deg)` < 180, `LONGITUDE (deg)` > -180, `LATITUDE (deg)` < 180, `LATITUDE (deg)` > -180) %>%
      group_by(`WMO ID`) %>%
      summarize(count = n(), lat = `LATITUDE (deg)`, lon = `LONGITUDE (deg)`) %>%
      distinct()
  })
  
  output$worldRelevesCount <- renderPlot({
    releves <- releves()
    ggplot() + 
      geom_jitter(data = releves, aes(x = lon, y = lat, color = count), size = 1.5, alpha = 0.5) +
      scale_color_gradient(low = "white", high = "blue") +
      geom_path(data = world.df, aes(x = long, y = lat, group = group)) +
      scale_y_continuous(breaks = (-2:2) * 30) +
      scale_x_continuous(breaks = (-4:4) * 45) +
      coord_map(xlim=c(-180,180)) + 
      labs(title = "Nombres de relevés par station")
    
  })
}
