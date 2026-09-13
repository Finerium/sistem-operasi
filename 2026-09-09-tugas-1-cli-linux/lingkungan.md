# Apakah perlu Linux, atau cukup macOS?

Jawabannya: **perlu Linux**. Bukan karena macOS tidak punya terminal, tapi karena
buku `learnbyexample/cli-computing` memakai **GNU coreutils**, sedangkan macOS
memakai userland **BSD**. Sebagian opsi tidak ada, dan yang lebih berbahaya,
ada opsi yang tetap jalan tapi artinya berbeda.

## Hasil uji di MacBook Pro M2 Pro ini

| Latihan | Opsi | Hasil di macOS |
|---|---|---|
| Ex 6 | `ls -v` | jalan, tapi di BSD artinya menampilkan karakter non-printable, bukan version sort |
| Ex 9 | `ls -G` | jalan, tapi di BSD artinya **mewarnai output**, di GNU artinya menyembunyikan kolom group. **Arti berlawanan** |
| Ex 23 | `cp -b` | tidak ada |
| Ex 23 | `cp -t` | tidak ada |
| Ex 27 | `mv -t` | tidak ada |
| Ex 28 | `rename` | tidak ada |
| Ex 20 | trash tool distro | pertanyaannya memang spesifik distro Linux |

Yang paling menjebak adalah **Ex 9**. Perintahnya jalan tanpa galat dan
keluarannya kelihatan masuk akal, jadi jawaban yang salah bisa lolos tanpa
terasa. Enam dari tiga puluh latihan terdampak langsung.

## Lingkungan yang akhirnya dipakai

Mesin Linux **OrbStack** bernama `ubuntu`, dibuat lewat aplikasi OrbStack dengan
distro Ubuntu 24.04. Versi 24.04 sengaja dipilih karena Ubuntu 25.10 sudah mengganti
coreutils ke versi Rust (uutils), sedangkan buku memakai GNU coreutils.

```
orb -m ubuntu
sudo apt install -y tree rename trash-cli
git clone --depth 1 https://github.com/learnbyexample/cli-computing.git
```

Paket `tree` dan `rename` dipakai di bab 3, sedangkan `trash-cli` untuk menjawab
latihan 20. Hasil versinya: Ubuntu 24.04.5 LTS, GNU coreutils 9.4, tree 2.1.1,
rename 2.02, trash-cli 0.23.11.10.

Docker sebenarnya juga terpasang, tapi tidak dipakai. Mesin OrbStack lebih ringan,
file di Mac langsung bisa diakses, dan tidak perlu membuat kontainer baru tiap sesi.

## Alternatif tanpa Linux, dan kenapa kurang bagus

Homebrew menyediakan GNU coreutils (`brew install coreutils findutils gnu-sed grep`),
tapi binarinya berawalan `g` (`gls`, `gcp`, `gsed`) kecuali PATH diatur ulang.
Tangkapan layar jadi memperlihatkan `gls` alih-alih `ls`, yang justru
memperlihatkan bahwa pengerjaannya bukan di Linux. Untuk tugas yang meminta
tangkapan layar, ini pilihan yang lebih buruk.
