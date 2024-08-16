library(shiny)

shinyUI(fluidPage(
   titlePanel("Dynamic Arsenal Table One in Shiny"),
  
  # Introduction
  fluidRow(
    column(12,
           HTML(r"(
        <p>Explore more about the Arsenal library at: <a href='https://mayoverse.github.io/arsenal/index.html' target='_blank'>Arsenal Documentation</a></p>
      )")
    )
  ),
  
  
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
