library(shiny)
library(dplyr)  # for data pre-processing and example data
# devtools::load_all()

# # prep a new data.frame with more diverse data types
# starwars2 <- starwars %>%
#   mutate_if(~is.numeric(.) && all(Filter(Negate(is.na), .) %% 1 == 0), as.integer) %>%
#   mutate_if(~is.character(.) && length(unique(.)) <= 25, as.factor) %>%
#   mutate(is_droid = species == "Droid") %>%
#   select(name, gender, height, mass, hair_color, eye_color, vehicles, is_droid)
#
# # create some labels to showcase column select input
# attr(starwars2$name, "label")     <- "name of character"
# attr(starwars2$gender, "label")   <- "gender of character"
# attr(starwars2$height, "label")   <- "height of character in centimeters"
# attr(starwars2$mass, "label")     <- "mass of character in kilograms"
# attr(starwars2$is_droid, "label") <- "whether character is a droid"

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
    )
  })

  # Create metric grid card.
  gridServer(id = 'grid', cards = boxes)

}

shinyApp(ui = ui, server = server)
