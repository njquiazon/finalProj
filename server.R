#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(MASS)
attach(Boston)
data(Boston)

shinyServer(function(input, output) {
  modelLstat <- lm(medv ~ lstat, data = Boston)
  
  modelLstatPred <- reactive({
    lstatIn <- input$lstatInput
    predict(modelLstat, newdata = data.frame(lstat = lstatIn))
  })
  
  output$plotOut <- renderPlot({
    lstatIn <- input$lstatInput
    
    plot(Boston$lstat, Boston$medv, xlab = "Lower Status of Pop in %",
         ylab = "Median value of home in $1000s")
    
    if(input$showModel){
      abline(modelLstat, col = "red", lwd = 2)
    }
    
    points(lstatIn, modelLstatPred(), col = 'red', pch = 16, cex = 2)
    
  })
  
  output$predMedv <- renderText({
    modelLstatPred()
  })
  
  output$howTo <- renderText({
    "To predict housing cost in Boston by the lower status of the population (lstat),
    drag the slider button to desired value of the lstat and click RUN. Tick the Show/Hide tickbox
    to show or hide the prediction model in the Result tab."
  })
  
  output$about <- renderText({
    "This project is a simple housing cost predictor that used simple linear regression. The LSTAT 
    predictor was used as the lone predictor, having a cor value of -0.7376627 with respect to MEDV
    (the median house price). The resulting model has an Adjusted R-squared value of 0.5432, indicating
    that the LSTAT predictor explains 54% of the variances observed in the MEDV values."
    
  })
  
})
