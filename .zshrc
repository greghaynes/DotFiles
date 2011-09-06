unsetopt beep

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

fpath=($fpath $HOME/.zsh/func)
typeset -u fpath

autoload -U zgitinit
zgitinit

# load aliases
if [ -e $HOME/.aliases ]; then
	source $HOME/.aliases
fi
if [ -e $HOME/.zsh/aliases ]; then
	source $HOME/.zsh/aliases
fi

# Prompt
prompt_preexec () {
	if [ "$TERM" = screen ]; then
		print -nP '\033k%'
		print -nPR "%60>...>${(V)1//\%/%%}"
		print -n '\033\\'
	fi
}
preexec_functions+=prompt_preexec

prompt_precmd() {
	# Get username color
	if [ "${UID}" = 0 ]; then
		usercolor="red"
	else
		case $(whoami) in
			greghaynes*) usercolor="green" ;;
			gregarei*) usercolor="yellow" ;;
			greghayn*) usercolor="blue" ;;
			*) usercolor="blue" ;;
		esac
	fi

	# Get hostname color
	case $(hostname) in
		bender*) hostcolor="blue" ;;
		morbo*) hostcolor="magenta" ;;
		farnsworth*) hostcolor="cyan" ;;
		*) hostcolor="blue" ;;
	esac

	if zgit_isgit; then
		PROMPT="[%F{$usercolor}%n%F{white}@%F{$hostcolor}%m%F{white}:%F{magenta}%~%f]
(%F{cyan}$(zgit_branch)%f)"
	else
		PROMPT="[%F{$usercolor}%n%F{white}@%F{$hostcolor}%m%F{white}:%F{magenta}%~%f]"
	fi

	# Add virtual env
	if [ -n "${VIRTUAL_ENV:+x}" ]; then
		PROMPT="$PROMPT(%F{yellow}$(basename $VIRTUAL_ENV)%F{white})"
	fi

	# Add end char
	PROMPT="$PROMPT>"
}
precmd_functions+=prompt_precmd

#History
HISTFILE=$HOME/.zsh_history
HISTSIZE=40000
SAVEHIST=1000

