library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "OECD Bilateral FDI"),
    dashboardSidebar(
        
        sidebarUserPanel("Thomas Deegan", image = "money_globe.jpg"),
        sidebarMenu(
            menuItem("Summary", tabName = "Summ", icon = icon("handshake-o")),
            menuItem("Compare", tabName = "Comp", icon = icon("handshake-o"))
        ),
        selectizeInput("dsel",
                       "Select Direction",
                       c("Inflows","Outflows")),
        selectizeInput("ctry_sel",
                       "Select Nation",
                       choices)
    ),
    dashboardBody(
        #tags$head(
         #   tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        #),
        tabItems(
            tabItem(tabName = "Summ",
                      fluidRow(column(6,sliderInput("year_selected", 
                                            label = h3("Year"), 
                                            min = 2005, max = 2016, 
                                            value = 2011, sep=""))),
                      fluidRow(box(htmlOutput("map"), height = 300),
                               box(htmlOutput("hist"), height = 300))),
            tabItem(tabName = "Comp")
                    
        )
    )
))