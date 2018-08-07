Sys.setenv(GITHUB_TOKEN = "38d65f20c9d4117062d6e82a4b8427ecf3f69473")
Sys.setenv(NOT_CRAN = "true")

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
  devtools::load_all("~/projects/drake")
}

cr <- function(){
  devtools::load_all("~/projects/crew")
  assign("workload", example_workload("environment"), envir = globalenv())
  assign("schedule", example_schedule("igraph"), envir = globalenv())
  assign("workers", 1, envir = globalenv())
  assign("fun", lapply, envir = globalenv())
}

td <- function(){
  dir <- tempfile()
  unlink(dir, recursive = TRUE)
  dir.create(dir)
  setwd(dir)
}

spell_check_ignore <- function(pkg){
  devtools::spell_check(pkg)$word
}

#library(devtools, warn.conflicts = FALSE)
#library(testthat, warn.conflicts = FALSE)
#library(usethis, warn.conflicts = FALSE)
#library(storr, warn.conflicts = FALSE)
