function gj {
  if [ $# -eq 0 ]; then
    git status
  else
    echo $1
    cd $1
    git status
    cd ..
  fi
}

function go {
  if [ $# -eq 0 ]; then
    git log -1
  else
    echo $1
    cd $1
    git log -1
    cd ..
  fi
}

function kv {
  Rscript -e 'library(covr); x <- covr::package_coverage(path = '\"$1\"'); print(x); print(covr::zero_coverage(x))'
}

function lt {
  Rscript -e 'lintr::lint('\"$1\"')'
}

function rb {
  R CMD build $1
}

function rh {
  R CMD check $1.*.tar.gz
}

function ri {
  R CMD INSTALL $1
}

function rn {
  Rscript -e 'devtools::check(pkg = '\"$1\"')'
}

function ro {
  Rscript -e 'library(roxygen2); roxygenize('\"$1\"')'
}

function roi {
  ro $1
  ri $1
}

function sl {
  Rscript -e 'lintr::lint_package('\"$1\"')'
}

function sp {
  Rscript -e 'spelling::spell_check_package('\"$1\"', lang = "en_US")'
}

function tk {
  Rscript -e 'devtools::test(pkg = '\"$1\"')'
}

function tl {
  grep Failed $1
  grep Warnings $1
  grep Skipped $1
}

function trim {
  sed -i 's/[[:space:]]*$//g' $1
}
