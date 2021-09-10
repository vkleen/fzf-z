#!/usr/bin/env zsh

set -o errexit
set -o pipefail

FZFZ_RECENT_DIRS_TOOL=${FZFZ_RECENT_DIRS_TOOL:="z"}

if [[ $FZFZ_RECENT_DIRS_TOOL == "z" && -n "$ZSHZ_PLUGIN_PATH" ]]; then
    source "$ZSHZ_PLUGIN_PATH"
    zshz -l 2>&1 && exit 0 || exit 0
elif [[ $FZFZ_RECENT_DIRS_TOOL == "autojump" ]]; then
    if [[ $OSTYPE == darwin* && -z $(whence tac) ]]; then
        REVERSER='tail -r'
    else
        REVERSER='tac'
    fi
    autojump -s | $REVERSER | tail +8 | $REVERSER | awk '{print $2}'
elif [[ $FZFZ_RECENT_DIRS_TOOL == "fasd" ]]; then
    fasd -dl 2>&1 && exit 0 || exit 0
else
    echo "Unrecognized recent dirs tool '$FZFZ_RECENT_DIRS_TOOL', please set \$FZFZ_RECENT_DIRS_TOOL correctly."
    exit 1
fi
