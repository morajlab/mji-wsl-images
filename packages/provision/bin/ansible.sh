#!/usr/bin/env bash

shopt -s expand_aliases

PROVISION_PATH=$(dirname $(realpath $(dirname $0)))

USER_PASS=
BPM_INSTALL_URL=

while [ "$#" -gt 0 ]; do
    case "${1^^}" in
        "--USER-PASS" | "--UP")
            USER_PASS=$2

            shift
            shift
        ;;
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

$PROVISION_PATH/scripts/install.sh --bpm-install-url $BPM_INSTALL_URL

alias is_installed="bash $(pwd)/bash_modules/bin/is_installed"

if [[ $(is_installed ansible --alias) = 1 ]]; then
    if [[ $(is_installed pip --alias) = 1 ]]; then
        cd $(mktemp -d)
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3 get-pip.py --user
    fi

    python3 -m pip install --user ansible
fi

alias ansible-playbook="$HOME/.local/bin/ansible-playbook"
alias ansible-galaxy="$HOME/.local/bin/ansible-galaxy"

ansible-galaxy install -r $PROVISION_PATH/playbooks/requirements.yml
ansible-playbook -v --connection=local --inventory 127.0.0.1, $PROVISION_PATH/playbooks/playbook.yml \
    -e "ansible_become_pass=$USER_PASS"