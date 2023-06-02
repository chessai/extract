if [ -z ${1+x} ]; then
  echo "Usage: extract </path/to/file>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|sz|ex|tar.bz2|tar.gz|tar.xz>"
else
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xvjf ./"$1"                                     ;;
      *.tar.gz)    tar xvzf ./"$1"                                     ;;
      *.tar.xz)    tar xvJf ./"$1"                                     ;;
      *.lzma)      xz --format=lzma --decompress ./"$1"                ;;
      *.bz2)       bzip2 -d ./"$1"                                     ;;
      *.rar)       unrar x -ad ./"$1"                                  ;;
      *.gz)        gzip -d ./"$1"                                      ;;
      *.tar)       tar xvf ./"$1"                                      ;;
      *.tbz2)      tar xvjf ./"$1"                                     ;;
      *.tgz)       tar xvzf ./"$1"                                     ;;
      *.zip)       unzip ./"$1"                                        ;;
      *.Z)         uncompress ./"$1"                                   ;;
      *.7z)        7z x ./"$1"                                         ;;
      *.xz)        xz --decompress ./"$1"                              ;;
      *.exe)       cabextract ./"$1"                                   ;;
      *.cab)       cabextract ./"$1"                                   ;;
      *)           echo "extract: '$1' - unknown archive method"     ;;
    esac
  else
    echo "$1 - file does not exist"
  fi
fi
