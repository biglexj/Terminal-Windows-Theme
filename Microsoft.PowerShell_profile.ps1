# ===========================
# 🚀 PowerShell $PROFILE - Biglex J Edition v3.0
# ===========================
$ProfileStartTime = [DateTime]::Now

# --- Oh My Posh theme path ---
$env:POSH_THEMES_PATH = "D:\Assets\Themes\2. Windows\Terminal Windows\Themes"

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
# ?? Aurora - Comandos del Servidor
# ===========================

$AuroraServer  = "biglexj@192.168.1.251"
$AuroraScripts = "/var/www/aurora-blog/scripts/server"

# --- Windows (local) ---
function aurora-start   { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_services.ps1" }
function aurora-stop    { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\stop_services.ps1" }
function aurora-check   { bun "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\check-services.ts" }
function aurora-backend { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_backend_cs.ps1" }
function aurora-ely     { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_ely_intelligence.ps1" }
function aurora-live    { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_live.ps1" }
function aurora-voz     { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_voz_ely.ps1" }
function aurora-voice   { & "$Drive\Proyectos\biglexj\Aurora---Blog\scripts\server\start_ely_voice_pipeline.ps1" }

# --- Linux (remoto via SSH) ---
function aurora-check-linux {
    $ip = "192.168.1.251"
    $services = @(
        # Familia 4000 - Frontend
        @{ name = "Frontend (Astro)    "; port = 4321;  label = "4000 · Dev" },
        # Familia 5000 - Core API
        @{ name = "Aurora Core API C#  "; port = 5000;  label = "5000 · Core" },
        @{ name = "Live API C#         "; port = 5050;  label = "5000 · Core" },
        # Familia 6000 - Voz
        @{ name = "VozEly Python XTTS  "; port = 6000;  label = "6000 · Voz" },
        @{ name = "Voice Companion C#  "; port = 6080;  label = "6000 · Voz" },
        # Familia 7000 - AI
        @{ name = "Ely Intelligence    "; port = 7000;  label = "7000 · AI" },
        # Familia 8000 - Coolify/Traefik
        @{ name = "Coolify Dashboard   "; port = 8000;  label = "8000 · Infra" },
        @{ name = "Traefik Proxy      "; port = 8080;  label = "8000 · Infra" },
        # Familia 9000 - Storage
        @{ name = "MinIO S3 API        "; port = 9000;  label = "9000 · Storage" },
        @{ name = "MinIO Web Console   "; port = 9001;  label = "9000 · Storage" },
        # Infra DevOps
        @{ name = "Portainer           "; port = 9443;  label = "Infra" },
        @{ name = "Grafana             "; port = 3000;  label = "Infra" }
    )
    Write-Host ""
    Write-Host "[Linux] Monitoreo Aurora — $ip" -ForegroundColor Cyan
    Write-Host ("─" * 62) -ForegroundColor DarkGray
    foreach ($svc in $services) {
        $tcp = New-Object System.Net.Sockets.TcpClient
        $active = $false
        try { $tcp.Connect($ip, $svc.port); $active = $tcp.Connected } catch {} finally { $tcp.Close() }
        $label = "[$($svc.label)]".PadRight(18)
        if ($active) {
            Write-Host "  " -NoNewline
            Write-Host "●" -ForegroundColor Green -NoNewline
            Write-Host " $($svc.name)" -NoNewline
            Write-Host $label -ForegroundColor DarkGray -NoNewline
            Write-Host "[ACTIVO] " -ForegroundColor Green -NoNewline
            Write-Host "→ :$($svc.port)"
        } else {
            Write-Host "  " -NoNewline
            Write-Host "○" -ForegroundColor DarkGray -NoNewline
            Write-Host " $($svc.name)" -NoNewline
            Write-Host $label -ForegroundColor DarkGray -NoNewline
            Write-Host "[offline] → :$($svc.port)" -ForegroundColor DarkGray
        }
    }
    Write-Host ("─" * 62) -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  ⚠  Si Coolify corre en :8000 choca con VozEly — moverlo a :8443" -ForegroundColor Yellow
    Write-Host ""
}
function aurora-start-linux { ssh -t $AuroraServer "bash $AuroraScripts/aurora-start.sh $args" }
function aurora-stop-linux  { ssh -t $AuroraServer "bash $AuroraScripts/aurora-stop.sh $args" }
function aurora-pull-linux  { ssh -t $AuroraServer "bash $AuroraScripts/aurora-pull.sh $args" }
function aurora-ssh         { ssh -t $AuroraServer }

function aurora-deploy {
    param([string]$message = "")

    # Si no pasaron mensaje, pedir uno
    if (-not $message) {
        $message = Read-Host "`n📝 Commit message"
        if (-not $message) {
            Write-Host "❌ Commit message vacío. Operación cancelada." -ForegroundColor Red
            return
        }
    }

    $AuroraRoot = "$Drive\Proyectos\biglexj\Aurora---Blog"

    Write-Host ""
    Write-Host "🚀 Aurora Deploy" -ForegroundColor Cyan
    Write-Host ("─" * 45) -ForegroundColor DarkGray
    Write-Host "  📁 $AuroraRoot" -ForegroundColor DarkGray

    Push-Location $AuroraRoot

    try {
        # 1. Stage
        Write-Host "  [1/4] Staging todos los cambios..." -ForegroundColor Gray
        git add .

        # 2. Commit
        Write-Host "  [2/4] Commit: $message" -ForegroundColor Gray
        $commitResult = git commit -m $message 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ⚠  Nada que commitear o ya estaba commiteado." -ForegroundColor Yellow
        } else {
            Write-Host "  ✅ Commit creado" -ForegroundColor Green
        }

        # 3. Push
        Write-Host "  [3/4] Pushing a GitHub..." -ForegroundColor Gray
        git push
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ❌ Push fallido. Revisa la conexión o conflictos." -ForegroundColor Red
            return
        }
        Write-Host "  ✅ Push exitoso" -ForegroundColor Green

        # 4. Pull en servidor Linux
        Write-Host "  [4/4] Pull en servidor Linux ($AuroraServer)..." -ForegroundColor Gray
        ssh -t $AuroraServer "cd /var/www/aurora-blog && git pull"

        Write-Host ("─" * 45) -ForegroundColor DarkGray
        Write-Host "  ✅ Deploy completo`n" -ForegroundColor Green
    }
    finally {
        Pop-Location
    }
}

# --- Aliases de compatibilidad ---
Set-Alias -Name start-aurora     -Value aurora-start     -Option AllScope
Set-Alias -Name stop-aurora      -Value aurora-stop      -Option AllScope
Set-Alias -Name check-aurora     -Value aurora-check     -Option AllScope
Set-Alias -Name backend          -Value aurora-backend   -Option AllScope
Set-Alias -Name ely-intelligence -Value aurora-ely       -Option AllScope
Set-Alias -Name live             -Value aurora-live      -Option AllScope
Set-Alias -Name vozely           -Value aurora-voz       -Option AllScope
Set-Alias -Name voice-ely        -Value aurora-voice     -Option AllScope
Set-Alias -Name server           -Value aurora-ssh       -Option AllScope


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
    Write-Host "" -ForegroundColor Yellow
    Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null } | ForEach-Object {
        $total = [math]::Round($_.Used / 1GB + $_.Free / 1GB, 1)
        $used  = [math]::Round($_.Used / 1GB, 1)
        $pct   = if ($total -gt 0) { [math]::Round($used / $total * 100) } else { 0 }
        $bar   = "#" * [math]::Floor($pct / 5) + "-" * (20 - [math]::Floor($pct / 5))
        Write-Host "  $($_.Name):  [$bar] $used/$total GB ($pct%)"
    }
}

function update-profile {
    . $PROFILE
    Write-Host "✅ Configuración de PowerShell recargada" -ForegroundColor Green
}

function edit-profile {
    code $PROFILE
}

function ahk {
    code "D:\Windows\AutoHotKey\biglexj.ahk"
}

function ahk-reload {
    if (Test-Path "D:\Windows\AutoHotKey\biglexj.ahk") {
        Start-Process "D:\Windows\AutoHotKey\biglexj.ahk"
        Write-Host "🔄 Configuración de AutoHotkey recargada" -ForegroundColor Green
    } else {
        Write-Host "❌ No se encontró el archivo AHK" -ForegroundColor Red
    }
}

function ahk-status {
    $proc = Get-Process -Name "AutoHotkey*" -ErrorAction SilentlyContinue
    if ($proc) {
        Write-Host "✅ AutoHotkey está activo (PID: $($proc.Id))" -ForegroundColor Green
    } else {
        Write-Host "❌ AutoHotkey no está en ejecución" -ForegroundColor Red
    }
}

function ahk-alias {
    $ahkPath = "D:\Windows\AutoHotKey\biglexj.ahk"
    if (!(Test-Path $ahkPath)) { Write-Host "No se encontro el archivo AHK" -ForegroundColor Red; return }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "    ATAJOS AUTOHOTKEY - BIGLEX J" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    $lines = Get-Content $ahkPath
    $currentSection = ""

    foreach ($line in $lines) {
        $line = $line.Trim()

        if ($line -match '^;\s*={3,}$') { continue }
        if ($line -match '^;\s*(ATAJOS PARA APLICACIONES|ATAJOS DE CARPETAS|CONTROLES MULTIMEDIA|EXPANSION DE TEXTO|EXPANSION PARA STREAMING|POWER USER|CHAT Y STREAMING|UTILIDADES DE DESARROLLO|SOCIAL MEDIA|ATAJOS AURORA)') {
            $currentSection = $line -replace '^;\s*', ''
            Write-Host ""
            Write-Host ">> $currentSection" -ForegroundColor Yellow
            Write-Host ("--" * 30) -ForegroundColor DarkGray
        }

        if ($line -match '^([#!^<>+*]*[a-zA-Z0-9_]+)::(.+)') {
            $key  = $Matches[1]
            $rest = $Matches[2].Trim()
            $desc = ""
            if ($rest -match ';.*?-\s*(.+)$')  { $desc = $Matches[1].Trim() }
            elseif ($rest -match ';(.+)$')        { $desc = $Matches[1].Trim() }

            $mods = @()
            if ($key -match '\^') { $mods += "Ctrl" }
            if ($key -match '!')  { $mods += "Alt" }
            if ($key -match '\+') { $mods += "Shift" }
            if ($key -match '#')  { $mods += "Win" }
            $baseKey = if ($key -match '[a-zA-Z0-9_]+$') { $Matches[0].ToUpper() } else { [string]$key[-1] }
            $keyDisplay = if ($mods.Count -gt 0) { ($mods -join " + ") + " + " + $baseKey } else { $baseKey }

            if ($desc) {
                Write-Host ("  " + $keyDisplay.PadRight(26)) -ForegroundColor Cyan -NoNewline
                Write-Host "-> $desc" -ForegroundColor White
            }
        }

        if ($line -match '^::(\w+)::(.+)$') {
            $trigger     = $Matches[1]
            $replacement = $Matches[2]
            if ($replacement -match 'SendText\("(.+)"\)') { $replacement = $Matches[1] -replace "``n", " " }
            if ($replacement.Length -gt 45) { $replacement = $replacement.Substring(0, 42) + "..." }
            Write-Host ("  ::" + $trigger + "::").PadRight(22) -ForegroundColor White -NoNewline
            Write-Host "-> $replacement" -ForegroundColor DarkGray
        }
    }
    Write-Host ""
    Write-Host "  ahk = editar | ahk-reload = recargar" -ForegroundColor Cyan
    Write-Host ""
}

function ahk-shortcuts { ahk-alias }

# ===========================
# 📦 APLICACIONES INSTALADAS
# ===========================

function apps {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║              📦 APLICACIONES INSTALADAS (winget)               ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan
    winget list --source winget --disable-interactivity
}

function apps-search {
    param([string]$query)
    if ($query) {
        winget search $query --source winget
    } else {
        Write-Host "Uso: apps-search <nombre>" -ForegroundColor Yellow
    }
}

function apps-upgrade {
    Write-Host "🔄 Buscando actualizaciones disponibles..." -ForegroundColor Cyan
    winget upgrade --source winget
}

function install {
    param([string]$app)
    if ($app) {
        winget install $app
    } else {
        Write-Host "Uso: install <nombre-app>" -ForegroundColor Yellow
    }
}

# ===========================
# 🌐 PUERTOS Y SERVICIOS
# ===========================

function ports {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║              🌐 PUERTOS EN USO                                ║" -ForegroundColor Magenta
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Magenta
    netstat -ano | Select-String "LISTENING" | ForEach-Object {
        $line = $_ -split '\s+'
        $port = $line[1] -split ':' | Select-Object -Last 1
        $pid = $line[-1]
        $proc = Get-Process -Id $pid -ErrorAction SilentlyContinue | Select-Object -ExpandProperty ProcessName
        [PSCustomObject]@{
            Puerto = $port
            PID = $pid
            Proceso = $proc
        }
    } | Sort-Object { [int]$_.Puerto } | Format-Table -AutoSize
}

function services {
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║              ⚙️ SERVICIOS DEL SISTEMA                         ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object Name, DisplayName, Status | Sort-Object Name | Format-Table -AutoSize
}

function my-ip {
    Write-Host "`n🌐 Tu dirección IP pública:" -ForegroundColor Cyan
    (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing).Content
    Write-Host "`n🏠 IPs locales:" -ForegroundColor Yellow
    Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -ne "127.0.0.1"} | Select-Object InterfaceAlias, IPAddress | Format-Table -AutoSize
}

# ===========================
# 🛤️ VARIABLES DE ENTORNO / PATH
# ===========================

function path {
    # Abrir editor de variables de entorno del usuario
    rundll32.exe sysdm.cpl,EditEnvironmentVariables
    Write-Host "📂 Abriendo variables de entorno del usuario..." -ForegroundColor Cyan
}

function path-admin {
    # Abrir editor de variables de entorno del sistema (requiere admin)
    Start-Process "SystemPropertiesAdvanced.exe" -Verb RunAs
    Write-Host "🔐 Abriendo variables de entorno del sistema (Admin)..." -ForegroundColor Yellow
}

function path-show {
    # Mostrar PATH actual dividido por secciones
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║              🛤️ VARIABLES DE ENTORNO (PATH)                   ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "👤 PATH DEL USUARIO:" -ForegroundColor Yellow
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath) {
        $userPath -split ";" | Where-Object { $_ } | ForEach-Object {
            Write-Host "  • $_" -ForegroundColor Gray
        }
    }
    
    Write-Host "`n🔐 PATH DEL SISTEMA:" -ForegroundColor Yellow
    $sysPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($sysPath) {
        $sysPath -split ";" | Where-Object { $_ } | ForEach-Object {
            Write-Host "  • $_" -ForegroundColor DarkGray
        }
    }
}

function env-show {
    # Mostrar todas las variables de entorno
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║              🌐 VARIABLES DE ENTORNO                          ║" -ForegroundColor Magenta
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Magenta
    
    Write-Host "👤 VARIABLES DEL USUARIO:" -ForegroundColor Yellow
    [Environment]::GetEnvironmentVariables("User") | Format-Table -AutoSize
    
    Write-Host "`n🔐 VARIABLES DEL SISTEMA:" -ForegroundColor Yellow
    [Environment]::GetEnvironmentVariables("Machine") | Format-Table -AutoSize
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
    Write-Host "  bjpros       → Ir a D:\Proyectos\biglexj" -ForegroundColor Gray
    Write-Host "  bjdes        → Ir a D:\Descargas" -ForegroundColor Gray
    Write-Host "  bjdoc        → Ir a D:\Documentos" -ForegroundColor Gray
    Write-Host "  bjimg        → Ir a D:\Imágenes" -ForegroundColor Gray
    Write-Host "  bjmus        → Ir a D:\Música" -ForegroundColor Gray
    Write-Host "  bjvid        → Ir a D:\Vídeos" -ForegroundColor Gray
    Write-Host "  bjass        → Ir a D:\Assets" -ForegroundColor Gray
    Write-Host "  bjdav        → Ir a D:\Vídeos\DaVinci Resolve" -ForegroundColor Gray
    Write-Host "  bjyt         → Ir a D:\Imágenes\YouTube" -ForegroundColor Gray
    Write-Host "  bjmarca      → Ir a D:\Imágenes\Proyectos\Marca" -ForegroundColor Gray
    Write-Host "  docs         → Abrir la biblioteca de documentación" -ForegroundColor Gray
    Write-Host "  aurora       → Ir al proyecto Aurora Blog" -ForegroundColor Gray
    Write-Host "  bgm          → Abrir biblioteca de música de fondo" -ForegroundColor Gray
    
    Write-Host "`n🛠️  DESARROLLO" -ForegroundColor Yellow
    Write-Host "  gs           → Mostrar estado del repositorio Git" -ForegroundColor Gray
    Write-Host "  ga [files]   → Agregar archivos al staging de Git" -ForegroundColor Gray
    Write-Host "  gc 'mensaje' → Hacer commit con mensaje" -ForegroundColor Gray
    Write-Host "  gp           → Subir cambios al repositorio remoto" -ForegroundColor Gray
    Write-Host "  gpl          → Descargar cambios del repositorio remoto" -ForegroundColor Gray
    Write-Host "  bj-sync      → Sincronizar repositorio (pull, add, commit, push)" -ForegroundColor Gray
    Write-Host "  dev          → Ejecutar modo desarrollo (bun run dev)" -ForegroundColor Gray
    Write-Host "  build        → Compilar proyecto (bun run build)" -ForegroundColor Gray
    Write-Host "  start        → Iniciar proyecto (bun start)" -ForegroundColor Gray
    Write-Host "  install      → Instalar dependencias (bun install)" -ForegroundColor Gray

    Write-Host "`n📌  SCRIPTS" -ForegroundColor Yellow
    Write-Host "  clonar-est   → Clonar estructura (solo carpetas)" -ForegroundColor Gray
    Write-Host "  crear-sub    → Crear Assets/Proyecto en subcarpetas" -ForegroundColor Gray
    Write-Host "  renombrar-it → Renombrado masivo inteligente" -ForegroundColor Gray
    Write-Host "  sfx-gen      → Generar estructura para SFX" -ForegroundColor Gray
    Write-Host "  wav2flac     → Convertir archivos WAV a FLAC" -ForegroundColor Gray
    Write-Host "  undo-org     → Deshacer cambios de organización" -ForegroundColor Gray
    Write-Host "  screaming    → Setup Screaming Architecture" -ForegroundColor Gray
    Write-Host "  clonar       → Alias de clonar-est" -ForegroundColor Gray
    Write-Host "  renombrar    → Alias de renombrar-it" -ForegroundColor Gray
    
    Write-Host "`n🎬 PRODUCCIÓN DE CONTENIDO" -ForegroundColor Yellow
    Write-Host "  new-project  → Crear estructura de carpetas para nuevo video" -ForegroundColor Gray
    Write-Host "               (Detecta canal, tipo y numeración automática)" -ForegroundColor DarkGray
    
    Write-Host "`n🤖 ELY INTELLIGENCE" -ForegroundColor Yellow
    Write-Host "  start-aurora    → Iniciar servicios de Aurora" -ForegroundColor Gray
    Write-Host "  stop-aurora     → Detener servicios de Aurora" -ForegroundColor Gray
    Write-Host "  check-aurora    → Verificar estado de los servicios (puertos)" -ForegroundColor Gray
    Write-Host "  backend         → Iniciar backend C#" -ForegroundColor Gray
    Write-Host "  ely-intelligence → Iniciar servidor principal de Ely" -ForegroundColor Gray
    Write-Host "  live            → Iniciar sistema de Live Stream" -ForegroundColor Gray
    Write-Host "  vozely          → Iniciar motor de voz con IA (XTTS)" -ForegroundColor Gray
    Write-Host "  voice-ely       → Iniciar pipeline de voz Ely" -ForegroundColor Gray
    
    Write-Host "`n🎨 UTILIDADES CREATIVAS" -ForegroundColor Yellow
    Write-Host "  color-palette → Mostrar paleta de colores oficial (Biglex J & Ely)" -ForegroundColor Gray
    
    Write-Host "`n🌐 WEB & REDES" -ForegroundColor Yellow
    Write-Host "  open-biglexj  → Abrir biglexj.com en navegador" -ForegroundColor Gray
    Write-Host "  open-youtube  → Abrir YouTube Studio" -ForegroundColor Gray
    
    Write-Host "`n⚙️  SISTEMA" -ForegroundColor Yellow
    Write-Host "  system-info   → Mostrar información del sistema (fastfetch)" -ForegroundColor Gray
    Write-Host "  check-space   → Ver espacio disponible en discos" -ForegroundColor Gray
    Write-Host "  update-profile→ Recargar configuración de PowerShell" -ForegroundColor Gray
    Write-Host "  edit-profile  → Editar configuracion en Antigravity" -ForegroundColor Gray
    Write-Host "  server        → Conectar al servidor SSH" -ForegroundColor Gray
    Write-Host "  ports         → Ver puertos en uso" -ForegroundColor Gray
    Write-Host "  services      → Ver servicios del sistema activos" -ForegroundColor Gray
    Write-Host "  my-ip         → Mostrar IP pública y local" -ForegroundColor Gray
    
    Write-Host "`n🛤️  PATH & ENTORNO" -ForegroundColor Yellow
    Write-Host "📁 NAVEGACIÓN" -ForegroundColor Yellow
    Write-Host "  .., ..., bjpro, bjpros, bjdes, bjdoc, bjimg, bjmus, bjvid," -ForegroundColor Gray
    Write-Host "  bjass, bjdav, bjyt, bjmarca, docs, aurora, bgm" -ForegroundColor Gray
    
    Write-Host "🛠️  DESARROLLO" -ForegroundColor Yellow
    Write-Host "  gs, ga, gc, gp, gpl, bj-sync, dev, build, start, install" -ForegroundColor Gray
    
    Write-Host "`n📌 SCRIPTS" -ForegroundColor Yellow
    Write-Host "  clonar-est, crear-sub, renombrar-it, sfx-gen, wav2flac," -ForegroundColor Gray
    Write-Host "  undo-org, screaming, clonar, renombrar" -ForegroundColor Gray
    
    Write-Host "`n🎬 PRODUCCIÓN" -ForegroundColor Yellow
    Write-Host "  new-project" -ForegroundColor Gray
    
    Write-Host "`n🤖 ELY INTELLIGENCE" -ForegroundColor Yellow
    Write-Host "  start-aurora, stop-aurora, check-aurora, backend," -ForegroundColor Gray
    Write-Host "  ely-intelligence, live, vozely, voice-ely" -ForegroundColor Gray
    
    Write-Host "`n🎨 CREATIVIDAD" -ForegroundColor Yellow
    Write-Host "  color-palette" -ForegroundColor Gray
    
    Write-Host "`n🌐 WEB" -ForegroundColor Yellow
    Write-Host "  open-biglexj, open-youtube" -ForegroundColor Gray
    
    Write-Host "`n⚙️  SISTEMA" -ForegroundColor Yellow
    Write-Host "  system-info, check-space, update-profile, edit-profile, server," -ForegroundColor Gray
    Write-Host "  ports, services, my-ip" -ForegroundColor Gray
    
    Write-Host "`n🛤️  PATH & ENTORNO" -ForegroundColor Yellow
    Write-Host "  path, path-admin, path-show, env-show" -ForegroundColor Gray
    
    Write-Host "`n🔧 AUTOHOTKEY" -ForegroundColor Yellow
    Write-Host "  ahk, ahk-reload, ahk-status, ahk-alias, ahk-shortcuts" -ForegroundColor Gray
    
    Write-Host "`n📦 APLICACIONES" -ForegroundColor Yellow
    Write-Host "  apps, apps-search, apps-upgrade, install" -ForegroundColor Gray
    
    Write-Host "`n💡 Tip: Escribe 'help' para ver descripciones detalladas`n" -ForegroundColor Cyan
}

# Alias para los comandos de ayuda
Set-Alias -Name "help" -Value "Show-Help"
function Show-Aliases {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host "   COMANDOS CUSTOM - BIGLEX J PROFILE" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta

    Write-Host "`n>> NAVEGACION" -ForegroundColor Yellow
    Write-Host "  .., ..., bjpro, bjpros, bjdes, bjdoc, bjimg, bjmus, bjvid" -ForegroundColor Gray
    Write-Host "  bjass, bjdav, bjyt, bjmarca, docs, aurora" -ForegroundColor Gray

    Write-Host "`n>> GIT" -ForegroundColor Yellow
    Write-Host "  gs, ga, gc, gp, gpl, bj-sync" -ForegroundColor Gray
    Write-Host "  aurora-deploy 'msg'   -> add + commit + push + linux pull" -ForegroundColor Gray

    Write-Host "`n>> AURORA SERVER (Windows)" -ForegroundColor Yellow
    Write-Host "  aurora-start   aurora-stop    aurora-check" -ForegroundColor Gray
    Write-Host "  aurora-backend aurora-ely     aurora-live" -ForegroundColor Gray
    Write-Host "  aurora-voz     aurora-voice" -ForegroundColor Gray

    Write-Host "`n>> AURORA SERVER (Linux via SSH)" -ForegroundColor Yellow
    Write-Host "  aurora-check-linux   aurora-start-linux [svc]" -ForegroundColor Gray
    Write-Host "  aurora-stop-linux [svc]   aurora-pull-linux" -ForegroundColor Gray
    Write-Host "  aurora-ssh   (alias: server)" -ForegroundColor Gray

    Write-Host "`n>> DEV" -ForegroundColor Yellow
    Write-Host "  dev, build, start, install   (bun)" -ForegroundColor Gray
    Write-Host "  touch, ports, services, my-ip" -ForegroundColor Gray

    Write-Host "`n>> SISTEMA" -ForegroundColor Yellow
    Write-Host "  system-info, check-space, update-profile, edit-profile" -ForegroundColor Gray
    Write-Host "  apps, apps-search, apps-upgrade" -ForegroundColor Gray

    Write-Host "`n>> AUTOHOTKEY" -ForegroundColor Yellow
    Write-Host "  ahk, ahk-reload, ahk-status" -ForegroundColor Gray
    Write-Host "  ahk-alias / ahk-shortcuts  -> ver atajos AHK" -ForegroundColor Gray

    Write-Host "`n>> CREATIVIDAD" -ForegroundColor Yellow
    Write-Host "  color-palette, new-project" -ForegroundColor Gray

    Write-Host "`n  help      -> referencia detallada con descripciones" -ForegroundColor Cyan
    Write-Host "  ahk-alias -> atajos de teclado AutoHotkey" -ForegroundColor Cyan
    Write-Host ""
}
Set-Alias -Name "aliases" -Value "Show-Aliases"

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
Set-Alias -Name "clonar-est" -Value Clonar-Estructura
Set-Alias -Name "crear-sub"  -Value Crear-Subcarpetas
Set-Alias -Name "undo-org"   -Value Undo-Org
Set-Alias -Name "renombrar-it" -Value Renombrar-It
Set-Alias -Name "sfx-gen"    -Value SFX-Gen
Set-Alias -Name "wav2flac"   -Value Wav2Flac
Set-Alias -Name "screaming"  -Value Setup-ScreamingArch

# Compatibilidad con nombres antiguos
Set-Alias -Name "clonar"     -Value Clonar-Estructura
Set-Alias -Name "renombrar"  -Value Renombrar-It

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

# ===========================
# 🚀 [SERVERS] Conexión Servidor
# ===========================
function server {
    if ($args.Count -eq 0) {
        ssh -t biglexj@192.168.1.251
    } else {
        ssh -t biglexj@192.168.1.251 $args
    }
}


