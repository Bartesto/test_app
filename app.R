library(shiny)

load("./dat.RData")

ui <- fluidPage(
  selectInput(inputId = "sid", "Select Somethings",
              choices = c("t1" = "Toyota Corolla",
                          "t2" = "Toyota Corona"),
              selected = NULL,
              multiple = TRUE
              ),
  downloadButton("downloadData", "Download")
)

server <- function(input, output) {
  # Our dataset
  # data <- mtcarsDF

  datasetInput <- reactive({
    mtcarsDF %>% filter(car %in% input$sid)
  })



  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui, server)
