library(shinydashboard)

dashboardPage(
  dashboardHeader( title = "Stations météos"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Stats", tabName = "stats", icon = icon("th")),
      menuItem("Graphiques", tabName = "graph", icon = icon("chart-bar")),
      sliderInput("slide", "Nb individus", 1, 82, 10)
    )
  ),
  dashboardBody(
    # First tab content
    tabItem(tabName = "stats",
            fluidRow(
              valueBoxOutput("nbReleves"),
              
              valueBoxOutput("nbStations")
            ),
            
            fluidRow(
              plotOutput("worldTemperatureGrowth")
            ),
            
            fluidRow(
              sliderInput("yearSlider", "Année", 1990, 2019, 2000, sep = "")
            )
    )
  )
)
