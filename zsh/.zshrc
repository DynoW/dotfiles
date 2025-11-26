# # ---------------------------
# # Powerlevel10k Instant Prompt
# # ---------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------------
# PATH Configuration
# ---------------------------
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH:/usr/local/bin:/usr/local/go/bin"

# fnm (Fast Node Manager)
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# ---------------------------
# Prompt Theme (Oh My Posh)
# ---------------------------
eval "$(oh-my-posh init zsh --config ~/.poshthemes/zen.toml)"

# ---------------------------
# Zinit Setup
# ---------------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
#zinit snippet OMZP::archlinux # This is an Arch-specific snippet, might not be useful on Fedora/Ubuntu
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Enable completions
ZSH_DISABLE_COMPFIX=true
autoload -Uz compinit && compinit -i
zinit cdreplay -q

# ---------------------------
# Prompt Configuration (Powerlevel10k)
# ---------------------------
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------
# History Configuration
# ---------------------------
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
HISTDUP=erase

# ---------------------------
# Keybindings
# ---------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey "^[[3~" delete-char

# ---------------------------
# Completion Styling
# ---------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ---------------------------
# Aliases
# ---------------------------
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# ---------------------------
# Extra Tools
# ---------------------------

# FZF Keybindings and Completion (Cross-Distribution)
# This block attempts to find fzf keybindings based on common Linux distro paths.
# The order is important: try most common (Ubuntu/Debian) first, then Fedora, then generic.
if [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]]; then # Ubuntu/Debian common path
    source "/usr/share/doc/fzf/examples/key-bindings.zsh"
elif [[ -f "/usr/share/fzf/shell/key-bindings.zsh" ]]; then # Fedora common path (based on your 'rpm -ql')
    source "/usr/share/fzf/shell/key-bindings.zsh"
elif [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then # Arch Linux / other generic
    source "/usr/share/fzf/key-bindings.zsh"
elif [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh" ]]; then # User-installed or custom fzf setup
    source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh"
elif [[ -f "$HOME/.fzf.zsh" ]]; then # Legacy personal fzf setup
    source "$HOME/.fzf.zsh"
fi
# For completion, Zsh's compinit should find _fzf in /usr/share/zsh/site-functions automatically.
# No explicit source for completion.zsh is usually needed if it's in a standard site-functions path.

eval "$(zoxide init --cmd cd zsh)"

# fnm (Fast Node Manager) - This was duplicated, removed the extra block
# The first fnm block at the top is sufficient.

# ---------------------------
# Restore standard Ctrl+R if FZF keybindings are not loaded
# This ensures that if fzf's Ctrl+r isn't active, Zsh's default is.
if [[ ! -f "/usr/share/fzf/shell/key-bindings.zsh" && \
      ! -f "/usr/share/doc/fzf/examples/key-bindings.zsh" && \
      ! -f "/usr/share/fzf/key-bindings.zsh" && \
      ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh" && \
      ! -f "$HOME/.fzf.zsh" ]]; then
    bindkey '^r' history-incremental-search-backward
fi

# fnm
FNM_PATH="/home/dyno/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
