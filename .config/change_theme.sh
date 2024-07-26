osascript -e \
'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
(defaults read -g AppleInterfaceStyle > ~/myscripts/osTheme.txt) &> /dev/null;
if [[ -s ~/myscripts/osTheme.txt ]]; then
    /Applications/kitty.app/Contents/MacOS/kitten themes --reload-in=all Catppuccin-Mocha;
    cat ~/.config/nvim/lua/plugins/dark-theme.txt > ~/.config/nvim/lua/plugins/catppuccin.lua
else
    /Applications/kitty.app/Contents/MacOS/kitten themes --reload-in=all Catppuccin-Latte
    cat ~/.config/nvim/lua/plugins/light-theme.txt > ~/.config/nvim/lua/plugins/catppuccin.lua
fi
