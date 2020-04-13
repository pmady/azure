$acrName = 'YourACRName'

#List all images in repo deletes all images except last 5
$repo = az acr repository list --name $acrName
$repo | Convertfrom-json | Foreach-Object {
    $imageName = $_
    (az acr repository show-tags -n $acrName --repository $_ | 
        convertfrom-json |) Select-Object -SkipLast 5 | Foreach-Object {
        az acr repository delete -n $acrName --image "$imageName:$_"
        }
}
