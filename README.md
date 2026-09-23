# Sistem Operasi

Sarjana Terapan Teknik Informatika, Jurusan Teknik Komputer dan Informatika,
Politeknik Negeri Bandung. Semester Ganjil 2026/2027.

- Nama  : Ghaisan Khoirul Badruzaman
- NIM   : 251524048
- Kelas : 2B-D4

## Jadwal

| Jenis | Waktu | Ruang | Dosen |
|---|---|---|---|
| Teori | Senin 13.00 - 14.40 | D111 | Setiadi Rachmat, M.Eng. |
| Praktikum | Rabu 15.40 - 17.20 | D115 Lab. PjBL-1 | Muhammad Riza Alifi, S.T., M.T. |

Jam teori Senin diubah dosen dari 13.50 menjadi 13.00 per 14 September 2026. Durasinya tetap 100 menit,
jadi selesai 14.40.

## Buku referensi

Dibagikan dosen pada pertemuan 1, keduanya ada di `materi/2026-09-07-pertemuan-1/`.

| Buku | Total | Bab 1 | Halaman Bab 1 |
|---|---|---|---|
| Tanenbaum, *Modern Operating Systems* 4th | 1137 hal | Introduction | PDF 32-115, 84 hal |
| Stallings, *Operating Systems: Internals and Design Principles* 6th | 841 hal | Computer System Overview | PDF 26-68, 43 hal |

Potongan Bab 1 kedua buku sudah diekstrak ke `materi/2026-09-07-pertemuan-1/cetak/`
supaya tinggal dicetak tanpa perlu memilih rentang halaman lagi.

## Rangkuman

Catatan Bab 1 kedua buku, ditulis ulang dengan kalimat sendiri sebagai bahan belajar.

| Rangkuman | Isi | Panjang |
|---|---|---|
| [Tanenbaum Bab 1: Introduction](rangkuman/tanenbaum-bab1-introduction.md) | Apa itu OS, sejarah lima generasi, tinjauan hardware, ragam OS, konsep dasar, system call, struktur OS | 8 bagian, 60 istilah |
| [Stallings Bab 1: Computer System Overview](rangkuman/stallings-bab1-computer-system-overview.md) | Elemen dasar, register prosesor, siklus instruksi, interrupt, hierarki memori, cache, teknik I/O | 5 bagian, 37 istilah |

## Tugas

| Tugas | Diberikan | Hasil | Status |
|---|---|---|---|
| [Tugas 1: Perintah Dasar Linux](2026-09-09-tugas-1-cli-linux/) | Rabu 9 Sep 2026, praktikum | [`Tugas_P1_2B_048.pdf`](2026-09-09-tugas-1-cli-linux/Tugas_P1_2B_048.pdf), exercise chapter 3 nomor 1-30 dengan screenshot asli dari Ubuntu | Selesai, dikumpulkan lewat Teams, deadline Rabu 16 Sep 2026 23.59 |
| [Tugas P2: Chapter 4 dan 5](2026-09-16-p2-cli-linux/) | Rabu 16 Sep 2026, lewat Teams | [`Tugas_P2_2B_048.pdf`](2026-09-16-p2-cli-linux/Tugas_P2_2B_048.pdf), 27 soal Shell Features dan 12 soal Viewing File Contents dengan screenshot asli | Selesai, belum dikumpulkan. Deadline Selasa 22 Sep 2026 23.59 |
| [Tugas P3.1: Chapter 6](2026-09-23-p3.1-cli-linux/) | Rabu 23 Sep 2026, lewat Teams | [`Tugas_P3.1_2B_048.pdf`](2026-09-23-p3.1-cli-linux/Tugas_P3.1_2B_048.pdf), 31 soal Searching Files and Filenames (`grep`, `find`, `locate`) dengan screenshot asli | Selesai, belum dikumpulkan. Deadline Rabu 23 Sep 2026 23.59 |

## Progres

| Pertemuan | Tanggal | Catatan |
|---|---|---|
| Teori 1 | Senin 7 Sep 2026 | Pembagian dua buku referensi. Tugas: cetak Bab 1 untuk pertemuan berikutnya. Rangkuman Bab 1 kedua buku sudah dibuat. |
| Praktikum 1 | Rabu 9 Sep 2026 | Tugas 1 lewat Google Classroom: pelajari chapter 1-3 buku cli-computing, kerjakan exercise chapter 3. |
| Teori 2 | Senin 14 Sep 2026 | Batal karena dosen tidak hadir, pengganti belum diumumkan. Cetakan Bab 1 dibawa ke pertemuan berikutnya. |
| Praktikum 2 | Rabu 16 Sep 2026 | Tugas P2 lewat Teams: pelajari chapter 4 dan 5 buku cli-computing, kerjakan exercise-nya. |
| Praktikum 3 | Rabu 23 Sep 2026 | Tugas P3.1 lewat Teams: pelajari chapter 6 buku cli-computing, kerjakan exercise-nya. Tugas P3.2 (chapter 7) juga sudah diumumkan, deadline Senin 28 Sep 2026. |

## Struktur folder

```
sistem-operasi/
├── README.md
├── rangkuman/                      catatan Bab 1 Tanenbaum dan Stallings
├── 2026-09-09-tugas-1-cli-linux/
│   ├── README.md                   instruksi, hasil, dan deadline
│   ├── lingkungan.md               kenapa dikerjakan di Linux, bukan macOS
│   └── Tugas_P1_2B_048.pdf        berkas yang dikumpulkan
├── 2026-09-16-p2-cli-linux/
│   ├── README.md
│   └── Tugas_P2_2B_048.pdf        berkas yang dikumpulkan
├── 2026-09-23-p3.1-cli-linux/
│   ├── README.md
│   └── Tugas_P3.1_2B_048.pdf      berkas yang dikumpulkan
└── materi/                         buku dari dosen, tidak ikut di-push
```

## Yang belum jelas

Dosen menyuruh mencetak Bab 1 tanpa menyebut buku yang mana. Dugaan sementara Tanenbaum,
karena Bab 1-nya memang bab pengantar sistem operasi, sedangkan Bab 1 Stallings berisi
penyegaran arsitektur komputer yang beririsan dengan mata kuliah Arsitektur dan Organisasi
Komputer. Perlu dipastikan ke dosen atau grup kelas.

Deadline Tugas 1 ditulis "hari H perkuliahan, menyesuaikan jadwal perkuliahan pengganti",
tanpa tanggal pasti. Perlu dicek lagi di Google Classroom.

## Catatan

Buku pada `materi/` berhak cipta penerbit, jadi folder itu masuk `.gitignore`.
Screenshot instruksi tugas dari Google Classroom juga tidak ikut di-push karena isinya
postingan dosen, teks instruksinya sudah ditulis ulang di README tugas.
