library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "OECD FDI"),
    dashboardSidebar(
        
        sidebarUserPanel("Thomas Deegan"),
        sidebarMenu(
            menuItem("Summary by Partner", tabName = "Summ", icon = icon("handshake-o")),
            menuItem("Partner Comparison", tabName = "Comp", icon = icon("handshake-o")),
            menuItem("Global Summary", tabName = "USumm", icon =icon("handshake-o"))
        ),
        selectizeInput("dsel",
                       "Select Direction",
                       c("Inflows","Outflows"),
                       selected = "Outflows")
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "Summ",
                      fluidRow(column(4,sliderInput("year_selected", 
                                            label = h3("Year"), 
                                            min = 2005, max = 2016, 
                                            value = 2011, sep="")),
                               column(4, selectizeInput("ctry_sel",
                                                        "Select Nation",
                                                        choices,
                                                        selected = "United States")),
                               infoBoxOutput("Total")),
                      fluidRow(box(htmlOutput("map"), height = 425),
                               box(htmlOutput("hist"), height = 425))),
            tabItem(tabName = "Comp",
                    fluidRow(column(4, sliderInput("years_selected",
                                            label = h3("Year Range"),
                                            min = 2005, max = 2016,
                                            value = c(2011,2016), sep="")),
                             column(4, selectizeInput("ctry_sel2",
                                            "Select Reporting Nation",
                                            choicesC,
                                            selected = "United States")),
                             column(2, textInput("text1", 
                                            label = h3("Enter nation to Compare"),
                                            value = "China")),
                             column(2, textInput("text2",
                                            label = h3("Enter nation to Compare"),
                                            value = "India"))),
                    fluidRow(box(htmlOutput("histC"), height = 400))),
            tabItem(tabName = "USumm",
                    fluidRow(column(4, sliderInput("uyears_selected",
                                                   label = h3("Year Range"),
                                                   min = 2005, max = 2016,
                                                   value = 2016, sep=""))),
                    fluidRow(box(htmlOutput("histU"), width = 7)))
                    
        )
    )
))