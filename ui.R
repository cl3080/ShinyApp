library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Predict Diamond's Price"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       numericInput(inputId="carat",label="What is the weight of the diamonds",value=1,step=0.01),
       selectInput("quality_of_the_cut","Choose a selection of the cutting:",
                   list("Fair","Good","Very Good","Premium","Ideal")),
        selectInput("color","Choose a color from J(worst) to D(best):",
                    list("D","E","F","G","H","I","J")),
        selectInput("clarity","How clear is the diamond:",
                    list("I1","SI1","SI2","VS1","VS2","VVS1","VVS2","IF")),
       numericInput("length","length in mm",value=1,step = 0.01),
       numericInput("width","width in mm",value=1,step = 0.01),
       numericInput("depth","depth in mm",value=1,step = 0.01),
       numericInput("table","width of top of diamond relative to widest point",value=1,step = 0.01),
       submitButton("Submit")
    ),

    mainPanel(
        plotOutput("plot1",brush = "brush1"),
        h3("Predicted diamond's price($):"),
        textOutput("modelpred"),
        h3("Selected points - slope:"),
        textOutput("slopeOut"),
        h3("Selected points - Intercept:"),
        textOutput("intOut")
    )
  )
))
