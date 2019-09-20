Sys.setenv(NOT_CRAN = "true")
Sys.setenv(KMP_DUPLICATE_LIB_OK = "True") # for TensorFlow

options(bitmapType = "cairo", drake_make_menu = FALSE, drake_clean_menu = FALSE)
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org"
  options(repos = r)
})

utils::assignInNamespace(
  "q",
  function(save = "no", status = 0, runLast = TRUE){
    .Internal(quit(save, status, runLast))
  },
  "base"
)

ld <- function(){
  library(devtools)
  library(testthat)
  library(usethis)
  library(storr)
  load_all(file.path(Sys.getenv("PROJECTS"), "drake"))
}

td <- function(){
  dir <- tempfile()
  unlink(dir, recursive = TRUE)
  dir.create(dir)
  setwd(dir)
}
