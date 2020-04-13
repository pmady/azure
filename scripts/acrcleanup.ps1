$acrName = 'YourACRName'

$repo = az acr repository list --name $acrName
$repo | Convertfrom-json | Foreach-Object {
    $imageName = $_
    (az acr repository show-tags -n $acrName --repository $_ | 
        convertfrom-json |) Select-Object -SkipLast 2 | Foreach-Object {
        az acr repository delete -n $acrName --image "$imageName:$_"
        }
}
