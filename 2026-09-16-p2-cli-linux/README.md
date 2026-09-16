# Tugas P2 Sistem Operasi: Perintah Dasar Linux Chapter 4 dan 5

Diberikan Rabu 16 September 2026 lewat Microsoft Teams, assignment
"[2B] P2 Perintah Dasar Linux - Chapter 4 & 5", praktikum Muhammad Riza Alifi, S.T., M.T.

## Instruksi

1. Pelajari chapter 4 dan 5.
2. Lanjutkan pengerjaan Exercise pada chapter 4 dan 5. Sertakan jawaban dan tangkapan layar
   hasil percobaan sendiri.
3. Sumber: https://learnbyexample.github.io/cli-computing/cover.html

| Ch | Judul | Jumlah soal |
|---|---|---|
| 4 | Shell Features | 27 |
| 5 | Viewing Part or Whole File Contents | 12 |

## Deliverables

1. Berkas PDF berisi identitas (NIM, Nama Lengkap, Kelas, Nama Mata Kuliah) dan jawaban.
2. Penamaan berkas: `Tugas_P2_2X_[3 Digit Terakhir NIM].pdf`, untuk Ghaisan jadi **`Tugas_P2_2B_048.pdf`**.

Deadline: H-1 perkuliahan, di Teams tertulis Selasa 22 September 2026 23.59, boleh submit berkali-kali.

## Hasil

[`Tugas_P2_2B_048.pdf`](Tugas_P2_2B_048.pdf), 28 halaman, sekitar 8 MB. Isinya:

- BAB I pendahuluan: lingkungan pengerjaan beserta versi alat, dan cara pengerjaan tiap soal.
- BAB II jawaban 27 soal chapter 4 (Shell Features).
- BAB III jawaban 12 soal chapter 5 (Viewing Part or Whole File Contents).
- BAB IV catatan hasil dan kesimpulan.

Tiap soal berisi ringkasan soal, perintah jawabannya, penjelasan singkat, dan tangkapan layar
terminal asli. Seluruh keluaran cocok dengan contoh keluaran di buku.

## Lingkungan

Sama seperti Tugas P1, semua perintah dijalankan di Ubuntu 24.04.5 LTS (GNU coreutils 9.4) yang
berjalan di OrbStack, bukan di macOS, karena buku memakai GNU coreutils sedangkan macOS memakai
userland BSD. Perbandingannya ada di `../2026-09-09-tugas-1-cli-linux/lingkungan.md`.

Tambahan untuk tugas ini: paket `man-db` dipasang karena image Ubuntu bawaan OrbStack tidak
menyertakan perintah `man`, padahal soal 5 dan 6 chapter 5 meminta pembacaan manual `less`.

Tiap soal chapter 4 dikerjakan di folder sendiri `~/tugas2-so/ch4-NN`, sedangkan soal chapter 5
dikerjakan di `~/cli-computing/example_files/text_files/`.
