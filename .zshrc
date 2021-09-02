

# ========================================================================#
#   PowerLevel10K init
#=========================================================================#
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



# ========================================================================#
#   antigen init
#=========================================================================#
source $HOME/.config/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle aliases
antigen bundle brew
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle compleat
antigen bundle cp
antigen bundle gitignore

antigen bundle docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

antigen bundle docker-compose
antigen bundle fastfile
antigen bundle mosh
antigen bundle vagrant
antigen bundle vagrant-prompt
antigen bundle extract
antigen bundle aws
antigen bundle universalarchive


antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-autosuggestions

antigen theme romkatv/powerlevel10k 
antigen bundle jeffreytse/zsh-vi-mode

# Quickly go back to a specific parent directory instead of typing cd ../../.. redundantly.
# $ mkdir -p a/b/c/d
# $ cd a/b/c/d
# $ bd b
# $ ls -> c
antigen bundle Tarrasch/zsh-bd

# Tell Antigen that you're done.
antigen apply

# ========================================================================#
#   == MY SETTINGS ==							  
#=========================================================================#






#===================#
#	Exports			
#===================#

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR=nvim
export HOMEBREW_NO_AUTO_UPDATE=1


#===================#
#	PATH			
#===================#

# if nothing exists do nothing, else add .local/bin/ to PATH
[[ ! -d ~/.local/bin ]] || PATH=$PATH:~/.local/bin

# add MacTeX to PATH
export PATH="/Library/TeX/texbin/pdflatex:$PATH"

# To activate jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# LANG prefs for nice ssh
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

#====================
#	fu(n)ctions		
#====================

# goes up from current directory
# cd..N, while n is number of directories to go up
# ex. 'cd.. 2' = 'cd ../../'
function cd_up() 
{
	cd $(printf "%0.s../" $(seq 1 $1 ));  
}

# mkdir dirname; cd dirname
mkcd ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# Docker
#
#   docker stopall      - stops all containers
#   docker rmall        - removes all containers
#   docker images rmall - removes all images
docker() {
    if [[ $@ == "stopall" ]]
	then
        command docker stop $(docker ps -a -q)
	elif [[ $@ == "rmall" ]]
	then
		command docker rm $(docker ps -a -q)
	elif [[ $@ == "images rmall" ]]
	then
		command docker image rm --force $(docker images  -a -q)

    else
        command docker "$@"
    fi
}


#====================
#	Aliases 		#
#====================

# ----------------
#   cd aliases
# ----------------
alias 'cd..'='cd_up'
alias cdd="cd $HOME/Devel"
alias cdj="cd $HOME/Devel/Java"
alias cdo="cd $HOME/Devel/Docker"
alias cdb="cd $HOME/.local/bin"

# -----------------------
#   edit configs aliases
# -----------------------
alias ecz="nvim $HOME/.zshrc"
alias ecy="nvim $HOME/.config/yabai/yabairc"
alias ecs="nvim $HOME/.config/skhd/skhdrc"
alias ecsp="nvim $HOME/.config/spacebar/spacebarrc"
alias ecn="nvim $HOME/.config/nvim/init.vim"
alias ecr="nvim $HOME/.config/ranger/rc.conf"


# ----------------
#   brew aliases
# ----------------
alias bsr="brew services restart"
alias bss="brew services start"
alias bst="brew services stop"
alias bsra="brew services restart --all"
alias bssa="brew services start --all"
alias bsta="brew services stop --all" 

# ----------------
#   other aliases
# ----------------
alias vim='nvim'
alias rr='ranger'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cadd='config add'
alias cpom="config push origin master"


# ========================================================================#
#   == Plugin Settings ==							  
#=========================================================================#


#=========================
#	powerlevel10k
#=========================
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



#=========================
#	    zoxide 		
#=========================

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
if [ "${__zoxide_hooked}" != '1' ]; then
    __zoxide_hooked='1'
    chpwd_functions=("${chpwd_functions[@]}" "__zoxide_hook")
fi

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
function __zoxide_z() {
    if [ "$#" -eq 0 ]; then
        __zoxide_cd ~
    elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
        if [ -n "${OLDPWD}" ]; then
            __zoxide_cd "${OLDPWD}"
        else
            # shellcheck disable=SC2016
            \builtin printf 'zoxide: $OLDPWD is not set'
            return 1
        fi
    elif [ "$#" -eq 1 ] &&  [ -d "$1" ]; then
        __zoxide_cd "$1"
    else
        \builtin local __zoxide_result
        __zoxide_result="$(zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" \
            && __zoxide_cd "${__zoxide_result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local __zoxide_result
    __zoxide_result="$(zoxide query -i -- "$@")" && __zoxide_cd "${__zoxide_result}"
}

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

# Remove definitions.
function __zoxide_unset() {
    \builtin unalias "$@" &>/dev/null
    \builtin unfunction "$@" &>/dev/null
    \builtin unset "$@" &>/dev/null
}

__zoxide_unset 'z'
function z() {
    __zoxide_z "$@"
}

__zoxide_unset 'zi'
function zi() {
    __zoxide_zi "$@"
}

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
#
eval "$(zoxide init zsh)"

