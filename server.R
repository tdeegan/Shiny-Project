library(shinydashboard)
library(DT)

shinyServer(function(input, output){
  
  output$map <- renderGvis({
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selected, MEASURE_PRINCIPLE == "DO")
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    gvisGeoChart(top10, 'Partner.country.territory','Total')
    
  })
  
  output$hist <- renderGvis({
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selected, MEASURE_PRINCIPLE == "DO")
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    my_options <- list(width="1200px", height="300px",
                       title="Foreign Direct Investment",
                       hAxis="{title:'Destination'}",
                       vAxis="{title:'$USD (in millions)'}")
    
    gvisColumnChart(top10[1:10,], options=my_options)
  })
  
  
})