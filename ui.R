# Code Blue Analysis
# M. Fawcett - 01/22/2016
# Developing Data Products Assignment
#
# ui.R file
#
# User interface file for Shiny application.  Allows interaction
# using day of week, gender, hour of day etc. to help form hypothesis about code
# blue occurance at a hospital.

# setwd("/Users/mitchellfawcett/Documents/RProjects/DataProducts/Assignment/CodeBlue")

library(shiny)

shinyUI(pageWithSidebar(
        
        headerPanel("Code Blue By Day of Week Analysis"),
        
        sidebarPanel(
                selectInput("variable", "Variable:",
                            list("Week" = "CodeBlueWeekOfYear",
                                 "Quarter" = "CodeBlueCalendarQuarter",
                                 "Year" = "CodeBlueCalendarYear")),
                # Simple integer interval
                sliderInput(inputId = "integer", 
                            label = "Interval:", 
                            min=1, 
                            max=156, # 3 years x 52 weeks per year
                            value=1,
                            animate = animationOptions(interval = 2000))
                
        ),
        
        mainPanel(
                h3(textOutput("caption")),
                h4(textOutput("weekNumber")),
                h4(textOutput("yearNumber")),
                h4(textOutput("dateRange")),
                plotOutput("codeBluePlot")
                
        )
        
))