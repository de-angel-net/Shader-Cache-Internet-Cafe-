# ============================================
# Merge Shader Cache di Server by De Angel Net
# ============================================

$SERVER = "\\192.168.0.1\Shadercache"
$LogFile = "$SERVER\robocopy_merge.log"

Write-Output "Menggabungkan semua shader dari PCxxx ke folder master Games..."

# Check semua folder PC di server, skip folder dummy
Get-ChildItem "$SERVER" -Directory | Where-Object { $_.Name -like "PC*" } | ForEach-Object {
    $PCFolder = $_.FullName

    # Check semua game di dalam folder PCxxx
    Get-ChildItem $PCFolder -Directory | ForEach-Object {
        $Game = $_.Name

        # Skip folder
        if ($Game -in @("Test","Asu")) {
            Write-Output "Skip $Game"
            return
        }

        $SourceAMD    = "$PCFolder\$Game\AMD"
        $SourceNVIDIA = "$PCFolder\$Game\NVIDIA"

        if (Test-Path $SourceAMD) {
            robocopy $SourceAMD "$SERVER\Games\$Game\AMD" /E /XO /R:2 /W:2 /LOG+:$LogFile
        }
        if (Test-Path $SourceNVIDIA) {
            robocopy $SourceNVIDIA "$SERVER\Games\$Game\NVIDIA" /E /XO /R:2 /W:2 /LOG+:$LogFile
        }

			
        # Jika sudah berhasil merge, hapus folder game di PCxxx
        if (Test-Path "$PCFolder\$Game") {
            Remove-Item "$PCFolder\$Game" -Recurse -Force
            Write-Output "Folder $PCFolder\$Game dihapus setelah merge."
        }
    }
}

Write-Output "Semua shader berhasil digabung ke folder master $SERVER\Games."