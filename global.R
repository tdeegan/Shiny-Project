library(DT)
library(shiny)
library(googleVis)
library(shinydashboard)
library(MASS)
library(dplyr)

# convert matrix to dataframe
fdi <- read.csv("./fdi_cleaned.csv")
fdi <- data.frame(fdi)
# create variable with colnames as choice
year.choice <- 2005:2016

choices <- sort(unique(as.vector(fdi$Reporting.country)))