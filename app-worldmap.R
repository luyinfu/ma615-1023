library(shiny)
library(ggplot2)

ui <- fluidPage(

    titlePanel("world map plotted with different locator projections"),

    sidebarLayout(
        sidebarPanel(
            selectInput("type",
                        "projection types:",
                        choices = c(cylindrical="cylindrical",
                                    mercator="mercator",
                                    sinusoidal="sinusoidal",
                                    gnomonic="gnomonic",
                                    azequalarea="azequalarea",
                                    lagrange="lagrange",
                                    stereographic="stereographic"))
        ),

        
        mainPanel(
           plotOutput("map2")
        )
    )
)


server <- function(input, output) {

    output$map2 <- renderPlot({
        
        mapWorld <- map_data("world")
        mp1 <- ggplot(mapWorld, aes(x=long, y=lat, group=group))+
            geom_polygon(fill="white", color="black") +
            coord_map(xlim=c(-180,180), ylim=c(-60, 90))
            mp2 <- mp1 + coord_map(input$type, xlim=c(-180,180), ylim=c(-60, 90))
            mp2
        })
}


shinyApp(ui = ui, server = server)
