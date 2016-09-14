function get_host {
  local user=`whoami`
  local found=0
  
  for name in ${DEFAULT_USER[@]}
  do
     if [ "$user" = "$name" ] 
       then 
            found=1
            break
     fi
  done

  if [[ $found = 0 ]] 
   then echo "$user"'@'`hostname`''
  fi
}

PROMPT='$(git_prompt_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg[yellow]%}>%{$reset_color%} '
RPROMPT='%{$fg[green]%}%~%{$reset_color%}$(get_host)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
