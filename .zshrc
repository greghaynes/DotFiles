unsetopt beep

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

fpath=($fpath $HOME/.zsh/func)
typeset -u fpath

precmd() {
    vcs_info
}
autoload -Uz vcs_info
 
zstyle ':vcs_info:*' stagedstr '%F{28}●'
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
    } else {
        zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}●%F{blue}]'
    }
 
    vcs_info
}
 
setopt prompt_subst
PROMPT='%F{green}%n %F{magenta}@%m %F{yellow}%c%F{blue}${vcs_info_msg_0_}%F{blue}%(?/%F{green}/%F{red})>%F{white}'

setopt complete_in_word prompt_subst always_to_end correct_all
setopt appendhistory hist_ignore_all_dups hist_ignore_space
setopt local_options local_traps
setopt auto_pushd pushd_ignore_dups pushdminus

unsetopt menu_complete 

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=40000
SAVEHIST=1000

# Colorful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

