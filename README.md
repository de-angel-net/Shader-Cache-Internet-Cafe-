# Shader Cache Diskless System by De Angel Net
Shader Cache Internet Cafe Server &lt;> Client 

Sistem shader cache sharing untuk warnet / game center berbasis PowerShell dan shared folder Windows.

==============================
STRUKTUR SISTEM
==============================

SERVER:
- Merge_Shader.ps1
- clean_up.ps1

CLIENT:
- Start.ps1
- Selesai.ps1

Contoh Struktur:

\\192.168.0.1\Shadercache
│
├── Games
│   └── MarvelRivals
│       ├── AMD
│       └── NVIDIA
│
├── PC01
├── PC02
├── PC03
│
├── Merge_Shader.ps1
├── clean_up.ps1
└── Splash.ps1


==================================================
README PC SERVER
==================================================

==================================================
1. Merge_Shader.ps1
==================================================

FUNGSI:
- Mengambil shader hasil upload dari seluruh PC client
- Menggabungkan shader ke folder master
- Menghapus folder temporary client setelah merge selesai

CARA KERJA:
1. Scan folder PC client
2. Membaca folder game
3. Copy shader menggunakan robocopy
4. Merge ke folder master:
   \\SERVER\Shadercache\Games
5. Menghapus folder temporary client

FOLDER YANG DIABAIKAN:
- Test
- Asu

CONTOH:
Dari:
\\192.168.0.1\Shadercache\PC01\MarvelRivals\AMD

Menjadi:
\\192.168.0.1\Shadercache\Games\MarvelRivals\AMD

MENJALANKAN SCRIPT:
powershell -ExecutionPolicy Bypass -File Merge_Shader.ps1

REKOMENDASI:
- Jalankan via Task Scheduler
- Setiap 30 menit / 1 jam / malam hari

LOG:
robocopy_merge.log


==================================================
2. clean_up.ps1
==================================================

FUNGSI:
Membersihkan shader cache lama di server.

DEFAULT:
$days = 30

Artinya:
File lebih tua dari 30 hari akan dihapus.

CARA KERJA:
1. Scan folder shader
2. Cek LastWriteTime
3. Hapus file lama

MENJALANKAN SCRIPT:
powershell -ExecutionPolicy Bypass -File clean_up.ps1

REKOMENDASI:
- Jalankan 1x sehari
- Disarankan malam hari


==================================================
README PC CLIENT
==================================================

==================================================
1. Start.ps1
==================================================

FUNGSI:
Dijalankan sebelum game dibuka.

FUNGSI UTAMA:
1. Menampilkan splash loading (optional)
2. Menghapus shader lokal lama
3. Download shader dari server
4. Copy ke shader cache lokal

FOLDER AMD:
- AMD\DxCache
- AMD\DxcCache
- AMD\VkCache

FOLDER NVIDIA:
- NVIDIA\DXCache
- NVIDIA\GLCache

KONFIGURASI GAME:
$Game = "Judul_Game"

Untuk game lain:
$Game = "Valorant"

MENJALANKAN SCRIPT:
powershell -ExecutionPolicy Bypass -File Start.ps1

CATATAN:
Script akan menghapus cache lokal sebelum sync.


==================================================
2. Selesai.ps1
==================================================

FUNGSI:
Dijalankan setelah game ditutup.

FUNGSI UTAMA:
1. Upload shader baru dari client
2. Simpan ke folder PC masing-masing
3. Shader siap di-merge server

CONTOH:
\\192.168.0.1\Shadercache\PC01\MarvelRivals

KONFIGURASI GAME:
$Game = "Judul_Game"

MENJALANKAN SCRIPT:
powershell -ExecutionPolicy Bypass -File Selesai.ps1


==================================================
ALUR SISTEM
==================================================

SEBELUM MAIN:
Server -> Client
Shader master di-download ke PC.

SETELAH MAIN:
Client -> Server
Shader baru di-upload ke server.

SERVER MERGE:
Semua shader client digabung menjadi database shader bersama.


==================================================
KELEBIHAN SISTEM
==================================================

- Mengurangi shader stutter
- Shader bisa dipakai semua PC
- Mengurangi compile ulang
- Otomatis merge
- Support AMD dan NVIDIA
- Tidak perlu software tambahan


==================================================
REQUIREMENT
==================================================

SERVER:
- Windows 10/11 atau Windows Server
- Shared folder aktif
- PowerShell
- Robocopy

CLIENT:
- Windows 10/11
- Akses shared folder ke server
- GPU AMD atau NVIDIA


==================================================
REKOMENDASI
==================================================

- Gunakan LAN Gigabit
- Gunakan SSD/NVMe di server
- Tambahkan antivirus exclusion untuk folder Shadercache


==================================================
TROUBLESHOOTING
==================================================

Shader tidak terdownload:
- Cek shared folder
- Cek permission
- Cek nama game
- Cek path server

Robocopy gagal:
- Cek jaringan
- Cek permission
- Cek file sedang dipakai

Splash screen tidak muncul:
- Pastikan Splash.ps1 tersedia di server


==================================================
CREDITS
==================================================

Dibuat oleh:

De Angel Net
