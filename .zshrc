PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:$HOME/.brew/bin
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000

setopt inc_append_history
setopt share_history

if [[ -f ~/.myzshrc ]]; then
  source ~/.myzshrc
fi

USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL

alias mycc='gcc -Wall -Wextra -Werror'
alias getlib='cp ~/semaine_1/libft_rendu/libft.a ~/semaine_1/libft_rendu/libft.h .'
alias goto_lib='cd ~/semaine_1/libft_rendu/'
alias makeMakefile='sh ~/DIV/make_Makefile.sh'
alias convertascii='./~/DIV/asciiart/makeascii'
