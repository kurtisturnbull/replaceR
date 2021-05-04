# `replaceR`
## A Tracery-like Replacement Grammar Implemented in R

`replaceR` generates text by traversing a grammar that is stored as a data table or CSV. This offers a simple and flexible approach to generate text.

[Tracery](https://www.tracery.io) was originally developed by Kate Compton in Javascript for grammars stored in JSON files. For a Tracery implementation in R using JSON see [TraceRy](https://github.com/dill/traceRy) by David Miller.

## Installation

`replaceR` can be installed directly from github.

``` r
devtools::install_github("kurtisturnbull/replaceR") # install
library(replaceR) # load
```

## How this package works

`replaceR` uses grammars stored as data tables. A grammar is a dictionary of
branches (*i.e.* rulesets) that match **symbols** (*i.e.* tags) to
**options** (*i.e.* replacements). When generating text, `replaceR` traverses
these rulesets replacing each symbol randomly with one of its options. We
can recursively reference symbols within options using `#`.

## Bugs, questions, or suggestions

To report a bug, ask a question, or offer a suggestion for improvement,
please open an [issue.](https://github.com/kurtisturnbull/replaceR/issues)

## More Tracery resources

To learn more about Tracery, see Kate Compton’s work:

  - [Tracery Javascript
    Repo](https://github.com/galaxykate/tracery/tree/tracery2)
  - [Tracery Tutorial](http://www.crystalcodepalace.com/traceryTut.html)
  - [Tracery Browser Editor](http://tracery.io/editor/)
  - [Tracery Conference Paper](https://link.springer.com/chapter/10.1007/978-3-319-27036-4_14)





