# Rangkuman Bab 1: Computer System Overview

Sumber: William Stallings, *Operating Systems: Internals and Design Principles*, edisi 6, Bab 1 (halaman PDF 26 sampai 68).

Catatan kuliah Sistem Operasi, Ghaisan Khoirul Badruzaman (251524048, 2B-D4),
D4 Teknik Informatika, Politeknik Negeri Bandung. Pertemuan 1, 7 September 2026.

Rangkuman ini ditulis ulang dengan kalimat sendiri sebagai bahan belajar.
Bukunya sendiri tidak ikut disimpan di repo ini karena berhak cipta penerbit.

---

## Daftar Isi

1. [1.1 dan 1.2 Elemen Dasar Komputer dan Register Prosesor](#11-dan-12-elemen-dasar-komputer-dan-register-prosesor)
2. [1.3 Eksekusi Instruksi](#13-eksekusi-instruksi)
3. [1.4 Interrupt](#14-interrupt)
4. [1.5 dan 1.6 Hierarki Memori dan Cache Memory](#15-dan-16-hierarki-memori-dan-cache-memory)
5. [1.7 Teknik Komunikasi I/O](#17-teknik-komunikasi-io)

---


## 1.1 dan 1.2 Elemen Dasar Komputer dan Register Prosesor

### Empat Elemen Dasar Komputer (hal PDF 27)

Di level paling atas, komputer hanya terdiri dari prosesor, memori, dan komponen I/O yang saling dihubungkan supaya bisa menjalankan program. Stallings memecahnya jadi empat elemen struktural:

- **Processor** (prosesor): mengendalikan operasi komputer sekaligus mengerjakan pemrosesan data. Kalau prosesornya cuma satu, biasa disebut CPU (central processing unit).
- **Main memory** (memori utama): menyimpan data dan program. Sifatnya volatile, isinya hilang begitu komputer dimatikan, berbeda dengan memori disk yang isinya tetap ada. Disebut juga real memory atau primary memory.
- **I/O module** (modul I/O): memindahkan data antara komputer dan lingkungan luarnya, mulai dari secondary memory seperti disk, perangkat komunikasi, sampai terminal. Modul ini punya buffer internal untuk menahan data sementara sebelum dikirim.
- **System bus**: jalur komunikasi antara prosesor, memori utama, dan modul I/O.

Modul memori sendiri adalah sekumpulan lokasi dengan alamat bernomor urut. Tiap lokasi berisi pola bit yang bisa ditafsirkan sebagai instruksi atau sebagai data. Jadi yang membedakan instruksi dan data bukan bentuk penyimpanannya, melainkan cara prosesor memperlakukannya.

Untuk bertukar data dengan memori, prosesor memakai dua register internal: MAR yang menyimpan alamat untuk operasi baca atau tulis berikutnya, dan MBR yang menampung datanya. Pola yang sama dipakai untuk I/O lewat I/O AR dan I/O BR.

### Dua Kategori Register Prosesor (hal PDF 28)

Register adalah memori di dalam prosesor yang lebih cepat tapi jauh lebih kecil daripada memori utama. Fungsinya dibagi dua:

1. **User visible register** (register yang terlihat program), bisa dirujuk lewat machine language, jadi programmer assembly atau optimizing compiler bisa menekan jumlah akses ke memori utama. Bahasa C bahkan mengizinkan programmer menyarankan variabel mana yang sebaiknya ditaruh di register.
2. **Control and status register** (register kendali dan status), dipakai prosesor untuk mengatur operasinya sendiri dan dipakai rutin OS berprivilese untuk mengendalikan eksekusi program.

Pemisahan ini tidak kaku. Program counter, misalnya, di sebagian prosesor user visible, di banyak prosesor lain tidak (hal PDF 29).

### User Visible Register (hal PDF 29)

| Jenis | Isi dan fungsi |
|---|---|
| Data register | Dipakai bebas oleh programmer untuk operasi terhadap data. Sering ada batasan, misalnya register khusus operasi floating-point dan register lain untuk integer. |
| Address register | Menyimpan alamat memori data atau instruksi, atau sebagian alamat yang dipakai menghitung effective address (alamat efektif). |
| Index register | Menyimpan index yang dijumlahkan ke nilai base untuk mendapat effective address. |
| Segment pointer | Menyimpan base address sebuah segment. Bisa lebih dari satu, misalnya satu untuk kode OS dan satu untuk aplikasi yang sedang jalan. |
| Stack pointer | Menunjuk puncak stack, sehingga instruksi tanpa field alamat seperti push dan pop bisa dipakai. |
| Condition code register | Menampung flag hasil operasi, sering jadi bagian dari control register. |

Soal penyimpanan isi register saat procedure call, perilakunya beda-beda per prosesor. Ada prosesor yang otomatis menyimpan seluruh user visible register dan memulihkannya saat return sebagai bagian dari instruksi call dan return, sehingga tiap prosedur bisa memakai register itu sendiri-sendiri. Di prosesor lain, programmer yang harus menulis instruksi penyimpanan sebelum call. Jadi mekanisme save dan restore bisa ditangani hardware atau software (hal PDF 29-30).

### Control and Status Register (hal PDF 30)

Kebanyakan register kategori ini tidak terlihat oleh program biasa. Sebagian hanya bisa diakses oleh instruksi yang dijalankan dalam control mode atau kernel mode.

| Register | Singkatan | Fungsi |
|---|---|---|
| Program counter | PC | Alamat instruksi berikutnya yang akan di-fetch |
| Instruction register | IR | Instruksi yang paling baru di-fetch |
| Memory address register | MAR | Alamat memori untuk operasi baca atau tulis berikutnya |
| Memory buffer register | MBR | Data yang akan ditulis ke memori atau yang baru dibaca dari memori |
| I/O address register | I/O AR | Menunjuk perangkat I/O tertentu |
| I/O buffer register | I/O BR | Wadah pertukaran data antara modul I/O dan prosesor |
| Program status word | PSW | Kumpulan condition code plus informasi status lain, misalnya bit interrupt enable/disable dan bit kernel/user mode |

Condition code atau flag diset oleh hardware prosesor sebagai hasil sebuah operasi, misalnya hasil aritmatika yang positif, negatif, nol, atau overflow. Hasil operasinya tetap disimpan di register atau memori, sementara flag-nya jadi catatan tambahan yang bisa diuji instruksi conditional branch berikutnya. Bit ini umumnya bisa dibaca lewat referensi implisit tapi tidak bisa diubah lewat referensi eksplisit, karena memang diniatkan sebagai umpan balik hasil eksekusi.

Di luar itu masih ada beberapa register lain. Prosesor dengan banyak jenis interrupt bisa punya sekumpulan interrupt register, masing-masing menunjuk satu rutin penanganan interrupt. Stack pointer diperlukan kalau ada fungsi yang diimplementasikan dengan stack. Memory management hardware juga menuntut register khusus, begitu pula pengendalian operasi I/O.

Rancangan organisasi control register dipengaruhi banyak faktor, dan salah satu yang utama adalah dukungan terhadap OS. Kalau perancang prosesor paham OS apa yang akan berjalan di atasnya, organisasi register bisa disiapkan untuk mendukung fitur tertentu seperti memory protection dan perpindahan antar program user.

## 1.3 Eksekusi Instruksi

Program yang dijalankan prosesor pada dasarnya adalah kumpulan instruksi yang tersimpan di memori. Pemrosesannya hanya dua langkah yang diulang terus: prosesor membaca (fetch) satu instruksi dari memori, lalu menjalankannya (execute). Satu putaran fetch ditambah execute untuk satu instruksi disebut **instruction cycle** (siklus instruksi), dengan *fetch stage* dan *execute stage* sebagai dua tahapnya. Loop ini tidak berhenti sendiri. Eksekusi program baru berhenti kalau prosesor dimatikan, terjadi error yang tidak bisa dipulihkan, atau prosesor menemui instruksi halt. (hal PDF 31)

### Peran program counter dan instruction register

Di awal tiap siklus, **program counter** (PC, pencacah alamat instruksi) menyimpan alamat instruksi berikutnya yang akan diambil. Setelah tiap fetch, prosesor otomatis menaikkan nilai PC supaya instruksi berikutnya diambil secara berurutan, kecuali ada instruksi yang menyuruh sebaliknya. Buku memakai contoh mesin sederhana dengan instruksi selebar satu word 16 bit: kalau PC diisi 300, siklus berikutnya akan mengambil instruksi dari 301, 302, 303, dan seterusnya.

Instruksi yang sudah diambil dimuat ke **instruction register** (IR, register penampung instruksi yang sedang dieksekusi). Bit-bit di dalam IR inilah yang menentukan aksi apa yang harus dikerjakan prosesor. (hal PDF 31)

### Empat kategori aksi instruksi

| Kategori | Yang dilakukan |
|---|---|
| Processor-memory | Memindahkan data dari prosesor ke memori atau sebaliknya |
| Processor-I/O | Memindahkan data ke atau dari peranti luar lewat modul I/O |
| Data processing | Operasi aritmetika atau logika terhadap data |
| Control | Mengubah urutan eksekusi, misalnya instruksi di lokasi 149 menetapkan instruksi berikutnya diambil dari 182, sehingga PC diisi 182 dan fetch berikutnya bukan dari 150 |

Satu instruksi bisa menggabungkan beberapa kategori sekaligus. (hal PDF 31-32)

### Mesin hipotetis yang dipakai buku

Prosesor contohnya cuma punya satu register data, yaitu **accumulator** (AC, penyimpan sementara hasil operasi). Instruksi dan data sama-sama 16 bit, memori disusun sebagai deret word 16 bit. Format instruksinya: 4 bit untuk **opcode** (kode operasi), jadi tersedia 2^4 = 16 opcode yang cukup ditulis satu digit heksadesimal, dan 12 bit sisanya untuk alamat, jadi 2^12 = 4096 (4K) word bisa dialamati langsung dengan tiga digit heksadesimal. Opcode yang dipakai di contoh: 0001 load AC dari memori, 0010 store AC ke memori, 0101 tambahkan isi memori ke AC. (hal PDF 32)

### Jejak eksekusi program contoh

Programnya menjumlahkan isi alamat 940 dengan isi alamat 941, hasilnya disimpan kembali ke 941. Nilai awal: lokasi 940 berisi 0003 dan lokasi 941 berisi 0002. Butuh tiga instruksi, berarti tiga fetch dan tiga execute.

| Langkah | Kejadian | Nilai heksadesimal |
|---|---|---|
| 1 | Fetch: PC = 300, instruksi di 300 masuk ke IR, PC naik jadi 301 | IR = 1940 |
| 2 | Execute: digit hex pertama (1) berarti load AC dari memori, tiga digit sisanya alamat 940 | AC = 0003 |
| 3 | Fetch: instruksi di 301 masuk ke IR, PC naik jadi 302 | IR = 5941 |
| 4 | Execute: isi AC lama ditambah isi lokasi 941, hasil disimpan di AC (3 + 2 = 5) | AC = 0005 |
| 5 | Fetch: instruksi di 302 masuk ke IR, PC naik jadi 303 | IR = 2941 |
| 6 | Execute: isi AC disimpan ke lokasi 941 | lokasi 941 = 0005 |

Perpindahan data ke dan dari memori sebenarnya masih lewat perantara **memory address register** (MAR) dan **memory buffer register** (MBR), tapi buku sengaja tidak menggambarkan keduanya supaya diagramnya tetap sederhana. (hal PDF 33)

## 1.4 Interrupt

### Kenapa interrupt harus ada (hal PDF 34-35)

Hampir semua komputer punya mekanisme yang memungkinkan modul lain, misalnya modul I/O atau memori, menyela urutan eksekusi normal prosesor. Alasan utamanya soal kecepatan: prosesor jauh lebih cepat daripada perangkat I/O, jadi menunggu perangkat selesai adalah pemborosan besar.

Stallings memberi angka konkret. PC 1 GHz kira-kira sanggup menjalankan 10^9 instruksi per detik. Hard disk 7200 rpm butuh sekitar 4 ms untuk setengah putaran track, artinya sekitar 4 juta kali lebih lambat dari prosesornya. Tanpa interrupt, setelah mengirim satu perintah write, prosesor harus diam menunggu printer atau disk, kadang selama ribuan sampai jutaan siklus instruksi.

Program I/O sendiri terdiri dari tiga bagian: instruksi persiapan (menyalin data ke buffer khusus, menyiapkan parameter perintah perangkat), perintah I/O yang sebenarnya, dan instruksi penutup (misalnya menyetel flag sukses atau gagal). Tanpa interrupt, alur eksekusi tersangkut di bagian tengah, entah menunggu diam atau melakukan polling (pengecekan status berulang) ke perangkat sampai selesai.

### Empat kelas interrupt (hal PDF 34)

| Kelas | Pemicu | Contoh |
|---|---|---|
| Program | Kondisi yang muncul akibat eksekusi sebuah instruksi | Arithmetic overflow, pembagian dengan nol, instruksi mesin ilegal, akses di luar ruang memori yang diizinkan |
| Timer | Timer di dalam prosesor | Memberi OS kesempatan menjalankan fungsi tertentu secara berkala |
| I/O | I/O controller | Sinyal operasi selesai normal, atau sinyal berbagai kondisi error |
| Hardware failure | Kegagalan perangkat keras | Power failure, memory parity error |

### Interrupt dan siklus instruksi (hal PDF 36-38)

Dengan interrupt, prosesor tetap bisa mengeksekusi instruksi lain sementara operasi I/O berjalan. Rutin I/O yang dipanggil lewat system call WRITE cukup berisi kode persiapan dan perintah I/O, lalu kendali langsung balik ke program pengguna. Perangkat eksternal bekerja bersamaan dengan eksekusi instruksi program tadi. Begitu perangkat siap dilayani, modul I/O mengirim sinyal permintaan interrupt, prosesor menunda program yang sedang jalan, mencabang ke interrupt handler (rutin penanganan interrupt), lalu melanjutkan program semula.

Untuk mendukung ini, siklus instruksi ditambahi satu tahap, yaitu interrupt stage.

```
        START
          |
          v
   +--> [FETCH STAGE] ambil instruksi berikutnya
   |      |
   |      v
   |    [EXECUTE STAGE] eksekusi instruksi
   |      |
   |      v
   |    [INTERRUPT STAGE] cek ada sinyal interrupt?
   |      |
   |      +-- tidak ada, atau interrupts disabled ---+
   |      |                                          |
   |      +-- ada interrupt --> jalankan             |
   |                            interrupt handler ---+
   |                                                 |
   +-------------------------------------------------+
          |
          v
        HALT
```

Dua hal yang perlu diingat dari gambar ini. Pertama, interrupt bisa terjadi di titik mana pun dalam program utama, bukan hanya pada satu instruksi tertentu, sehingga kemunculannya tidak bisa diprediksi. Kedua, program pengguna tidak perlu kode khusus untuk mengantisipasi interrupt, karena prosesor dan OS yang bertanggung jawab menghentikan lalu melanjutkannya di titik yang sama.

Memang ada overhead karena handler harus menjalankan instruksi tambahan untuk mengenali jenis interrupt dan memutuskan tindakan. Tapi dibanding waktu yang terbuang kalau prosesor cuma menunggu I/O, overhead itu kecil. Untuk kasus I/O pendek, waktu operasi I/O sepenuhnya tertutup oleh eksekusi instruksi pengguna. Untuk I/O panjang, misalnya printer, program pengguna bisa saja sudah sampai ke WRITE kedua sebelum operasi pertama selesai sehingga tetap tersendat, tapi tetap ada keuntungan karena sebagian waktu I/O tumpang tindih dengan eksekusi instruksi.

### Langkah pemrosesan interrupt (hal PDF 39-41)

Satu interrupt memicu rangkaian kejadian di sisi hardware maupun software.

| No | Sisi | Yang terjadi |
|---|---|---|
| 1 | Hardware | Perangkat mengirim sinyal interrupt ke prosesor |
| 2 | Hardware | Prosesor menyelesaikan dulu instruksi yang sedang dieksekusi |
| 3 | Hardware | Prosesor menguji adanya permintaan interrupt, lalu mengirim sinyal acknowledgment supaya perangkat bisa menurunkan sinyalnya |
| 4 | Hardware | Prosesor mendorong PSW (program status word) dan PC (program counter) ke control stack |
| 5 | Hardware | Prosesor memuat PC dengan alamat awal rutin penanganan interrupt yang sesuai |
| 6 | Software | Handler menyimpan isi seluruh register ke stack, karena register itu akan dipakai handler sendiri |
| 7 | Software | Handler memproses interrupt: memeriksa status operasi I/O, mengirim perintah atau acknowledgment tambahan ke perangkat |
| 8 | Software | Nilai register diambil kembali dari stack dan dipulihkan |
| 9 | Software | PSW dan PC lama dipulihkan dari stack, eksekusi kembali ke program yang tadi disela |

Informasi minimum yang wajib disimpan adalah PSW dan PC, karena tanpa keduanya prosesor tidak tahu harus melanjutkan dari mana dan dengan status apa. Pada contoh Figure 1.11, program pengguna disela setelah instruksi di lokasi N. Isi semua register plus alamat instruksi berikutnya (N + 1), totalnya M word, didorong ke control stack, stack pointer bergeser dari T ke T - M, dan PC diarahkan ke awal interrupt service routine (ISR). Saat return, stack pointer kembali ke T dan PC berisi N + 1.

Alasan semua state harus disimpan: interrupt bukan pemanggilan rutin biasa oleh program. Ia bisa datang kapan saja dan di titik mana saja, jadi tidak ada asumsi register mana yang aman untuk dirusak.

### Interrupt ganda (hal PDF 41-44)

Masalah muncul kalau interrupt baru datang saat interrupt lain sedang diproses. Contohnya program yang menerima data dari jalur komunikasi sambil mencetak hasil. Printer memicu interrupt tiap selesai satu operasi cetak, sementara controller jalur komunikasi memicu interrupt tiap satu unit data tiba. Ada dua pendekatan.

| | Disabled interrupt (sequential) | Nested interrupt (prioritas) |
|---|---|---|
| Cara kerja | Interrupt dimatikan begitu handler mulai. Permintaan baru diabaikan dan tetap pending sampai interrupt diaktifkan lagi | Tiap interrupt diberi prioritas. Interrupt berprioritas lebih tinggi boleh menyela handler yang berprioritas lebih rendah |
| Urutan penanganan | Ketat berurutan, satu selesai baru berikutnya | Bertumpuk, handler bisa disela handler lain |
| Kelebihan | Sederhana | Menghormati kebutuhan time-critical |
| Kekurangan | Mengabaikan prioritas relatif. Data bisa hilang kalau buffer perangkat penuh sebelum sempat dilayani | Lebih rumit, stack bisa bertumpuk beberapa level |

Contoh urutan waktu dengan tiga perangkat, yaitu printer (prioritas 2), disk (4), dan jalur komunikasi (5), diadaptasi Stallings dari [TANE06].

| Waktu | Kejadian | Yang berjalan setelahnya |
|---|---|---|
| t = 0 | Program pengguna mulai | Program pengguna |
| t = 10 | Interrupt printer | ISR printer |
| t = 15 | Interrupt komunikasi, prioritas lebih tinggi, ISR printer disela | ISR komunikasi |
| t = 20 | Interrupt disk, prioritas lebih rendah dari komunikasi, ditahan dulu | ISR komunikasi |
| t = 25 | ISR komunikasi selesai, state ISR printer dipulihkan, tapi interrupt disk yang prioritasnya lebih tinggi langsung dilayani | ISR disk |
| t = 35 | ISR disk selesai | ISR printer dilanjutkan |
| t = 40 | ISR printer selesai | Kembali ke program pengguna |

Catat detail di t = 25: ISR printer belum sempat menjalankan satu instruksi pun sebelum disela lagi oleh disk. Urutan penanganan mengikuti prioritas, bukan urutan kedatangan.

### Menuju multiprogramming (hal PDF 44-45)

Interrupt saja belum menjamin prosesor terpakai efisien. Kalau waktu operasi I/O jauh lebih besar daripada kode pengguna di antara pemanggilan I/O, prosesor tetap banyak menganggur. Solusinya adalah membiarkan beberapa program pengguna aktif bersamaan, sehingga saat satu program menunggu I/O, prosesor pindah ke program lain. Setelah sebuah handler selesai, kendali belum tentu balik ke program yang tadi disela, bisa saja pindah ke program pending lain yang prioritasnya lebih tinggi. Konsep giliran eksekusi banyak program inilah yang disebut multiprogramming, dibahas lebih jauh di Bab 2.

## 1.5 dan 1.6 Hierarki Memori dan Cache Memory

### Tiga pertanyaan desain memori (hal PDF 45)

Desain sistem memori bertumpu pada tiga pertanyaan: berapa besar kapasitasnya, seberapa cepat, dan berapa mahal. Kapasitas nyaris tidak punya jawaban pasti, sebab begitu ruangnya tersedia akan ada aplikasi baru yang memakainya. Kecepatan punya patokan lebih jelas, yaitu memori harus sanggup mengimbangi processor supaya processor tidak berhenti menunggu instruksi atau operand. Ketiganya saling tarik, dan Stallings meringkasnya jadi tiga relasi:

- Waktu akses makin cepat, biaya per bit makin mahal.
- Kapasitas makin besar, biaya per bit makin murah.
- Kapasitas makin besar, kecepatan aksesnya makin lambat.

Perancang terjepit: ia butuh kapasitas besar berbiaya per bit rendah, tapi performa memaksanya memakai memori cepat yang mahal dan kecil. Jalan keluarnya bukan memilih satu teknologi, melainkan menyusun beberapa teknologi sekaligus menjadi memory hierarchy (hierarki memori).

### Piramida hierarki memori (hal PDF 45-48)

Makin turun hierarki, empat hal terjadi bersamaan: biaya per bit turun, kapasitas naik, waktu akses naik, dan frekuensi akses processor ke level tersebut turun. Poin terakhir itu kunci keberhasilan skema ini, bukan sekadar efek samping. Memori kecil, cepat, dan mahal ditopang memori besar, lambat, dan murah.

| Kelompok | Isi level (Figure 1.14) | Sifat |
|---|---|---|
| Inboard memory | Register, cache, main memory | Semikonduktor, volatile, paling cepat, kapasitas kecil, mahal per bit |
| Outboard storage | Magnetic disk, CD-ROM, CD-RW, DVD-RW, DVD-RAM | Nonvolatile, kapasitas besar, akses lambat, murah per bit |
| Off-line storage | Magnetic tape | Nonvolatile, kapasitas terbesar, akses paling lambat, paling murah |

Register adalah memori tercepat sekaligus termahal, jumlahnya biasanya beberapa lusin per processor meski ada yang sampai ratusan. Main memory adalah memori internal utama, tiap lokasinya beralamat unik dan jadi rujukan kebanyakan machine instruction. Cache duduk di antaranya sebagai penyangga cepat yang umumnya tidak terlihat oleh programmer maupun processor. Memori eksternal (secondary memory atau auxiliary memory) terlihat oleh programmer sebagai file dan record, bukan byte satuan, dan hard disk juga dipakai memperluas main memory lewat virtual memory (Bab 8).

Level tambahan bisa dibuat di software, misalnya sebagian main memory dijadikan disk cache. Untungnya dua: tulisan ke disk jadi terkumpul sehingga transfer besar menggantikan banyak transfer kecil, dan data yang belum sempat ditulis ke disk masih bisa dibaca cepat dari cache software itu.

### Locality of reference dan hit ratio (hal PDF 46-47)

Alasan frekuensi akses ke level bawah bisa rendah adalah prinsip locality of reference (kelokalan rujukan) [DENN68]. Selama program berjalan, rujukan memori untuk instruksi maupun data cenderung mengelompok: begitu satu loop atau subroutine dimasuki, sekumpulan kecil instruksi yang sama dirujuk berulang, dan operasi tabel serta array menyentuh data yang berdekatan. Dalam jangka panjang klaster ini berpindah, tapi dalam jangka pendek processor bekerja di klaster yang tetap.

Contoh dua levelnya: level 1 berisi 1000 byte dengan waktu akses 0,1 mikrodetik, level 2 berisi 100.000 byte dengan waktu akses 1 mikrodetik. Kalau data ada di level 1 processor mengaksesnya langsung (hit), kalau tidak (miss) blok dipindah dulu ke level 1. Dengan hit ratio H = 0,95:

`(0,95)(0,1) + (0,05)(0,1 + 1) = 0,095 + 0,055 = 0,15 mikrodetik`

Rata-ratanya jauh lebih dekat ke 0,1 daripada ke 1. Jadi hierarki memberi kecepatan mendekati memori tercepat dengan kapasitas dan harga memori termurah, asal locality-nya terpenuhi.

### Cache memory: motivasi (hal PDF 48-49)

Setiap instruction cycle processor mengakses memori minimal sekali untuk mengambil instruksi, sering ditambah akses lain untuk operand atau menyimpan hasil. Laju eksekusi jadi dibatasi memory cycle time, yaitu waktu membaca atau menulis satu word, sementara kecepatan processor naik lebih cepat daripada kecepatan akses memori sehingga jaraknya melebar terus. Membangun main memory dengan teknologi register terlalu mahal, jadi solusinya memasang memori kecil dan cepat di antara processor dan main memory.

Cache menyimpan salinan sebagian isi main memory. Saat processor membaca satu byte atau word, dicek dulu apakah ada di cache. Kalau ada langsung dikirim, kalau tidak satu blok main memory berukuran tetap dibaca ke cache dulu. Karena locality, byte lain di blok yang sama besar kemungkinannya dirujuk sebentar lagi.

### Struktur baris cache dan tag (hal PDF 49-50)

Main memory dianggap terdiri atas 2^n word beralamat n bit, dikelompokkan jadi blok berisi K word, sehingga ada M = 2^n/K blok. Cache punya C slot (disebut juga line atau baris) yang masing-masing menampung K word, dengan C jauh lebih kecil daripada M. Karena blok lebih banyak daripada slot, satu slot tidak bisa dipatok permanen untuk satu blok tertentu. Karena itu tiap slot menyimpan tag, biasanya sejumlah bit tertinggi alamat, yang menandai blok mana yang sedang ditampung. Contoh di buku: alamat 6 bit dengan tag 2 bit, tag `01` mewakili semua alamat dari `010000` sampai `011111`.

### Lima elemen desain cache (hal PDF 50-52)

Buku hanya meringkas, karena rincian desain cache di luar cakupannya. Lima elemennya: cache size, block size, mapping function, replacement algorithm, dan write policy.

**Block size.** Blok adalah unit pertukaran data antara cache dan main memory. Saat ukuran blok dinaikkan dari sangat kecil, hit ratio naik karena data di sekitar word yang dirujuk ikut terbawa. Naik terus, hit ratio justru turun, sebab peluang memakai data baru itu kalah dibanding peluang memakai lagi data yang terpaksa digusur.

**Mapping function.** Fungsi ini menentukan slot mana yang ditempati blok yang baru masuk. Ada dua tekanan berlawanan: makin fleksibel pemetaannya, makin leluasa merancang replacement algorithm untuk memaksimalkan hit ratio, tapi makin rumit pula rangkaian pencarian untuk mengecek apakah suatu blok ada di cache. Buku edisi 6 berhenti di level ini dan tidak menyebut nama ketiga skemanya, jadi tabel berikut tambahan dari materi arsitektur komputer:

| Skema | Aturan penempatan | Fleksibilitas | Biaya pencarian |
|---|---|---|---|
| Direct | Satu blok hanya boleh masuk ke satu slot tertentu | Paling kaku, rawan bentrok | Paling murah, cukup satu perbandingan tag |
| Fully associative | Blok boleh masuk slot mana saja | Paling bebas | Paling mahal, semua tag dibandingkan paralel |
| Set associative | Cache dibagi jadi set, blok terpetakan ke satu set lalu bebas di dalam set | Kompromi | Sedang, bandingkan tag sebanyak isi satu set |

**Replacement algorithm.** Kalau semua slot penuh, satu blok harus digusur. Idealnya yang digusur adalah blok yang paling kecil kemungkinannya dipakai lagi, tapi itu mustahil diketahui pasti. Pendekatan yang cukup efektif adalah least-recently-used (LRU), yaitu menggusur blok yang paling lama tidak dirujuk, dan ini butuh dukungan perangkat keras untuk melacak urutan pemakaian.

**Write policy.** Kalau isi sebuah blok di cache diubah, blok itu harus ditulis balik ke main memory sebelum digusur. Write policy mengatur kapan penulisan itu terjadi, dan buku menyebut dua ekstremnya:

| Kebijakan | Kapan menulis ke main memory | Konsekuensi |
|---|---|---|
| Write through | Setiap kali blok diperbarui | Main memory selalu sinkron, tapi trafik tulis paling banyak |
| Write back | Hanya saat blok digusur | Operasi tulis paling sedikit, tapi main memory sempat basi |

Isi main memory yang basi jadi masalah nyata pada sistem multiprocessor dan pada modul I/O yang memakai direct memory access, karena keduanya bisa membaca main memory langsung dan melihat data lama.

## 1.7 Teknik Komunikasi I/O

### Tiga Cara Prosesor Berurusan dengan I/O

Stallings membagi operasi I/O jadi tiga teknik: programmed I/O, interrupt driven I/O, dan direct memory access atau DMA (akses memori langsung). Pembedanya bukan hasil akhir, karena data tetap sampai ke memori, melainkan siapa yang mengurus perpindahan tiap kata data dan berapa banyak waktu prosesor yang tersita (hal PDF 52).

### Programmed I/O: Prosesor Menunggu Sambil Sibuk

Saat prosesor menemui instruksi I/O, ia mengirim perintah ke I/O module (modul I/O) yang bersangkutan. Modul itu mengerjakan permintaannya, lalu menyetel bit di I/O status register (register status I/O). Sampai di situ saja, modul tidak menginterupsi prosesor. Jadi prosesor sendiri yang harus aktif mencari tahu kapan operasi selesai, dengan memeriksa status modul berulang kali sampai ready. Inilah busy waiting atau polling (memeriksa terus-menerus).

Pengambilan data dari main memory untuk output dan penyimpanan ke main memory untuk input juga jadi tugas prosesor. Karena itu instruction set punya tiga kategori instruksi I/O (hal PDF 52):

- **Control**: mengaktifkan perangkat eksternal dan menyuruhnya melakukan sesuatu, misalnya menyuruh unit pita magnetik melakukan rewind.
- **Status**: menguji berbagai kondisi status modul I/O dan peripheral-nya.
- **Transfer**: membaca atau menulis data antara register prosesor dan perangkat eksternal.

Pada Figure 1.19a, satu blok dibaca per word (kata, misalnya 16 bit), dan untuk setiap word prosesor terkunci di loop pengecekan status. Kelemahannya langsung terlihat, prosesor sibuk tanpa menghasilkan apa-apa (hal PDF 53).

### Interrupt Driven I/O: Kerjakan Hal Lain Dulu

Alternatifnya, prosesor mengirim perintah I/O lalu pergi mengerjakan hal lain yang berguna, dan modul I/O yang akan menginterupsinya begitu siap bertukar data. Untuk input, modul menerima perintah READ, membaca data dari peripheral, dan setelah data ada di data register-nya barulah ia mengirim sinyal interrupt (sinyal potong) lewat jalur kontrol, lalu menunggu sampai datanya diminta.

Dari sisi prosesor, setelah mengirim READ ia menyimpan context (konteks, misalnya program counter dan register prosesor) program yang sedang jalan dan beralih ke pekerjaan lain. Di akhir setiap instruction cycle prosesor mengecek ada tidaknya interrupt. Kalau interrupt datang, konteks program yang sedang berjalan disimpan, interrupt handler dijalankan untuk membaca satu word dari modul I/O dan menyimpannya ke memori, lalu konteks tadi dipulihkan dan eksekusi dilanjutkan (hal PDF 54).

Cara ini lebih efisien karena waktu tunggu sia-sia hilang. Tapi prosesor tetap termakan banyak waktu, sebab setiap word yang bergerak antara memori dan modul I/O harus lewat prosesor. Karena satu sistem hampir selalu punya banyak modul I/O, dibutuhkan mekanisme untuk tahu perangkat mana yang menginterupsi dan mana yang dilayani lebih dulu: bisa banyak jalur interrupt dengan prioritas berbeda, bisa juga satu jalur interrupt plus jalur tambahan untuk alamat perangkat (hal PDF 54).

### DMA: Serahkan Satu Blok Sekaligus

Programmed I/O dan interrupt driven I/O sama-sama punya dua kelemahan bawaan (hal PDF 54):

1. Laju transfer dibatasi kecepatan prosesor menguji dan melayani perangkat.
2. Prosesor tersandera mengurus transfer, karena sejumlah instruksi harus dijalankan untuk setiap transfer.

Untuk volume data besar, DMA jadi jawabannya. Fungsinya bisa berupa modul terpisah di system bus atau ditanam di dalam modul I/O. Prosesor cukup mengirim satu perintah ke modul DMA berisi empat hal: apakah operasinya read atau write, alamat perangkat I/O yang terlibat, lokasi awal di memori, dan jumlah word yang akan dipindahkan. Setelah itu prosesor lanjut bekerja. Modul DMA memindahkan seluruh blok data, satu word sekali jalan, langsung dari atau ke memori tanpa melewati prosesor. Begitu selesai, modul DMA mengirim satu interrupt. Jadi prosesor hanya terlibat di awal dan di akhir transfer, bukan di tengah-tengahnya (Figure 1.19c, hal PDF 55).

Itu sebabnya DMA paling efisien untuk transfer besar: biaya keterlibatan prosesor bersifat tetap per blok, bukan per word. Blok seribu word tetap butuh satu perintah dan satu interrupt.

### Cycle Stealing

Modul DMA butuh menguasai bus untuk memindahkan data, jadi kalau prosesor kebetulan juga butuh bus, prosesor harus menunggu. Stallings menegaskan ini bukan interrupt, karena prosesor tidak menyimpan konteks dan tidak beralih mengerjakan hal lain. Prosesor cuma berhenti selama satu bus cycle (siklus bus, waktu untuk memindahkan satu word lewat bus). Efeknya prosesor berjalan sedikit lebih lambat selama transfer DMA. Perilaku "mencuri" satu siklus bus dari prosesor inilah yang lazim disebut cycle stealing. Meski begitu, untuk transfer banyak word DMA tetap jauh lebih efisien daripada dua teknik lainnya (hal PDF 55).

### Tabel Perbandingan

| Aspek | Programmed I/O | Interrupt Driven I/O | DMA |
|---|---|---|---|
| Siapa memindahkan data | Prosesor | Prosesor | Modul DMA |
| Data lewat prosesor? | Ya | Ya | Tidak, langsung ke memori |
| Cara tahu I/O selesai | Prosesor cek status berulang (busy waiting) | Modul I/O mengirim interrupt | Modul DMA mengirim interrupt saat satu blok selesai |
| Keterlibatan prosesor | Penuh, sepanjang operasi | Per word yang dipindahkan | Hanya awal dan akhir blok |
| Prosesor bisa kerja lain saat menunggu | Tidak | Bisa | Bisa, hanya melambat saat bus direbut |
| Beban ke prosesor | Paling berat | Sedang | Paling ringan |
| Cocok untuk | Data sangat sedikit, perangkat sederhana | Transfer sedang, perangkat yang tak menentu waktunya | Transfer blok besar, disk dan jaringan |

---

## Istilah Kunci

| Istilah | Arti |
|---|---|
| `accumulator (AC)` | Satu-satunya register data pada mesin contoh, dipakai sebagai penyimpan sementara hasil operasi |
| `Bus cycle` | Waktu yang dibutuhkan untuk memindahkan satu word melewati bus sistem |
| `Busy waiting (polling)` | Kondisi prosesor terkunci di loop pengecekan status sehingga sibuk tanpa mengerjakan hal berguna |
| `Condition code (flag)` | Bit yang diset hardware sesudah sebuah operasi, misalnya menandai hasil nol atau overflow, lalu diuji oleh instruksi conditional branch |
| `Context` | Kumpulan keadaan program yang sedang berjalan, misalnya program counter dan isi register, yang disimpan sebelum interrupt dilayani |
| `Control and status register` | Register yang dipakai prosesor untuk mengatur operasinya sendiri dan dipakai rutin OS berprivilese untuk mengendalikan eksekusi program |
| `Control stack` | Area memori tempat PSW, PC, dan isi register didorong saat interrupt terjadi lalu diambil kembali saat handler selesai |
| `CPU (central processing unit)` | Sebutan untuk prosesor tunggal yang mengendalikan operasi komputer sekaligus melakukan pemrosesan data |
| `Cycle stealing` | Penundaan prosesor selama satu bus cycle karena modul DMA sedang memakai bus, bukan interrupt dan tanpa penyimpanan konteks |
| `Direct memory access (DMA)` | Teknik yang menyerahkan pemindahan satu blok data langsung antara memori dan perangkat ke modul DMA tanpa melewati prosesor |
| `Disabled interrupt` | Pendekatan interrupt ganda di mana interrupt baru diabaikan dan dibiarkan pending selama sebuah handler berjalan, sehingga penanganan berlangsung ketat berurutan |
| `execute stage` | Tahap saat prosesor menafsirkan isi IR dan mengerjakan aksi yang diminta instruksi |
| `fetch stage` | Tahap saat prosesor mengambil instruksi berikutnya dari memori berdasarkan alamat di PC |
| `Hit ratio (H)` | Proporsi akses memori yang datanya sudah ada di memori tingkat lebih cepat, dan penentu utama waktu akses rata-rata |
| `I/O status register` | Register di modul I/O yang bitnya disetel untuk menandakan status operasi, misalnya ready atau error |
| `instruction cycle` | Satu putaran pemrosesan untuk satu instruksi, terdiri dari fetch stage dan execute stage |
| `instruction register (IR)` | Register tempat instruksi yang sedang dieksekusi ditampung setelah diambil dari memori |
| `Interrupt` | Mekanisme yang membuat modul lain seperti I/O atau memori bisa menyela urutan eksekusi normal prosesor, terutama supaya prosesor tidak menganggur menunggu perangkat lambat |
| `Interrupt driven I/O` | Teknik I/O yang membiarkan prosesor mengerjakan hal lain sampai modul I/O mengirim sinyal interrupt saat siap bertukar data |
| `Interrupt handler` | Rutin milik OS yang dipanggil prosesor untuk melayani interrupt tertentu, menentukan jenisnya, dan melakukan tindakan yang diperlukan |
| `Interrupt stage` | Tahap tambahan pada siklus instruksi, setelah execute, tempat prosesor mengecek ada tidaknya sinyal interrupt yang pending |
| `Locality of reference` | Kecenderungan rujukan memori sebuah program mengelompok di sekumpulan alamat yang sama dalam jangka pendek |
| `LRU (least-recently-used)` | Algoritma penggantian yang menggusur blok paling lama tidak dirujuk saat cache penuh |
| `MAR dan MBR` | Pasangan register internal prosesor yang masing-masing memegang alamat memori tujuan dan data yang ditulis atau dibaca |
| `Memory hierarchy` | Susunan beberapa teknologi memori berlapis, dari kecil-cepat-mahal di atas sampai besar-lambat-murah di bawah |
| `Miss` | Kondisi saat word yang diminta tidak ada di memori cepat sehingga bloknya harus diambil dulu dari level bawah |
| `Nested interrupt` | Pendekatan interrupt ganda berbasis prioritas, di mana interrupt berprioritas lebih tinggi boleh menyela handler yang sedang berjalan |
| `opcode` | Bagian 4 bit pertama instruksi yang menentukan operasi apa yang dijalankan prosesor |
| `Program counter (PC)` | Register yang menyimpan alamat instruksi berikutnya yang akan diambil prosesor |
| `Program status word (PSW)` | Register status yang berisi condition code plus informasi seperti bit interrupt enable/disable dan bit kernel/user mode |
| `Programmed I/O` | Teknik I/O yang membuat prosesor mengecek sendiri status modul I/O berulang kali sampai operasi selesai |
| `PSW (program status word)` | Register status program yang wajib disimpan saat interrupt agar kondisi eksekusi bisa dipulihkan persis seperti sebelum disela |
| `Slot atau line` | Satu tempat di cache yang menampung K word, jumlahnya jauh lebih sedikit daripada jumlah blok main memory |
| `System bus` | Jalur yang menghubungkan prosesor, memori utama, dan modul I/O supaya bisa saling bertukar data |
| `Tag` | Bit-bit tertinggi alamat yang disimpan di tiap slot untuk menandai blok main memory mana yang sedang ditampung |
| `User visible register` | Register yang bisa dirujuk lewat machine language sehingga program dan compiler bisa memakainya untuk mengurangi akses ke memori utama |
| `Write policy` | Aturan kapan perubahan isi cache ditulis ke main memory, dari write through tiap update sampai write back saat penggusuran |
