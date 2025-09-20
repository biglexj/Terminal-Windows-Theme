# ===========================
# 🚀 PowerShell $PROFILE - Biglex J Edition
# ===========================

# --- Oh My Posh (tema personalizado) ---
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\biglexj.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\cert.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\1_shell.omp.json" | Invoke-Expression

# --- Terminal Icons ---
Import-Module -Name Terminal-Icons

# --- PSReadLine con predicciones avanzadas ---
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function DeleteChar
Set-PSReadLineKeyHandler -Key "Ctrl+w" -Function BackwardDeleteWord

# --- Chocolatey tab-completion ---
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) {
    Import-Module "$ChocolateyProfile"
}

# ===========================
# 🎨 Banner ASCII de bienvenida
# ===========================
$banner = @'
___________________________________________________________________
|   ___     ___     ___     *       ***   **  __                _ |
|  | * )   |* *|   / *_|   | |     | __|  \ \/ /     o O O   _ | ||
|  | * \    | |   | (* |   | |__   | _|    >  <     o       | || ||
|  |___/   |___|   \___|   |____|  |___|  /_/\_\   TS__[O]  *\*_/ |
|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| {======|_|"""""||
|"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'|
|_________________________________________________________________|
'@

$bannerWidth = 67
foreach ($line in $banner -split "`n") {
    Write-Host ($line.PadRight($bannerWidth)) -ForegroundColor Green
}

# ===========================
# ℹ️ Info del sistema optimizada
# ===========================

# Calcular uptime correctamente
$lastBootTime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$uptime = (Get-Date) - $lastBootTime

# Usar LinkedHashMap para mantener el orden
$info = [ordered]@{
    "📅 Fecha"      = Get-Date -Format 'dd/MM/yyyy HH:mm'
    "💻 Equipo"     = $env:COMPUTERNAME
    "🚀 Uptime"     = "{0:dd}d {0:hh}h {0:mm}m" -f $uptime
    "👤 Usuario"    = $env:USERNAME
    "⚡ PowerShell" = "v$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
    "🖥️  SO"        = (Get-WmiObject -Class Win32_OperatingSystem).Caption
}

$tableWidth = 67

# Línea superior
Write-Host ("┌" + "─" * ($tableWidth - 2) + "┐") -ForegroundColor Cyan

# Cuerpo con colores alternados
$colorIndex = 0
$colors = @('Green', 'Yellow', 'Magenta', 'Cyan', 'Blue', 'Red')

foreach ($key in $info.Keys) {
    $value = $info[$key]
    # Calcular espacios necesarios para que la línea tenga exactamente $tableWidth caracteres
    $contentLength = $key.Length + $value.Length + 6  # 6 = "│ " + " │ " + "│"
    $paddingNeeded = $tableWidth - $contentLength
    
    if ($paddingNeeded -gt 0) {
        $line = "│ {0} │ {1}{2} │" -f $key, $value, (" " * $paddingNeeded)
    } else {
        # Si el contenido es muy largo, truncar el valor
        $maxValueLength = $tableWidth - $key.Length - 8
        if ($value.Length -gt $maxValueLength) {
            $value = $value.Substring(0, $maxValueLength - 3) + "..."
        }
        $line = "│ {0} │ {1} │" -f $key, $value
        $line = $line.PadRight($tableWidth - 1) + "│"
    }
    
    Write-Host $line -ForegroundColor $colors[$colorIndex % $colors.Length]
    $colorIndex++
}

# Línea inferior
Write-Host ("└" + "─" * ($tableWidth - 2) + "┘") -ForegroundColor Cyan
# ===========================
# 🔗 Aliases de navegación rápida 
# ===========================
function .. { Set-Location ".." }
function ... { Set-Location "..\.." }
function .... { Set-Location "..\..\.." }

# Rutas específicas de Biglex J
function bjpro { Set-Location "E:\Proyectos\biglexj" }
function bjdes { Set-Location "E:\Descargas" }
function bjdoc { Set-Location "E:\Documentos" }
function bjimg { Set-Location "E:\Imágenes" }
function bjmus { Set-Location "E:\Música" }
function bjvid { Set-Location "E:\Vídeos" }
function bjass { Set-Location "E:\Assets" }
function bjdav { Set-Location "E:\Vídeos\DaVinci Resolve" }
function bjyt { Set-Location "E:\Imágenes\YouTube" }
function bjmarca { Set-Location "E:\Imágenes\Proyectos\Marca" }

# ===========================
# 🛠️ Utilidades de desarrollo
# ===========================
function touch {
    param([string]$Path)
    if (!(Test-Path $Path)) {
        New-Item -ItemType File -Path $Path | Out-Null
        Write-Host "✅ Archivo creado: $Path" -ForegroundColor Green
    } else {
        (Get-Item $Path).LastWriteTime = Get-Date
        Write-Host "🔄 Archivo actualizado: $Path" -ForegroundColor Yellow
    }
}

# Git shortcuts con feedback visual
function gs { 
    git status
    Write-Host "📊 Estado del repositorio mostrado" -ForegroundColor Cyan
}

function ga { 
    param([string]$files = ".")
    git add $files
    Write-Host "➕ Archivos agregados al staging" -ForegroundColor Green
}

function gc { 
    param([string]$message)
    if ($message) {
        git commit -m $message
        Write-Host "💾 Commit realizado: $message" -ForegroundColor Green
    } else {
        Write-Host "❌ Necesitas un mensaje de commit" -ForegroundColor Red
    }
}

function gp { 
    git push
    Write-Host "🚀 Cambios enviados al repositorio remoto" -ForegroundColor Green
}

function gpl { 
    git pull
    Write-Host "⬇️  Cambios descargados del repositorio remoto" -ForegroundColor Blue
}

# NPM/PNPM shortcuts
function dev { pnpm run dev }
function build { pnpm run build }
function start { pnpm start }
function install { pnpm install }

# ===========================
# 🎮 Funciones de utilidad
# ===========================

# Función para mostrar todos los alias disponibles
function Show-Aliases {
    Write-Host "`n🔗 Aliases de Navegación:" -ForegroundColor Yellow
    Write-Host "  ..     → Subir un directorio" -ForegroundColor Gray
    Write-Host "  ...    → Subir dos directorios" -ForegroundColor Gray  
    Write-Host "  bjpro  → E:\Proyectos\biglexj" -ForegroundColor Gray
    Write-Host "  bjyt   → E:\Imágenes\YouTube" -ForegroundColor Gray
    
    Write-Host "`n🛠️  Comandos de Desarrollo:" -ForegroundColor Yellow
    Write-Host "  gs     → git status" -ForegroundColor Gray
    Write-Host "  dev    → pnpm run dev" -ForegroundColor Gray
    Write-Host "  build  → pnpm run build" -ForegroundColor Gray
    
    Write-Host "`n💡 Tip: Escribe 'Show-Aliases' para ver esta ayuda`n" -ForegroundColor Cyan
}

# Alias corto para la ayuda
New-Alias -Name "help" -Value "Show-Aliases"
New-Alias -Name "aliases" -Value "Show-Aliases"

# ===========================
# 🌟 Mensaje de bienvenida final
# ===========================
Write-Host "`n🎉 ¡Terminal de Biglex J cargado exitosamente!" -ForegroundColor Green
Write-Host "💡 Escribe 'help' para ver todos los comandos disponibles" -ForegroundColor Cyan
Write-Host "🚀 ¡A programar y crear contenido épico!" -ForegroundColor Magenta