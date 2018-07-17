library(DT)
library(shiny)
library(googleVis)
library(shinydashboard)

# convert matrix to dataframe
fdi <- data.frame(fdi)
# create variable with colnames as choice
year.choice <- 2005:2016

choice <- sort(unique(c(as.vector(fdi$Reporting.country), 
            as.vector(fdi$Partner.country.territory))))