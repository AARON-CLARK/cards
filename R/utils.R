
#' Automatic font re-sizer
#'
#' A function that adjusts the number (to be used as font size) that is
#' proportional to the length of a text string. So the longer the text string,
#' the smaller the font. Used in MetricBox.R.
#'
#' @param txt a string
#' @param txt_max an integer to specify a length of text that is considered "to
#'   long" to continue to toggle the font size
#' @param size_min an integer specifying the smallest font size you'd like to
#'   see in the output
#' @param size_max integer specifying the largest font size you'd like to see in
#'   the output
#' @param num_bins when not NULL (the default), accepts an integer that bins a
#'   continuous font size into a categorical one.
#'
#' @keywords internal
#'
auto_font <- function(txt, txt_max = 45, size_min = .75, size_max = 1.5,
                      num_bins = NULL){
  txt_len <- nchar(txt)
  txt_pct <- 1- ifelse(txt_len >= txt_max, 1, txt_len / txt_max)
  cont_size <- round(size_min + (txt_pct * (size_max - size_min)), 3)
  if (is.null(num_bins)) {
    return(cont_size)
  } else {
    # when creating bins, we want equally sized categories and to choose the
    # left bound if cont_size falls in the lowest category; otherwise,
    # re-calculate the breaks to be more proportional and choose the upper bound
    num_bins0 <- ifelse(num_bins < 2, 2, num_bins)
    breaks <- seq(size_min, size_max, length.out = num_bins0 + 1)
    grp <- as.character(cut(cont_size, breaks, include.lowest = TRUE))

    breaks2 <- seq(size_min, size_max, length.out = num_bins0)
    return(ifelse(substr(grp, 1, 1) == "[",
                  size_min,
                  breaks2[cut(cont_size, breaks, include.lowest = TRUE, labels = FALSE)])
    )
  }
}


#' Add box card
#'
#' Pretty simple function that makes new card data creation really simple, and
#'   adds small cheat to create the table if it doesn't already exist
#'
#' @param data a data.frame
#'
#' @import dplyr
#' @export
#'
add_box_card <- function(
    data = NULL,
    name = "card_name",
    title = 'Card Title',
    desc = 'Card Description',
    value = 'Card Value',
    succ_icon = 'black-tie',
    icon_class = "text-info",
    is_perc = 0,
    is_url = 0
    ){
  if(is.null(data)) {
    data <- dplyr::tibble(
      name = character(),
      title = character(),
      desc = character(),
      value = character(),
      succ_icon = character(),
      icon_class = character(),
      is_perc = numeric(),
      is_url = numeric(),
      type = "information"
    )
  }
    dplyr::add_row(data,
      name = name,
      title = title,
      desc = desc,
      value = value,
      succ_icon = succ_icon,
      icon_class = icon_class,
      is_perc = is_perc,
      is_url = is_url
    )
}


