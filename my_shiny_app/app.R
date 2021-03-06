
# This is the absolute bare minimum of what I need to create a shiny app.
# Beware! ... This alone will be a REALLY boring app. A blank page :(

library(shiny)
library(tidyverse)
library(babynames)
library(rsconnect)

ui <- fluidPage(textInput(inputId = "name",
                          label = "Name:",
                          value = "",
                          placeholder = "Lisa"),
                selectInput(inputId = "sex",
                            label = "Sex:",
                            choices = list(Female = "F",
                                           Male = "M")),
                sliderInput(inputId = "year",
                            label = "Year Range:",
                            min = min(babynames$year),
                            max = max(babynames$year),
                            value = c(min(babynames$year),max(babynames$year)),
                            sep = ""),
                submitButton(text = "Create your plot!"),
                plotOutput(outputId = "nameplot"))

server <- function(input, output) {
 output$nameplot <- renderPlot(
   babynames %>% 
     filter(sex == input$sex,
            name == input$name) %>% 
     ggplot(aes(x = year,
                y = n)) + 
     geom_line() + 
     scale_x_continuous(limits = input$year) + 
     theme_minimal()
 )
}

shinyApp(ui = ui, server = server)


