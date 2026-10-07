# Tugas P5: Shell Script User Management

Praktikum pertemuan 5 (Rabu 7 Oktober 2026), lewat Teams. Deadline Selasa 13 Oktober 2026 23.59.

## Instruksi

1. Buat 8 group dan folder group `/company/<group>`: marketing, developer, finance, design, hr, sales, ops, it.
2. Folder group hanya bisa diakses group-nya, folder shared bisa diakses semua group secara read-only.
3. Tulis shell script di vi untuk membuat user dari `users.txt` (format `user:group`, 38 baris): tiap user diberi home
   folder, user yang sudah ada diganti nama lewat input per baris, group dan folder group yang belum ada dibuat
   beserta permission-nya, setiap aksi menampilkan pesan, dan menghasilkan `users-created.txt` serta `actions.log`.

## Isi folder

```
Tugas_P5_2B_048.pdf   berkas yang dikumpulkan (23 halaman)
buat_user.sh          script yang diketik di vi
users.txt             daftar user dari soal
hasil/                users-created.txt (38 user) dan actions.log (105 pesan) hasil run di server
```

## Hasil

- 38 user dibuat. Dua nama bentrok diganti lewat input: aliya (developer) jadi `aliyaputri`, halim (ops) jadi
  `halimperdana`. Input `aliya putri` sempat ditolak karena berspasi.
- Group support dan qa tidak ada di 8 group awal, jadi dibuat otomatis oleh script lengkap dengan folder `2770`
  dan akses read-only ke shared.
- Folder group `root:<group>` mode `2770` (setgid), shared `root:root` mode `750` + ACL `r-x` per group dan
  default ACL.
- Semua screenshot asli dari server Ubuntu 26.04 bersih di OrbStack (`ciwaruga-srv`). `users.txt` dan
  `buat_user.sh` benar-benar diketik di vi, dan hasil ketikannya sudah dicek identik dengan berkas di folder ini.
