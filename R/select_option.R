#' Select Option
#'
#' Generate a pattern node by selection an option from a specified symbol.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param target_symbol An existing grammar symbol (character)
#' @return A string (character)
#' @export

select_option <- function(grammar, target_symbol) {
  if (str_detect(target_symbol, "\\.")) {
    modifiers <- str_split(target_symbol, "\\.")[[1]]
    target_symbol <- modifiers[1]
    modifiers <- modifiers[-1]
    option <- grammar[grammar$symbol == target_symbol][sample(.N, 1)]$option
    if (!str_detect(option, "#.+#")) {
      if ('s' %in% modifiers) {
        tail_char <- str_sub(option, -1)
        if (tail_char %in% c('s', 'h', 'x', 'y')) {
          if (tail_char == 's' | tail_char == 'h' | tail_char == 'x') {
            option <- paste0(option, 'es')
          }
          if (tail_char == 'y') {
            if (str_extract(str_sub(option, -2), "^[aeiouAEIOU]")) {
              option <- paste0(option, "s")
            }
            else {
              option <- paste0(str_sub(option, 0, nchar(option) - 1), "ies")
            }
          }
        }
        else {
          option <- paste0(option, "s")
        }
      }
      if ('ed' %in% modifiers) {
        tail_char <- str_sub(option, -1)
        if (tail_char %in% c('s', 'h', 'x', 'y', 'e')) {
          if (tail_char == 's' | tail_char == 'h' | tail_char == 'x') {
            option <- paste0(option, 'ed')
          }
          if (tail_char == 'e') {
            option <- paste0(option, "d")
          }
          if (tail_char == 'y') {
            if (str_extract(str_sub(option, -2), "^[aeiouAEIOU]")) {
              option <- paste0(str_sub(option, 0, nchar(option) - 1), "ied")
            }
            else {
              option <- paste0(option, "ed")
            }
          }
        }
        else {
          option <- paste0(option, "ed")
        }
      }
      if ("cap" %in% modifiers) {
        option <- paste0(toupper(str_sub(option, 1, 1)), str_sub(option, 2))
      }
      if ("inQuotes" %in% modifiers) {
        option <- paste0('"', option, '"')
      }
      if ("a" %in% modifiers) {
        if (!is.na(str_extract(str_sub(option, 1), "^[aeiouAEIOU]"))) {
          option <- paste0("an ", option)
        }
        else {
          option <- paste0("a ", option)
        }
      }
      return(option)
    }
  }
  else {
    return(grammar[grammar$symbol == target_symbol][sample(.N, 1)]$option)
  }
}

.datatable.aware = TRUE
