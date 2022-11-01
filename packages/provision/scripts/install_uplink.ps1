param ($url, $token, $name)

$file_name = $url.Substring($url.LastIndexOf("/") + 1)
cd $env:USERPROFILE
curl -#LO $url
Expand-Archive ".\$file_name"
cd .\uplink_windows_amd64\
New-Item .\acc-grant.key
echo $token > .\acc-grant.key
echo y|.\uplink.exe access import $name .\acc-grant.key
