if [ -f ~/.bash_default ]; then
  . ~/.bash_default
fi

if [ -f ~/.bash_cli ]; then
  . ~/.bash_cli
fi

if [ -f ~/.bash_git ]; then
  . ~/.bash_git
fi

if [ -f ~/.bash_r ]; then
  . ~/.bash_r
fi

if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
