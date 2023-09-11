
options(shiny.fullstacktrace = FALSE)

library(shiny)
library(dplyr)  # for data pre-processing and example data
# devtools::document()
devtools::load_all()


ui <- fluidPage(
  titlePanel("{cards} Example: Simple Box App"),
  fluidRow(
    column(8, gridUI('grid'))
    ))

server <- function(input, output, session) {

  boxes <- reactive({
    add_box_card(
      name = "card_name",
      title = 'Card Title',
      desc = 'Card Description',
      value = 'Card Value',
      succ_icon = 'black-tie',
      icon_class = "text-info",
      is_perc = FALSE,
      is_url = FALSE
    ) %>%
    add_box_card(
      name = "card_name2",
      title = 'Card Title2',
      desc = 'Card Description2',
      value = 'Card Value2',
      succ_icon = 'black-tie',
      icon_class = "text-info",
      is_perc = FALSE,
      is_url = FALSE
    )
  })

  observe({
    print("server")
    print(boxes())
  })

  # Create metric grid card.
  gridServer(id = 'grid', cards = boxes)

}

shinyApp(ui = ui, server = server)
