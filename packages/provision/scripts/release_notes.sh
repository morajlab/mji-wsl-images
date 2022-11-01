#!/usr/bin/env bash

shopt -s expand_aliases

ROOT_PATH=$(dirname $(dirname $(realpath $(dirname $0))))
download_file_path=
download_file_url=
version_array=()
software_list=

alias feature_list="bash $(pwd)/bash_modules/bin/feature_list"

while [ "$#" -gt 0 ]; do
  case "${1^^}" in
    "--DOWNLOAD-FILE" | "-D" )
      download_file_path=$2

      shift
      shift
    ;;
    "--DOWNLOAD-URL" | "-U" )
      download_file_url=$2

      shift
      shift
    ;;
    *)
      shift
    ;;
  esac
done

if [[ -z $download_file_path ]]; then
  echo "ERROR:: option '--DOWNLOAD-FILE' is missing"
  exit 1
fi

if [[ ! -f $download_file_path ]]; then
  echo "ERROR:: path '$download_file_path' is invalid"
  exit 1
fi

if [[ -z $download_file_url ]]; then
  echo "ERROR:: option '--DOWNLOAD-URL' is missing"
  exit 1
fi

while IFS= read -r version; do
  version_array+=("$version")
done < <(feature_list -l $ROOT_PATH/packages/provision/scripts/features_list \
-v $ROOT_PATH/packages/provision/scripts/version.sh)

list_versions() {
  local counter=0

  while IFS= read -r software; do
    echo '-' $software '->' ${version_array[$counter]}
    ((++counter))
  done < $ROOT_PATH/packages/provision/scripts/features_list
}

download_file_name=$(basename $download_file_path)
download_file_size=$(ls -lah $download_file_path | cut -d ' ' -f 5)

cat <<- EOF
### Installed Software

$(list_versions)

### Download File

| Name                                      | Size                |
| ----------------------------------------- | ------------------- |
| [$download_file_name]($download_file_url) | $download_file_size |
EOF
