#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(webshot)
#library(ggplot2)
ui <- fluidPage(
    
   
    titlePanel("generating marks using leaftet in different ways version 2.0"),
    sidebarLayout(
        sidebarPanel(
            
            p(" Option 1 loading a cvs file"),
            
            fileInput(inputId = "datos", label = "loading data", multiple = FALSE, placeholder = "file not selected or format error", accept = "csv"),
            actionButton(inputId = "marcas", label = "draw all marks"),
            
           p(strong("you can see the data")),
            actionButton(inputId="ver", label="view data"),
            
           
           p(strong("Option 2 you can enter the data")),
           textInput(inputId ="lg", "longitud","enter longitude (lg)"),
           textInput(inputId = "la","lattitud","enter latitude (lat)"),
           textInput(inputId = "popup","popup","enter your label"),
           actionButton(inputId = "dib", label = "show one mark"),
        
           p(strong("Option 3 generating random marks ")),
           sliderInput(inputId ="marks","Number of marks:", min = 1,max = 20, value = 10),
           actionButton(inputId = "aleatorio", label = "show marks"),
           #actionButton(inputId = "veraleatorios", label = "view data"),
           ),
        mainPanel(
            h3("Result"),
            leafletOutput("mymap"),
            tableOutput(outputId = "table"),
            )
    )
)