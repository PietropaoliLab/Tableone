library(shiny)

shinyUI(fluidPage(
  # titlePanel("Dynamic Arsenal Table in Shiny"),
  
  HTML(r"(
    <h1>Dynamic Table 1 creation using the Arsenal library</h1>
    <p class="my-class"> https://mayoverse.github.io/arsenal/index.html </p>
  )"),
  
  tableOutput("table"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose Excel File",  accept = c(".xlsx")),
      uiOutput("var_select_ui"),
      uiOutput("group_select_ui")
    ),
    
    mainPanel(
      uiOutput("tableone")  # Use UI output for HTML content
    )
  )
))
