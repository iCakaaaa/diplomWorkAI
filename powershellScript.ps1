$key = "2313f0fb3cc744fb90220a8e3af070d8"
$endpoint = "https://dimplomworkinstanceofme.cognitiveservices.azure.com/"

# Code to call Computer Vision service for image analysis
$img_file = "dog.png"
if ($args.count -gt 0 -and $args[0] -eq "dog.png") {
    $img_file = $args[0]
}

$img = "https://github.com/iCakaaaa/diplomWorkAI/raw/main/data/vision/dog.png"
$headers = @{
    "Ocp-Apim-Subscription-Key" = $key
    "Content-Type" = "application/json"
}

$body = @{
    "url" = $img
} | ConvertTo-Json

Write-Host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/vision/v3.2/analyze?visualFeatures=Categories,Description,Objects" `
          -Headers $headers `
          -Body $body

$analysis = $result | ConvertFrom-Json

Write-Host "`nDescription:"
foreach ($caption in $analysis.description.captions) {
    Write-Host $caption.text
}

Write-Host "`nObjects in this image:"
foreach ($object in $analysis.objects) {
    Write-Host " - $($object.object)"
}

Write-Host "`nTags relevant to this image:"
foreach ($tag in $analysis.description.tags) {
    Write-Host " - $tag"
}

Write-Host "`n"
