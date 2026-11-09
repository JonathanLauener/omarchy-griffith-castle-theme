#!/bin/bash
# Author helper: copy the live theme (~/.config/omarchy/themes/griffith-castle)
# and the installed extras back into this repo before committing.
# The live theme dir must stay free of .git — omarchy treats a theme with a
# .git directory as installed from a repo and drops its .lua files.
set -euo pipefail
repo=$(cd "$(dirname "$0")/.." && pwd)
live="$HOME/.config/omarchy/themes/griffith-castle"
rsync -a --delete --exclude .git --exclude .dev --exclude extras --exclude README.md --exclude LICENSE "$live/" "$repo/"
cp "$HOME/.config/omarchy/hooks/theme-set.d/theme-motif" "$repo/extras/hooks/theme-motif"
cp "$HOME/.local/bin/griffith-vhs" "$repo/extras/bin/griffith-vhs"
git -C "$repo" status --short
