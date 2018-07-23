library(DT)
library(shiny)
library(googleVis)
library(shinydashboard)
library(MASS)
library(dplyr)

# convert matrix to dataframe
fdi <- read.csv("./fdiAdd.csv")
fdi <- data.frame(fdi)
# create variable with colnames as choice

#load("./.RData")

year.choice <- 2005:2016

choices <- sort(unique(as.vector(fdi$Reporting.country)))
choicesC <- choices