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

    # Example aliases
    # alias zshconfig="mate ~/.zshrc"
    # alias ohmyzsh="mate ~/.oh-my-zsh"

    # Set to this to use case-sensitive completion
    # CASE_SENSITIVE="true"

    # Comment this out to disable weekly auto-update checks
    # DISABLE_AUTO_UPDATE="true"

    # Uncomment following line if you want to disable colors in ls
    # DISABLE_LS_COLORS="true"

    # Uncomment following line if you want to disable autosetting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Uncomment following line if you want red dots to be displayed while waiting for completion
    # COMPLETION_WAITING_DOTS="true"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # zsh-navigation-tools


    zstyle ":plugin:zconvey" check_interval "2"         # How often to check if there are new commands (in seconds)
    zstyle ":plugin:zconvey" expire_seconds "22"        # If shell is busy for 22 seconds, the received command will expire and not run
    zstyle ":plugin:zconvey" greeting "logo"            # Display logo at Zsh start ("text" – display text, "none" – no greeting)
    zstyle ":plugin:zconvey" ask "0"                    # zc won't ask for missing data ("1" has the same effect as always using -a option)
    zstyle ":plugin:zconvey" ls_after_rename "0"        # Don't execute zc-ls after doing rename (with zc-rename or zc-take)
    zstyle ":plugin:zconvey" use_zsystem_flock "1"      # Should use faster zsystem's flock when it's possible?
                                                        # (default true on Zsh >= 5.3)
    zstyle ":plugin:zconvey" output_method "feeder"     # To put commands on command line, Zconvey can use small program "feeder". Or "zsh"
                                                        # method, which currently doesn't automatically run the command – to use when e.g.
                                                        # feeder doesn't build (unlikely) or when occurring any problems with it
    zstyle ":plugin:zconvey" timestamp_from "datetime"  # Use zsh/datetime module for obtaining timestamp. "date" – use date command (fork)


    export ZSHSELECT_BOLD="1"                   # The interface will be drawn in bold font. Use "0" for no bold
    export ZSHSELECT_COLOR_PAIR="white/black"   # Draw in white foreground, black background. Try e.g.: "white/green"
    export ZSHSELECT_BORDER="0"                 # No border around interface, Use "1" for the border
    export ZSHSELECT_ACTIVE_TEXT="reverse"      # Mark current element with reversed text. Use "underline" for marking with underline
    export ZSHSELECT_START_IN_SEARCH_MODE="1"   # Starts Zsh-Select with searching active. "0" will not invoke searching at start.
    
    plugins=(git env misc tar gitflow git-aliases lein showoff amazon z vagrant osx battery  thefuck github zsh-navigation-tools zconvey zsh-select zsh-autosuggestions zsh-syntax-highlighting aws)

    eval "$(thefuck --alias f)"
    bindkey -e

    source $ZSH/oh-my-zsh.sh

    if [ -d "$HOME/.local/bin" ]; then
        export PATH=~/.local/bin:$PATH
        source aws_zsh_completer.sh
    fi

    if [ -f "/usr/libexec/java_home" ]; then
        export JAVA_HOME="$(/usr/libexec/java_home)"
    fi

    PATH=$PATH:$HOME/bin # Add RVM to PATH for scripting
    if [ -d "$HOME/lemur-1.2.0/bin" ]; then
        PATH=$PATH:$HOME/lemur-1.2.0/bin # Add RVM to PATH for scripting
    fi


    # Customize to your needs...
    export TERM=xterm-256color

    alias hn=hostname

    PATH=$HOME/sbt/bin:$PATH
    if [ -d "$HOME/apache-maven-3.3.3/bin" ]; then
        PATH=$HOME/apache-maven-3.3.3/bin:$PATH
    fi
    #eval $(gpg-agent --daemon)

    # set up keyboard
    #xmodmap -e 'keycode 148 = Tab'
    #setxkbmap -option "ctrl:swapcaps"
    #setxkbmap -option grp:switch,grp:alt_space_toggle,grp_led:scroll us,il

    function kill-itunes() {
        while true; do sudo killall iTunes > /dev/null 2>&1 ; sleep 1; done
    }

    sdo() sudo zsh -c "$functions[$1]" "$@"

    function auto-commit-org() {
        inotifywait -q -m -e CLOSE_WRITE --format="git commit -m 'autocommit on change' %w" file.txt | sh
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
        
	function prelude-emacs() {
	    /Applications/Emacs.app/Contents/MacOS/Emacs -q --load ~/.emacs.d.9.6.2016.new/init.el "$@"
	}
    fi

fi

# ZSH Higher Order Functions
#. $HOME/.zsh/functional/functional.plugin.zsh
