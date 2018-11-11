body <- dashboardBody(
  fluidRow(
    column(width = 5, box("Box content", width = NULL)),
    column(width = 7, uiOutput('markdown'))
  )
)

ui <- dashboardPage(
  dashboardHeader(title = "Include Rmarkdown"),
  dashboardSidebar(),
  body
)

server <- function(input, output) { 
  output$markdown <- renderUI({
  HTML(markdown::markdownToHTML(knit('exampleMD.rmd', quiet = TRUE)))
  })
}

shinyApp(ui = ui, server = server)