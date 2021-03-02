if (!require("tidyverse")) install.packages('tidyverse')
if (!require("homerange")) install.packages('homerange')


library(shiny)
library(tidyverse)
library(shinydashboard)


ui <- fluidPage( titlePanel("Homerange Locomotion"),
                 radioButtons("x","Select Fill Variable", choices = c("trophic.guild","thermoregulation"), selected = "trophic.guild"),
                 plotOutput("plot",width = "600px",height="500px")
                 
)

server <- function(input, output, session) {
  output$plot<-renderPlot({
    ggplot(homerange,aes_string(x="locomotion",fill=input$x))+
      geom_bar(position = "dodge",alpha=0.8, color="black")+
      theme_light(base_size=18)+
      labs(x=NULL,y=NULL,fill="guild or thermo")
  })
  
}

shinyApp(ui, server)

