param ($tag, $notesfile)

$version = echo $tag | Foreach-Object {
  $_.split("-")[3]
}
gh release create $tag -n -p -F $notesfile -t "WSL Ubuntu image ($version update)"
