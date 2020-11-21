#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

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