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
    titlePanel("generating marks on maps using leaflet"),
    sidebarLayout(
        sidebarPanel(
            
            p(" generating marks with file csv"),
            
            fileInput(inputId = "datos", label = "Cargue los datos", multiple = FALSE, placeholder = "archivo no seleccionado o error de formato", accept = "csv"),
            actionButton(inputId = "marcas", label = "dibujar todas"),
            
           p(strong("Table")),
            actionButton(inputId="ver", label="ver datos"),
            
           
           p(strong("input datos")),
           textInput(inputId ="lg", "longitud","ingrese la longitud"),
           textInput(inputId = "la","lattitud","ingresa la latitud"),
           textInput(inputId = "popup","popup","ingresa la etiqueta de tu marca"),
           actionButton(inputId = "dib", label = "dibujar una"),
        ),
        mainPanel(
            h3("Result"),
            leafletOutput("mymap"),
            tableOutput(outputId = "table"),
            )
    )
)