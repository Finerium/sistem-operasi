# Tugas 1 Sistem Operasi: Perintah Dasar Linux

Diberikan Rabu 9 September 2026 lewat Google Classroom, praktikum Muhammad Riza Alifi, S.T., M.T.

## Instruksi

1. Pelajari chapter 1, 2, dan 3.
2. Kerjakan Exercise pada chapter 3, nomor 1 sampai 30. Sertakan jawaban dan
   tangkapan layar hasil pengerjaan sendiri.
3. Sumber: https://learnbyexample.github.io/cli-computing/cover.html

Chapter yang dimaksud:

| Ch | Judul |
|---|---|
| 1 | Introduction and Setup |
| 2 | Command Line Overview |
| 3 | Managing Files and Directories |

## Deliverables

1. Berkas PDF berisi identitas (NIM, Nama Lengkap, Kelas, Nama Mata Kuliah) dan jawaban.
2. Penamaan berkas: `T1_2B_[3 Digit NIM Terakhir].pdf`, untuk Ghaisan jadi **`T1_2B_048.pdf`**

## Hasil

[`T1_2B_048.pdf`](T1_2B_048.pdf), 28 halaman, sekitar 7 MB. Isinya:

- BAB I lingkungan pengerjaan: versi Ubuntu, coreutils, dan paket tambahan yang dipakai.
- BAB II jawaban soal 1 sampai 30. Tiap soal berisi ringkasan soal, jawaban, penjelasan singkat,
  catatan kalau hasilnya beda dengan buku, dan screenshot terminal asli. Satu soal selalu
  utuh di satu halaman, jadi jawaban dan screenshot-nya tidak terpisah.

Semua perintah dijalankan langsung di mesin Linux, bukan disimulasikan. Tiap soal punya folder
percobaan sendiri `~/tugas1-so/soal-NN`, kecuali soal 3, 5, dan 11 yang memakai `ls_examples`
dari repo buku.

Enam soal hasilnya beda dengan buku (soal 4, 5, 14, 21, 23, 26). Bedanya bukan karena
jawabannya salah, tapi karena versi alat yang lebih baru, filesystem yang berbeda, atau baris
output yang memang tidak ditulis di solusi buku. Contohnya `tree` 2.1.1 yang ikut menghitung
direktori `.` dan `cp -n` di coreutils 9.4 yang sekarang mencetak peringatan. Rinciannya ada
di PDF pada bagian "Beda dengan buku".

## Deadline

Pada hari H perkuliahan, menyesuaikan jadwal perkuliahan pengganti.
Praktikum Sistem Operasi normalnya Rabu 15.40, jadi perkiraan Rabu 16 September 2026.
Perlu dikonfirmasi karena instruksinya menyebut jadwal pengganti.

## Catatan lingkungan

Buku ini memakai GNU coreutils. macOS memakai userland BSD, jadi beberapa
jawaban akan berbeda atau perintahnya tidak ada sama sekali. Karena itu tugas ini
dikerjakan di Ubuntu 24.04.5 LTS (GNU coreutils 9.4) yang jalan di OrbStack.
Perbandingan BSD dan GNU ada di `lingkungan.md`.
