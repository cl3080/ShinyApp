library(shiny)

shinyServer(function(input, output) {
    diamonds$cut<-as.factor(diamonds$cut)
    diamonds$color<-as.factor(diamonds$color)
    diamonds$clarity<-as.factor(diamonds$clarity)

    model<-lm(formula = I(log10(price))~I(carat^(1/3))+carat+cut+color+clarity+x+y+z+depth+table,data = diamonds)
    modelpred<-reactive({
        predict(model,newdata = data.frame(carat=input$carat,
                                           cut=as.factor(input$quality_of_the_cut),
                                           color=as.factor(input$color),
                                           clarity=as.factor(input$clarity),
                                           x=input$length,
                                           y=input$width,
                                           z=input$depth,
                                           depth=input$depth/mean(input$length,input$width),
                                           table=input$table))
    })
    model2<-reactive({
        brushed_data<-brushedPoints(diamonds,input$brush1,
                                    xvar = "carat",yvar = "price")
        if(nrow(brushed_data)<2){
            return(NULL)
        }

        lm(formula = I(log10(price))~carat,data = brushed_data)
    })

    output$slopeOut<-renderText({
        if(is.null(model2())){
            "No Model Found"
        } else{
            model2()[[1]][[2]]
        }
    })

    output$intOut<-renderText({
        if(is.null(model2())) {
            "No Model Found"
        } else {
            model2()[[1]][[1]]
        }
    })

    output$plot1<-renderPlot({
        ggplot(data = diamonds,aes(x=carat,y=price))+
            geom_point(aes(color=cut),alpha=0.3)+
            geom_vline(xintercept = input$carat,color="red")

    })
    output$modelpred<-renderText({
           10^modelpred()
        })
})
