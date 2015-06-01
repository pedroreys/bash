kbdict=$HOME/Library/KeyBindings/DefaultKeyBinding.dict

if ! [ -L "$kbdict" ]; then
    echo "DefaultKeyBinding.dict not found. Creating symlink"
    mkdir -p $HOME/Library/KeyBindings
    ln -s $HOME/.bash/scripts/DefaultKeyBinding.dict $kbdict
fi
