## ui.R ##
library(shinydashboard)

dashboardPage(
  dashboardHeader( title = "Star Wars"),
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
              valueBoxOutput("boxeFixe"),
              
              valueBoxOutput("nbIndividusBox"),
              
              valueBoxOutput("dimensions")
            ),
            
            fluidRow(
              infoBoxOutput("avgHeight"),
              
              infoBoxOutput("medianMass"),
              
              
            )
    )
  )
)