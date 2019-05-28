# for emacs tramp support
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
else
    # Path to your oh-my-zsh configuration.
    ZSH=$HOME/.oh-my-zsh

    export emotty_set=nature
    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="my-wezm"
    #ZSH_THEME="michelebologna"
    #ZSH_THEME="amuse"
    #ZSH_THEME="emotty"
    #ZSH_THEME="kardan"

    DEFAULT_USER=(shlomiv shlomi)

    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    export FZF_PREVIEW='"[ -f {} ] && head -100 {} || [ -d {} ] && ls -ltr | head -100"'

    export FZF_PREVIEW='"[ -d {} ] && ls -ltr | head  -100 ||
                         [[ $(file --mime {}) =~ binary ]] &&
                         echo {} is a binary ||
                         bat --style=numbers --color=always {} ||
                         cat {} 2> /dev/null | head -500"'

    export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border -m --bind 'ctrl-v:page-down,alt-v:page-up'"
    #export FZF_CTRL_T_COMMAND='find . -name "*.ts"'
    export FZF_CTRL_T_OPTS="--preview ${FZF_PREVIEW} --bind ?:toggle-preview"
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:4 --bind ?:toggle-preview"

    setopt HIST_FIND_NO_DUPS
    
    export FZF_BASE=/usr/local/opt/fsf
    
    plugins=(git lein z osx docker-compose docker github zsh-autosuggestions zsh-syntax-highlighting fzf)

    bindkey -e

    source $ZSH/oh-my-zsh.sh

    alias dk='docker'
    alias dkpn='docker system prune -a'
    alias dkps='docker ps -a'
    alias dclft='dclf --tail=10 -t'

    alias gke='\gitk --all $(git log -g --pretty=%h)'
    alias glg='git log --stat'
    alias glgg='git log --graph'
    alias glgga='git log --graph --decorate --all'
    alias glgm='git log --graph --max-count=10'
    alias glgp='git log --stat -p'
    alias glo='git log --oneline --decorate'
    alias glog='git log --oneline --decorate --graph'
    alias gloga='git log --oneline --decorate --graph --all'
    alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
    alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --all'

    PATH=$PATH:$HOME/bin

    # Customize to your needs...
    export TERM=xterm-256color

    alias hn=hostname

    #eval $(gpg-agent --daemon)

    # set up keyboard
    #xmodmap -e 'keycode 148 = Tab'
    #setxkbmap -option "ctrl:swapcaps"
    #setxkbmap -option grp:switch,grp:alt_space_toggle,grp_led:scroll us,il

    function kill-itunes() {
        while true; do sudo killall iTunes > /dev/null 2>&1 ; sleep 1; done
    }

    sdo() sudo zsh -c "$functions[$1]" "$@"

    function auto-commit-org-linux() {
        inotifywait -q -m -e CLOSE_WRITE --format="git commit -m 'autocommit on change' %w" ${1:=work.org} | sh
    }

    function auto-commit-org-osx() {
        echo "Auto commiting " ${1:=~/Documents/work.org}
        fswatch -0 ${1:=~/Documents/work.org} | while read -d "" event;  do cd $(dirname ${event}); git commit -m 'autocommit on change' ${event} ;done
    }

    function vm-start() {
        VBoxManage startvm ${1:=Envoy} --type headless
    }

    function vm-stop() {
        VBoxManage controlvm ${1:=Envoy} poweroff --type headless
    }

    function vm-suspend() {
        VBoxManage controlvm ${1:=Envoy} pause --type headless
    }

    function vm-resume() {
        VBoxManage controlvm ${1:=Envoy} resume --type headless
    }
    
    if [ -f /Applications/Emacs.app/Contents/MacOS/Emacs ]
    then
	alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs $@'

	function myemacs() {
	    ~/emacs-git/emacs/nextstep/Emacs.app/Contents/MacOS/Emacs -q --load ~/shlomi-emacs/init.el "$@"
	}

        function myemacs-q() {
	    ~/emacs-git/emacs/nextstep/Emacs.app/Contents/MacOS/Emacs -q "$@"
	}
        
        function myemacs-installed() {
	    /Applications/Emacs.app/Contents/MacOS/Emacs -q --load ~/shlomi-emacs/init.el "$@"
	}

        function myemacs-installed-auto-commit-org() {
	    /Applications/Emacs.app/Contents/MacOS/Emacs -q --load ~/shlomi-emacs/init.el "$@" &
            auto-commit-org-osx
	}
        
	function prelude-emacs() {
	    /Applications/Emacs.app/Contents/MacOS/Emacs -q --load ~/.emacs.d.9.6.2016.new/init.el "$@"
	}
    fi

fi
