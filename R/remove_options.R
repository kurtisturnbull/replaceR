#' Remove Options from a Grammar
#'
#' `remove_options` removes options or an entire symbol from a grammar.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param target_symbol An existing grammar symbol (character)
#' @param ... A series of symbols (characters) to remove from the target symbol
#' @return A data table containing a Tracery-like grammar
#' @export

remove_options <- function(grammar, target_symbol, ...) {
  if (length(c(...)) > 0) {
    return(grammar[! paste0(symbol, option) %in% paste0(target_symbol, c(...))])
  }
  else {
    return(grammar[symbol != target_symbol])
  }
}
