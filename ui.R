library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyBS)

ui <- fluidPage(
    
    # Define UI for app ----
    ui <- fluidPage(
        
        # App title ----
        titlePanel("Genome scale"),
        
        # App theme ----
        theme = shinytheme("yeti"),
        
        # Define page layout ----
        verticalLayout(
            
            # Render bar plot ----
            plotOutput("bar_plot"),
            
            # Render user options panel ----
            wellPanel(
                
                # Check boxes to choose species of interest
                checkboxGroupInput("species_choice", "Choose species:",
                                   c("Human" = "human",
                                     "Virus" = "virus"),
                                   selected = list("human", "virus")),
                
                # Check boxes to choose genetic data type of interest
                checkboxGroupInput("genetic_data_choice", "Choose data type:",
                                   c("Gene" = "gene",
                                     "Exome" = "exome",
                                     "Genome" = "genome"),
                                   selected = list("gene", "exome", "genome"))
                
            )
        )
    )
)
