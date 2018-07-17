library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "OECD Bilateral FDI"),
    dashboardSidebar(
        
        sidebarUserPanel("Thomas Deegan", image = "money_globe.jpg"),
        sidebarMenu(
            menuItem("Inflows", tabName = "I", icon = icon("handshake-o")),
            menuItem("Outflows", tabName = "O", icon = icon("handshake-o"))
        ),
        selectizeInput("ctry_sel",
                       "Select Nation",
                       choice)
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "I",
                      fluidRow(column(6,sliderInput("year_selected", 
                                            label = h3("Year"), 
                                            min = 2005, max = 2016, 
                                            value = 2011, sep="")))),
                    #,fluidRow(box(htmlOutput("map"), 
                     #            height = 300),
                      #       box(htmlOutput("hist"), 
                       #          height = 300))),
            tabItem(tabName = "O")
                    #,fluidRow() to be replaced
                    
        )
    )
))