# 🎯 Comandos y Aliases Disponibles

Esta es la lista completa de atajos de teclado, aliases y funciones personalizadas incluidas en el perfil de PowerShell.

---

## 📁 Aliases de Navegación Rápida

| Alias | Ruta | Descripción |
|-------|------|-------------|
| `..` | `../` | Sube un nivel de directorio. |
| `...` | `../../` | Sube dos niveles de directorio. |
| `....` | `../../../` | Sube tres niveles de directorio. |
| `bjpro` | `D:\Proyectos` | Carpeta principal de proyectos. |
| `bjpros` | `D:\Proyectos\biglexj` | Proyectos de Biglex J. |
| `bjdes` | `D:\Descargas` | Carpeta de descargas. |
| `bjdoc` | `D:\Documentos` | Carpeta de documentos. |
| `bjimg` | `D:\Imágenes` | Carpeta de imágenes. |
| `bjmus` | `D:\Música` | Carpeta de música. |
| `bjvid` | `D:\Vídeos` | Carpeta de vídeos. |
| `bjass` | `D:\Assets` | Assets generales. |
| `bjdav` | `D:\Vídeos\DaVinci Resolve` | Proyectos de DaVinci Resolve. |
| `bjyt` | `D:\Imágenes\YouTube` | Assets para YouTube. |
| `bjmarca`| `D:\Imágenes\Proyectos\Marca` | Assets de marca personal. |

---

## 🛠️ Utilidades de Desarrollo

| Comando | Acción | Feedback |
|---------|--------|----------|
| `touch <nombre>` | Crea un archivo si no existe, o actualiza su fecha de modificación. | ✅ / 🔄 |
| `gs` | `git status` | 📊 Estado del repositorio. |
| `ga [archivos]` | `git add [archivos]` (por defecto `.`) | ➕ Archivos agregados. |
| `gc "<mensaje>"` | `git commit -m "<mensaje>"` | 💾 Commit realizado. |
| `gp` | `git push` | 🚀 Cambios enviados al remoto. |
| `gpl` | `git pull` | ⬇️ Cambios descargados del remoto. |
| `bj-sync` | Sincroniza repositorio (`git pull`, `git add .`, `git commit`, `git push`) | ✅ Sincronización completa. |
| `dev` | `bun run dev` (o script equivalente en el proyecto) | Inicia el servidor de desarrollo. |
| `build` | `bun run build` | Compila el proyecto. |
| `start` | `bun start` | Inicia el proyecto en producción. |
| `install` | `bun install` | Instala las dependencias. |

---

## 🤖 Ely Intelligence & Live Stream

| Comando | Acción | Descripción |
|---------|--------|-------------|
| `aurora-start` | Inicia servicios de Aurora local | Ejecuta el script de inicio de servicios en Windows. |
| `aurora-stop` | Detiene servicios de Aurora local | Ejecuta el script de parada de servicios en Windows. |
| `aurora-check` | Verifica estado de los servicios (puertos) | Chequea el estado de puertos y servicios locales. |
| `aurora-backend` | Iniciar backend C# | Levanta la API del backend. |
| `aurora-ely` | Iniciar servidor de Ely Intelligence | Inicia el motor principal de IA. |
| `aurora-live` | Inicia sistema de Live Stream | Arranca el flujo de transmisión en vivo. |
| `aurora-voz` | Inicia motor de voz IA (XTTS) | Arranca el motor de Text-To-Speech local de Ely. |
| `aurora-voice` | Inicia pipeline de voz Ely | Ejecuta el procesamiento de audio. |
| `aurora-check-linux` | Monitoreo Aurora Linux | Corre el script `check-services.ts` en el servidor SSH remoto `192.168.1.251`. |
| `aurora-start-linux` | Iniciar servicios en Linux | Inicia los contenedores/servicios mediante SSH remoto. |
| `aurora-stop-linux` | Detener servicios en Linux | Detiene los contenedores/servicios mediante SSH remoto. |
| `aurora-ssh` / `server` | Conectar al servidor SSH | Conecta de manera interactiva a `biglexj@192.168.1.251`. |
| `aurora-deploy "[msg]"` | Deploy automático completo | Agrega, hace commit, empuja a GitHub, y corre `git pull` en el servidor Linux. |

---

## 🎨 Utilidades Creativas & Sistema

| Comando | Acción | Descripción |
|---------|--------|-------------|
| `color-palette` | Muestra paleta de colores oficial | Muestra los colores de marca de Biglex J y Ely VTuber. |
| `new-project` | Estructura para nuevo video | Generador automatizado de carpetas para nuevos videos y canales. |
| `system-info` | Información de hardware/SO | Ejecuta `fastfetch` para mostrar un resumen del sistema. |
| `check-space` | Espacio disponible en discos | Muestra barra de porcentaje y GB usados de tus unidades. |
| `update-profile` | Recargar perfil de PowerShell | Ejecuta `. $PROFILE` en la sesión activa. |
| `edit-profile` | Editar perfil en VS Code | Abre el archivo `$PROFILE` en el editor. |
| `ports` | Puertos en uso | Lista puertos TCP a la escucha con el nombre de proceso y PID. |
| `services` | Servicios activos | Lista los servicios activos del sistema ordenados por nombre. |
| `my-ip` | Direcciones IP | Muestra tu IP pública e IPs locales asociadas a las interfaces. |

---

## 🎨 Personalización

### Cambiar el Tema de Oh My Posh
En tu perfil de PowerShell, puedes comentar la línea del tema actual y descomentar la que quieras usar:
```powershell
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\biglexj.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
```

### Modificar Rutas de Aliases
Edita las funciones de navegación rápida en el archivo para que coincidan con la estructura de tus directorios locales. Por ejemplo, para cambiar la ruta de tus proyectos:
```powershell
function bjpro { Set-Location "D:\MisProyectos" }
```
