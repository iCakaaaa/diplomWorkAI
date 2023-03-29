$key="2313f0fb3cc744fb90220a8e3af070d8"
$endpoint="https://dimplomworkinstanceofme.cognitiveservices.azure.com/"


# Code to call Computer Vision service for image analysis
$img_file = "dog.png"
if ($args.count -gt 0 -And $args[0] -in ("dog.png"))
{
    $img_file = $args[0]
}

$img = "https://github.com/iCakaaaa/diplomWorkAI/blob/ea56d3848c302d90bb69cbad25c080e8fae13789/data/vision/dog.png"
        

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/vision/v3.2/analyze?visualFeatures=Categories,Description,Objects" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = $result | ConvertFrom-Json
Write-Host("`nDescription:")
foreach ($caption in $analysis.description.captions)
{
    Write-Host ($caption.text)
}

Write-Host("`nObjects in this image:")
foreach ($object in $analysis.objects)
{
    Write-Host (" -", $object.object)
}

Write-Host("`nTags relevant to this image:")
foreach ($tag in $analysis.description.tags)
{
    Write-Host (" -", $tag)
}

Write-Host("`n")
