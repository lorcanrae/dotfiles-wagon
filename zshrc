ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# [[ -f "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh" ]] && source "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv ssh-agent direnv)

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load pyenv (to manage your Python versions)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[%T][🐍 $(pyenv_prompt_info)]'
# PROMPT='[%T] '$PROMPT

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# gcloud autocomplete
[[ $commands[gcloud] ]] && source /usr/share/google-cloud-sdk/completion.zsh.inc

# Kubernetes autocomplete
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
[[ $commands[minikube] ]] && source <(minikube completion zsh)

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# Set ipdb as the default Python debugger
export PYTHONBREAKPOINT=ipdb.set_trace

eval "$(direnv hook zsh)"

export GOOGLE_APPLICATION_CREDENTIALS=/home/lscr/.gcp_keys/wagon-data-bootcamp-347311-5efe55510046.json

# Created by `pipx` on 2023-04-06 08:39:48
export PATH="$PATH:/home/lscr/.local/bin"

# Remove duplicates from $PATH - alternatively use typeset -U path
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}       # the first remaining entry
        case $PATH: in
            *:"$x":*) ;;         # if it's already in $PATH, skip it
            *) PATH=$PATH$x:;;   # if not, add it to $PATH
        esac
        old_PATH=${old_PATH#*:}  # remove the first entry from $old_PATH
    done
    PATH=${PATH%:}             # remove the trailing colon
    unset old_PATH x           # clean up temporary variables
fi
