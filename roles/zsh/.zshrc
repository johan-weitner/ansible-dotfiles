# Powerlevel10k configuration - (setup managed by zgenom)
if [[ ! -f ~/.p10k.zsh ]]; then
    echo "Powerlevel10k not configured, starting configuration wizard"
    p10k configure
else
    source ~/.p10k.zsh
fi

LANG=en_US.UTF-8

# PNPM support in volta is experimental behind this flag
VOLTA_FEATURE_PNPM=1

## PJ - Project Jump: Project directories
PROJECT_PATHS=(~/Code/ ~/)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

### ZGENOM SETUP ###
# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    # Add this if you experience issues with missing completions or errors mentioning compdef.
    # zgenom compdef

    # Ohmyzsh base library
    zgenom ohmyzsh

    # Load powerlevel10k theme
    zgenom load romkatv/powerlevel10k powerlevel10k


    # plugins
    zgenom ohmyzsh plugins/git
    zgenom oh-my-zsh plugins/jsontools
    zgenom oh-my-zsh plugins/vscode
    zgenom oh-my-zsh plugins/python
    zgenom oh-my-zsh plugins/1password
    zgenom oh-my-zsh plugins/dircycle
    zgenom oh-my-zsh plugins/direnv
    zgenom oh-my-zsh plugins/pj
    zgenom oh-my-zsh plugins/safe-paste
    zgenom oh-my-zsh plugins/sprunge
    zgenom oh-my-zsh plugins/volta
    # just load the completions
    zgenom ohmyzsh --completion plugins/docker-compose

    # Install ohmyzsh osx plugin if on macOS
    [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

    # prezto options
    zgenom prezto editor key-bindings 'emacs'
    # zgenom prezto prompt theme 'sorin'

    # prezto and modules
    # If you use prezto and ohmyzsh - load ohmyzsh first.
    zgenom prezto
    zgenom prezto command-not-found

    # Load prezto tmux when tmux is installed
    if hash tmux &>/dev/null; then
        zgenom prezto tmux
    fi

    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load djui/alias-tips
    zgenom load z-shell/F-Sy-H

    # use a plugin file
    # The file must only contain valid parameters for `zgenom load`
    # zgenom loadall < path/to/plugin/file

    # completions
    zgenom load zsh-users/zsh-completions

    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
    # Uncomment if you set ZDOTDIR manually
    # zgenom compile $ZDOTDIR

    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.
    zgenom autoupdate

    # rbenv rehash
fi
### END ###

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/plugins/zsh-dircycle/dircycle.zsh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='code'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias nano="micro"
alias python="python3"
alias pip="pip3"
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="lsd -l"
alias ll="lsd -alh"
alias lsa="lsd -la"
alias gwipe="git reset --hard"
alias glist="git show --pretty="" --name-only"
alias cat="bat"
alias z="zoxide"
alias sz="source ~/.zshrc"
alias sourcegit="source ~/.gitconfig"
alias ez="code ~/.zshrc"
alias editg="code ~/.gitconfig"
alias howdoi="howdoi -e duckduckgo $1"
alias cls="clear"
alias $="echo *** Remove leading $ character ***"
alias listalias="cat ~/.zshrc | grep alias"
alias catt="cat --style plain"
alias bc="better-commits"
alias lg="lazygit"
alias t="todo.sh"
alias w="watson"
alias cht="cht.sh"
alias nba="nb todo add $1"
alias nbl="nb list"
alias mc="LANG=en mc"
alias ppath="echo $PATH | tr ':' '\n'"
alias fzf="fzf -e -m --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias zg="zgenom"
alias ya="yadm"
alias yas="yadm status"
alias yaa="yadm add"
alias yac="yadm commit"
alias yap="yadm push"

# Zsh Navigation Tools
alias nc="n-cd"
alias na="n-aliases"
alias nh="n-history"
alias nk="n-kill"
alias ne="n-env"
alias no="n-options"
alias np="n-panelize"
alias nf="n-functions"

# Script aliases
alias printcommit="sh printFilesInCommit.sh"
alias copycommit="sh copyChangedFiles.sh"
alias copyback="sh copyFilesBack.sh"
alias gmove="sh moveCommit.sh"
alias cpDotFiles="sh copyDotFilesToGitRepo.sh"

# pnpm
export PNPM_HOME="~/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$PATH:/Users/johanweitner/Script"

if [ -x /usr/local/git/bin/git ]; then
    source ~/.git-completion.bash
fi

### Bypass stuff if Warp terminal ###
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
##### WHAT YOU WANT TO DISABLE FOR WARP - BELOW
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
##### WHAT YOU WANT TO DISABLE FOR WARP - ABOVE
fi
### END ###

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

export JAVA_HOME="/Applications/jdk-22.0.1.jdk/Contents/Home"
export PATH="$PATH:~/.local/bin"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PATH:/Users/johanweitner/.cargo/bin"
export PATH="$PATH:$JAVA_HOME/bin"



eval "$(direnv hook zsh)"

  ### ZNT's installer added snippet ###
  fpath=( "$fpath[@]" "$HOME/.config/znt/zsh-navigation-tools" )
  autoload n-aliases n-cd n-env n-functions n-history n-kill n-list n-list-draw n-list-input n-options n-panelize n-help
  autoload znt-usetty-wrapper znt-history-widget znt-cd-widget znt-kill-widget
  alias naliases=n-aliases ncd=n-cd nenv=n-env nfunctions=n-functions nhistory=n-history
  alias nkill=n-kill noptions=n-options npanelize=n-panelize nhelp=n-help
  zle -N znt-history-widget
  bindkey '^R' znt-history-widget
  zle -N znt-cd-widget
  bindkey "^C" znt-cd-widget
  zle -N znt-kill-widget
  bindkey "^K" znt-kill-widget

  zle -N paste-from-clipboard
  bindkey "^[[3;3~" paste-from-clipboard

  setopt AUTO_PUSHD HIST_IGNORE_DUPS PUSHD_IGNORE_DUPS
  zstyle ':completion::complete:n-kill::bits' matcher 'r:|=** l:|=*'
  ### END ###

# eval "$(ntfy shell-integration)"
if [[ "$(uname)" == "Darwin" ]]; then
	source $HOME/Code/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# if command -v python3 > /dev/null; then
#     export PATH=`python3 -m site --user-base`/bin:$PATH
# fi

if [[ "$(uname)" == "Linux" ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
source ~/.oh-my-zsh/oh-my-zsh.sh
