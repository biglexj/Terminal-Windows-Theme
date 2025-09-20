# ===========================
# 🚀 PowerShell $PROFILE - Biglex J Edition
# ===========================

Una configuración personalizada de PowerShell 7 diseñada para optimizar el flujo de trabajo de desarrollo y la experiencia en la terminal, con un toque visual único.

## ✨ Características Principales

- **Prompt Personalizado:** Integración con **Oh My Posh** y un tema `biglexj.omp.json` a medida.
- **Banner de Bienvenida:** Un saludo ASCII con información clave del sistema en una tabla estilizada.
- **Iconos en la Terminal:** `Terminal-Icons` para una mejor visualización de archivos y carpetas.
- **Autocompletado Avanzado:** `PSReadLine` con predicciones históricas y atajos mejorados.
- **Aliases de Navegación:** Atajos rápidos para acceder a directorios comunes y de proyectos.
- **Utilidades de Desarrollo:** Funciones para `git`, `pnpm` y `touch` con feedback visual.
- **Menú de Ayuda:** Un comando `help` para listar todos los aliases y funciones personalizadas.

## 📋 Requisitos

- **PowerShell 7+**
- **Windows 10/11** con **Windows Terminal**.
- **Oh My Posh:** `winget install JanDeDobbeleer.OhMyPosh`
- **Terminal-Icons:** `Install-Module -Name Terminal-Icons -Scope CurrentUser`
- **Chocolatey** (Opcional, para autocompletado).
- **Nerd Font:** Necesaria para renderizar los iconos correctamente (ej. Fira Code Nerd Font, Caskaydia Cove Nerd Font).

## 🚀 Instalación

1.  **Abre tu perfil de PowerShell:**
    ```powershell
    code $PROFILE
    # O si prefieres notepad:
    # notepad $PROFILE
    ```

2.  **Copia el contenido:**
    Pega el contenido del archivo `Microsoft.PowerShell_profile.ps1` en el archivo que se abrió.

3.  **Configura el tema de Oh My Posh:**
    Asegúrate de que la variable de entorno `$env:POSH_THEMES_PATH` apunte a la carpeta donde tienes tus temas `.json`. Luego, verifica que la línea de `oh-my-posh init` en tu perfil apunte al tema correcto:
    ```powershell
    # Ejemplo de cómo debería verse en tu $PROFILE
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\biglexj.omp.json" | Invoke-Expression
    ```

4.  **Recarga tu terminal:**
    Cierra y vuelve a abrir Windows Terminal, o ejecuta el siguiente comando en tu sesión actual:
    ```powershell
    . $PROFILE
    ```

## 🎯 Comandos y Aliases Disponibles

### 📁 Aliases de Navegación Rápida

| Alias | Ruta | Descripción |
|-------|------|-------------|
| `..` | `../` | Sube un nivel de directorio. |
| `...` | `../../` | Sube dos niveles de directorio. |
| `....` | `../../../` | Sube tres niveles de directorio. |
| `bjpro` | `E:\Proyectos\biglexj` | Proyectos de programación. |
| `bjdes` | `E:\Descargas` | Carpeta de descargas. |
| `bjdoc` | `E:\Documentos` | Carpeta de documentos. |
| `bjimg` | `E:\Imágenes` | Carpeta de imágenes. |
| `bjmus` | `E:\Música` | Carpeta de música. |
| `bjvid` | `E:\Vídeos` | Carpeta de vídeos. |
| `bjass` | `E:\Assets` | Assets generales. |
| `bjdav` | `E:\Vídeos\DaVinci Resolve` | Proyectos de DaVinci Resolve. |
| `bjyt` | `E:\Imágenes\YouTube` | Assets para YouTube. |
| `bjmarca`| `E:\Imágenes\Proyectos\Marca` | Assets de marca personal. |

### 🛠️ Utilidades de Desarrollo

| Comando | Acción | Feedback |
|---------|--------|----------|
| `touch <nombre>` | Crea un archivo si no existe, o actualiza su fecha de modificación. | ✅ / 🔄 |
| `gs` | `git status` | 📊 Estado del repositorio. |
| `ga [archivos]` | `git add [archivos]` (por defecto `.`) | ➕ Archivos agregados. |
| `gc "<mensaje>"` | `git commit -m "<mensaje>"` | 💾 Commit realizado. |
| `gp` | `git push` | 🚀 Cambios enviados al remoto. |
| `gpl` | `git pull` | ⬇️ Cambios descargados del remoto. |
| `dev` | `pnpm run dev` | Inicia el servidor de desarrollo. |
| `build` | `pnpm run build` | Compila el proyecto para producción. |
| `start` | `pnpm start` | Inicia el proyecto (usualmente en producción). |
| `install` | `pnpm install` | Instala las dependencias. |

### 💡 Ayuda

| Comando | Acción |
|---------|--------|
| `help` / `aliases` | Muestra la lista de comandos y alias personalizados. |

## 🎨 Personalización

### Cambiar el Tema de Oh My Posh

Simplemente comenta la línea actual y descomenta la que prefieras en tu `$PROFILE`:

```powershell
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\biglexj.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
```

### Modificar Rutas de Aliases

Edita las funciones directamente en el archivo `$PROFILE` para que coincidan con la estructura de tus directorios.

```powershell
# Ejemplo: Cambiar la ruta de proyectos
function bjpro { Set-Location "D:\MisProyectos\personales" }
```

## 🔧 Solución de Problemas

### Los iconos se ven como cuadrados (□)
- **Causa:** No tienes una Nerd Font instalada o configurada en Windows Terminal.
- **Solución:** Descarga una Nerd Font (como Fira Code o Caskaydia Cove), instálala y luego selecciónala en la configuración de Windows Terminal (`Settings` > `Defaults` > `Appearance` > `Font face`).

### `oh-my-posh` no se encuentra
- **Causa:** Oh My Posh no está instalado o no se encuentra en el PATH.
- **Solución:** Sigue las instrucciones de instalación oficiales en ohmyposh.dev.

### Error de directiva de ejecución
- **Causa:** La directiva de ejecución de PowerShell impide ejecutar scripts.
- **Solución:** Abre una terminal de PowerShell como **Administrador** y ejecuta:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

---

⚡ **Tip:** ¡Recuerda que puedes añadir tantos alias y funciones como necesites para hacer tu flujo de trabajo aún más épico!

