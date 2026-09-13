# Sistem Operasi

Sarjana Terapan Teknik Informatika, Jurusan Teknik Komputer dan Informatika,
Politeknik Negeri Bandung. Semester Ganjil 2026/2027.

- Nama  : Ghaisan Khoirul Badruzaman
- NIM   : 251524048
- Kelas : 2B-D4

## Jadwal

| Jenis | Waktu | Ruang | Dosen |
|---|---|---|---|
| Teori | Senin 13.50 - 15.20 | D111 | Setiadi Rachmat, M.Eng. |
| Praktikum | Rabu 15.40 - 17.20 | D115 Lab. PjBL-1 | Muhammad Riza Alifi, S.T., M.T. |

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
| [Tugas 1: Perintah Dasar Linux](2026-09-09-tugas-1-cli-linux/) | Rabu 9 Sep 2026, praktikum | [`T1_2B_048.pdf`](2026-09-09-tugas-1-cli-linux/T1_2B_048.pdf), exercise chapter 3 nomor 1-30 dengan screenshot asli dari Ubuntu | Selesai, belum dikumpulkan. Deadline hari H praktikum, perkiraan Rabu 16 Sep 2026 |

## Progres

| Pertemuan | Tanggal | Catatan |
|---|---|---|
| Teori 1 | Senin 7 Sep 2026 | Pembagian dua buku referensi. Tugas: cetak Bab 1 untuk pertemuan berikutnya. Rangkuman Bab 1 kedua buku sudah dibuat. |
| Praktikum 1 | Rabu 9 Sep 2026 | Tugas 1 lewat Google Classroom: pelajari chapter 1-3 buku cli-computing, kerjakan exercise chapter 3. |

## Struktur folder

```
sistem-operasi/
├── README.md
├── rangkuman/                      catatan Bab 1 Tanenbaum dan Stallings
├── 2026-09-09-tugas-1-cli-linux/
│   ├── README.md                   instruksi, hasil, dan deadline
│   ├── lingkungan.md               kenapa dikerjakan di Linux, bukan macOS
│   └── T1_2B_048.pdf               berkas yang dikumpulkan
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
