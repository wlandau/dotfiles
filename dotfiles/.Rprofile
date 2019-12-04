Sys.setenv(NOT_CRAN = "true")
Sys.setenv(KMP_DUPLICATE_LIB_OK = "True") # for TensorFlow

options(bitmapType = "cairo", drake_make_menu = FALSE, drake_clean_menu = FALSE)
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org"
  options(repos = r)
})

q0 <- function() {
  q(save = "no", status = 0, runLast = TRUE)
}

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

vis_rprof <- function(rprof) {
  vis_pprof <- function(path, host = "localhost", port = NULL) {
    server <- sprintf("%s:%s", host, port %||% random_port())
    message("local pprof server: http://", server)
    args <- c("-http", server, path)
    if (on_windows()) {
      shell(paste(c("pprof", args), collapse = " "))
    } else {
      system2(jointprof::find_pprof(), args)
    }
  }
  
  random_port <- function(from = 49152L, to = 65355L) {
    sample(seq.int(from = from, to = to, by = 1L), size = 1L)
  }
  
  on_windows <- function() {
    tolower(Sys.info()["sysname"]) == "windows"
  }
  
  `%||%` <- function(x, y) {
    if (is.null(x) || length(x) <= 0) {
      y
    } else {
      x
    }
  }
  
  pprof <- tempfile()
  message("reading rprof")
  data <- profile::read_rprof(rprof)
  message("writing pprof")
  profile::write_pprof(data, pprof)
  message("showing pprof")
  vis_pprof(pprof)
}
