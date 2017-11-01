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

dl <- function(){
  library(cranlogs)
  for (pkg in c("downsize", "drake", "eply", "grapes", "wildcard")){
    cat("\n")
    now <- Sys.time()
    out <- suppressWarnings(cran_downloads(
      pkg,
      from = format(now - 3e5, "%Y-%m-%d"),
      to = "last-day"
    ))
    print(out[-nrow(out), ])
  }
}

ld <- function(){
  library(devtools)
  library(eply)
  library(lintr)
  library(spelling)
  library(storr)
  library(testthat)
  load_all("~/projects/drake")
}

td <- function(){
  dir <- tempfile()
  unlink(dir, recursive = TRUE)
  dir.create(dir)
  setwd(dir)
}
