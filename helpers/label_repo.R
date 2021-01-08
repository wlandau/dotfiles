#' @title Add GitHub labels to the current repo.
#' @export
#' @description Borrows several labels from <https://github.com/wlandau/targets>.
#' @inheritParams usethis::use_github_labels
#' @param ... Optional named arguments to `usethis::use_github_labels()`.
#' \dontrun{
#' label_repo()
#' }
label_repo <- function(delete_default = TRUE, ...) {
  labels <- tibble::tribble(
    ~label, ~color,
    "depends: another issue", "2DC6AD",
    "depends: external prerequisite", "2DC6AD",
    "depends: future release", "2DC6AD",
    "depends: help or input", "2DC6AD",
    "depends: reprex", "2DC6AD",
    "difficulty: advanced", "0052CC",
    "difficulty: beginner", "0052CC",
    "difficulty: intermediate", "0052CC",
    "difficulty: good first issue", "0052CC",
    "order: later", "fbca04",
    "order: sooner", "fbca04",
    "order: 1", "fbca04",
    "order: 2", "fbca04",
    "order: 3", "fbca04",
    "order: 4", "fbca04",
    "order: 5", "fbca04",
    "status: cannot reproduce", "ffffff",
    "status: duplicate", "ffffff",
    "status: ignoring", "ffffff",
    "status: questioning", "ffffff",
    "status: shelved", "ffffff",
    "status: stale", "ffffff",
    "status: incompatible", "ffffff",
    "status: out of scope", "ffffff",
    "status: priority", "D93F0B",
    "topic: api", "BFD4F2",
    "topic: ci", "BFD4F2",
    "topic: cran", "BFD4F2",
    "topic: dependencies", "BFD4F2",
    "topic: design", "BFD4F2",
    "topic: documentation", "BFD4F2",
    "topic: performance", "BFD4F2",
    "topic: style", "BFD4F2",
    "type: bottleneck", "aa0566",
    "type: bug", "b60205",
    "type: edge case", "aa0566",
    "type: faq", "aa0566",
    "type: limitation", "aa0566",
    "type: new feature", "aa0566",
    "type: question", "aa0566",
    "type: trouble", "aa0566",
    "type: use case", "aa0566"
  )
  usethis::use_github_labels(
    labels = labels$label,
    colours = stats::setNames(object = labels$color, nm = labels$label),
    delete_default = delete_default,
    ...
  )
}
