#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Linear Model for Boston Dataset"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("lstatInput", "(Percentage of) Lower status of the population", value = 12, min = 1, max = 36, step = 0.5),
      checkboxInput("showModel", "Show/Hide Model", value = TRUE),
      submitButton("Run")
    ),
    mainPanel(
      tabsetPanel(type = 'tabs', 
                  tabPanel("Result", br(),
                           plotOutput("plotOut"),
                           h3("Predicted Median value of homes (in $1000s)"),
                           textOutput("predMedv")
                  ),
                  tabPanel("How to Use", br(), textOutput("howTo")),
                  tabPanel("About the Model", br(), textOutput("about"))
       
      )
    )
  )
))
