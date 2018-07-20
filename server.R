library(shinydashboard)
library(DT)

shinyServer(function(input, output, session){
  
  observe({
    ls = fdi %>%
      filter(., Year == input$year_selected, 
             MEASURE_PRINCIPLE == ifelse(input$dsel == "Inflows", "DI","DO")) %>%
      group_by(.,Reporting.country) %>%
      summarize(.,Total=sum(Value)) %>%
      filter(.,Total > 0) 
    
    ls <- as.vector(ls$Reporting.country)
      
    if(!(input$ctry_sel %in% ls)){
      updateSelectizeInput(
        session, "ctry_sel",
        choices = ls
      )
    } else{
      updateSelectizeInput(
        session, "ctry_sel",
        choices = ls,
        selected = input$ctry_sel
      )
    }
    
  })
  
  output$map <- renderGvis({
    
    mp <- ifelse(input$dsel == "Inflows","DI","DO")
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selected, 
                      MEASURE_PRINCIPLE == mp)
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    gvisGeoChart(top10, 'Partner.country.territory','Total',
                 options = list(width = "auto", height = "auto"))
    
  })
  
  output$hist <- renderGvis({
    
    mp <- ifelse(input$dsel == "Inflows","DI","DO")
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel, 
                      Year == input$year_selected, 
                      MEASURE_PRINCIPLE == mp)
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    
    my_options <- list(width="600px", height="300px",
                       title="Foreign Direct Investment",
                       hAxis="{title:'Destination'}",
                       vAxis="{title:'$USD (in millions)'}")
    
    gvisColumnChart(top10[1:7,], options=my_options)
  })
  
})