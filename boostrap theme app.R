ui <- fluidPage(theme = shinytheme("united"), #shinytheme("cerulean"),
                
                # Application title
                titlePanel("Common distributions used in Survival Aanalysis"),
                
                
                # Sidebar with a slider input for number of bins 
                sidebarLayout(
                  sidebarPanel(
                    withMathJax(),
                    selectInput(inputId = "Distribution",
                                label = "Choose a distribution:",
                                choices = c("Exponential", "Weibull", "Gamma")),
                    sliderInput("shape",
                                "Shape parameter:",
                                min = 0.01,
                                max = 10,
                                value = 1),
                    sliderInput("scale",
                                "Scale parameter:",
                                min = 0.01,
                                max = 10,
                                value = 1)
                  ),
                  
                  
                  # Show a plot of the generated distribution
                  mainPanel(
                    fluidRow(
                      column(width = 10, 
                                  plotOutput("pdf", height = 220),
                                  plotOutput("h", height = 220),
                                  plotOutput("S", height = 220))
                    ))
                )
)


# Data and Functions
t = seq(0.0001, 5, 0.001)

hweibull = function(t, shape, scale){
  return(shape/scale*(t/scale)^(shape - 1))
}

hexp = function(t, rate){
  return(rep(rate, length(t)))
}

hgamma = function(t, shape, scale){
  h_gamma = dgamma(t, shape, scale)/(1 - pgamma(t, shape, scale))
  return(h_gamma)
}


server <- function(input, output, session) {
  
  output$pdf <- renderPlot({
    p = switch(input$Distribution, 
               Exponential = dexp(t, rate = 1),
               Weibull = dweibull(t, shape = input$shape, scale = input$scale),
               Gamma = dgamma(t, shape = input$shape, scale = input$scale))
    
    hdat = data.frame(t, p)
    
    ggplot(hdat, aes(x = t, y = p)) + 
      geom_line(color = '#75AADB') + 
      ggtitle(paste("PDF of", 
                    input$Distribution, 
                    "distribution", 
                    sep = " ")) + 
      ylab("Probability density") + 
      theme_bw()
  })
  
  output$h <- renderPlot({
    h = switch(input$Distribution, 
               Exponential = hexp(t, rate = 1),
               Weibull = hweibull(t, shape = input$shape, scale = input$scale),
               Gamma = hgamma(t, shape = input$shape, scale = input$scale))
    
    hdat = data.frame(t, h)
    
    ggplot(hdat, aes(x = t, y = h)) + 
      geom_line(color = '#75AADB') + 
      ggtitle(paste("Hazard function of", 
                    input$Distribution, 
                    "distribution", 
                    sep = " ")) + 
      ylab("Hazard") + 
      theme_bw()
  })
  
  output$S <- renderPlot({
    S = switch(input$Distribution, 
               Exponential = 1 - pexp(t, rate = 1),
               Weibull = 1 - pweibull(t, shape = input$shape, scale = input$scale),
               Gamma = 1 - pgamma(t, shape = input$shape, scale = input$scale))
    
    Sdat = data.frame(t, S)
    
    ggplot(Sdat, aes(x = t, y = S)) + 
      geom_line(color = '#75AADB') + 
      ggtitle(paste("Survival function of", 
                    input$Distribution, 
                    "distribution", 
                    sep = " ")) + 
      ylab("Survival probability") + 
      theme_bw()
  })
  
  
  #output$markdown <- renderUI({
  # HTML(markdown::markdownToHTML(knit('SurvivalDist.rmd', quiet = TRUE)))
  #})
  
}

# Run the application 
shinyApp(ui = ui, server = server)
