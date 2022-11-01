#!/usr/bin/env bash

PROVISION_PATH=$(dirname $(realpath $(dirname $0)))
TEMP_PATH=$(mktemp -d)
BPM_INSTALL_URL=

# Default variables
USER_NAME=mjl
USER_PASS=$USER_NAME
ROOT_PASS=toor

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

echo -e "$ROOT_PASS\n$ROOT_PASS" | passwd
useradd -m -s /bin/bash -G adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev $USER_NAME
echo -e "$USER_PASS\n$USER_PASS" | passwd $USER_NAME

cp -r $PROVISION_PATH $TEMP_PATH

chown $USER_NAME:$USER_NAME $TEMP_PATH -R
chmod 777 $TEMP_PATH/provision -R

su -c "cd $TEMP_PATH/provision && ./bin/ansible.sh --user-pass $USER_PASS --bpm-install-url $BPM_INSTALL_URL" $USER_NAME