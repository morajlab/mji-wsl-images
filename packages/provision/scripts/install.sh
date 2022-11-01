#!/usr/bin/env bash

shopt -s expand_aliases

BPM_INSTALL_URL=

while [ "$#" -gt 0 ]; do
    case "${1^^}" in
        "--BPM-INSTALL-URL" | "-U")
            BPM_INSTALL_URL=$2

            shift
            shift
        ;;
        *)
            shift
        ;;
    esac
done

# Install bpm
curl -fsSL $BPM_INSTALL_URL | bash

# TODO: Add this feature to bpm installer script
alias bpm=$HOME/.bpm/bpm
bpm install is_installed log feature_list
