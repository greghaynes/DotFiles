unsetopt beep

# Aliases
alias ls="ls -b -CF --color=auto"
alias ssh-morbo="ssh greghaynes@morbo.greghaynes.net"
alias ssh-alkazar="ssh greghaynes@alkazar.greghaynes.net"
alias ssh-linuxlab="ssh gregarei@linuxlab.cs.pdx.edu"
alias df='df -h -x none'
alias free='free -m'

# Prompt
preexec () {
	if [ "$TERM" = screen ]; then
		print -nP '\033k%'
		print -nPR "%60>...>${(V)1//\%/%%}"
		print -n '\033\\'
	fi
}

if [[ "$TERM" == "screen" ]]; then
	PROMPT="${PROMPT}%{^[kzsh^[\\%}"
fi


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
	bender*) hostcolor="yellow" ;;
	morbo*) hostcolor="magenta" ;;
	*) hostcolor="blue" ;;
esac

PROMPT="[%F{$usercolor}%n%F{white}@%F{$hostcolor}%m%F{white}:%F{blue}%~%f]>"

#History
HISTFILE=$HOME/.zsh_history
HISTSIZE=40000
SAVEHIST=1000

