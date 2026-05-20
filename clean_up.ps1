# ============================
# Cleanup Shader Cache Lama
# ============================

$path = "I:\shadercache"
$days = 30

Write-Output "Menghapus file shader cache lebih dari $days hari..."

# Cari file yang lebih tua dari $days hari
$threshold = (Get-Date).AddDays(-$days)

Get-ChildItem -Path $path -Recurse -File |
    Where-Object { $_.LastWriteTime -lt $threshold } |
    ForEach-Object {
        try {
            Remove-Item $_.FullName -Force -Verbose
        }
        catch {
            Write-Warning "Gagal menghapus file: $($_.FullName)"
        }
    }

Write-Output "Cleanup selesai."