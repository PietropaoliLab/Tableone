library(shiny)
library(readxl)
library(arsenal)
library(dplyr)

# Define server logic required to generate Tableone
shinyServer(function(input, output, session) {
  
  # Reactive expression to read the uploaded file
  data_reactive <- reactive({
    req(input$file1)  # Ensure file is uploaded
    file <- input$file1$datapath
    data <- read_excel(file)
    return(data)
  })
  
  # Dynamically generate UI for variable selection
  output$var_select_ui <- renderUI({
    data <- data_reactive()
    req(data)
    
    selectInput("vars", "Select Variables to Include:",
                choices = names(data), multiple = TRUE)
  })
  
  # Dynamically generate UI for grouping variable selection
  output$group_select_ui <- renderUI({
    data <- data_reactive()
    req(data)
    
    selectInput("group", "Select Grouping Variable:",
                choices = c("None", names(data)),
                selected = "None")
  })
  
  # Render Arsenal table based on user inputs
  output$tableone <- renderTable({
    data <- data_reactive()
    req(data)
    
    selected_vars <- input$vars
    group_var <- input$group
    
    # Check if any variables are selected
    if (length(selected_vars) == 0) {
      return(data.frame("Error" = "No variables selected"))
    }
    
    # Check if the grouping variable is valid
    if (group_var != "None" && !(group_var %in% names(data))) {
      return(data.frame("Error" = paste("Invalid grouping variable:", group_var)))
    }
    
    # Create Arsenal table
    if (group_var != "None") {
      tableone <- tableby(as.formula(paste(group_var, "~", paste(selected_vars, collapse = "+"))), data = data)
    } else {
      tableone <- tableby(as.formula(paste("~", paste(selected_vars, collapse = "+"))), data = data)
    }
    
    # Convert Arsenal table to a data frame for display
    tableone_df <- summary(tableone, text = "html")
    
    # Return the formatted table
    as.data.frame(tableone_df)
  }, sanitize.text.function = function(x) x)  # Ensure text is not sanitized in rendering
})
