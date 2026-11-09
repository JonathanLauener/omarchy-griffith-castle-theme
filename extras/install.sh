#!/bin/bash
# Griffith Castle · optional extras installer.
#
# The theme itself installs with `omarchy theme install <repo-url>`. These
# extras add what a theme cannot ship on its own:
#   1. shell plugin clones with the [motif] patches (Brand in the bar that
#      bleeds on critical alerts, Eclipse critical cards, Brand lock screen)
#   2. the theme-motif theme-set hook (nvim colourscheme link, fastfetch logo,
#      starship palette switch — all reverted for other themes)
#   3. griffith-vhs, the 1997 broadcast shader toggle
# Every plugin change falls back to stock behaviour under themes without a
# [motif] section in their shell.toml. Nothing here needs root.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
plugins="$HOME/.config/omarchy/plugins"
user=${USER:-$(id -un)}

step() { printf '\n\033[1;31m▌\033[0m %s\n' "$1"; }

patch_plugin() { # <source-id> <file-in-plugin> <patch>
  local id=$1 file=$2 patchfile=$3 clone="$plugins/$user.${1#omarchy.}"
  if [[ ! -d $clone ]]; then
    omarchy plugin clone "$id"
  fi
  if grep -q "motif:begin\|motifActive\|motifCritical" "$clone/$file" 2>/dev/null; then
    echo "  $clone/$file already carries the motif changes"
  elif patch --dry-run -s "$clone/$file" <"$patchfile" >/dev/null 2>&1; then
    cp "$clone/$file" "$clone/$file.pre-motif"
    patch -s "$clone/$file" <"$patchfile"
    echo "  patched $clone/$file (backup: $file.pre-motif)"
  else
    echo "  ! $clone/$file differs from stock; apply $patchfile by hand"
  fi
}

step "Shell plugins"
patch_plugin omarchy.menu BarWidget.qml "$here/patches/menu-BarWidget.patch"
patch_plugin omarchy.notifications components/NotificationCard.qml "$here/patches/notifications-NotificationCard.patch"
patch_plugin omarchy.lock LockView.qml "$here/patches/lock-LockView.patch"

step "theme-set hook"
omarchy hook install theme-set "$here/hooks/theme-motif"

step "VHS shader toggle"
mkdir -p "$HOME/.local/bin"
install -m 755 "$here/bin/griffith-vhs" "$HOME/.local/bin/griffith-vhs"
echo "  installed ~/.local/bin/griffith-vhs"
echo "  bind it in ~/.config/hypr/bindings.lua, e.g.:"
echo '    o.bind("SUPER + CTRL + ALT + V", "VHS-Shader umschalten", "griffith-vhs")'

step "Starship"
if grep -q '^\[palettes\.griffith-castle\]' "$HOME/.config/starship.toml" 2>/dev/null; then
  echo "  palette already present"
else
  echo "  to get the red prompt, merge extras/starship/palettes.toml into ~/.config/starship.toml"
fi

step "Done"
echo "  Restart the shell so the plugin code is loaded fresh:  omarchy restart shell"
echo "  Then re-apply the theme:                               omarchy theme set griffith-castle"
echo "  Boot screen (asks for your password):                  omarchy plymouth set by theme griffith-castle"
