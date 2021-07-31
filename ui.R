#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Global data & variables
df <- read.csv("COVID19BE_HOSP.csv")
df <- df[, c("PROVINCE", "TOTAL_IN")]

# aggregate data by PROVINCE
df1 <- aggregate(. ~ PROVINCE, data = df, FUN = sum)

# replace the French(accent) name
df1[5,1]<-"Liege"

# store all the province names in v_provinces, to use for select input
v_provinces <- df1[,"PROVINCE"]

##################################################
# Define UI for application that draws a histogram
shinyUI 
(
    fluidPage
    (
        # Application title
        titlePanel("Covid-19 in Belgium"),
        br(),
        p("The following data are provided by Sciensano, the Belgian institute for health, for the period of 2020-03-15 to 2021-07-27."),
        p("Source: https:epistat.wiv-isp.be/covid under the section \"Datasets Hospitalisations by date and provinces\"."),
        p("Select the province to display its total number of hospitalisations."),
        
        
        # Sidebar with a select input for province 
        sidebarLayout
        (
            sidebarPanel(
                selectInput("v_Provinces", "Province:",v_provinces)
            ),
            
            # Show a barplot of the hospitalisations/province
            mainPanel(
                plotOutput("hospPlot"),
                textOutput("hospProvince")
            )
        )
    )
)
