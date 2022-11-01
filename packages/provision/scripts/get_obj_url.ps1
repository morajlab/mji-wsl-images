$object = $args[0]

& "$env:USERPROFILE\uplink_windows_amd64\uplink.exe" share $object --url --not-after=none | select -Last 1 | ForEach-Object {
    $_.split(" ")[-1]
}
