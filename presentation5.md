FINAL PROJECT DEVELOPING DATA PRODUCTS VERSION 2.0
========================================================
author: MIGUEL ANGEL COHUO AVILA
date: 1/12/2020 
autosize: true

WELCOME TO LEARNING SHINY
========================================================

view apps in   <https://macohuo.shinyapps.io/aprendiendo/>.

- Instructions for using the app

- Example using ui.R

- Example using server.R


how can you use the app?
========================================================
this basic application generates a map with leaflet using shiny reactive. In three ways: 

ONE.
- 1)  Loading latitude and longitude data in a csv file. 

    - a) you should consider a file with columns defined as lng and lat and in csv format view example:https://github.com/macohuo/developingdata/blob/master/d.csv
    
    
    - b) Press the button "draw all marks", you can see the data by pressing the button "view data"

how can you use the app?
========================================================
TWO

- 2) Entering the data in the fields.
    - you can see the data by  -you can enter the longitude, latitude and the label of a landmark and press the button "show one mark"

THREE

- 3) Generating random marks.
    - you can select the number of marks and press the button "show mark"
    
Example Slide With Code ui.R
========================================================




```r
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
           
           ),
        mainPanel(
            h3("Result"),
            leafletOutput("mymap"),
            tableOutput(outputId = "table"),
            )
    )
)
```
Example Slide With Code server.R
========================================================



```r
library(shiny)
library(leaflet)
library(webshot)
server <- function(input, output, session) {
        contentsrea <- reactive({
            inFile <- input$datos
        if (is.null(inFile))
            return(NULL)
        read.csv(inFile$datapath)
    })
    
    observeEvent(input$marcas,{
        
        if(!is.null(input$datos)){
            df<- read.csv(input$datos$datapath, header=TRUE,sep=",")
            output$mymap <- renderLeaflet({
                df %>%
                    leaflet()%>%
                    addTiles() %>%
                    addMarkers()
            })
            
        }
    })
    
    observeEvent(input$aleatorio,{
     
        dfa <- data.frame(lng = runif(input$marks, min=-92.000 , max=-87.000 ),
                         lat = runif(input$marks, min=19.000, max=21.000)
                         )
        output$mymap <-renderLeaflet({
           dfa %>% 
            leaflet() %>%
            addTiles() %>%
            addMarkers()
            
            
            #output$table <- renderTable(dfa, rownames = TRUE)   
        })
           
    })
    
    observeEvent(input$dib,{
        longitud <- as.numeric(input$lg)
        latitud <- as.numeric(input$la)
        output$mymap <- renderLeaflet({
        leaflet() %>%
            addTiles() %>%
            setView(lng =longitud, lat = latitud, zoom = 7) %>%
            addMarkers(lng = longitud, lat = latitud, popup = input$popup)
 
        })
                  })
    
    
    observeEvent(input$ver,{
     if(!is.null(input$datos)){
         df<- read.csv(input$datos$datapath, header=TRUE,sep=",")
         output$table <- renderTable(df, rownames = TRUE)
         
     }
        
           
    })
    
   
}
```

