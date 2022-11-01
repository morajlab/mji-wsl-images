param ($file, $bucket)

& "$env:USERPROFILE\uplink_windows_amd64\uplink.exe" cp $file sj://$bucket
