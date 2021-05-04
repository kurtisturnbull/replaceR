#' Expand Story
#'
#' Generate a story from a specified start symbol and grammar.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param origin A specified start symbol to initiate story.
#' @return A data table containing a Tracery-like grammar
#' @export

expand_story <- function(grammar, origin){
  template <- grammar[grammar$symbol == origin][sample(.N, 1)]$option
  while (str_detect(template, "#[a-zA-Z_\\.]+#")) {
    symbols <- str_replace_all(
              str_extract_all(template, "#[a-zA-Z_\\.]+#")[[1]], "#", "")
    for (target_symbol in symbols){
      if (! str_split(target_symbol, "\\.")[[1]][1] %in% grammar$symbol) {
        template <- str_replace_all(template, paste0("#", target_symbol, "#"),
                                              paste0("$", target_symbol, "$"))
      }
      else {
      template <- str_replace(template, paste0("#", target_symbol, "#"),
                            grow_branch(grammar, target_symbol))
      }
    }
  }
  return(template)
}
