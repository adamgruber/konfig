# function zsh_recompile {
#   autoload -U zrecompile
#   rm -f ~/.zsh/*.zwc
#   [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
#   [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old

#   for f in ~/.zsh/**/*.zsh; do
#     [[ -f $f ]] && zrecompile -p $f
#     [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
#   done

#   [[ -f ~/.zcompdump ]] && zrecompile -p ~/.zcompdump
#   [[ -f ~/.zcompdump.zwc.old ]] && rm -f ~/.zcompdump.zwc.old

#   source ~/.zshrc
# }

function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xjf $1  ;;
          *.tar.gz)    tar xzf $1  ;;
          *.bz2)       bunzip2 $1  ;;
          *.rar)       unrar x $1    ;;
          *.gz)        gunzip $1   ;;
          *.tar)       tar xf $1   ;;
          *.tbz2)      tar xjf $1  ;;
          *.tgz)       tar xzf $1  ;;
          *.zip)       unzip $1   ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1  ;;
          *)        echo "'$1' cannot be extracted via extract()" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

function trash () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      /bin/mv "$path" ~/.Trash/"$dst"
    fi
  done
}

## Print a horizontal rule
rule () {
  printf "%$(tput cols)s\n"|tr " " "─"}}


# Find AWeber hostnames
search() {
  for domainname in colo.lair int.prd.csh lbl.prd.csh svc.prd.csh int.csh lbl.csh svc.csh int.stg.csh lbl.stg.csh svc.stg.csh int.tst.csh lbl.tst.csh; do
    dig -t AXFR $domainname | grep -v ";" | grep -v "^_" | grep -v "^\s*$" | awk '{ print $1}' | sed 's/\.$//' | grep "$1" | uniq
  done
}