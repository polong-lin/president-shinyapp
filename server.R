library(shiny)
shinyServer(
    function(input, output) {
        output$overifiedText <- renderPrint("Presidential Status: Unverified")
        output$onameVar <- renderPrint({input$nameVar})
        output$ocountryVar <- renderPrint({input$countryVar})
        output$osecretVar <- renderPrint({input$secretVar})
        output$owelcome <- renderPrint({"Verification Required"})
        output$overificationSuccess <- renderText({
            if (input$verifyButton > 0 & nchar(input$nameVar) > 0 & nchar(input$countryVar) > 0 & (as.numeric(input$secretVar2)^2 +1) == input$secretVar1 & input$checkbox == TRUE)
                "STATUS: VERIFIED"
            else
                "STATUS: UNVERIFIED"
            })
        output$overifiedText <- renderText({
            if (input$verifyButton == 0) 
                paste("Presidential Status for: \"", input$nameVar, "\" of \"", input$countryVar, "\"", sep = "")
            else if (input$verifyButton > 0 & nchar(input$nameVar) > 0 & nchar(input$countryVar) > 0 & (as.numeric(input$secretVar2)^2 +1) == input$secretVar1 & input$checkbox == TRUE)
                paste("Verified: \n Welcome back, President", input$nameVar)
            else 
                "ERROR: \n Please check your credentials again."
            })
        output$owelcome <- renderText({
            if (nchar(input$nameVar) > 0 & nchar(input$countryVar) > 0 & (as.numeric(input$secretVar2)^2 +1) == input$secretVar1 & input$checkbox == TRUE)
                paste("Welcome back, President ", input$nameVar, " of ", input$countryVar)
            })
        output$olaunchOutput <- renderText(
            if (input$launchButton %% 2 == 1)
                paste("Report: Launch success at coordinates: (", input$plotX, ", ", input$plotY, ")", sep ="")
        )
        output$oscatter <- renderPlot({
            if(input$selectPlanet == "Venus")
                planetColour = "lightyellow"
            if(input$selectPlanet == "the Moon")
                planetColour = "lightgray"
            if(input$selectPlanet == "Mars")
                planetColour = "coral1"
            par(bg = planetColour)
            plot(1:100, 1:100, xlim = c(0,100), ylim = c(0,100), pch = "",
                 ylab = "",
                 xlab = "",
                 main = paste("Satellite image of region of interest on", input$selectPlanet))
            abline(h = input$plotY, lwd = 3)
            abline(v = input$plotX, lwd = 3)
            if (input$launchButton %% 2 == 1) 
                plot(1:100, 1:100, xlim = c(0,100), ylim = c(0,100), pch = "",
                     ylab = "",
                     xlab = "",
                     main = paste("Satellite image of region of interest on", input$selectPlanet))
                points(as.numeric(unlist(textOutput(input$plotX))), as.numeric(unlist(textOutput(input$plotY))), col = "red", pch = 19, cex = 5)
        })
        })
