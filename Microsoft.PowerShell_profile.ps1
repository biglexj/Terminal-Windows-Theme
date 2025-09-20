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
# ℹ️ Info del sistema optimizada y arreglada
# ===========================

function Show-SystemInfoTable {
    # Calcular uptime correctamente
    $lastBootTime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    $uptime = (Get-Date) - $lastBootTime

    # Formatear los valores antes de crear la tabla
    $data = @(
        @{ Label = " S.O";       Value = (Get-CimInstance -Class Win32_OperatingSystem).Caption },
        @{ Label = " Equipo";    Value = $env:COMPUTERNAME },
        @{ Label = " Usuario";   Value = $env:USERNAME },
        @{ Label = " Uptime";    Value = "{0:dd}d {0:hh}h {0:mm}m" -f $uptime },
        @{ Label = " Fecha";     Value = Get-Date -Format 'dd/MM/yyyy HH:mm' },
        @{ Label = " PowerShell";Value = "v$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)" }
    )
    
    # Usar el mismo ancho que el banner (67 caracteres)
    $tableWidth = 67
    $colors = @('Green', 'Yellow', 'Magenta', 'Blue', 'Cyan', 'Red')  # Ajustado para 5 elementos
    
    # Línea superior
    Write-Host ("┌" + "─" * ($tableWidth - 2) + "┐") -ForegroundColor $colors[0]
    
    # Filas de datos
    $data | ForEach-Object -Begin { $i = 0 } -Process {
        $row = $_
        $textColor = $colors[$i % $colors.Length]
        $borderColor = $colors[0]
        
        $left = $row.Label.PadRight(20)
        $right = $row.Value
        
        # Calcular espacios para llenar exactamente el ancho de la tabla
        $contentLength = $left.Length + 3 + $right.Length
        $padding = $tableWidth - $contentLength - 2
        if ($padding -lt 0) { $padding = 0 }
        
        # Línea de contenido
        Write-Host "│" -ForegroundColor $borderColor -NoNewline
        Write-Host "$left | $right" -ForegroundColor $textColor -NoNewline
        Write-Host (" " * $padding) -NoNewline
        Write-Host "│" -ForegroundColor $borderColor
        $i++
    } 
    
    # Línea inferior
    Write-Host ("└" + "─" * ($tableWidth - 2) + "┘") -ForegroundColor $colors[0]
}

# ¡AQUÍ ESTÁ LA LLAMADA QUE FALTABA!
Show-SystemInfoTable

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