library(shinydashboard)

dashboardPage(
  dashboardHeader( title = "Stations météos"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Evolution", tabName = "Evolution", icon = icon("th")),
      menuItem("Stations", tabName = "Stations", icon = icon("chart-bar"))
    )
  ),
  dashboardBody(
    # First tab content
    tabItems(
      tabItem(tabName = "Evolution",
              fluidRow(
                valueBoxOutput("nbReleves"),
                
                valueBoxOutput("nbStations")
              ),
              
              fluidRow(
                plotOutput("worldTemperatureGrowth")
              ),
              
              fluidRow(
                sliderInput("page1YearSlider", "Année", 1990, 2019, 2000, sep = "")
              )
      ),
      tabItem(tabName = "Stations",
              fluidRow(
                valueBoxOutput("page2NbReleves"),
                
                valueBoxOutput("page2NbStations")
              ),
              
              fluidRow(
                plotOutput("worldRelevesCount")
              ),
              
              fluidRow(
                sliderInput("page2YearSlider", "Année", 1990, 2019, 2000, sep = "")
              )
      )
    )
  )
)
