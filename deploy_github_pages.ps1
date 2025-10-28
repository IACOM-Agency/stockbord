# Script automatique pour déployer sur GitHub Pages sans Git
# Utilise l'API GitHub directement

param(
    [string]$RepoUrl = "https://github.com/IACOM-Agency/stockbord",
    [string]$Token = ""
)

Write-Host "🚀 Déploiement automatique sur GitHub Pages..." -ForegroundColor Green

# Extraire le nom du repo et l'owner
if ($RepoUrl -match "github\.com/([^/]+)/([^/]+)") {
    $Owner = $matches[1]
    $Repo = $matches[2]
    Write-Host "📁 Repository: $Owner/$Repo" -ForegroundColor Cyan
} else {
    Write-Host "❌ URL du repository invalide" -ForegroundColor Red
    exit 1
}

# Demander le token si pas fourni
if (-not $Token) {
    Write-Host "🔑 Vous avez besoin d'un Personal Access Token GitHub"
    Write-Host "   Allez sur: https://github.com/settings/tokens"
    Write-Host "   Créez un token avec les permissions 'repo' et 'pages'"
    $Token = Read-Host "Entrez votre token GitHub"
}

# Fonction pour encoder en base64
function ConvertTo-Base64 {
    param([string]$Content)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Content)
    return [System.Convert]::ToBase64String($bytes)
}

# Fonction pour créer/mettre à jour un fichier via l'API GitHub
function Update-GitHubFile {
    param(
        [string]$FilePath,
        [string]$Content,
        [string]$Message
    )
    
    $EncodedContent = ConvertTo-Base64 $Content
    $ApiUrl = "https://api.github.com/repos/$Owner/$Repo/contents/$FilePath"
    
    $Headers = @{
        "Authorization" = "token $Token"
        "Accept" = "application/vnd.github.v3+json"
        "User-Agent" = "PowerShell-Deploy-Script"
    }
    
    # Vérifier si le fichier existe déjà
    try {
        $ExistingFile = Invoke-RestMethod -Uri $ApiUrl -Headers $Headers -Method Get
        $Sha = $ExistingFile.sha
    } catch {
        $Sha = $null
    }
    
    $Body = @{
        message = $Message
        content = $EncodedContent
    }
    
    if ($Sha) {
        $Body.sha = $Sha
    }
    
    $JsonBody = $Body | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri $ApiUrl -Headers $Headers -Method Put -Body $JsonBody -ContentType "application/json"
        Write-Host "✅ $FilePath mis à jour" -ForegroundColor Green
    } catch {
        Write-Host "❌ Erreur pour $FilePath : $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Lister tous les fichiers à déployer
$FilesToDeploy = @()
Get-ChildItem -Path "." -Recurse -File | ForEach-Object {
    $RelativePath = $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/')
    if ($RelativePath -notmatch "deploy_github_pages\.ps1|publish_to_pages\.ps1") {
        $FilesToDeploy += @{
            Path = $RelativePath
            Content = Get-Content $_.FullName -Raw -Encoding UTF8
        }
    }
}

Write-Host "📦 $($FilesToDeploy.Count) fichiers à déployer" -ForegroundColor Cyan

# Déployer chaque fichier
foreach ($File in $FilesToDeploy) {
    Update-GitHubFile -FilePath $File.Path -Content $File.Content -Message "Deploy: Update $($File.Path)"
    Start-Sleep -Milliseconds 500  # Éviter les limites de taux
}

# Activer GitHub Pages via l'API
Write-Host "🌐 Activation de GitHub Pages..." -ForegroundColor Cyan
$PagesApiUrl = "https://api.github.com/repos/$Owner/$Repo/pages"
$PagesBody = @{
    source = @{
        branch = "main"
        path = "/"
    }
} | ConvertTo-Json

try {
    Invoke-RestMethod -Uri $PagesApiUrl -Headers $Headers -Method Post -Body $PagesBody -ContentType "application/json"
    Write-Host "✅ GitHub Pages activé!" -ForegroundColor Green
} catch {
    if ($_.Exception.Response.StatusCode -eq 409) {
        Write-Host "ℹ️  GitHub Pages déjà activé" -ForegroundColor Yellow
    } else {
        Write-Host "⚠️  Erreur lors de l'activation de Pages: $($_.Exception.Message)" -ForegroundColor Yellow
        Write-Host "   Vous devrez l'activer manuellement dans les paramètres du repo" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "🎉 Déploiement terminé!" -ForegroundColor Green
Write-Host "🌍 Votre site sera disponible à: https://$($Owner.ToLower()).github.io/$($Repo.ToLower())/" -ForegroundColor Cyan
Write-Host "⏱️  Il peut falloir quelques minutes pour que le site soit accessible" -ForegroundColor Yellow