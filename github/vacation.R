# length of vacation
expiry <- "one_week" # one_day three_days one_week one_month six_months
date <- "2023-11-28" # date of return

# vacation functions
vacation_on <- function(expiry, date) {
  limit_repos(expiry)
  limit_users(expiry)
  open_issues(expiry = expiry, date = date)
}

vacation_off <- function() {
  unlimit_users()
  unlimit_repos()
  close_issues()
}

# repo and user settings
# Each token needs repo, user, and discussion permissions.
repo_args <- function() {
  tibble::tribble(
    ~repo, ~owner, ~token, ~expiry, ~issue,
    "drake", "ropensci", Sys.getenv("GITHUB_PAT"), expiry, "1374",
    "targets", "ropensci", Sys.getenv("GITHUB_PAT"), expiry, "1007",
    "tarchetypes", "ropensci", Sys.getenv("GITHUB_PAT"), expiry, "130",
    "gittargets", "ropensci", Sys.getenv("GITHUB_PAT"), expiry, "13",
    "jagstargets", "ropensci", Sys.getenv("GITHUB_PAT"), expiry, "32",
    "stantargets", "ropensci", Sys.getenv("GITHUB_PAT"), expiry, "58",
    "crew", "wlandau", Sys.getenv("GITHUB_PAT"), expiry, "24",
    "crew.cluster", "wlandau", Sys.getenv("GITHUB_PAT"), expiry, "11",
    "crew.aws.batch", "wlandau", Sys.getenv("GITHUB_PAT"), expiry, "1",
    "historicalborrow", "wlandau", Sys.getenv("GITHUB_PAT"), expiry, "5",
    "historicalborrowlong", "wlandau", Sys.getenv("GITHUB_PAT"), expiry, "1",
    "instantiate", "wlandau", Sys.getenv("GITHUB_PAT"), expiry, "5"
  )
}

user_args <- function() {
  tibble::tribble(
    ~user, ~token,
    "wlandau", Sys.getenv("GITHUB_PAT")
  )
}

# utility functions
limit_users <- function(expiry) {
  args <- user_args()
  limit_user(token = args$token, expiry = expiry)
}

unlimit_users <- function() {
  args <- user_args()
  unlimit_user(token = args$token)
}

limit_user <- function(token, expiry) {
  expiry <- match_expiry(expiry)
  args <- c(
    "-X PUT",
    headers(token),
    "https://api.github.com/user/interaction-limits",
    sprintf("-d '{\"limit\":\"collaborators_only\",\"expiry\":\"%s\"}'", expiry)
  )
  system2(command = "git", args = c("config", "--global", "user.name"))
  system2(command = "curl", args = args)
}

unlimit_user <- function(token) {
  args <- c(
    "-X DELETE",
    headers(token),
    "https://api.github.com/user/interaction-limits"
  )
  system2(command = "git", args = c("config", "--global", "user.name"))
  system2(command = "curl", args = args)
}

limit_repos <- function(expiry) {
  args <- repo_args()
  for (row in seq_len(nrow(args))) {
    limit_repo(
      repo = args$repo[row],
      owner = args$owner[row],
      token = args$token[row],
      expiry = expiry
    )
  }
}

unlimit_repos <- function() {
  args <- repo_args()
  for (row in seq_len(nrow(args))) {
    unlimit_repo(
      repo = args$repo[row],
      owner = args$owner[row],
      token = args$token[row]
    )
  }
}

limit_repo <- function(repo, owner, token, expiry) {
  expiry <- match_expiry(expiry)
  message(paste0(owner, "/", repo))
  args <- c(
    "-X PUT",
    headers(token),
    sprintf("https://api.github.com/repos/%s/%s/interaction-limits", owner, repo),
    sprintf("-d '{\"limit\":\"collaborators_only\",\"expiry\":\"%s\"}'", expiry)
  )
  system2(command = "curl", args = args)
}

unlimit_repo <- function(repo, owner, token) {
  message(paste0(owner, "/", repo))
  args <- c(
    "-X DELETE",
    headers(token),
    sprintf("https://api.github.com/repos/%s/%s/interaction-limits", owner, repo)
  )
  system2(command = "curl", args = args)
}

open_issues <- function(expiry, date) {
  args <- repo_args()
  for (row in seq_len(nrow(args))) {
    open_issue(
      repo = args$repo[row],
      owner = args$owner[row],
      issue = args$issue[row],
      token = args$token[row],
      date = date
    )
  }
}

close_issues <- function() {
  args <- repo_args()
  for (row in seq_len(nrow(args))) {
    close_issue(
      repo = args$repo[row],
      owner = args$owner[row],
      issue = args$issue[row],
      token = args$token[row]
    )
  }
}

open_issue <- function(repo, owner, issue, token, date) {
  message(paste0(owner, "/", repo, " ", issue))
  args <- c(
    "-X PATCH",
    headers(token),
    sprintf("https://api.github.com/repos/%s/%s/issues/%s", owner, repo, issue),
    sprintf("-d '{\"state\":\"open\",\"body\":\"%s\"}'", issue_text(date))
  )
  system2(command = "curl", args = args)
}

close_issue <- function(repo, owner, issue, token) {
  message(paste0(owner, "/", repo, " ", issue))
  args <- c(
    "-X PATCH",
    headers(token),
    sprintf("https://api.github.com/repos/%s/%s/issues/%s", owner, repo, issue),
    sprintf("-d '{\"state\":\"close\",\"body\":\"%s\"}'", issue_text("Already returned."))
  )
  system2(command = "curl", args = args)
}

issue_text <- function(date) {
  sprintf(
    paste0(
      "## Vacation mode\\n\\nWhen this issue is open, ",
      "vacation mode is turned on. That means ",
      "[Github interactions are temporarily limited]",
      "(https://docs.github.com/en/communities/moderating-comments-and-conversations/limiting-interactions-in-your-repository), ",
      "so users cannot open or comment on ",
      "[issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/about-issues) or ",
      "[discussions](https://docs.github.com/en/discussions) until I return and re-enable interactions (see return date below). ",
      "When this issue is closed, vacation mode is turned off and interactions are re-enabled and possible again.\\n",
      "\\n\\n## Thanks\\n\\n",
      "Vacation mode helps me rest because it prevents tasks from piling up in my absence. ",
      "Thank you for your patience and understanding.\\n\\n## Day of my return\\n\\n%s",
      "\\n\\n## Vacation mode source code\\n\\n* <https://github.com/wlandau/dotfiles/blob/main/github/vacation.R>"
    ),
    date
  )
}

headers <- function(token) {
  c(
    "-H \"Accept: application/vnd.github+json\"",
    sprintf("-H \"Authorization: Bearer %s\"", token),
    "-H \"X-GitHub-Api-Version: 2022-11-28\""
  )
}

match_expiry <- function(expiry) {
  choices <- c("one_day", "three_days", "one_week", "one_month", "six_months")
  match.arg(arg = expiry, choices = choices, several.ok = FALSE)
}
