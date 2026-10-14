# Tugas P6: Signal

Tugas praktikum Pertemuan 6 lewat Teams ("[2B] P6 Signal"), deadline Rabu 14 Oktober 2026 23.59, multiple submissions.

Instruksi dari dosen:

1. Buat program dalam bahasa C untuk menerima signal dan menghasilkan output di layar seperti gambar contoh.
2. Beri penjelasan singkat dalam bentuk komentar.

Yang dikumpulkan: source code C dan screenshot hasil eksekusi (maksimal 2).

## Isi folder

```
Tugas_P6_2B_048.c        source code dengan komentar
Tugas_P6_2B_048_1.png    ./signal berjalan, signal 1, 2, 1, 5 dikirim dari terminal kanan
Tugas_P6_2B_048_2.png    lanjutan: signal 3 dan 4, lalu kill -9 menghentikan program
```

## Cara kerja program

Program mendaftarkan satu handler untuk signal 1 sampai 5 (SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP) lewat
`sigaction`. Handler hanya menambah hitungan, lalu `main` mencetak `Caught signal N (NAMA). jumlah.` dan baris
`Working... 1:x 2:x 3:x 4:x 5:x` setiap detik. `sleep` terhenti saat ada signal, jadi pesan langsung muncul.
SIGINT ikut ditangkap sehingga Ctrl+C tidak menghentikan program, program dihentikan dengan `kill -9`.

Contoh dari dosen menulis `(SIGINT)` untuk semua nomor signal. Di program ini nama signal ditulis sesuai nomornya
(1 SIGHUP, 2 SIGINT, 3 SIGQUIT, 4 SIGILL, 5 SIGTRAP).

Dijalankan di Ubuntu 26.04 (mesin OrbStack `ciwaruga`), gcc 15.2, kompilasi `gcc -Wall` tanpa warning.
