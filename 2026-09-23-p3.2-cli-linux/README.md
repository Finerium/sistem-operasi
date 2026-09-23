# Tugas P3.2 Sistem Operasi: Perintah Dasar Linux Chapter 7

Diberikan Rabu 23 September 2026 lewat Microsoft Teams, assignment
"[2B] P3.2 Perintah Dasar Linux - Chapter 7", praktikum Muhammad Riza Alifi, S.T., M.T.
Diumumkan bersamaan dengan P3.1 (chapter 6).

## Instruksi

Formatnya sama dengan P3.1: pelajari chapter 7, kerjakan exercise-nya, sertakan jawaban dan tangkapan
layar hasil percobaan sendiri. Sumber: https://learnbyexample.github.io/cli-computing/cover.html

Chapter 7 berjudul File Properties (`wc`, `du`, `df`, `stat`, `touch`, `file`, `basename`, `dirname`,
`chmod`), isinya 21 soal.

## Deliverables

Berkas PDF berisi identitas dan jawaban, nama berkas mengikuti pola P3.1: **`Tugas_P3.2_2B_048.pdf`**.

Deadline di Teams: Senin 28 September 2026.

## Hasil

[`Tugas_P3.2_2B_048.pdf`](Tugas_P3.2_2B_048.pdf), 17 halaman, sekitar 5,9 MB. Isinya:

- BAB I pendahuluan: lingkungan dan pengaturan mesin, cara pengerjaan, dan perbedaan hasil dengan buku.
- BAB II jawaban 21 soal, masing-masing dengan perintah, penjelasan, dan tangkapan layar terminal asli.
- BAB III catatan hasil dan kesimpulan.

Soal 1, 3, 4, 6, 10, 16, dan 19 hasilnya sama persis dengan buku. Yang berbeda disebabkan lingkungan mesin:

| Soal | Penyebab |
|---|---|
| 7 | btrfs tidak menghitung blok untuk direktori, jadi ukuran folder lebih kecil 4 KiB per direktori |
| 12, 13 | zona waktu mesin WIB (+0700), buku +0530 |
| 14 | `file` 5.45 menulis `Unicode text, UTF-8 text`, buku `UTF-8 Unicode text` |
| 17, 18, 20, 21 | umask mesin 0022 (berkas baru 644, direktori baru 755), buku 0002. Hasil akhir 18, 20, 21 tetap sama |

## Lingkungan

Ubuntu 24.04.5 LTS di OrbStack, GNU coreutils 9.4. Paket `file` dipasang dulu karena image bawaan
OrbStack tidak menyertakannya. Soal yang membuat berkas baru dikerjakan di folder latihan kosong
`~/tugas3-so/ch7-NN`, soal `du.sh` dan `touch.sh` di folder `scripts` buku.
