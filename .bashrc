
# remaps
xmodmap -e "keycode 112 = Home" # page up -> home
xmodmap -e "keycode 117 = End" # page down -> end
xmodmap -e "keycode 110 = Prior" # home -> page up
xmodmap -e "keycode 115 = Next" # end -> page down

# aliases
alias ls='ls --color'
alias dcup='docker-compose up'
alias dc='docker-compose'

alias vim=nvim
alias vi=nvim
alias v=nvim

# variables
export EDITOR=nvim
export GOPATH=/work/go

# extra
source /usr/share/nvm/init-nvm.sh
alias tempo='curl http://wttr.in/Blumenau --header "Accept-Language: pt-br"'
