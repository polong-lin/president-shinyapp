library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("The President's Interplanetary-Missile-Launching Control Box"),
    mainPanel(
        ## Conditional Panel that pops up after the credentials are "verified"
        conditionalPanel(
        condition = 'output.overificationSuccess == "STATUS: VERIFIED"',
        h4("Welcome back, President"),
        h2("Missile Launcher Controls"),
        h5(paste("Maximum Missile Range: Neighbouring Planets")),
        ## Choosing planets
        selectInput("selectPlanet", label = h4("Select your Planet:"), 
                    choices = list("Venus" = "Venus", "Moon" = "the Moon",
                                   "Mars" = "Mars"), selected = 1),
        ##Slider bars
        sliderInput('plotX', 
                    'Control the X-axis', 
                    value = 50, min = 0, max = 100, step = 1),
        sliderInput('plotY', 
                    'Control the Y-axis', 
                    value = 50, min = 0, max = 100, step = 1),
        
        ##Launch button and some text output
        actionButton("launchButton", "LAUNCH"),
        verbatimTextOutput("olaunchOutput"),
        ## Plot
        plotOutput("oscatter")
        )
    ),
    sidebarPanel(
        conditionalPanel(
            ## Conditional panel that appears before credentials are verified
            condition = 'output.overificationSuccess == "STATUS: UNVERIFIED"',
            textInput('nameVar', 'Insert your name'),
            br(),
            textInput('countryVar', 'Insert your country'),
            br(),
            br(),
            h5("Adjust the sliders so that the TOP slider is the square of the BOTTOM slider plus one."),
            sliderInput('secretVar1', 
                        'TOP', 
                        value = 50, min = 0, max = 100, step = 1),
            sliderInput('secretVar2', 
                        'BOTTOM', 
                        value = 50, min = 0, max = 100, step = 1),
            br(),
            h5("Terms of Use:"),
            checkboxInput("checkbox",
                          label = "By checking this, I hereby agree to the United Galaxies' laws on Intergalactic Warfare", value = FALSE),
            h6("The following button is for use by the President only. Click VERIFY to verify that you are indeed the President."),
            verbatimTextOutput("overifiedText"),
            verbatimTextOutput("overificationSuccess"),
            actionButton("verifyButton", "VERIFY")
        )
    )
))