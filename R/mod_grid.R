#' Metric Grid module's UI.
#'
#' @param id a module id name
#' @keywords internal
#'
gridUI <- function(id) {
  fluidPage(uiOutput(NS(id, 'grid')))
}


#' Metric Grid module's server logic
#'
#' @param id a module id name
#' @param metrics placeholder
#'
#' @keywords internal
#'
#' @import dplyr
#' @importFrom stringr str_extract
#'
gridServer <- function(id, cards) {
  moduleServer(id, function(input, output, session) {

    output$grid <- renderUI({
      req(nrow(cards()) > 1) # need at least two cards to make a metric grid UI

      columns <- 3
      column_vector_grid_split <- split(seq_len(nrow(cards())), rep(1:columns, length.out = nrow(cards())))

      fluidRow(style = "padding-right: 10px", class = "card-group",
               map(column_vector_grid_split,
                   ~ column(width= 4, map(.x,~ boxUI(session$ns(cards()$name[.x])))))
      )
    })

    observeEvent(req(nrow(cards()) > 0), {
      apply(cards(), 1, function(m)
        boxServer(id = m['name'],
                  title = m['title'],
                  desc = m['desc'],
                  value = m['value'],
                  is_perc = m['is_perc'],
                  is_url = m['is_url'],
                  succ_icon = m['succ_icon'],
                  icon_class = m['icon_class'],
                  type = m['type']
        )
      )
    })
  })
}
