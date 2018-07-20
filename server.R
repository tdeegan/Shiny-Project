library(shinydashboard)
library(DT)

shinyServer(function(input, output){
  
  output$mapI <- renderGvis({
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selectedI, MEASURE_PRINCIPLE == "DI")
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    gvisGeoChart(top10, 'Partner.country.territory','Total',
                 options = list(width = "auto", height = "auto"))
    
  })
  
  output$mapO <- renderGvis({
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selectedO, MEASURE_PRINCIPLE == "DO")
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    gvisGeoChart(top10, 'Partner.country.territory','Total',
                 options = list(width = "auto", height = "auto"))
    
  })
  
  output$histI <- renderGvis({
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selectedI, MEASURE_PRINCIPLE == "DI")
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    my_options <- list(width="600px", height="300px",
                       title="Foreign Direct Investment - Inflows",
                       hAxis="{title:'Destination'}",
                       vAxis="{title:'$USD (in millions)'}")
    
    gvisColumnChart(top10[1:7,], options=my_options)
  })
  
  output$histO <- renderGvis({
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selectedO, MEASURE_PRINCIPLE == "DO")
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    my_options <- list(width="600px", height="300px",
                       title="Foreign Direct Investment - Outflows",
                       hAxis="{title:'Destination'}",
                       vAxis="{title:'$USD (in millions)'}")
    
    gvisColumnChart(top10[1:7,], options=my_options)
  })
  
  
})