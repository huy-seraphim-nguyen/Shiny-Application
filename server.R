#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Global data & variables
df <- read.csv("COVID19BE_HOSP.csv")
df <- df[, c("PROVINCE", "TOTAL_IN")]

# aggregate data by PROVINCE
df1 <- aggregate(. ~ PROVINCE, data = df, FUN = sum)

# replace the French(accent) name
df1[5,1]<-"Liege"

# store all the province names in v_provinces
v_provinces <- df1[,"PROVINCE"]


##################################################
# Define server logic  
server <- function(input, output) {
    
    output$hospPlot <- renderPlot({
        
        p <- ggplot(data=df1, aes(x=PROVINCE, y=TOTAL_IN)) +
            geom_bar(stat="identity", fill="steelblue") + coord_flip()
        print(p)
    })
    
    output$hospProvince <- renderText({ 
        res <- df1[df1$PROVINCE==input$v_Provinces,]
        paste("Total hospitalisations in ", res[1], " : ", res[2] )
    })
}
