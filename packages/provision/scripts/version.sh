cut_d__f_n() {
  $1 | cut -d ' ' -f $2
}

_python3() {
  cut_d__f_n 'python3 --version' 2
}

_pip() {
  cut_d__f_n 'pip --version' 2
}

_virtualenv() {
  cut_d__f_n 'virtualenv --version' 2
}

_git() {
  cut_d__f_n 'git --version' 3
}

_gh() {
  while IFS= read -r line; do
    cut_d__f_n "echo $line" 3
    break;
  done < <(gh --version)
}

_dos2unix() {
  while IFS= read -r line; do
    cut_d__f_n "echo $line" 2
    break;
  done < <(dos2unix --version)
}

_tree() {
  cut_d__f_n 'tree --version' 2
}

_build-essential() {
  local continued=0

  while IFS= read -r line; do
    if [[ $continued = 2 ]]; then
      cut_d__f_n "echo $line" 2
      break
    else
      ((++continued))
      continue
    fi
  done < <(apt-cache show build-essential)
}

_curl() {
  while IFS= read -r line; do
    cut_d__f_n "echo $line" 2
    break
  done < <(curl --version)
}

_gnupg2() {
  local continued=0

  while IFS= read -r line; do
    if [[ $continued = 2 ]]; then
      cut_d__f_n "echo $line" 2
      break
    else
      ((++continued))
      continue
    fi
  done < <(apt-cache show gnupg2)
}

_zip() {
  local continued=0

  while IFS= read -r line; do
    if [[ $continued = 2 ]]; then
      cut_d__f_n "echo $line" 2
      break
    else
      ((++continued))
      continue
    fi
  done < <(apt-cache show zip)
}

_unzip() {
  local continued=0

  while IFS= read -r line; do
    if [[ $continued = 2 ]]; then
      cut_d__f_n "echo $line" 2
      break
    else
      ((++continued))
      continue
    fi
  done < <(apt-cache show unzip)
}

_fnm() {
  cut_d__f_n 'fnm --version' 2
}

_sdk() {
  local continued=0

  while IFS= read -r line; do
    if [[ $continued = 0 ]]; then
      ((++continued))
      continue
    fi

    cut_d__f_n "echo $line" 2 | sed 's/[[:cntrl:]]\[0m//'
    break
  done < <(. $HOME/.sdkman/bin/sdkman-init.sh && sdk version)
}

_java() {
  while IFS= read -r line; do
    cut_d__f_n "echo $line" 2
    break
  done < <(java --version)
}
