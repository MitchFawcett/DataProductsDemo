# Code Blue Analysis
# M. Fawcett - 01/22/2016
# Developing Data Products Assignment
#
# server.R file
#
# Server file for Shiny application.  Allows interaction
# using day of week, gender, hour of day etc. to help form hypothesis about code
# blue occurance at a hospital.

# setwd("/Users/mitchellfawcett/Documents/RProjects/DataProducts/Assignment/CodeBlue")

library(shiny)
library(ggplot2)
library(lubridate)

# Load data set containing code blue occurance data in current directory.
d <- read.csv('CodeBlueAnalysis.txt', sep = "\t")

# Order the data set by the day of week, Monday first, so plot will have the proper
# ordering of days on the x axis. Start by changing the data type to "factor" for CodeBlueDayOfWeek.
d$CodeBlueDayOfWeek <- factor(d$CodeBlueDayOfWeek, levels= c( "Sunday", "Monday", 
                                         "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
# Now sort the data set.
d <- d[order(d$CodeBlueDayOfWeek), ]

# Configure the server functions for the Shiny app.
shinyServer(function(input, output, session) {
        topCaption <- reactive({
                if (input$variable == "CodeBlueWeekOfYear") {
                     "Code Blue By Week Of Year" 
                } else
                if (input$variable == "CodeBlueCalendarQuarter") {
                        "Code Blue By Calendar Quarter"   
                } else
                if (input$variable == "CodeBlueCalendarYear") {
                        "Code Blue By Calendar Year"   
                }

        })  
        
        observe({
             ## nothing here yet   
        })
        
        # Return the formula text for printing as a caption
        output$caption <- renderText( {
                topCaption()
        })
        
        # Return slider output as week number or quarter number so they can be displayed
        output$weekNumber <- renderText( {
                if (input$variable == "CodeBlueWeekOfYear") {
                        if (input$integer %% 52 == 0) {
                                paste("Week # ", 52)
                        } else {
                                paste("Week # ", input$integer %% 52)
                        }
                } else 
                if (input$variable == "CodeBlueCalendarQuarter") {
                        paste("Quarter # ",  ((input$integer - 1) %% 4) + 1)
                }
        })
        
        # Return date range start date
        output$dateRange <- renderText( {
                if (input$variable == "CodeBlueWeekOfYear") {
                        # Capture week number from slider position
                        weekNum <- 1 # Initialize a weekNum variable
                        weekNum = ((input$integer - 1) %% 52 ) + 1
                        # Capture year number from slider position
                        yearNum <- 2013
                        yearNum = 2013 + ((input$integer - 1) %/% 52)
                        e <- subset(d, CodeBlueWeekOfYear == weekNum & CodeBlueCalendarYear == yearNum)
                        paste(e[1, "CodeBlueWeekStartDate"], " - ", e[1, "CodeBlueWeekEndDate"])
                } else 
                if (input$variable == "CodeBlueCalendarQuarter") {
                        # Capture quarter number from slider position
                        quarterNum <- 1 # Initialize a quarterNum variable
                        quarterNum = ((input$integer - 1) %% 4) + 1
                        # Capture year number from slider position
                        yearNum <- 2013
                        yearNum = 2013 + ((input$integer - 1) %/% 4)                      
                        # Filter the data set based on quarter number and year
                        e <- subset(d, CodeBlueCalendarQuarter == quarterNum & CodeBlueCalendarYear == yearNum )
                        paste(e[1, "CodeBlueQuarterStartDate"], " - ", e[1, "CodeBlueQuarterEndDate"])        
                } else
                if (input$variable == "CodeBlueCalendarYear") {
                        # Capture year number from slider position
                        yearNum <- 2013
                        yearNum = 2013 + ((input$integer - 1) %/% 4)                      
                        # Filter the data set based on quarter number and year
                        e <- subset(d, CodeBlueCalendarYear == yearNum )
                        paste("01/01/", yearNum, " - ", "12/31/", yearNum)        
                }
                
       })
        
        # Plot results
        output$codeBluePlot <- renderPlot( {
                 
                ## Drop down list Week option selected
                if (input$variable == "CodeBlueWeekOfYear") {
                        # Update range of slider
                        updateSliderInput(session, "integer",
                                          max = 156)  # 156 weeks (3 years) of data
                        # Capture week number from slider position
                        weekNum <- 1 # Initialize a weekNum variable
                        weekNum = ((input$integer - 1) %% 52 ) + 1
                        # Capture year number from slider position
                        yearNum <- 2013
                        yearNum = 2013 + ((input$integer - 1) %/% 52)
                        # filter the data set based on week number and year
                        d2 <- subset(d, CodeBlueWeekOfYear == weekNum & CodeBlueCalendarYear == yearNum)
                        # Create a day of week factor to the result data set so that days with zero counts will appear in the plot.
                        d2$CodeBlueDayOfWeek <- factor(d2$CodeBlueDayOfWeek, 
                                                       levels= c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
                        # Plot bar graph of number of code blue by day of week
                        p <- ggplot(d2, aes(x = CodeBlueDayOfWeek)) + geom_bar(stat="bin", width=0.7, fill="steelblue") + scale_x_discrete(drop=FALSE)
                        p <- p + labs(x = "Day of week") + labs(y = "Number of Code Blue Per Day")
                        p <- p + theme(axis.text = element_text(size=12),
                                       axis.title = element_text(size=14,face="bold"),
                                       axis.title.y = element_text(vjust = 0.5),
                                       axis.title.x = element_text(vjust = -0.5))
                        print(p)
                }
                
                ## Drop down list Quarter option selected
                if (input$variable == "CodeBlueCalendarQuarter") {
                        # Update range of slider
                        updateSliderInput(session, "integer",
                                          max = 12)  # 12 quarters (3 years) of data
                        # Capture quarter number from slider position
                        quarterNum <- 1 # Initialize a quarterNum variable
                        quarterNum = ((input$integer - 1) %% 4) + 1
                        # Capture year number from slider position
                        yearNum <- 2013
                        yearNum = 2013 + ((input$integer - 1) %/% 4)                      
                        # Filter the data set based on quarter number and year
                        d3 <- subset(d, CodeBlueCalendarQuarter == quarterNum & CodeBlueCalendarYear == yearNum )
                        # Add a day of week factor to the result data set so that days with zero counts will appear in the plot.
                        d3$CodeBlueDayOfWeek <- factor(d3$CodeBlueDayOfWeek, 
                                                       levels= c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
                        # Bar graph of number of code blue by day of week
                        p <- ggplot(d3, aes(x = CodeBlueDayOfWeek)) + geom_bar(stat="bin", width=0.7, fill="steelblue") + scale_x_discrete(drop=FALSE)
                        p <- p + labs(x = "Day of the Week") + labs(y = "Number of Code Blue Per Day")
                        p <- p + theme(axis.text = element_text(size=12),
                                       axis.title = element_text(size=14,face="bold"),
                                       axis.title.y = element_text(vjust = 0.5),
                                       axis.title.x = element_text(vjust = -0.5))
                        print(p)
                }
                
                ## Drop down list Year selected.
                if (input$variable == "CodeBlueCalendarYear") {
                        d2 <- subset(d, CodeBlueCalendarYear == 2013)
                        # Update range of slider
                        updateSliderInput(session, "integer",
                                          max = 3)  # three years of data
                        # Capture year number from slider position
                        yearNum <- 2013
                        yearNum = 2013 + (input$integer - 1)                          
                        # Filter the data set based on quarter number and year
                        d4 <- subset(d, CodeBlueCalendarYear == yearNum )
                        # Add a day of week factor to the result data set so that days with zero counts will appear in the plot.
                        d4$CodeBlueDayOfWeek <- factor(d4$CodeBlueDayOfWeek, 
                                                       levels= c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
                        # Bar graph of number of code blue by day of week
                        p <- ggplot(d4, aes(x = CodeBlueDayOfWeek)) + geom_bar(stat="bin", width=0.7, fill="steelblue") + scale_x_discrete(drop=FALSE)
                        p <- p + labs(x = "Day of week") + labs(y = "Number of Code Blue Per Day")
                        p <- p + theme(axis.text = element_text(size=12),
                                       axis.title = element_text(size=14,face="bold"),
                                       axis.title.y = element_text(vjust = 0.5),
                                       axis.title.x = element_text(vjust = -0.5))
                        print(p) 
                }

        })

})