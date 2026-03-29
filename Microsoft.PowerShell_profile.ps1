# ===========================
# 🚀 PowerShell $PROFILE - Biglex J Edition v3.0
# ===========================
$ProfileStartTime = [DateTime]::Now

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
# --- Banner estilo Copilot para BIGLEX-J ---
$banner = @'
╔═════════════════════════════════════════════════════════════════╗
║                                                                 ║
║      ██████╗ ██╗ ██████╗ ██╗     ███████╗██╗  ██╗      ██╗      ║
║      ██╔══██╗██║██╔════╝ ██║     ██╔════╝╚██╗██╔╝      ██║      ║
║      ██████╔╝██║██║  ███╗██║     █████╗   ╚███╔╝       ██║      ║
║      ██╔══██╗██║██║   ██║██║     ██╔══╝   ██╔██╗       ██║      ║
║      ██████╔╝██║╚██████╔╝███████╗███████╗██╔╝ ██╗   ██╗██║      ║
║      ╚═════╝ ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝╚═╝      ║
║                                                                 ║
║              W E L C O M E   T O   B I G L E X - J              ║
║                                                                 ║
║           CLI Version 2.0.0 • Build: CREATOR-EDITION            ║
║                                                                 ║
║   🎨 Content Creator | 💻 Developer | 🎵 JPop Enthusiast        ║
║   🚀 C# • Astro • Python | 🎬 DaVinci • Blender • OBS           ║
║                                                                 ║
║              > Ready to create amazing content...               ║
║                                                                 ║
╚═════════════════════════════════════════════════════════════════╝
'@

# Colores tipo "neón Copilot" con efecto aleatorio
$colors = @('Cyan','Magenta','Yellow','Green','Blue','Red')
$primaryColor = Get-Random $colors
$secondaryColor = Get-Random ($colors | Where-Object { $_ -ne $primaryColor })


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
    $colors = @('Green', 'Yellow', 'Magenta', 'Blue', 'Cyan', 'Red')
    
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

Show-SystemInfoTable

# ===========================
# 🔗 Aliases de navegación rápida 
# ===========================
function .. { Set-Location ".." }
function ... { Set-Location "..\.." }
function .... { Set-Location "..\..\.." }


# Rutas específicas de Biglex J
$Drive = "D:"
function bjpro { Set-Location "$Drive\Proyectos" }
function bjpros { Set-Location "$Drive\Proyectos\biglexj" }
function bjdes { Set-Location "$Drive\Descargas" }
function bjdoc { Set-Location "$Drive\Documentos" }
function bjimg { Set-Location "$Drive\Imágenes" }
function bjmus { Set-Location "$Drive\Música" }
function bjvid { Set-Location "$Drive\Vídeos" }
function bjass { Set-Location "$Drive\Assets" }
function bjdav { Set-Location "$Drive\Vídeos\DaVinci Resolve" }
function bjyt { Set-Location "$Drive\Imágenes\YouTube" }
function bjmarca { Set-Location "$Drive\Imágenes\Proyectos\Marca" }
function docs { Set-Location "$Drive\Proyectos\biglexj\Docs" }
function aurora { Set-Location "$Drive\Proyectos\biglexj\Aurora---Blog" }

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

function bj-sync {
    param([string]$message = "Syncing changes from terminal")
    git pull
    git add .
    git commit -m $message
    git push
    Write-Host "✅ Sincronización completa" -ForegroundColor Green
}

# NPM/PNPM shortcuts
function dev { bun run dev }
function build { bun run build }
function start { bun start }
function install { bun install }

# ===========================
# 🤖 Ely Intelligence & Live Stream
# ===========================
function start-aurora { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_services.ps1" }
function stop-aurora { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\stop_services.ps1" }
function backend { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_backend_cs.ps1" }
function ely-intelligence { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_ely_intelligence.ps1" }
function live { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_live.ps1" }
function vozely { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_voz_ely.ps1" }
function voice-ely { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_ely_voice_pipeline.ps1" }
function add-video { 
    param([string]$url, [string]$title, [string]$description, [string]$tags)
    & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\add-video.ps1" -Url $url -Type "video" -Title $title -Description $description
}
function add-karaoke { 
    param([string]$url, [string]$title, [string]$description, [string]$tags)
    & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\add-video.ps1" -Url $url -Type "karaoke" -Title $title -Description $description -Tags $tags
}

# --- PRODUCCIÓN ---
function new-project { python "$Drive\Proyectos\biglexj\Scripts\creacion\new_project.py" @args }

# ===========================
# 🎨 UTILIDADES CREATIVAS
# ===========================

# Mostrar paleta de colores oficial
function color-palette {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║              🎨 PALETA OFICIAL BIGLEX J                        ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan
    
    # Grid de colores Biglex J
    Write-Host "┌────────────┬────────────┬────────────┬────────────┐" -ForegroundColor DarkGray
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Cyan
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Red
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Green
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Blue
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#00AAFF" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#FF6B4C" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#4CFF5B" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#5B4CFF" -NoNewline -ForegroundColor White
    Write-Host "   │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Cyan Base" -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Coral    " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Verde    " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Morado   " -NoNewline -ForegroundColor Gray
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "└────────────┴────────────┴────────────┴────────────┘" -ForegroundColor DarkGray
    
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║             🎨 PALETA OFICIAL ELY VTUBER                       ║" -ForegroundColor Magenta
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Magenta
    
    # Grid de colores Ely VTuber
    Write-Host "┌────────────┬────────────┬────────────┬────────────┐" -ForegroundColor DarkGray
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Cyan
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Magenta
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor DarkGray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Yellow
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#00C7B1" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#FB7793" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#6E7179" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#FFE6CA" -NoNewline -ForegroundColor White
    Write-Host "   │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Turquesa " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Rosa     " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Gris Polo" -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Beige    " -NoNewline -ForegroundColor Gray
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "└────────────┴────────────┴────────────┴────────────┘" -ForegroundColor DarkGray
    
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "║         🎨 COLORES ADICIONALES INDEPENDIENTES                  ║" -ForegroundColor Yellow
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow
    
    # Grid de colores adicionales
    Write-Host "┌────────────┬────────────┬────────────┬────────────┐" -ForegroundColor DarkGray
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Cyan
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Magenta
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Magenta
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "████████" -NoNewline -ForegroundColor Cyan
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#01D6B9" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#FF4C70" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#EE6EA7" -NoNewline -ForegroundColor White
    Write-Host "   │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "#A5FFED" -NoNewline -ForegroundColor White
    Write-Host "   │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Turquesa " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Rosa     " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Rosa     " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Cyan     " -NoNewline -ForegroundColor Gray
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "│  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Brillante" -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Fuerte   " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Pastel   " -NoNewline -ForegroundColor Gray
    Write-Host "  │  " -NoNewline -ForegroundColor DarkGray
    Write-Host "Claro    " -NoNewline -ForegroundColor Gray
    Write-Host "  │" -ForegroundColor DarkGray
    
    Write-Host "└────────────┴────────────┴────────────┴────────────┘`n" -ForegroundColor DarkGray
}

# Acceso rápido a música de fondo
function bgm {
    $bgmPath = "$Drive\Música\IA Sounds\Instrumental 2"
    if (Test-Path $bgmPath) {
        Start-Process explorer.exe $bgmPath
        Write-Host "🎵 Biblioteca de música de fondo abierta" -ForegroundColor Cyan
    } else {
        Write-Host "❌ No se encontró la carpeta de música de fondo" -ForegroundColor Red
    }
}

# ===========================
# 🌐 WEB & REDES
# ===========================

function open-biglexj {
    Start-Process "https://biglexj.com"
    Write-Host "🌐 Abriendo biglexj.com..." -ForegroundColor Cyan
}

function open-youtube {
    Start-Process "https://studio.youtube.com"
    Write-Host "📺 Abriendo YouTube Studio..." -ForegroundColor Red
}

# ===========================
# ⚙️ SISTEMA Y MANTENIMIENTO
# ===========================

function system-info {
    fastfetch
}

function check-space {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "║              💾 ESPACIO EN DISCOS                              ║" -ForegroundColor Yellow
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow
    
    $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null -and $_.Name -match '^[C-Z]$' }
    
    foreach ($drive in $drives) {
        $name = $drive.Name
        $used = [math]::Round($drive.Used / 1GB, 2)
        $free = [math]::Round($drive.Free / 1GB, 2)
        $total = $used + $free
        $percentUsed = [math]::Round(($used / $total) * 100, 1)
        
        # Barra de progreso
        $barLength = 40
        $filledLength = [math]::Round(($percentUsed / 100) * $barLength)
        $bar = "█" * $filledLength + "░" * ($barLength - $filledLength)
        
        # Color según porcentaje
        $color = if ($percentUsed -gt 90) { "Red" } elseif ($percentUsed -gt 70) { "Yellow" } else { "Green" }
        
        Write-Host "Disco $name`:\" -ForegroundColor Cyan -NoNewline
        Write-Host " [$bar] " -ForegroundColor $color -NoNewline
        Write-Host "$percentUsed% usado" -ForegroundColor White
        Write-Host "  $used GB / $total GB ($free GB libres)`n" -ForegroundColor Gray
    }
}

function update-profile {
    . $PROFILE
    Write-Host "✅ Configuración de PowerShell recargada" -ForegroundColor Green
}

function edit-profile {
    antigravity $PROFILE
}

# ===========================
# 📚 Sistema de Ayuda Mejorado
# ===========================

# Función de ayuda detallada (con descripciones)
function Show-Help {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║               📚 AYUDA DE COMANDOS - BIGLEX J                  ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan
    
    Write-Host "🔗 NAVEGACIÓN RÁPIDA" -ForegroundColor Yellow
    Write-Host "  ..           → Subir un directorio" -ForegroundColor Gray
    Write-Host "  ...          → Subir dos directorios" -ForegroundColor Gray
    Write-Host "  bjpro        → Ir a D:\Proyectos" -ForegroundColor Gray
    Write-Host "  bjdav        → Ir a carpeta de DaVinci Resolve" -ForegroundColor Gray
    Write-Host "  bjyt         → Ir a carpeta de Miniaturas" -ForegroundColor Gray
    Write-Host "  bgm          → Abrir biblioteca de música de fondo" -ForegroundColor Gray
    Write-Host "  docs         → Abrir la biblioteas de documentación" -ForegroundColor Gray
    
    Write-Host "`n🛠️  DESARROLLO" -ForegroundColor Yellow
    Write-Host "  gs           → Mostrar estado del repositorio Git" -ForegroundColor Gray
    Write-Host "  ga [files]   → Agregar archivos al staging de Git" -ForegroundColor Gray
    Write-Host "  gc 'mensaje' → Hacer commit con mensaje" -ForegroundColor Gray
    Write-Host "  gp           → Subir cambios al repositorio remoto" -ForegroundColor Gray
    Write-Host "  gpl          → Descargar cambios del repositorio remoto" -ForegroundColor Gray
    Write-Host "  bj-sync      → Sincronizar repositorio (pull, add, commit, push)" -ForegroundColor Gray
    Write-Host "  dev          → Ejecutar modo desarrollo (bun run dev)" -ForegroundColor Gray
    Write-Host "  build        → Compilar proyecto (bun run build)" -ForegroundColor Gray

    Write-Host "`n📌  SCRIPTS" -ForegroundColor Yellow
    Write-Host "  clonar-est   → Clonar estructura (solo carpetas)" -ForegroundColor Gray
    Write-Host "  crear-sub    → CrearAssets/Proyecto en subcarpetas" -ForegroundColor Gray
    Write-Host "  renombrar-it → Renombrado masivo inteligente" -ForegroundColor Gray
    Write-Host "  sfx-gen      → Generar estructura para SFX" -ForegroundColor Gray
    Write-Host "  wav2flac     → Convertir archivos WAV a FLAC" -ForegroundColor Gray
    Write-Host "  undo-org     → Deshacer cambios de organización" -ForegroundColor Gray
    
    Write-Host "`n🎬 PRODUCCIÓN DE CONTENIDO" -ForegroundColor Yellow
    Write-Host "  new-project  → Crear estructura de carpetas para nuevo video" -ForegroundColor Gray
    Write-Host "               (Detecta canal, tipo y numeración automática)" -ForegroundColor DarkGray
    
    Write-Host "`n🤖 ELY INTELLIGENCE" -ForegroundColor Yellow
    Write-Host "  ely-intelligence → Iniciar servidor principal de Ely" -ForegroundColor Gray
    Write-Host "  live             → Iniciar sistema de Live Stream" -ForegroundColor Gray
    Write-Host "  vozely           → Iniciar motor de voz con IA (XTTS)" -ForegroundColor Gray
    Write-Host "  add-video        → Añadir video al sistema de publicación web" -ForegroundColor Gray
    Write-Host "  add-karaoke      → Añadir karaoke (detecta género automáticamente)" -ForegroundColor Gray
    
    Write-Host "`n🎨 UTILIDADES CREATIVAS" -ForegroundColor Yellow
    Write-Host "  color-palette → Mostrar paleta de colores oficial (Biglex J & Ely)" -ForegroundColor Gray
    
    Write-Host "`n🌐 WEB & REDES" -ForegroundColor Yellow
    Write-Host "  open-biglexj  → Abrir biglexj.com en navegador" -ForegroundColor Gray
    Write-Host "  open-youtube  → Abrir YouTube Studio" -ForegroundColor Gray
    
    Write-Host "`n⚙️  SISTEMA" -ForegroundColor Yellow
    Write-Host "  system-info   → Mostrar información del sistema (fastfetch)" -ForegroundColor Gray
    Write-Host "  check-space   → Ver espacio disponible en discos" -ForegroundColor Gray
    Write-Host "  update-profile→ Recargar configuración de PowerShell" -ForegroundColor Gray
    Write-Host "  edit-profile  → Editar configuración en Antigravity" -ForegroundColor Gray
    
    Write-Host "`n💡 Tip: Escribe 'aliases' para ver solo la lista de comandos`n" -ForegroundColor Cyan
}

# Función de aliases compacta (solo nombres)
function Show-Aliases {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                  🔗 ALIASES DISPONIBLES                        ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "📁 NAVEGACIÓN" -ForegroundColor Yellow
    Write-Host "  .., ..., bjpro, bjpros, bjdes, bjdoc, bjimg, bjmus, bjvid, aurora" -ForegroundColor Gray
    Write-Host "  bjass, bjdav, bjyt, bjmarca, bgm" -ForegroundColor Gray
    
    Write-Host "🛠️  DESARROLLO" -ForegroundColor Yellow
    Write-Host "  gs, ga, gc, gp, gpl, bj-sync, dev, build, start, install, clonar, renombrar" -ForegroundColor Gray
    
    Write-Host "`n🎬 PRODUCCIÓN" -ForegroundColor Yellow
    Write-Host "  new-project" -ForegroundColor Gray
    
    Write-Host "`n🤖 ELY INTELLIGENCE" -ForegroundColor Yellow
    Write-Host "  ely-intelligence, live, vozely, add-video, add-karaoke" -ForegroundColor Gray
    
    Write-Host "`n🎨 CREATIVIDAD" -ForegroundColor Yellow
    Write-Host "  color-palette" -ForegroundColor Gray
    
    Write-Host "`n🌐 WEB" -ForegroundColor Yellow
    Write-Host "  open-biglexj, open-youtube" -ForegroundColor Gray
    
    Write-Host "`n⚙️  SISTEMA" -ForegroundColor Yellow
    Write-Host "  system-info, check-space, update-profile, edit-profile" -ForegroundColor Gray                 
    
    Write-Host "`n💡 Tip: Escribe 'help' para ver descripciones detalladas`n" -ForegroundColor Cyan
}

# Alias para los comandos de ayuda
New-Alias -Name "help" -Value "Show-Help"
New-Alias -Name "aliases" -Value "Show-Aliases"

# ===========================
# 📁 SCRIPTS UTILITY
# ===========================

# --- Organización ---
function Clonar-Estructura { python "$Drive\Proyectos\biglexj\Scripts\organizacion\clonar_estructura.py" @args }
function Crear-Subcarpetas { python "$Drive\Proyectos\biglexj\Scripts\organizacion\crear_subcarpetas_estandar.py" @args }
function Undo-Org { python "$Drive\Proyectos\biglexj\Scripts\organizacion\undo_organization.py" @args }

# --- Gestión ---
function Renombrar-It { python "$Drive\Proyectos\biglexj\Scripts\gestion\renombrar_archivos_carpetas.py" @args }

# --- Multimedia ---
function SFX-Gen { powershell "$Drive\Proyectos\biglexj\Scripts\multimedia\estructura_sfx.ps1" @args }
function Wav2Flac { python "$Drive\Proyectos\biglexj\Scripts\multimedia\wav_a_flac.py" @args }

# --- Antiguos / Otros ---
function Setup-ScreamingArch { & "$Drive\Proyectos\biglexj\Scripts\Estructure\setup-screaming-architecture.ps1" }

# --- ALIASES ---
New-Alias -Name "clonar-est" -Value Clonar-Estructura
New-Alias -Name "crear-sub"  -Value Crear-Subcarpetas
New-Alias -Name "undo-org"   -Value Undo-Org
New-Alias -Name "renombrar-it" -Value Renombrar-It
New-Alias -Name "sfx-gen"    -Value SFX-Gen
New-Alias -Name "wav2flac"   -Value Wav2Flac
New-Alias -Name "screaming"  -Value Setup-ScreamingArch

# Compatibilidad con nombres antiguos
New-Alias -Name "clonar"     -Value Clonar-Estructura
New-Alias -Name "renombrar"  -Value Renombrar-It

# ===========================
# 🌟 Mensaje de bienvenida final
# ===========================
Write-Host "`n🎉 ¡Terminal de Biglex J cargado exitosamente!" -ForegroundColor Green
Write-Host "💡 Escribe 'help' para ver todos los comandos disponibles" -ForegroundColor Blue
Write-host "📌 Escribe 'aliases' para ver solo la lista de comandos" -ForegroundColor Cyan
Write-Host "🚀 ¡A programar y crear contenido épico!" -ForegroundColor Magenta

$ProfileEndTime = [DateTime]::Now
$ProfileDuration = ($ProfileEndTime - $ProfileStartTime).TotalMilliseconds
Write-Host ("`n🚀 Perfil cargado en {0:N0} ms" -f $ProfileDuration) -ForegroundColor Gray

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58