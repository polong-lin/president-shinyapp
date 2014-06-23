library(shiny)
shinyServer(
    function(input, output) {
        ## Various output variables
        output$overifiedText <- renderPrint("Presidential Status: Unverified")
        output$onameVar <- renderPrint({input$nameVar})
        output$ocountryVar <- renderPrint({input$countryVar})
        output$osecretVar <- renderPrint({input$secretVar})
        output$owelcome <- renderPrint({"Verification Required"})
        ## Part of the verfication process that toggles the conditional panels in the ui.R
        output$overificationSuccess <- renderText({
            if (input$verifyButton > 0 & nchar(input$nameVar) > 0 & nchar(input$countryVar) > 0 & (as.numeric(input$secretVar2)^2 +1) == input$secretVar1 & input$checkbox == TRUE)
                "STATUS: VERIFIED"
            else
                "STATUS: UNVERIFIED"
            })
        
        ## Near the VERIFY button: text that tells you that you are unverified, or that you need to double-check your credentials
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
        ## Output text for coordinates at missle launch
        output$olaunchOutput <- renderText(
            if (input$launchButton %% 2 == 1)
                paste("Report: Launch success at coordinates: (", input$plotX, ", ", input$plotY, ")", sep ="")
        )
        
        ## Plot for the planets and the moon
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
            ## Horizontal and Vertical lines used for aiming
            abline(h = input$plotY, lwd = 3)
            abline(v = input$plotX, lwd = 3)
            ## Supposed to create a permanent point on the graph - a bug to fix in the future.
            if (input$launchButton %% 2 == 1) 
                plot(1:100, 1:100, xlim = c(0,100), ylim = c(0,100), pch = "",
                     ylab = "",
                     xlab = "",
                     main = paste("Satellite image of region of interest on", input$selectPlanet))
                points(as.numeric(unlist(textOutput(input$plotX))), as.numeric(unlist(textOutput(input$plotY))), col = "red", pch = 19, cex = 5)
        })
        })
