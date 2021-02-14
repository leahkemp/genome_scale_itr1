library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

# Import data
data <- read.csv("./data/genome_scale_data.csv", header = TRUE, stringsAsFactors = FALSE)

# data1 <- read.table("./data/species_genome_size.txt", comment.char = "", header = TRUE)
# data1 <- data1 %>% 
#     rename(species_taxid = X.species_taxid)
# 
# # Get species of interest
# data1 <- data1 %>%
#     # Humans and covid
#     filter(species_taxid == 9685)

# Create string to order genetic_data_type variables in plot
level_order <- c("gene", "exome", "genome")

# Stop scientific notation
options(scipen=999)

# Define server logic for app ----
server <- function(input, output, session) {
    
    # Generate shiny bar plot ----
    output$bar_plot <- renderPlot({
        
        # Filter data by user choice of species and genetic data type to view
        data_filtered <- data %>%
            filter(species %in% input$species_choice) %>%
            filter(genetic_data_type %in% input$genetic_data_choice)
        
        # ggplot bar plot
        ggplot(data = data_filtered, aes(x = factor(genetic_data_type, level = level_order),
                                         y = base_pairs,
                                         fill = species)) +
            geom_bar(stat="identity",
                     position=position_dodge()) +
            # geom_errorbar(aes(ymin = min_ungapped_length, ymax = max_ungapped_length),
            #               width=.2,
            #               position = position_dodge(.9)) +
            geom_text(aes(label = base_pairs),
                      vjust = 1.6,
                      color = "black",
                      position = position_dodge(0.9),
                      size = 3.5) +
            labs(title = "",
                 x = "", 
                 y = "Base pairs (bp)") +
            theme_linedraw() +
            scale_fill_brewer(palette = "YlGn")
    })
}
