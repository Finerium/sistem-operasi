# Tugas P3.1 Sistem Operasi: Perintah Dasar Linux Chapter 6

Diberikan Rabu 23 September 2026 lewat Microsoft Teams, assignment
"[2B] P3.1 Perintah Dasar Linux - Chapter 6", praktikum Muhammad Riza Alifi, S.T., M.T.

## Instruksi

1. Pelajari chapter 6.
2. Lanjutkan pengerjaan Exercise pada chapter 6. Sertakan jawaban dan tangkapan layar hasil
   percobaan sendiri.
3. Sumber: https://learnbyexample.github.io/cli-computing/cover.html

Chapter 6 berjudul Searching Files and Filenames (`grep`, `find`, `locate`), isinya 31 soal.

## Deliverables

1. Berkas PDF berisi identitas (NIM, Nama Lengkap, Kelas, Nama Mata Kuliah) dan jawaban.
2. Penamaan berkas: `Tugas_P3.1_2X_[3 Digit Terakhir NIM].pdf`, untuk Ghaisan jadi **`Tugas_P3.1_2B_048.pdf`**.

Deadline: hari H perkuliahan, di Teams tertulis Rabu 23 September 2026 23.59, boleh submit berkali-kali.

## Hasil

[`Tugas_P3.1_2B_048.pdf`](Tugas_P3.1_2B_048.pdf), 24 halaman, sekitar 10,6 MB. Isinya:

- BAB I pendahuluan: lingkungan pengerjaan, cara pengerjaan, dan kenapa urutan hasil beberapa soal beda dengan buku.
- BAB II jawaban soal 1 sampai 17 (`grep`).
- BAB III jawaban soal 18 sampai 31 (`find` dan `locate`).
- BAB IV catatan hasil dan kesimpulan.

Isi keluaran 28 soal yang punya contoh keluaran sama dengan buku. Urutan barisnya beda di soal 16, 17,
18, 19, 21, 22, 24, 26, 28, dan 29 karena `find` dan `grep -r` mengikuti urutan entri direktori btrfs, dan
di soal 27 karena locale `C.UTF-8`. Soal 25, 30, dan 31 berupa pertanyaan, jawabannya disertai percobaan.

## Lingkungan

Sama seperti P1 dan P2: Ubuntu 24.04.5 LTS di OrbStack, GNU grep 3.11, GNU findutils 4.9.0.
Soal `grep` dikerjakan di `~/cli-computing/example_files/text_files/`, soal `grep -r` dan `find` di folder
`scripts` buku lewat `source grep.sh` dan `source find.sh`.

Untuk soal 31 dipasang paket `plocate` 1.1.19. Sebelum database pertamanya dibuat, `/etc/updatedb.conf`
ditambah `virtiofs` di PRUNEFS dan `/Users /mnt/machines /opt/orbstack-guest` di PRUNEPATHS supaya
`updatedb` tidak mengindeks disk macOS yang di-mount OrbStack.
