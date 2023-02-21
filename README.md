# `replaceR`
## A Tracery-like Replacement Grammar Implemented in R

`replaceR` generates text by traversing a grammar that is stored as a
data table or CSV. This offers a simple and flexible approach to
generate text.

[Tracery](https://www.tracery.io) was originally developed by Kate
Compton in Javascript for grammars stored in JSON files. For a Tracery
implementation in R using JSON see
[TraceRy](https://github.com/dill/traceRy) by David Miller.

## Installation

`replaceR` can be installed directly from github.

``` r
devtools::install_github("kurtisturnbull/replaceR") # install
library(replaceR) # load
```

## Writing an example grammar

`replaceR` uses grammars stored as data tables. A grammar is a
dictionary of rulesets that match **symbols** (*i.e.* tags) to
**options** (*i.e.* replacements). When generating text, `replaceR`
traverses these rulesets replacing each symbol randomly with one of its
options. We can recursively reference symbols within options using `#`.

Let’s begin by writing a simple example grammar to generate text about
the discovery of exoplanets.

``` r
# Create a data table with a grammar
exoplanet_grammar <- data.table(
                      # symbol specifies the tag
                      symbol = "discoveryEvent", 
                      # option specifies the replacement
                      option = c("Using #technique#, we #finding#.")
                      )
# `replaceR` uses grammars stored as data tables
exoplanet_grammar
```

    #>            symbol                           option
    #> 1: discoveryEvent Using #technique#, we #finding#.

## Adding new options

We can add one or more new options to exisiting symbols or create new
branches using `add_options()`.

``` r
# Add a new option to discoveryEvent symbol
exoplanet_grammar <- add_options(exoplanet_grammar, "discoveryEvent",  # symbol
                         "We #finding# after validating #technique#." # option
                    )
# Add several new rulsets (symbol and options)
exoplanet_grammar <- add_options(exoplanet_grammar, "technique", # symbol
                         "the radial-velocity method",          # options
                         "transit photometry", 
                         "gravational microlensing"
                      )
exoplanet_grammar <- add_options(exoplanet_grammar, "finding",  # symbol
                         "discovered several #planetTypes#",   # options
                         "described novel #planetTypes#", 
                         "revised our understanding of #planetTypes#"
                      )
exoplanet_grammar <- add_options(exoplanet_grammar, "planetTypes", # symbol
                         "hot Jupiters",                          # options
                         "mini-Neptunes", 
                         "super-Earths"
                      )
exoplanet_grammar
```

    #>             symbol                                     option
    #>  1: discoveryEvent           Using #technique#, we #finding#.
    #>  2: discoveryEvent We #finding# after validating #technique#.
    #>  3:      technique                 the radial-velocity method
    #>  4:      technique                         transit photometry
    #>  5:      technique                   gravational microlensing
    #>  6:        finding           discovered several #planetTypes#
    #>  7:        finding              described novel #planetTypes#
    #>  8:        finding revised our understanding of #planetTypes#
    #>  9:    planetTypes                               hot Jupiters
    #> 10:    planetTypes                              mini-Neptunes
    #> 11:    planetTypes                               super-Earths

## Generating text

We can use `expand_story()` to generate text. We start expanding the
story at a specified symbol called the origin. Here, let’s generate a
sentence about exoplanet discovery with the `discoveryEvent` symbol from
our example grammar.

``` r
# Generate a sentence about exoplanet discovery
expand_story(exoplanet_grammar, origin = "discoveryEvent")
```

    #> [1] "We discovered several mini-Neptunes after validating transit photometry."

The origin can be any symbol in the grammar. For example, we can
generate fragments about exoplanet discovery by using the `finding`
symbol from our grammar as the origin.

``` r
# Generate a sentence fragment about exoplanet discovery
expand_story(exoplanet_grammar, origin = "finding")
```

    #> [1] "described novel super-Earths"

## Removing existing options

We can remove one or more options from exisiting symbols, or remove
branches (symbols and options) using `remove_options()`. If a symbol is
called but not present in the grammar it will be tagged with `$`.

``` r
# Remove super-Earths from planetType symbol
exoplanet_grammar <- remove_options(exoplanet_grammar, "planetTypes", # symbol
                                 "super-Earths"                   # option
                                 )
# Remove planetType symbol altogether 
exoplanet_grammar <- remove_options(exoplanet_grammar, "planetTypes"
                                 )
# Generate a fragment about exoplanet discovery without any exoplanet symbol
expand_story(exoplanet_grammar, origin = "discoveryEvent")
```

    #> [1] "Using the radial-velocity method, we described novel $planetTypes$."

## Working with modifiers

Modifiers deal with some (but not all) basic English rules for articles
(*i.e.* determiners), pluralization and tense. Modifiers are applied to
options after they’ve been selected for replacement.

-   `.cap` Capitalizes the first letter of the option
-   `.ed` Modifies a option for the paste tense
-   `.s` Pluralizes a option
-   `.a` Adds ‘an’ or ‘a’ as a determiner before a symbol

``` r
# Create a data table with a grammar
forest_grammar <- data.table(
                      # symbol specifies the tag
                    symbol = "forestEvent", 
                      # option specifies the replacement
                    option = paste0("#preps.cap# I #move.ed#, I saw #animal.a#",
                                   " and several #animal.s#.")
                  )
# Add several new branches (symbol and options)
forest_grammar <- add_options(forest_grammar, "move", # symbol
                         "walk",          # options
                         "move", 
                         "jump",
                         "hike"
                      )
forest_grammar <- add_options(forest_grammar, "animal",  # symbol
                         "fox",   # options
                         "racoon", 
                         "robin",
                         "insect"
                      )
forest_grammar <- add_options(forest_grammar, "preps",  # symbol
                         "when",   # options
                         "before", 
                         "after",
                         "as"
                      )
# Generate text
expand_story(forest_grammar, origin = "forestEvent")
```

    #> [1] "As I moved, I saw a robin and several racoons."

## Saving and opening an existing grammar

A grammar can be saved as a CSV using `write.csv()`. An existing grammar
saved as a CSV can be opened using `read_grammar()`.

``` r
# Temporary file for writing CSV 
temporary_file <- tempfile()
write.csv(forest_grammar, temporary_file)

# Read in grammar
forest_grammar <- read_grammar(temporary_file)
```

## Bugs, questions, or suggestions

To report a bug, ask a question, or offer a suggestion for improvement,
please open an
[issue.](https://github.com/kurtisturnbull/%60replaceR%60/issues)

## More Tracery resources

To learn more about Tracery, see Kate Compton’s work:

-   [Tracery Javascript
    Repo](https://github.com/galaxykate/tracery/tree/tracery2)
-   [Tracery Tutorial](http://www.crystalcodepalace.com/traceryTut.html)
-   [Tracery Browser Editor](http://tracery.io/editor/)
-   [Tracery Conference
    Paper](https://link.springer.com/chapter/10.1007/978-3-319-27036-4_14)
