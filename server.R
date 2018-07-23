library(shinydashboard)
library(DT)
library(tidyr)

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
    
    if(dim(top10)[1] < 20){
      gvisGeoChart(top10, 'Partner.country.territory','Total',
                   options = list(width = "auto", 
                                  height = "auto",
                                  legend.title = "Foreign Direct Investment",
                                  displayMode = "markers",
                                  resolution = "countries",
                                  magnifyingGlass.enable = TRUE,
                                  magnifyingGlass.zoomFactor = 3.0))
      
    }else{
      gvisGeoChart(top10[1:20,], 'Partner.country.territory','Total',
                   options = list(width = "auto", 
                                  height = "auto",
                                  legend.title = "Foreign Direct Investment",
                                  displayMode = "markers",
                                  resolution = "countries",
                                  magnifyingGlass.enable = TRUE,
                                  magnifyingGlass.zoomFactor = 3.0))
      
    }
    
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
    
    my_options <- list(height = '425px',
                       width = '425px',
                       title="Foreign Direct Investment",
                       hAxis="{title:'Destination', viewWindowMode: 'pretty'}",
                       vAxis="{title:'$USD (in millions)'}",
                       legend = "bottom")
    
    gvisColumnChart(top10[1:7,], options=my_options)
  })
  
  output$Total <- renderInfoBox({
    
    mp <- ifelse(input$dsel == "Inflows","DI","DO")
    
    value <- sum(fdi[fdi$Reporting.country == input$ctry_sel 
                     & fdi$Year == input$year_selected 
                     & fdi$MEASURE_PRINCIPLE == mp,]$Value)
    
    value <- formatC(value, format="d", big.mark=",")
    
    infoBox(paste("Total",input$dsel, "(USD Millions)"),value,icon=icon("calculator"),fill=TRUE)
  })
  
  output$histC <- renderGvis({
    
    mp <- ifelse(input$dsel == "Inflows","DI","DO")
    
    fdi.sub <- filter(fdi, Reporting.country == input$ctry_sel2, 
                      Year %in% c(input$years_selected[1]:input$years_selected[2]), 
                      MEASURE_PRINCIPLE == mp,
                      Partner.country.territory == input$text1 | 
                        Partner.country.territory == input$text2)
    
    top10 <- fdi.sub %>%
      group_by(.,Partner.country.territory, Year) %>%
      summarize(.,Total = sum(Value)) %>%
      arrange(.,desc(Total))
    
    top10 <- data.frame(top10)
    top10 <- top10 %>% spread(Year, Total)
    
    my_options <- list(height = 'auto',
                       width = 'auto',
                       title=paste("Foreign Direct Investment", input$dsel),
                       hAxis="{title:'Destination'}",
                       vAxis="{title:'$USD (in millions)'}")
    
    if(dim(top10)[1] == 0){
      df <- data.frame(Names = c(input$text1,input$text2),Total = c(0,0))
      gvisColumnChart(df)
    } else{
      gvisColumnChart(top10, options=my_options)
    }
    
  })
  
})