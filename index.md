---
title       : Developing Data Products
subtitle    : Case Study - Code Blue Analysis 
author      : M Fawcett
job         : Student of Coursera Data Science Specialization, 2016
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap, quiz]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Purpose

The final learning module in the Coursera Data Science Specialization covers the topic of developing "data products".

Data products are applications, software, presentations, etc., based on data, that facilitate our understanding of data (Brian Caffo).

The course introduced a plentitude of development tools that can be used to create data products with almost any desired look and feel.  The list included Shiny, Slidify, RPresenter, GoogleVis, Open CPU, RCharts, Manipulate, Morris Chart, XCharts and Plotly.

All of the tools have R, the statistical programming language, in their underpinnings. These are all free, open source tools.

This presentation demonstrates the use of Shiny and Slidify and how they can help us understand code blue occurances at a hospital. 

All of the code for my Shiny app and Slidify slides is at https://github.com/MitchFawcett/DataProductsDemo/blob/master/index.md

--- .class #id 

## What is Code Blue?

Code Blue refers to an emergency situation in which a patient is in cardiopulmonary arrest (patient has stopped breathing and heart has stopped beating) requiring a team of providers to begin immediate resuscitative efforts.

This is the structure of the code blue data set.


```
## 'data.frame':	1689 obs. of  10 variables:
##  $ StudyID                 : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ CodeBlueDate            : Factor w/ 821 levels "01/01/2013                    ",..: 464 53 498 728 117 53 283 3 78 43 ...
##  $ CodeBlueDayOfWeek       : Factor w/ 7 levels "Friday","Monday",..: 2 7 4 2 2 7 5 7 1 1 ...
##  $ CodeBlueWeekOfYear      : int  28 4 30 45 8 4 17 1 5 3 ...
##  $ CodeBlueCalendarQuarter : int  3 1 3 4 1 1 2 1 1 1 ...
##  $ CodeBlueCalendarYear    : int  2014 2014 2013 2013 2015 2014 2015 2013 2013 2013 ...
##  $ CodeBlueWeekStartDate   : Factor w/ 144 levels "01/04/2015","01/05/2014",..: 80 8 87 127 19 8 46 144 12 6 ...
##  $ CodeBlueWeekEndDate     : Factor w/ 144 levels "01/03/2015","01/04/2014",..: 83 11 90 130 22 11 49 3 15 9 ...
##  $ CodeBlueQuarterStartDate: Factor w/ 11 levels "01/01/2013","01/01/2014",..: 8 2 7 10 3 2 6 1 1 1 ...
##  $ CodeBlueQuarterEndDate  : Factor w/ 11 levels "03/31/2013","03/31/2014",..: 8 2 7 10 3 2 6 1 1 1 ...
```

---

## About the Code Blue Shiny App 

"Shiny" is an open source development tool that allows construction of sophisticated interactive Web pages using R.  No knowledge of HTML, CSS or Javascript is necessary, although Shiny apps can be customized using those languages if desired. For more information about Shiny visit http://shiny.rstudio.com.

Shiny developer tools are free and hosting of applications is free for 25 hours of use per month for up to 5 applications.  Various tiers of paid accounts are available to match specific needs.

Going to the following Web page will display my Shiny application:

https://myshinyacct.shinyapps.io/CodeBlue/


--- &radio

## Conclusion
"Slidify" is a development tool for creating attractive, interactive slide presentations and posting them to the Internet.  This series of slides was prepared using Slidify.  An example of interactivity using Slidify is the "quiz" feature. All of the tools discussed here are free open source tools.  For more information about Slidify go to http://slidify.org

## Survey Quiz
What is your rating for this presentation?

1. Great!
2. _Awesome_
3. Spectacular
4. Incredible

*** .hint
Starts with "A"

*** .explanation
Gratuitous yet awesome demonstration of interactivity with Slidify

