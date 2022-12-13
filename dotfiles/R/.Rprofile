options(
  bitmapType = "cairo",
  blogdown.hugo.version = "0.80.0",
  covr.flags = c(CXXFLAGS = "-O2", LDFLAGS = ""),
  repos = (\(repos) {
    repos["CRAN"] <- "https://cloud.r-project.org"
    repos
  })(getOption("repos")),
  tidyverse.quiet = TRUE
)

k <- function() {
  system("clear && printf '\\e[3J'")
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

td <- function() {
  dir <- tempfile()
  unlink(dir, recursive = TRUE)
  dir.create(dir)
  setwd(dir)
}
