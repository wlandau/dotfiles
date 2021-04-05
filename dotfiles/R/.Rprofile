Sys.setenv(NOT_CRAN = "true")
Sys.setenv(KMP_DUPLICATE_LIB_OK = "True") # for TensorFlow

options(bitmapType = "cairo", drake_make_menu = FALSE, drake_clean_menu = FALSE)
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org"
  options(repos = r)
})

k <- function() {
  system("clear && printf '\\e[3J'")
}

et <- function() {
  usethis::edit_file("_targets.R")
}

q0 <- function() {
  q(save = "no", status = 0, runLast = TRUE)
}

la <- function() {
  pkgload::load_all()
}

ur <- function(x) {
  file <- fs::path_ext_set(x, "R")
  path <- usethis::proj_path("R", file)
  if (file.exists(path)) {
    usethis::edit_file(path)
  } else {
    stop("file ", path, " does not exist")
  }
}

cr <- function(x) {
  file <- fs::path_ext_set(x, "R")
  path <- usethis::proj_path("R", file)
  if (!file.exists(path)) {
    usethis::use_r(x)
  } else {
    stop("file ", path, " already exists")
  }
}

ut <- function(x) {
  file <- fs::path_ext_set(x, "R")
  file <- paste0("test-", file)
  path <- usethis::proj_path("tests/testthat", file)
  if (file.exists(path)) {
    usethis::edit_file(path)
  } else {
    stop("file ", path, " does not exist")
  }
}

ct <- function(x) {
  file <- fs::path_ext_set(x, "R")
  file <- paste0("test-", file)
  path <- usethis::proj_path("tests/testthat", file)
  if (!file.exists(path)) {
    usethis::use_test(x)
  } else {
    stop("file ", path, " already exists")
  }
}

ld <- function() {
  library(devtools)
  library(testthat)
  library(usethis)
  library(storr)
  load_all(file.path(Sys.getenv("PROJECTS"), "drake"))
}

td <- function() {
  dir <- tempfile()
  unlink(dir, recursive = TRUE)
  dir.create(dir)
  setwd(dir)
}

if (interactive()) {
  k()
}
