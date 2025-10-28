$ErrorActionPreference = 'Stop'

# Ce script prépare et publie le dossier courant (autobord_stock_web)
# sur un dépôt GitHub Pages. Il crée un dépôt local, un premier commit,
# puis pousse sur la branche main. L'activation de Pages côté GitHub
# peut nécessiter un passage par l'interface si vous n'utilisez pas l'API.

param(
  [string]$RepoUrl = "",
  [string]$UserName = "",
  [string]$UserEmail = ""
)

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Error "Git n'est pas installé ou introuvable dans PATH."
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

Write-Host "Dossier: $root"

# Init git
if (-not (Test-Path (Join-Path $root ".git"))) {
  git init | Out-Null
}

# Config user si absent
try {
  $curName = git config user.name
  $curMail = git config user.email
} catch {}

if ([string]::IsNullOrWhiteSpace($curName) -and -not [string]::IsNullOrWhiteSpace($UserName)) {
  git config user.name $UserName | Out-Null
}
if ([string]::IsNullOrWhiteSpace($curMail) -and -not [string]::IsNullOrWhiteSpace($UserEmail)) {
  git config user.email $UserEmail | Out-Null
}

# Fichiers à inclure
git add .

try {
  git commit -m "Initial StockBord site" | Out-Null
} catch {
  Write-Host "Rien à committer ou identité git déjà configurée."
}

if (-not [string]::IsNullOrWhiteSpace($RepoUrl)) {
  # Définir remote si non présent
  $remotes = git remote
  if (-not ($remotes -match "origin")) {
    git remote add origin $RepoUrl | Out-Null
  }
  # Pousser sur main
  git branch -M main | Out-Null
  git push -u origin main
  Write-Host "Poussé sur main: $RepoUrl"
}

Write-Host "Terminé. Si nécessaire, activez GitHub Pages (Settings → Pages → Branch: main, /root)."