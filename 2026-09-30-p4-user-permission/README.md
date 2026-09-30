# Tugas P4 Sistem Operasi: User Management and Permission

Diberikan Rabu 30 September 2026 lewat Microsoft Teams, assignment "[2B] P4 User Management and Permission",
praktikum Muhammad Riza Alifi, S.T., M.T. Deadline di Teams Selasa 6 Oktober 2026 23.59 (H-1 praktikum),
boleh submit berkali-kali.

## Soal

Studi kasus server dokumen PT. Digital Intelijensia Ciwaruga dengan tiga divisi (marketing, developer,
finance), dibagi lima bagian:

| Bagian | Isi | Pertanyaan |
|---|---|---|
| 1 | Membuat grup dan enam user | 1.1 perintah, 1.2 verifikasi keanggotaan |
| 2 | Folder `/company/{marketing,developer,finance,shared}` | 2.1 kepemilikan, 2.2 permission |
| 3 | `report_finance.txt`: finance rw, marketing r, developer tanpa akses | 3.1 ACL, 3.2 verifikasi |
| 4 | Folder developer mewariskan grup | 4.1 permission khusus, 4.2 pengujian |
| 5 | User andi akses penuh ke `projectX` tanpa mengubah grupnya | 5.1 ACL, 5.2 verifikasi |

Setiap jawaban wajib berisi command line, penjelasan, dan screenshot. Nama berkas `Tugas_P4_2X_[3 digit NIM].pdf`.

## Hasil

[`Tugas_P4_2B_048.pdf`](Tugas_P4_2B_048.pdf), 19 halaman, 12 screenshot terminal asli.

Ringkasan konfigurasi akhirnya:

| Path | Pemilik:grup | Mode | ACL tambahan |
|---|---|---|---|
| `/company` | root:root | 755 | - |
| `/company/marketing` | root:marketing | 770 | - |
| `/company/finance` | root:finance | 770 | `g:marketing:--x` |
| `/company/finance/report_finance.txt` | root:finance | 660 | `g:marketing:r--`, `g:developer:---` |
| `/company/developer` | root:developer | 2770 (setgid) | `u:andi:--x`, default `g::rwx` |
| `/company/developer/projectX` | root:developer | 2770 | `u:andi:rwx` + default |
| `/company/shared` | root:root | 750 | `r-x` untuk tiga grup + default |

Hal yang paling penting dari tugas ini: ACL pada file atau subfolder tidak berguna kalau folder induknya tidak
bisa dilewati, jadi marketing dan andi butuh hak `--x` di folder induk (bisa lewat, tidak bisa melihat isi).

## Lingkungan

Dikerjakan di mesin OrbStack baru bernama `ciwaruga` (Ubuntu 26.04.1 LTS, uutils coreutils 0.10.0, sudo-rs
0.2.13, acl 2.3.2), terpisah dari mesin `ubuntu` yang dipakai tugas sebelumnya. Semua perintah dicoba dulu di
mesin kedua `ciwaruga-uji`, baru diulang di `ciwaruga` sambil di-screenshot. Pengujian akses memakai
`sudo -u <user>`, jadi keenam user tidak perlu diberi password.
