# ======================================================
# Script Shader Cache Sebelum Start Game by De Angel Net
# ======================================================

# Jalankan splash screen di background
$splash = Start-Process powershell.exe `
    -ArgumentList @(
        "-ExecutionPolicy", "Bypass",
        "-WindowStyle", "Hidden",
        "-File", "\\192.168.0.1\Shadercache\Splash.ps1",
        "-Message", "Menyalin shader..."
    ) -PassThru

# Daftar PC dan jenis GPU
$PCs = @{
    "PC01" = "NVIDIA"
    "PC02" = "AMD"
    "PC03" = "AMD"
    "PC04" = "AMD"
    "PC05" = "AMD"
    "PC06" = "AMD"
    "PC07" = "AMD"
    "PC08" = "AMD"
    "PC09" = "AMD"
    "PC10" = "AMD"
    "PC11" = "AMD"
    "PC12" = "AMD"
    "PC13" = "AMD"
    "PC14" = "AMD"
    "PC15" = "AMD"
    "PC16" = "AMD"
    "PC17" = "AMD"
    "PC18" = "AMD"
    "PC19" = "AMD"
    "PC20" = "AMD"
}

$SERVER   = "\\192.168.0.1\Shadercache\Games"
$Local    = "$env:LOCALAPPDATA"
$LogFile  = "\\192.168.0.1\Shadercache\$env:COMPUTERNAME\robocopy_${Game}_start_$env:COMPUTERNAME.log"
$Game     = "MarvelRivals"   # edit sesuai judul game

Write-Output "Membersihkan cache shader lokal..."

# Hapus isi folder cache sebelum sync
Remove-Item "$Local\AMD\DxCache\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$Local\AMD\DxcCache\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$Local\AMD\VkCache\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$Local\NVIDIA\DXCache\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$Local\NVIDIA\GLCache\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "Mengambil shader $Game dari server..."

if ($PCs[$env:COMPUTERNAME] -eq "AMD") {
    robocopy "$SERVER\$Game\AMD\DxCache" "$Local\AMD\DxCache" /E /XO /R:1 /W:1 /MT:16 /LOG+:$LogFile
    robocopy "$SERVER\$Game\AMD\DxcCache" "$Local\AMD\DxcCache" /E /XO /R:1 /W:1 /MT:16 /LOG+:$LogFile
	robocopy "$SERVER\$Game\AMD\VkCache" "$Local\AMD\VkCache" /E /XO /R:1 /W:1 /MT:16 /LOG+:$LogFile
} elseif ($PCs[$env:COMPUTERNAME] -eq "NVIDIA") {
    robocopy "$SERVER\$Game\NVIDIA\DXCache" "$Local\NVIDIA\DXCache" /E /XO /R:1 /W:1 /MT:16 /LOG+:$LogFile
    robocopy "$SERVER\$Game\NVIDIA\GLCache" "$Local\NVIDIA\GLCache" /E /XO /R:1 /W:1 /MT:16 /LOG+:$LogFile
}

# --- Tutup splash screen ---
Stop-Process -Id $splash.Id -Force

Write-Output "Shader $Game siap digunakan."