#' Creates an R Markdown PDF Thesis document
#'
#' This is a function called in output in the YAML of the driver Rmd file to
#' specify using the Heidelberg University template.
#'
#' @export
#' @param toc A Boolean (TRUE or FALSE) specifying whether table of contents
#' should be created
#' @param toc_depth A positive integer
#' @param highlight Syntax highlighting style. Supported styles include
#' "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn",
#' and "haddock". Pass NULL to prevent syntax highlighting.
#' @param ... Additional parameters to pass to `pdf_book()`.
#' @return A modified \code{pdf_document} based on the thesisdown template and
#' the huwiwidown template.
#' @examples
#' \dontrun{
#'  output: heididown::thesis_pdf
#' }
thesis_pdf <- function(toc = TRUE, toc_depth = 3, highlight = "default", ...) {

    base <- bookdown::pdf_book(
        template    = "template.tex",
        toc         = toc,
        toc_depth   = toc_depth,
        highlight   = highlight,
        keep_tex    = TRUE,
        pandoc_args = "--top-level-division=chapter",
        ...
    )

    # Mostly copied from knitr::render_sweave
    base$knitr$opts_chunk$comment   <- NA

    # To ensure images are in correct place (in line with text)
    base$knitr$opts_chunk$fig.align <- "center"
    # base$knitr$opts_chunk$fig.pos    <- "H"
    # base$knitr$opts_chunk$out.extra  <- ""

    # For tables
    options(knitr.table.format = "latex")
    options(kableExtra.latex.load_packages = FALSE)

    old_opt <- getOption("bookdown.post.latex")
    options(bookdown.post.latex = fix_envs)
    on.exit(options(bookdown.post.late = old_opt))

    return(base)
}

#' Creates an R Markdown PDF Thesis document without chapters
#'
#' This is a function called in output in the YAML of the driver Rmd file to
#' specify using the Heidelberg University template.
#'
#' @export
#' @param toc A Boolean (TRUE or FALSE) specifying whether table of contents
#' should be created
#' @param toc_depth A positive integer
#' @param highlight Syntax highlighting style. Supported styles include
#' "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn",
#' and "haddock". Pass NULL to prevent syntax highlighting.
#' @param ... Additional parameters to pass to `pdf_book()`.
#' @return A modified \code{pdf_document} based on the HU Berlin School of
#' Business and Economics LaTeX template.
#' @examples
#' \dontrun{
#'  output: heididown::thesis_without_chapter_pdf
#' }
thesis_without_chapter_pdf <- function(toc = TRUE, toc_depth = 3, highlight = "default", ...) {

    base <- bookdown::pdf_book(
        template    = "template_wo_chap.tex",
        toc         = toc,
        toc_depth   = toc_depth,
        highlight   = highlight,
        keep_tex    = TRUE,
        pandoc_args = "--top-level-division=section",
        ...
    )

    # Mostly copied from knitr::render_sweave
    base$knitr$opts_chunk$comment   <- NA

    # To ensure images are in correct place (in line with text)
    base$knitr$opts_chunk$fig.align <- "center"
    # base$knitr$opts_chunk$fig.pos    <- "H"
    # base$knitr$opts_chunk$out.extra  <- ""

    # For tables
    options(knitr.table.format = "latex")
    options(kableExtra.latex.load_packages = FALSE)

    old_opt <- getOption("bookdown.post.latex")
    options(bookdown.post.latex = fix_envs)
    on.exit(options(bookdown.post.late = old_opt))

    return(base)
}

#' Creates an R Markdown PDF Thesis document without chapters for submission
#' of a bachelor/master thesis to IPMB
#'
#' This is a function called in output in the YAML of the driver Rmd file to
#' specify using the Heidelberg University template.
#'
#' @export
#' @param toc A Boolean (TRUE or FALSE) specifying whether table of contents
#' should be created
#' @param toc_depth A positive integer
#' @param highlight Syntax highlighting style. Supported styles include
#' "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn",
#' and "haddock". Pass NULL to prevent syntax highlighting.
#' @param ... Additional parameters to pass to `pdf_book()`.
#' @return A modified \code{pdf_document} based on the HU Berlin School of
#' Business and Economics LaTeX template.
#' @examples
#' \dontrun{
#'  output: heididown::thesis_without_chapter_ipmb_pdf
#' }
thesis_without_chapter_ipmb_pdf <- function(toc = TRUE, toc_depth = 3, highlight = "default", ...) {

    base <- bookdown::pdf_book(
        template    = "template_wo_chap_ipmb.tex",
        toc         = toc,
        toc_depth   = toc_depth,
        highlight   = highlight,
        keep_tex    = TRUE,
        pandoc_args = "--top-level-division=section",
        ...
    )

    # Mostly copied from knitr::render_sweave
    base$knitr$opts_chunk$comment   <- NA

    # To ensure images are in correct place (in line with text)
    base$knitr$opts_chunk$fig.align <- "center"
    # base$knitr$opts_chunk$fig.pos    <- "H"
    # base$knitr$opts_chunk$out.extra  <- ""

    # For tables
    options(knitr.table.format = "latex")
    options(kableExtra.latex.load_packages = FALSE)

    old_opt <- getOption("bookdown.post.latex")
    options(bookdown.post.latex = fix_envs)
    on.exit(options(bookdown.post.late = old_opt))

    return(base)
}

fix_envs = function(x) {
    beg_reg <- '^\\s*\\\\begin\\{.*\\}'
    end_reg <- '^\\s*\\\\end\\{.*\\}'
    i3      <- if (length(i1 <- grep(beg_reg, x))) {
        (i1 - 1)[grepl("^\\s*$", x[i1 - 1])]
    }
    i3      <- c(
        i3,
        if (length(i2 <- grep(end_reg, x))) {
            (i2 + 1)[grepl("^\\s*$", x[i2 + 1])]
        }
    )
    if (length(i3)) {
        x <- x[-i3]
    }
    return(x)
}
