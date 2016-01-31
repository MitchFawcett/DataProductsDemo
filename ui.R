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
                            animate = animationOptions(interval = 2000)),
                p("Above, there are two user input controls: a drop down list and a slider.", style = "color:blue"),
                p("On the right is a bar plot showing the number of code blue occurances by day of week for a selected period of time.", style = "color:blue"),
                p("The drop down list lets you select week, quarter or year.  Select Week to display the number of code blues by day of week for one week.  Select Quarter to display the number by day of week for an entire quarter.  Select Year to display the number per day of week for an entire year.", style = "color:blue"),
                p("Drag the slider to pick a particular week, quarter or year to display. Click the triangular play button under the slider to animate it with an update happening every two seconds.", style = "color:blue"),
                p("Note, there is no need for a Submit button to update the chart.  It refreshes as soon as a change is made in the user inputs.  Shiny calls this Reactive Programming.", style = "color:blue")
        ),
        
        
        mainPanel(
                h3(textOutput("caption")),
                h4(textOutput("weekNumber")),
                h4(textOutput("yearNumber")),
                h4(textOutput("dateRange")),
                plotOutput("codeBluePlot")
                
        )

))