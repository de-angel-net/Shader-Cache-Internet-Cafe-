# ========================================================
# Script Shader Cache Selesai Bermain Game by De Angel Net
# ========================================================

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

$SERVER   = "\\192.168.0.1\Shadercache"
$Local    = "$env:LOCALAPPDATA"
$PCName   = $env:COMPUTERNAME
$LogFile  = "\\192.168.0.1\Shadercache\$PCName\robocopy_${Game}_stop_$PCName.log"
$Game     = "MarvelRivals"   # edit sesuai judul game

Write-Output "Mengupload shader $Game ke server..."

if ($PCs[$PCName] -eq "AMD") {
    robocopy "$Local\AMD\DxCache" "$SERVER\$PCName\$Game\AMD\DxCache" /E /Z /XO /R:2 /W:2 /LOG+:$LogFile
	robocopy "$Local\AMD\DxcCache" "$SERVER\$PCName\$Game\AMD\DxcCache" /E /Z /XO /R:2 /W:2 /LOG+:$LogFile
	robocopy "$Local\AMD\VkCache" "$SERVER\$PCName\$Game\AMD\VkCache" /E /Z /XO /R:2 /W:2 /LOG+:$LogFile
} elseif ($PCs[$PCName] -eq "NVIDIA") {
    robocopy "$Local\NVIDIA\DXCache" "$SERVER\$PCName\$Game\NVIDIA\DXCache" /E /Z /XO /R:2 /W:2 /LOG+:$LogFile
	robocopy "$Local\NVIDIA\GLCache" "$SERVER\$PCName\$Game\NVIDIA\GLCache" /E /Z /XO /R:2 /W:2 /LOG+:$LogFile
}

Write-Output "Shader $Game selesai diupload ke folder $PCName."