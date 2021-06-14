library(shinydashboard)

dashboardPage(
  dashboardHeader( title = "Stations météos"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Evolution", tabName = "Evolution", icon = icon("th")),
      menuItem("Stations", tabName = "Stations", icon = icon("chart-bar")),
      menuItem("Pôle Nord", tabName = "PôleNord", icon = icon("snowman"))
    )
  ),
  dashboardBody(
    # First tab content
    tabItems(
      tabItem(tabName = "Evolution",
              fluidRow(
                valueBoxOutput("nbReleves", 6),
                
                valueBoxOutput("nbStations", 6)
              ),
              
              fluidRow(
                plotOutput("worldTemperatureGrowth")
              ),
              
              fluidRow(
                div(style = "margin: auto; width: 80%",
                  sliderInput("page1YearSlider", "Année", 1990, 2019, 2000, sep = "", width = '100%')
                )
              )
      ),
      tabItem(tabName = "Stations",
              fluidRow(
                valueBoxOutput("page2NbReleves", 6),
                
                valueBoxOutput("page2NbStations", 6)
              ),
              
              fluidRow(
                plotOutput("worldRelevesCount")
              ),
              
              fluidRow(
                div(style = "margin: auto; width: 80%",
                    sliderInput("page2YearSlider", "Année", 1990, 2019, 2000, sep = "", width = '100%')
                )
              )
              
      ),
      tabItem(tabName = "PôleNord",
              fluidRow(
                column(12, align="center",
                  plotOutput("poleNordTemperature", width='50%'),
                  plotOutput("poleNordSeaIce", width='50%')
                )
              ),
              
              fluidRow(
                div(style = "margin: auto; width: 80%",
                    sliderInput("page3YearSlider", "Année", 1980, 2020, 2000, sep = "", width = '100%')
                )
              )
              
      )
    )
  )
)
