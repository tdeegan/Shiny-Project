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
                       c("Inflows","Outflows"),
                       selected = "Outflows"),
        selectizeInput("ctry_sel",
                       "Select Nation",
                       choices,
                       selected = "United States")
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "Summ",
                      fluidRow(column(6,sliderInput("year_selected", 
                                            label = h3("Year"), 
                                            min = 2005, max = 2016, 
                                            value = 2011, sep="")),
                               infoBoxOutput("Total")),
                      fluidRow(box(htmlOutput("map"), height = 400),
                               box(htmlOutput("hist"), height = 400))),
            tabItem(tabName = "Comp",
                    fluidRow(column(4, sliderInput("years_selected",
                                            label = h3("Year Range"),
                                            min = 2005, max = 2016,
                                            value = c(2011,2016), sep="")),
                             column(4, textInput("text1", 
                                            label = h3("Enter nation to Compare"),
                                            value = "China")),
                             column(4, textInput("text2",
                                            label = h3("Enter nation to Compare"),
                                            value = "India"))),
                    fluidRow(box(htmlOutput("histC"), height = 400)))
                    
        )
    )
))