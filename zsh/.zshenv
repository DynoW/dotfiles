# Rust
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
if [ -d "$ZVM_INSTALL" ]; then
    export PATH="$PATH:$HOME/.zvm/bin"
    export PATH="$PATH:$ZVM_INSTALL"
fi
