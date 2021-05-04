#' Add New Options to a Grammar
#'
#' `add_options` appends options to a new or existing symbol in a grammar.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param target_symbol A new or existing grammar symbol (character)
#' @param ... A series of symbols (characters) to add to the target symbol
#' @return A data table containing a Tracery-like grammar
#' @export

add_options <- function(grammar, target_symbol, ...) {
  rbind(grammar,
    data.table(
      symbol = target_symbol,
      option = c(...)
    )
  )
}



