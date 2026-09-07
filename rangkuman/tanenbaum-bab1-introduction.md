# Rangkuman Bab 1: Introduction

Sumber: Andrew S. Tanenbaum dan Herbert Bos, *Modern Operating Systems*, edisi 4, Bab 1 (halaman PDF 32 sampai 115).

Catatan kuliah Sistem Operasi, Ghaisan Khoirul Badruzaman (251524048, 2B-D4),
D4 Teknik Informatika, Politeknik Negeri Bandung. Pertemuan 1, 7 September 2026.

Rangkuman ini ditulis ulang dengan kalimat sendiri sebagai bahan belajar.
Bukunya sendiri tidak ikut disimpan di repo ini karena berhak cipta penerbit.

---

## Daftar Isi

1. [1.1 Apa Itu Sistem Operasi](#11-apa-itu-sistem-operasi)
2. [1.2 Sejarah Sistem Operasi](#12-sejarah-sistem-operasi)
3. [1.3 Tinjauan Hardware Komputer](#13-tinjauan-hardware-komputer)
4. [1.4 Kebun Binatang Sistem Operasi](#14-kebun-binatang-sistem-operasi)
5. [1.5 Konsep Dasar Sistem Operasi](#15-konsep-dasar-sistem-operasi)
6. [1.6 System Call](#16-system-call)
7. [1.7 Struktur Sistem Operasi](#17-struktur-sistem-operasi)
8. [1.8-1.12 Dunia Menurut C, Riset OS, dan Penutup Bab](#18-112-dunia-menurut-c-riset-os-dan-penutup-bab)

---


## 1.1 Apa Itu Sistem Operasi

Tanenbaum membuka bab ini dengan mengakui bahwa OS sendiri sulit didefinisikan. Jawaban paling ringkas, yaitu perangkat lunak yang berjalan di kernel mode (mode istimewa dengan akses penuh ke hardware), ternyata tidak selalu tepat, sebab pada sebagian sistem layanan seperti file system justru dijalankan di user space. Akarnya, OS mengerjakan dua fungsi yang pada dasarnya tidak berhubungan satu sama lain. (hal PDF 34-35)

Ukuran kodenya menjelaskan kenapa OS jarang ditulis ulang dari nol. Inti Linux atau Windows berada di kisaran lima juta baris kode, dan Windows beserta shared library pentingnya menembus 70 juta baris. Sistem sebesar itu dievolusikan, bukan dibuang.

### OS sebagai extended machine (mesin yang diperluas)

Ini sudut pandang top-down. Antarmuka hardware di level bahasa mesin itu primitif dan menyusahkan, terutama untuk I/O. Contoh yang dipakai Tanenbaum: buku Anderson (2007) yang menjelaskan versi awal antarmuka disk SATA saja tebalnya lebih dari 450 halaman, dan spesifikasinya sudah direvisi berkali-kali sejak itu. Tidak ada programmer waras yang mau berurusan dengan disk pada level tersebut.

OS menyembunyikannya bertingkat. disk driver (penggerak perangkat disk) menangani hardware dan menyediakan operasi baca tulis blok disk. Level itu pun masih terlalu rendah untuk kebanyakan aplikasi, jadi OS menambah lapisan abstraksi berikutnya, yaitu file. Abstraksi yang baik memecah satu pekerjaan yang nyaris mustahil menjadi dua pekerjaan yang bisa dikerjakan: mendefinisikan lalu mengimplementasikan abstraksinya, dan memakai abstraksi itu untuk menyelesaikan masalah aslinya. Gambar 1-2 merangkumnya sebagai "ugly interface" hardware yang disulap jadi "beautiful interface" bagi program aplikasi.

Satu hal yang sering salah tangkap: pelanggan sesungguhnya dari OS adalah program aplikasi, bukan pengguna akhir. Pengguna berhadapan dengan abstraksi user interface, entah command line shell atau GUI. Gnome, KDE, dan X Window System memberi tampilan yang jauh berbeda di atas abstraksi Linux yang sama persis. (hal PDF 35-36)

### OS sebagai resource manager (pengelola sumber daya)

Ini sudut pandang bottom-up. Komputer modern terdiri dari processor, memori, timer, disk, mouse, network interface, printer, dan macam-macam perangkat lain. Tugas OS adalah membagikan semuanya secara tertib ke program yang memintanya, mencatat siapa memakai apa, dan menengahi permintaan yang bentrok. Kebutuhan ini makin besar begitu ada banyak pengguna, karena mereka bisa saling mengganggu sekaligus perlu berbagi berkas dan basis data.

Contoh klasiknya printer. Tiga program yang mencetak serentak akan menghasilkan keluaran tercampur aduk. OS menampung dulu output ke disk, lalu mengirimkannya bergiliran, sementara program lain tetap bisa lanjut bekerja.

Pembagian pakai sumber daya (multiplexing) terjadi dengan dua cara:

| Jenis | Cara berbagi | Contoh |
|---|---|---|
| Time multiplexing | pemakai bergantian menguasai sumber daya secara utuh | CPU dijatah ke satu program sekian lama, lalu berpindah; antrean print job |
| Space multiplexing | tiap pemakai kebagian potongan sumber daya pada saat bersamaan | memori utama dibagi ke beberapa program; satu disk menyimpan berkas banyak pengguna |

Keputusan siapa duluan, berapa lama, dan kebagian berapa besar, plus urusan keadilan dan proteksi yang mengikutinya, semuanya jatuh ke OS. (hal PDF 36-37)

### Kenapa dua sudut pandang ini tidak bertentangan

Keduanya menggambarkan sistem yang sama dari arah yang berlawanan. Dari atas, OS menjual abstraksi bersih ke aplikasi. Dari bawah, OS harus membagi hardware yang jumlahnya terbatas ke banyak peminta. Justru abstraksi itulah yang membuat pembagian bisa berjalan diam-diam: file menyembunyikan kenyataan bahwa satu disk dipakai ramai-ramai, dan process menyembunyikan kenyataan bahwa satu CPU digilir. Sebaliknya, tanpa manajemen sumber daya di belakangnya, abstraksinya langsung bocor begitu ada program kedua yang ikut jalan.

## 1.2 Sejarah Sistem Operasi

Tanenbaum memetakan perkembangan OS ke generasi komputer karena OS selalu menempel pada arsitektur mesin tempatnya berjalan. Dia sendiri bilang pemetaan ini kasar dan urutannya tidak rapi: banyak perkembangan tumpang tindih, salah arah, atau mati di tengah jalan. Pakai ini sebagai panduan, bukan garis waktu presisi. (hal PDF 37-38)

Sebelum masuk generasi pertama, ada catatan Charles Babbage (1792-1871) dengan *analytical engine*, komputer digital pertama yang murni mekanis dan tidak pernah jalan benar karena teknologi roda gigi zaman itu tidak cukup presisi. Mesin ini tidak punya OS, tapi Babbage sadar butuh software dan merekrut Ada Lovelace sebagai programmer pertama di dunia. (hal PDF 38)

### Generasi 1 (1945-1955): Tabung Vakum, Belum Ada OS

Perang Dunia II memicu ledakan pembuatan komputer digital. John Atanasoff dan mahasiswanya Clifford Berry membangun mesin dengan 300 tabung vakum di Iowa State, Konrad Zuse membuat Z3 dari relay elektromekanis di Berlin, lalu menyusul Colossus di Bletchley Park (1944, kelompoknya termasuk Alan Turing), Mark I oleh Howard Aiken di Harvard, dan ENIAC oleh Mauchley dan Eckert di University of Pennsylvania.

Satu tim yang sama merancang, membangun, memprogram, mengoperasikan, sekaligus merawat mesinnya. Pemrograman dilakukan dalam absolute machine language (bahasa mesin murni) atau bahkan dengan mencolokkan ribuan kabel ke plugboard. Assembly language saja belum ada, apalagi OS. Alurnya: programmer mendaftar slot waktu di kertas yang ditempel di dinding, datang ke ruang mesin, memasang plugboard, lalu berdoa supaya tidak ada dari sekitar 20.000 tabung yang putus selama program berjalan. Beban kerjanya sederhana, misalnya membuat tabel sinus, cosinus, logaritma, dan menghitung lintasan artileri. Awal 1950-an punched card masuk dan menggantikan plugboard, tapi prosedurnya tetap sama. (hal PDF 38-39)

### Generasi 2 (1955-1965): Transistor dan Batch System

Transistor membuat komputer cukup andal untuk dijual ke pelanggan. Mesin ini disebut mainframe, dikunci di ruangan ber-AC, dijalankan operator profesional, dan hanya terjangkau perusahaan besar, lembaga pemerintah, atau universitas. Peran mulai terpisah tegas antara perancang, operator, programmer, dan teknisi.

Alur kerja satu job: programmer menulis program di kertas dalam FORTRAN atau assembler, melubanginya ke kartu, menyerahkan tumpukan kartu ke operator, lalu menunggu hasil cetak. Banyak waktu CPU terbuang hanya karena operator berjalan mondar-mandir di ruang mesin. Solusinya adalah **batch system**: kumpulkan satu baki job, salin ke magnetic tape memakai komputer murah IBM 1401 yang jago baca kartu dan cetak, lalu bawa tape itu ke mesin mahal IBM 7094 yang jago hitung. Output ditulis ke tape kedua dan dicetak offline lagi di 1401.

Tiap job dibungkus control card berurutan: `$JOB` (batas waktu, nomor akun, nama programmer), `$FORTRAN`, `$LOAD`, `$RUN`, dan `$END`. Kartu kendali primitif inilah nenek moyang shell dan command-line interpreter sekarang. OS khas generasi ini adalah **FMS** (Fortran Monitor System) dan **IBSYS**, OS IBM untuk 7094. (hal PDF 39-40)

### Generasi 3 (1965-1980): IC dan Multiprogramming

Awal 1960-an, pabrikan punya dua lini produk yang tidak kompatibel: mesin ilmiah word-oriented seperti 7094, dan mesin komersial character-oriented seperti 1401 yang dipakai bank dan asuransi. Merawat dua lini itu mahal. IBM menjawabnya dengan **System/360**, satu keluarga mesin yang software-compatible dari kelas 1401 sampai lebih kuat dari 7094, berbeda hanya di harga dan performa. 360 juga jadi lini besar pertama yang memakai IC (Integrated Circuit), dan penerusnya berlanjut lewat 370, 4300, 3080, 3090, sampai zSeries. (hal PDF 40-42)

Kekuatan ide "satu keluarga" sekaligus jadi kelemahannya. **OS/360** harus jalan di sistem kecil dan besar, untuk kebutuhan komersial dan ilmiah, dan tetap efisien di semuanya. Hasilnya OS raksasa berisi jutaan baris assembly dari ribuan programmer, penuh bug, dengan rilis perbaikan yang tidak habis-habis. Tiap rilis menambal sebagian bug dan menyuntik bug baru, jadi jumlahnya kira-kira tetap. Fred Brooks, salah satu perancangnya, menulis pengalaman ini di *The Mythical Man-Month* (1995) dengan sampul kawanan binatang purba terjebak di kubangan ter. (hal PDF 42)

Meski begitu, generasi ini mempopulerkan tiga teknik yang tidak ada di generasi kedua:

- **Multiprogramming**: memori dipartisi, tiap partisi diisi job berbeda. Saat satu job menunggu I/O, job lain memakai CPU. Ini penting karena pada pengolahan data komersial waktu tunggu I/O bisa 80 sampai 90% dari total. Syaratnya ada hardware proteksi supaya job tidak saling mengintip atau merusak, dan 360 sudah punya itu.
- **Spooling** (Simultaneous Peripheral Operation On Line): job dibaca dari kartu langsung ke disk begitu masuk ruang komputer, lalu saat sebuah partisi kosong OS memuat job berikutnya dari disk. Setelah ada spooling, 1401 tidak diperlukan lagi dan ritual angkut-angkut tape hilang.
- **Timesharing**: varian multiprogramming dengan tiap user memegang terminal online. Kalau 20 user login dan 17 sedang mengetik atau ngopi, CPU cukup dibagi ke 3 job yang benar-benar minta layanan. Ini lahir karena turnaround batch bisa berjam-jam, sehingga satu koma salah letak membuat programmer kehilangan setengah hari.

Sistem timesharing serbaguna pertama adalah **CTSS** (Compatible Time Sharing System) di M.I.T. pada 7094 yang dimodifikasi (Corbato dkk., 1962). Setelah CTSS sukses, M.I.T., Bell Labs, dan General Electric menggarap **MULTICS** (MULTiplexed Information and Computing Service), sebuah *computer utility*: komputasi disediakan seperti listrik, tinggal colok sesuai kebutuhan, dan satu mesin GE-645 diharapkan melayani ratusan pengguna. MULTICS gagal secara komersial, antara lain karena ditulis dalam PL/I sementara compiler PL/I terlambat bertahun-tahun dan hampir tidak berfungsi saat datang. Bell Labs mundur, GE keluar dari bisnis komputer, tapi M.I.T. menuntaskannya dan Honeywell menjualnya ke sekitar 80 perusahaan dan universitas. General Motors, Ford, dan NSA baru mematikan MULTICS akhir 1990-an. Pengaruh idenya besar ke UNIX dan turunannya (FreeBSD, Linux, iOS, Android), dan gagasan computer utility kembali hari ini dalam bentuk cloud computing. (hal PDF 42-45)

Perkembangan besar lain generasi ketiga adalah minikomputer, dimulai dari DEC PDP-1 (1961) yang hanya bermemori 4K word 18-bit tapi berharga $120.000, kurang dari 5% harga 7094. Ken Thompson di Bell Labs, mantan anggota tim MULTICS, menulis versi MULTICS yang dipangkas untuk satu pengguna di sebuah PDP-7 nganggur, dan itu berkembang jadi **UNIX**. Karena source code-nya tersebar luas, muncul banyak versi tidak kompatibel, terutama System V dari AT&T dan BSD (Berkeley Software Distribution). IEEE lalu menstandarkan antarmuka minimal system call lewat **POSIX**. Tanenbaum sendiri merilis **MINIX** untuk pendidikan pada 1987, dan MINIX 3 yang sangat modular bisa mendeteksi serta mengganti modul rusak seperti device driver tanpa reboot. Keinginan akan MINIX versi produksi yang gratis mendorong Linus Torvalds menulis **Linux**. (hal PDF 45)

### Generasi 4 (1980-sekarang): Komputer Pribadi

LSI (Large Scale Integration) membawa era personal computer. Secara arsitektur PC awal tidak jauh beda dari minikomputer kelas PDP-11, yang berubah drastis adalah harganya: kalau minikomputer memungkinkan satu departemen punya komputer sendiri, chip mikroprosesor memungkinkan satu orang punya komputer sendiri.

Intel merilis 8080 pada 1974 dan meminta konsultannya Gary Kildall menulis OS untuk chip itu. Kildall membuat controller floppy 8 inci Shugart lalu menulis **CP/M** (Control Program for Microcomputers), OS berbasis disk pertama untuk mikrokomputer. Intel tidak yakin mikrokomputer berbasis disk punya masa depan, jadi hak CP/M diserahkan ke Kildall yang lalu mendirikan Digital Research. Setelah ditulis ulang pada 1977, CP/M mendominasi dunia mikrokomputer sekitar lima tahun.

Saat IBM menyiapkan IBM PC di awal 1980-an, Bill Gates menyarankan mereka menghubungi Digital Research. Kildall menolak menemui IBM dan pengacaranya menolak menandatangani NDA, jadi IBM balik ke Gates. Gates membeli DOS dari Seattle Computer Products (konon $75.000), merekrut penulisnya Tim Paterson, dan menjualnya ke IBM sebagai **MS-DOS**. Kunci kemenangan Gates adalah menjual MS-DOS ke produsen komputer untuk dibundel dengan hardware, bukan menjual satuan ke pengguna akhir seperti CP/M. Saat IBM PC/AT keluar pada 1983 dengan 80286, MS-DOS sudah kokoh dan CP/M sekarat. (hal PDF 46-47)

Peralihan dari antarmuka ketik ke grafis berakar pada riset Doug Engelbart di Stanford Research Institute tahun 1960-an, yang menemukan GUI lengkap dengan window, ikon, menu, dan mouse. Ide itu diadopsi Xerox PARC, dilihat Steve Jobs saat berkunjung, lalu melahirkan Lisa yang gagal komersial dan Macintosh yang sukses besar karena murah dan ramah pengguna. Pada 1999 Apple mengadopsi kernel turunan Mach microkernel dari Carnegie Mellon, jadi Mac OS X sebenarnya OS berbasis UNIX dengan tampilan khas.

Microsoft membalas dengan **Windows**. Dari 1985 sampai 1995 Windows hanya lingkungan grafis di atas MS-DOS, lebih mirip shell daripada OS sungguhan. Windows 95 berdiri sendiri dan memakai MS-DOS hanya untuk booting dan program lama, disusul Windows 98, tapi keduanya masih penuh assembly Intel 16-bit. Jalur lain adalah **Windows NT** (New Technology), tulis ulang total, 32-bit penuh, dipimpin David Cutler yang juga merancang VMS. Karena terlalu banyak ide VMS di dalamnya, DEC menggugat Microsoft dan kasusnya diselesaikan di luar pengadilan. NT baru laku besar di versi 4.0, lalu versi 5 diganti nama jadi Windows 2000. Setelahnya keluarga Windows pecah jadi lini klien (XP dan penerusnya), lini server (Windows Server 2003, 2008), dan lini embedded. Windows XP (2001) bertahan enam tahun. Vista (Januari 2007) dikritik keras karena kebutuhan sistem tinggi, lisensi ketat, dan dukungan DRM, sehingga banyak orang melompat langsung ke Windows 7 yang lebih ringan dan stabil. Windows 8 (2012) hadir dengan tampilan baru untuk layar sentuh. (hal PDF 47-48)

Pesaing utama di dunia PC tetap UNIX dan turunannya, kuat di server jaringan dan enterprise, hadir juga di desktop, notebook, tablet, dan smartphone. Di mesin x86, Linux jadi alternatif populer bagi mahasiswa dan makin banyak pengguna korporat. FreeBSD, turunan BSD Berkeley, jadi basis OS X. Karena banyak pengguna UNIX lebih suka antarmuka perintah, hampir semua sistem UNIX memakai X Window System (X11) dari M.I.T. untuk manajemen window dasar, dengan Gnome atau KDE di atasnya kalau mau GUI penuh. (hal PDF 48-49)

Pertengahan 1980-an muncul jaringan PC dengan dua model OS yang perlu dibedakan:

| Aspek | Network OS | Distributed OS |
|---|---|---|
| Kesadaran pengguna | Tahu ada banyak mesin, bisa remote login dan copy file antar mesin | Terlihat seperti satu sistem uniprocessor biasa |
| Struktur | Tiap mesin punya OS lokal dan pengguna lokal sendiri | Banyak prosesor dikelola sebagai satu kesatuan |
| Perubahan pada OS | Tidak fundamental, cukup tambah network interface controller, driver, dan program remote | Perlu perubahan mendasar, misalnya scheduling yang mengoptimalkan paralelisme |
| Tantangan | Relatif sedikit | Algoritma harus bekerja dengan informasi tidak lengkap, basi, atau salah karena delay jaringan |

(hal PDF 49-50)

### Generasi 5 (1990-sekarang): Komputer Bergerak

Telepon mobile pertama muncul 1946 dengan bobot sekitar 40 kilogram, jadi "portabel" berarti harus punya mobil untuk mengangkutnya. Handheld sungguhan baru muncul 1970-an dengan berat sekitar satu kilogram dan dijuluki "the brick". Sekarang penetrasi ponsel mendekati 90% populasi dunia, dan fungsi teleponnya justru bagian yang paling tidak menarik dibanding email, web, chat, game, dan navigasi.

Smartphone nyata pertama adalah Nokia N9000 pertengahan 1990-an, yang secara harfiah menggabungkan dua perangkat terpisah, telepon dan PDA (Personal Digital Assistant). Istilah *smartphone* sendiri dicetuskan Ericsson pada 1997 untuk GS88 "Penelope". Dekade pertama smartphone dikuasai Symbian OS yang dipakai Samsung, Sony Ericsson, Motorola, dan terutama Nokia. Pangsanya digerogoti BlackBerry OS dari RIM (masuk smartphone 2002) dan iOS Apple (rilis bersama iPhone pertama 2007). Nokia meninggalkan Symbian pada 2011 dan beralih ke Windows Phone. **Android**, OS berbasis Linux yang dirilis Google pada 2008, akhirnya menyalip semua pesaing karena open source dengan lisensi permisif sehingga vendor bebas menyesuaikannya dengan hardware sendiri, ditambah komunitas developer besar yang menulis app dalam Java. Tanenbaum menutup dengan catatan bahwa di dunia smartphone tidak ada yang bertahan lama di puncak. (hal PDF 50-51)

### Tabel Ringkas Kelima Generasi

| Generasi | Periode | Teknologi | Cara pakai | Sistem khas | Keterbatasan utama |
|---|---|---|---|---|---|
| 1 | 1945-1955 | Tabung vakum, relay | Plugboard lalu punched card, satu orang menguasai mesin selama slotnya | Tidak ada OS | Tidak ada bahasa pemrograman, tabung sering putus, satu job satu waktu |
| 2 | 1955-1965 | Transistor, mainframe | Serahkan kartu ke operator, tunggu cetakan | FMS, IBSYS | Turnaround lama, CPU nganggur saat operator bekerja, hanya batch |
| 3 | 1965-1980 | IC, minikomputer | Batch dengan multiprogramming, mulai ada terminal timesharing | OS/360, CTSS, MULTICS, UNIX | OS/360 raksasa dan penuh bug, turnaround batch masih berjam-jam, butuh hardware proteksi |
| 4 | 1980-sekarang | LSI, mikroprosesor | Satu mesin per orang, CLI lalu GUI | CP/M, MS-DOS, Mac OS X, Windows, Linux | Fragmentasi versi, kompatibilitas warisan, kompleksitas administrasi |
| 5 | 1990-sekarang | SoC mobile, layar sentuh | Perangkat genggam selalu terhubung | Symbian, BlackBerry OS, iOS, Android | Daya dan baterai terbatas, persaingan platform yang cepat berubah |

## 1.3 Tinjauan Hardware Komputer

Sistem operasi menempel erat pada hardware di bawahnya: ia memperluas instruction set mesin dan mengatur resource-nya. Model paling sederhana sebuah PC adalah CPU, memory, dan I/O device yang disambung satu bus. (hal PDF 51)

### Prosesor dan register

Siklus dasar CPU diulang sampai program habis: fetch instruksi dari memory, decode untuk tahu jenis dan operand-nya, execute, lalu lanjut. Tiap CPU punya instruction set sendiri, jadi prosesor x86 tidak bisa menjalankan program ARM dan sebaliknya. Karena mengambil data dari memory jauh lebih lambat daripada mengeksekusi instruksi, CPU menyimpan variabel penting dan hasil sementara di register dalam chip.

Selain general register, ada register khusus yang terlihat oleh programmer:

- **Program counter (PC)**, alamat instruksi berikutnya yang akan di-fetch. Begitu instruksi diambil, isinya digeser ke penerusnya.
- **Stack pointer (SP)**, penunjuk puncak stack. Stack berisi satu frame per prosedur yang sudah dimasuki tapi belum keluar, isinya parameter, variabel lokal, dan variabel sementara yang tidak disimpan di register.
- **PSW (Program Status Word)**, berisi condition code hasil instruksi perbandingan, prioritas CPU, bit mode (user atau kernel), dan bit kontrol lain. Program user boleh membaca seluruh PSW tapi hanya menulis sebagian field-nya.

Sistem operasi wajib tahu semua register ini. Setiap kali satu program dihentikan untuk menjalankan yang lain, isi register harus disimpan supaya bisa dipulihkan nanti. (hal PDF 52)

### Pipeline dan superscalar

Pada **pipeline**, unit fetch, decode, dan execute dipisah sehingga saat instruksi n dieksekusi, instruksi n+1 sedang di-decode dan n+2 sedang di-fetch. Instruksi yang sudah masuk pipeline umumnya harus tetap dieksekusi walau instruksi sebelumnya ternyata conditional branch yang diambil.

**Superscalar** punya banyak execution unit (integer, floating point, Boolean). Beberapa instruksi diambil dan di-decode sekaligus lalu menunggu di holding buffer sampai ada execution unit menganggur yang sanggup menanganinya, jadi instruksi sering dieksekusi out of order. Hardware yang bertugas menjamin hasilnya sama dengan eksekusi berurutan, tapi sebagian kerumitannya jatuh ke sistem operasi. Ditambah **multithreading** dan chip **multicore**, OS melihat lebih banyak CPU daripada yang benar-benar ada. (hal PDF 52-55)

### Mode kernel dan mode user

CPU punya dua mode, dikendalikan satu bit di PSW. Di **kernel mode** CPU boleh menjalankan seluruh instruction set dan memakai semua fitur hardware; di sinilah sistem operasi berjalan. Di **user mode** instruksi yang menyangkut I/O dan proteksi memory dilarang, termasuk mengubah bit mode di PSW.

Untuk minta layanan OS, program user melakukan **system call** yang men-trap ke kernel. Instruksi TRAP memindahkan CPU ke kernel mode dan menjalankan sistem operasi; setelah selesai, kontrol kembali ke instruksi sesudah system call tadi. Anggap saja procedure call biasa dengan efek samping ganti mode. Trap juga bisa dipicu hardware, misalnya pembagian dengan 0, dan OS yang memutuskan apakah program dimatikan, error diabaikan, atau ditangani sendiri oleh program itu. (hal PDF 53-54)

### Hierarki memori

Memory ideal itu sangat cepat, sangat besar, dan sangat murah sekaligus. Tidak ada teknologi yang bisa ketiganya, jadi memory disusun bertingkat: makin ke atas makin cepat, makin kecil, makin mahal per bit, dan selisihnya bisa satu miliar kali lipat.

| Lapisan | Waktu akses | Kapasitas | Dikelola |
|---|---|---|---|
| Register | 1 nsec | < 1 KB | program sendiri |
| Cache | 2 nsec | 4 MB | hardware |
| Main memory (RAM) | 10 nsec | 1-8 GB | sistem operasi |
| Magnetic disk | 10 msec | 1-4 TB | sistem operasi |

Register dibuat dari bahan yang sama dengan CPU sehingga aksesnya tanpa penundaan, jumlahnya sekitar 32 x 32 bit pada CPU 32-bit dan 64 x 64 bit pada CPU 64-bit. **Cache** dikelola hardware: main memory dipotong jadi **cache line** khasnya 64 byte, dan saat satu word dibaca hardware mengecek apakah line-nya ada di cache. Kalau ada (**cache hit**) permintaan selesai sekitar dua clock cycle tanpa lewat bus, kalau **cache miss** penaltinya besar. L1 cache selalu di dalam CPU, khasnya 16 KB dan tanpa delay; L2 beberapa megabyte dengan delay satu sampai dua clock cycle. Di luar RAM ada memory non-volatile seperti ROM, EEPROM, dan flash, plus **CMOS** yang menyimpan jam dan konfigurasi boot dengan tenaga baterai kecil. (hal PDF 55-58)

### Disk

Magnetic disk dua orde lebih murah per bit dan dua orde lebih besar daripada RAM, tapi akses acaknya sekitar tiga orde lebih lambat karena disk adalah alat mekanis. Piringannya berputar 5400, 7200, 10.800 RPM atau lebih. Lingkaran yang terbaca pada satu posisi lengan disebut **track**, kumpulan track pada posisi yang sama disebut **cylinder**, dan tiap track dibagi jadi **sector** khasnya 512 byte.

Pindah ke silinder tetangga sekitar 1 msec, ke silinder acak 5 sampai 10 msec, ditambah 5 sampai 10 msec menunggu sektor yang dituju berputar ke bawah head. Baru setelah itu baca tulis berjalan 50 sampai 160 MB/detik. **SSD** sebenarnya bukan disk: tidak ada bagian bergerak dan datanya disimpan di flash.

**Virtual memory** membuat program yang lebih besar daripada memory fisik tetap bisa jalan: programnya ditaruh di disk, main memory jadi cache bagian yang paling sering dieksekusi, dan alamat program dipetakan ke alamat fisik RAM oleh **MMU (Memory Management Unit)**. Cache dan MMU inilah yang membuat **context switch** mahal, karena pindah program kadang menuntut flush blok cache yang dimodifikasi sekaligus mengganti register pemetaan di MMU. (hal PDF 58-59)

### Perangkat I/O, controller, dan driver

Perangkat I/O umumnya dua bagian: **controller** dan device-nya sendiri. Controller adalah chip yang mengendalikan device secara fisik dan menyembunyikan detailnya dari OS. Diberi perintah semacam "baca sektor 11.206 dari disk 2", controller disk menerjemahkannya jadi cylinder, sector, dan head, menggerakkan lengan, menunggu rotasi, lalu menyusun bit jadi word di memory. Device-nya sendiri berinterface standar, supaya controller SATA mana pun cocok dengan disk SATA mana pun.

Tiap jenis controller butuh **device driver** sendiri, software yang memberi perintah ke controller dan menerima responsnya. Driver umumnya dipasang di dalam kernel supaya jalan di kernel mode, walau MINIX 3 menjalankan semuanya di user space. Cara memasangnya bisa relink kernel lalu reboot (UNIX lama), entri di berkas konfigurasi lalu reboot (cara Windows), atau muat on the fly, yang wajib untuk perangkat hot-pluggable seperti USB. Register tiap controller membentuk **I/O port space**, yang bisa dipetakan ke address space OS lalu dibaca tulis seperti memory biasa, atau ditaruh terpisah dan diakses lewat instruksi IN dan OUT khusus kernel mode. (hal PDF 59-61)

### Tiga cara melakukan I/O

1. **Busy waiting.** Driver menyalakan I/O lalu berputar melakukan polling sampai device selesai. Sederhana, tapi CPU tersandera selama menunggu.
2. **Interrupt.** Driver menyalakan device lalu langsung return, dan OS mencari kerja lain. Saat transfer selesai, controller memberi sinyal ke chip interrupt controller lewat jalur bus, chip itu menekan pin di CPU, lalu menaruh nomor device di bus supaya CPU tahu siapa yang selesai. PC dan PSW didorong ke stack, CPU pindah ke kernel mode, dan nomor device jadi indeks ke **interrupt vector** untuk menemukan alamat handler-nya. Handler menanyai status device lalu mengembalikan kontrol ke instruksi pertama yang belum sempat dijalankan.
3. **DMA (Direct Memory Access).** Chip DMA mengatur aliran bit antara memory dan controller tanpa campur tangan CPU terus-menerus. CPU cukup memberi tahu jumlah byte, alamat device dan memory, serta arah transfernya, lalu melepasnya. Setelah selesai, chip DMA memicu interrupt.

Interrupt sering datang di saat tidak enak, misalnya ketika handler lain sedang jalan, jadi CPU bisa mematikan lalu menyalakannya lagi. Selama dimatikan, device yang selesai tetap menahan sinyalnya, dan begitu dinyalakan interrupt controller memilih siapa yang lewat duluan berdasarkan prioritas statis. (hal PDF 61-62)

### Bus

Satu bus tunggal seperti pada IBM PC asli tidak sanggup lagi menampung trafik setelah prosesor dan memory makin cepat, jadi bus ditambah dan OS harus mengenali semuanya. CPU bicara ke memory lewat DDR3 dan ke hub berisi device lain lewat DMI.

| Bus | Catatan |
|---|---|
| PCIe | Bus utama, penerus PCI (yang menggantikan ISA), lahir 2004. Serial dan point to point, tiap sambungan disebut **lane** dan bisa dipakai banyak lane sekaligus. 16 lane PCIe 2.0 memberi 64 Gbps. |
| PCI | Paralel dan shared: satu angka 32-bit lewat 32 kawat sekaligus, butuh arbiter saat banyak device ingin memakai bus. |
| USB | Untuk device lambat seperti keyboard dan mouse. Root device melakukan polling tiap 1 msec. USB 1.0 12 Mbps, 2.0 480 Mbps, 3.0 5 Gbps, colok langsung jalan tanpa reboot. |
| SATA dan SCSI | SATA untuk hard disk dan DVD drive; SCSI sampai 640 MB/detik, kini kebanyakan di server. |

Sebelum ada **plug and play**, tiap kartu I/O memakai interrupt dan alamat tetap, jadi dua kartu dengan interrupt sama akan bentrok dan penggunanya harus mengatur DIP switch sendiri. Plug and play membuat sistem mendata device sendiri, membagikan interrupt level dan alamat I/O terpusat, lalu memberi tahu tiap kartu nomornya. (hal PDF 63-65)

### Booting

Di parentboard ada **BIOS (Basic Input Output System)** berisi software I/O tingkat rendah untuk membaca keyboard, menulis ke layar, dan melakukan I/O disk. BIOS disimpan di flash RAM, non-volatile tapi tetap bisa diperbarui saat ada bug. Urutannya:

1. BIOS memeriksa berapa RAM terpasang dan apakah keyboard serta device dasar merespons, lalu memindai bus PCIe dan PCI; device baru dikonfigurasi.
2. Boot device ditentukan dari daftar di memory CMOS. Biasanya CD-ROM atau USB dicoba dulu, kalau gagal barulah hard disk.
3. Sektor pertama boot device dibaca ke memory lalu dieksekusi. Isinya memeriksa partition table untuk mencari partisi aktif, lalu memuat **secondary boot loader** dari situ.
4. Boot loader membaca sistem operasi dari partisi aktif dan menjalankannya, lalu OS bertanya ke BIOS soal konfigurasi dan mengecek apakah driver tiap device sudah ada.

(hal PDF 65)

## 1.4 Kebun Binatang Sistem Operasi

Sistem operasi sudah ada lebih dari setengah abad dan berkembang jadi banyak varian, sebagian tidak pernah terdengar di luar bidangnya. Tanenbaum mendaftar sembilan jenis, diurutkan dari mesin terbesar ke yang paling mungil. Pembedanya bukan cuma ukuran hardware, tapi beban kerja yang ditangani dan seberapa bebas pengguna memasang software sendiri. (hal PDF 66)

### Sembilan jenis dan kebutuhan khasnya

| Jenis | Contoh OS | Kebutuhan khas |
|---|---|---|
| Mainframe | OS/390 (turunan OS/360), makin sering diganti varian UNIX seperti Linux | Kapasitas I/O raksasa, 1000 disk dan jutaan gigabyte data itu biasa; banyak job jalan sekaligus |
| Server | Solaris, FreeBSD, Linux, Windows Server 201x | Melayani banyak pengguna lewat jaringan, berbagi resource, layanan print, file, dan Web |
| Multiprocessor | Windows dan Linux (keduanya jalan di multiprocessor) | Fitur tambahan untuk komunikasi, konektivitas, dan konsistensi antar CPU |
| Personal computer | Linux, FreeBSD, Windows 7, Windows 8, OS X | Multiprogramming (banyak program aktif bersamaan) dan dukungan bagus untuk satu pengguna |
| Handheld | Android, iOS | CPU multicore, GPS, kamera dan sensor lain, memori besar, plus ekosistem aplikasi pihak ketiga |
| Embedded | Embedded Linux, QNX, VxWorks | Semua software ada di ROM, tidak ada software asing yang masuk, jadi proteksi antar aplikasi bisa dipangkas |
| Sensor node | TinyOS | OS kecil dan event driven (digerakkan kejadian), irit RAM dan baterai, jaringan harus tahan node yang mati satu per satu |
| Real-time | eCos | Waktu jadi parameter utama, deadline (tenggat) wajib dipenuhi |
| Smart card | Umumnya proprietary, sebagian berbasis JVM | Daya dan memori sangat terbatas, kartu contactless malah cuma disuplai secara induktif |

(hal PDF 66-69)

### Catatan yang tidak muat di tabel

**Mainframe menjual tiga layanan sekaligus.** *Batch* (pemrosesan tumpukan) menggarap job rutin tanpa pengguna interaktif, misalnya pemrosesan klaim asuransi atau laporan penjualan jaringan toko. *Transaction processing* (pemrosesan transaksi) menangani ratusan sampai ribuan permintaan kecil per detik, contohnya pemrosesan cek di bank dan reservasi pesawat. *Timesharing* (berbagi waktu) membiarkan banyak pengguna remote menjalankan job bersamaan, misalnya query database besar. Satu OS mainframe biasanya menyediakan ketiganya. (hal PDF 66)

**Multicore menyeret OS biasa ke ranah multiprocessor.** Desktop dan notebook sekarang harus mengurus multiprocessor skala kecil, dan jumlah core bakal terus naik. Teorinya sudah lama matang dari riset multiprocessor, yang sulit justru membuat aplikasi benar-benar memakai daya itu. (hal PDF 67)

**Hard vs soft real-time.** Hard real-time menuntut jaminan mutlak bahwa suatu aksi terjadi pada saat tertentu. Contohnya robot las di lini perakitan mobil, kalau mengelas terlalu cepat atau terlambat, mobilnya rusak. Ranahnya kontrol proses industri, avionik, dan militer. Soft real-time masih memaklumi deadline yang sesekali lewat asal tidak ada kerusakan permanen, misalnya audio digital dan multimedia; smartphone termasuk di sini. Demi ketepatan waktu, OS hard real-time kadang cuma berupa library yang di-link ke program aplikasi, semuanya rapat tanpa proteksi antar bagian. (hal PDF 68-69)

**Tiga kategori yang saling tumpang tindih.** Handheld, embedded, dan real-time beririsan lebar dan hampir semuanya punya sisi soft real-time. Bedanya di sasaran, handheld dan embedded untuk konsumen sedangkan real-time lebih ke industri, dan di embedded maupun real-time hanya perancang sistem yang boleh memasukkan software sehingga proteksi jadi urusan gampang. (hal PDF 69)

**Smart card berbasis Java.** ROM kartunya berisi interpreter Java Virtual Machine (JVM). Applet (program kecil) diunduh ke kartu lalu dijalankan interpreter itu. Kalau lebih dari satu applet hidup bersamaan, muncul kebutuhan multiprogramming, penjadwalan, manajemen resource, dan proteksi, semua ditangani OS kartu yang oleh Tanenbaum disebut "usually extremely primitive". (hal PDF 69)

## 1.5 Konsep Dasar Sistem Operasi

Hampir semua sistem operasi berdiri di atas segelintir abstraksi yang sama: process, address space, dan file. Contoh di subbab ini kebanyakan dari UNIX. (hal PDF 69-70)

### Process

Process (proses) adalah program yang sedang dijalankan. Tiap process punya address space (ruang alamat), daftar lokasi memori dari 0 sampai batas tertentu yang boleh dibaca dan ditulis olehnya, berisi kode program, data, dan stack. Menempel juga sekumpulan resource: register termasuk program counter dan stack pointer, daftar file yang terbuka, alarm yang belum jatuh tempo, dan daftar process kerabatnya. Tanenbaum menyebut process sebagai "a container that holds all the information needed to run a program". Contoh multiprogramming-nya: video editor mengonversi video satu jam, browser dipakai berselancar, pengecek email jalan di latar. Sistem operasi bergantian menghentikan satu process untuk menjalankan yang lain, misalnya karena satu sudah memakan jatah CPU lebih dari porsinya. (hal PDF 70)

Process yang dihentikan harus bisa dilanjutkan persis pada keadaan terakhirnya, jadi seluruh informasinya wajib disimpan, termasuk pointer posisi baca tiap file yang terbuka supaya panggilan read berikutnya membaca byte yang benar. Informasi itu, kecuali isi address space-nya sendiri, ditaruh di process table, array of structure dengan satu entri per process. Jadi process yang tersuspensi terdiri dari core image (isi address space, nama warisan zaman magnetic core memory) plus entri process table-nya. (hal PDF 70)

System call terpenting untuk process adalah pembuatan dan penghentian: shell membaca perintah kompilasi, membuat process baru untuk menjalankan compiler, lalu process itu mengakhiri dirinya sendiri. Process bentukan process lain disebut child process, dan child bisa punya child lagi sehingga terbentuk process tree seperti Gambar 1-13 (A membuat B dan C, B membuat D, E, F). Process yang bekerja sama bertukar data lewat interprocess communication (komunikasi antarproses). System call lain menyediakan permintaan memori tambahan, pelepasan memori, penantian sampai child selesai, dan penimpaan program dengan program lain. (hal PDF 71)

Informasi untuk process yang tidak sedang menunggu apa pun dikirim lewat signal, misalnya timer untuk mengirim ulang pesan jaringan yang tak kunjung dibalas. Saat waktunya tiba sistem operasi mengirim alarm signal, process menyimpan register ke stack, menjalankan signal handler, lalu kembali ke keadaan sebelumnya. Signal adalah padanan software dari hardware interrupt, dan trap hardware seperti instruksi ilegal juga diubah jadi signal. Soal identitas, tiap pengguna diberi UID (User Identification) dan tiap process membawa UID orang yang menjalankannya; child mewarisi UID parent. Pengguna bisa masuk group yang punya GID (Group Identification), dan satu UID istimewa, superuser di UNIX atau Administrator di Windows, boleh menembus banyak aturan proteksi. (hal PDF 71-72)

### Address Space dan Virtual Memory

Sistem sederhana hanya menaruh satu program di memori. Sistem yang lebih maju menampung banyak program sekaligus, jadi butuh mekanisme proteksi yang wujudnya di hardware tapi kendalinya di sistem operasi. Dengan alamat 32 atau 64 bit, address space bisa mencapai 2^32 atau 2^64 byte, jauh melebihi memori fisik. Jawabannya virtual memory: sebagian address space disimpan di memori utama, sebagian di disk, dan potongannya dipindah bolak-balik sesuai kebutuhan. Address space jadi abstraksi yang lepas dari memori fisik dan boleh lebih besar atau lebih kecil darinya. (hal PDF 72)

### Sistem Berkas

Sistem operasi menyembunyikan keanehan disk dan perangkat I/O, lalu menyodorkan model file yang bersih dan tidak bergantung perangkat. Ada system call untuk membuat, menghapus, membaca, menulis, membuka, dan menutup file. Directory mengelompokkan file, isinya bisa file atau directory lain, dan dari situ lahir hierarki sistem berkas seperti Gambar 1-14. (hal PDF 72-73)

Hierarki process dan hierarki file sama-sama pohon, tapi miripnya berhenti di situ:

| Aspek | Hierarki process | Hierarki file |
|---|---|---|
| Kedalaman | Jarang lebih dari tiga level | Lazim empat, lima, atau lebih |
| Umur | Pendek, paling lama hitungan menit | Bisa bertahun-tahun |
| Akses | Umumnya hanya parent yang mengendalikan child | Hampir selalu bisa dibaca pihak di luar pemilik |

Setiap file ditunjuk lewat path name dari root directory. Path absolut berisi urutan directory dari root sampai file, dipisah garis miring, misalnya /Faculty/Prof.Brown/Courses/CS101; garis miring di depan itulah penandanya. Windows memakai backslash karena alasan historis. Tiap process punya working directory (direktori kerja), tempat path tanpa garis miring awal dicari, jadi kalau working directory-nya /Faculty/Prof.Brown, path Courses/CS101 menunjuk file yang sama. Saat file dibuka izinnya diperiksa; kalau lolos sistem mengembalikan bilangan bulat kecil bernama file descriptor untuk operasi berikutnya, kalau tidak yang kembali kode error. (hal PDF 74)

Mounting menyatukan sistem berkas terpisah, misalnya CD-ROM atau USB, ke dalam satu pohon. UNIX menolak path berawalan nama drive karena itu persis ketergantungan perangkat yang mestinya dihapus sistem operasi; sebagai gantinya system call mount menempelkan sistem berkas tadi ke titik mana pun yang diminta program. Pada Gambar 1-15, setelah dimount di directory b, isinya diakses sebagai /b/x dan /b/y, sedangkan file lama di b tak terjangkau selama mount aktif. Ini jarang jadi masalah karena orang biasanya me-mount ke direktori kosong. (hal PDF 74-75)

Special file membuat perangkat I/O tampak seperti file sehingga bisa dibaca dan ditulis dengan system call yang sama. Block special file memodelkan perangkat berisi blok beralamat acak seperti disk; character special file memodelkan printer, modem, dan perangkat beraliran karakter. Konvensinya semua ditaruh di /dev, misalnya /dev/lp untuk printer. Pipe adalah pseudofile penyambung dua process yang harus disiapkan lebih dulu: process A menulis ke pipe seolah file output, process B membacanya seolah file input. Satu-satunya cara process tahu ia menulis ke pipe dan bukan file betulan adalah lewat system call khusus. (hal PDF 75)

### Input/Output dan Proteksi

Setiap sistem operasi punya subsistem I/O. Sebagian software-nya device independent karena berlaku untuk banyak perangkat, sebagian lain seperti device driver dibuat khusus per perangkat. (hal PDF 76)

File UNIX dijaga protection code 9 bit yang dipecah jadi tiga field berisi 3 bit: pemilik, anggota group pemilik, dan semua orang lain. Tiap field punya bit read, write, dan execute, dikenal sebagai bit rwx. Contoh rwxr-x--x berarti pemilik boleh membaca, menulis, dan mengeksekusi; anggota group boleh membaca dan mengeksekusi tapi tidak menulis; sisanya hanya boleh mengeksekusi. Tanda hubung berarti izinnya tidak ada, dan pada directory bit x berarti izin search. (hal PDF 76)

### Shell

Sistem operasi adalah kode yang melaksanakan system call. Editor, compiler, assembler, linker, dan command interpreter (penerjemah perintah) bukan bagiannya. Shell termasuk kelompok terakhir, tapi dipakai sebagai contoh karena memakai banyak fitur sistem operasi dan jadi antarmuka utama pengguna terminal. Variannya sh, csh, ksh, dan bash. Begitu login, shell jalan dengan terminal sebagai standard input dan standard output lalu mencetak prompt. Ketik `date`, shell membuat child process untuk program date dan menunggunya selesai sebelum prompt muncul lagi. (hal PDF 76-77)

- `date >file` mengarahkan standard output ke file.
- `sort <file1 >file2` mengambil input dari file1 dan menulis hasil ke file2.
- `cat file1 file2 file3 | sort >/dev/lp` menyambung tiga file, mengurutkannya lewat pipe, lalu mengirim hasilnya ke printer.
- Ampersand di akhir perintah membuat shell tidak menunggu, jadi pekerjaan jalan sebagai background job.

GUI sendiri hanyalah program di atas sistem operasi, sama seperti shell. Di Linux ini jelas karena pengguna bisa memilih Gnome, KDE, atau tidak sama sekali. (hal PDF 77)

### Ontogeny Recapitulates Phylogeny

Ungkapan pinjaman dari zoolog Ernst Haeckel: perkembangan embrio mengulang evolusi spesiesnya. Biolog modern menganggapnya penyederhanaan berlebihan, tapi analoginya cocok untuk industri komputer, karena tiap spesies baru (mainframe, minicomputer, PC, handheld, embedded, smart card) mengulang tahap perkembangan pendahulunya. Banyak hal di bidang ini digerakkan teknologi. Orang Romawi tidak punya mobil bukan karena senang berjalan kaki, melainkan karena belum tahu cara membuatnya. (hal PDF 78)

Perubahan teknologi bisa membuat sebuah ide usang, lalu perubahan berikutnya menghidupkannya lagi, terutama kalau yang berubah adalah performa relatif antarbagian sistem. Cache jadi penting ketika CPU jauh lebih cepat daripada memori; kalau memori suatu saat lebih cepat cache hilang, dan kalau CPU kembali unggul cache muncul lagi. Di biologi kepunahan itu selamanya, di ilmu komputer kadang cuma beberapa tahun, jadi konsep usang tetap perlu dipelajari berikut alasan ia ditinggalkan. Instruksi hardwired misalnya, digantikan microprogramming pada IBM 360, lalu dianggap usang oleh RISC yang eksekusi langsungnya lebih cepat, kemudian interpretasi kembali lewat Java applet. (hal PDF 78-79)

- **Memori besar.** IBM 7090/7094 hanya punya sedikit di atas 128 KB, jadi diprogram dengan assembly demi hemat memori. Setelah compiler FORTRAN dan COBOL membaik assembly dinyatakan mati, tapi hidup lagi di PDP-1 dengan 4096 kata 18 bit, dan sekali lagi di mikrokomputer awal 1980-an bermemori 4 KB. (hal PDF 79)
- **Hardware proteksi.** Mainframe awal tanpa proteksi hanya menjalankan satu program. IBM 360 membawa proteksi primitif sehingga multiprogramming mungkin dan monoprogramming dianggap usang, sampai minicomputer datang tanpa proteksi. PDP-11 akhirnya punya dan dari situ lahir UNIX. Intel 8080 memundurkan lagi ke monoprogramming sampai 80286 mengembalikannya, dan banyak sistem embedded sampai kini tetap tanpa proteksi. (hal PDF 79-80)
- **Disk.** Mainframe awal berbasis pita magnetik, tanpa konsep sistem berkas. RAMAC dari IBM, hard disk pertama tahun 1956, memakan sekitar 4 meter persegi lantai untuk 5 juta karakter 7 bit dengan sewa 35.000 dolar per tahun. CDC 6600 tahun 1964 masih memakai directory satu tingkat, dan hierarki bertingkat baru matang belakangan, puncaknya di MULTICS. (hal PDF 80)

Polanya berulang: ide lahir di satu konteks, dibuang saat konteksnya berubah, lalu muncul lagi sekitar satu dekade kemudian. Roda reinkarnasi ini ada di bidang lain juga, tapi di industri komputer putarannya paling cepat. (hal PDF 80)

## 1.6 System Call

Sistem operasi punya dua tugas besar, yaitu menyediakan abstraksi untuk program pengguna dan mengelola sumber daya mesin. Bagian pengelolaan sumber daya berjalan otomatis dan hampir tidak terlihat oleh pengguna, sehingga antarmuka yang benar-benar dipakai program sehari-hari isinya soal abstraksi: membuat berkas, membaca, menulis, menghapus. Antarmuka itulah yang disebut **system call** (panggilan sistem). Tanenbaum memilih membahas POSIX (International Standard 9945-1) secara spesifik daripada memberi generalisasi kabur, karena detail konkret lebih menjelaskan apa yang sebenarnya dikerjakan OS. POSIX berlaku untuk UNIX, System V, BSD, Linux, dan MINIX 3 (hal PDF 81).

### Perpindahan user mode ke kernel mode

CPU tunggal hanya bisa menjalankan satu instruksi pada satu waktu. Ketika sebuah process yang sedang berjalan di **user mode** (mode pengguna) butuh layanan kernel, misalnya membaca data dari berkas, ia menjalankan instruksi **trap** untuk memindahkan kendali ke sistem operasi. Kernel memeriksa parameter, mengerjakan permintaannya, lalu mengembalikan kendali ke instruksi setelah system call tadi. Analoginya mirip procedure call biasa, bedanya system call masuk ke kernel sementara procedure call tidak (hal PDF 82).

Mekanisme penerbitan system call sangat bergantung mesin dan biasanya ditulis dalam assembly, jadi disediakan pustaka prosedur supaya bisa dipanggil dari C. Contohnya `count = read(fd, buffer, nbytes)`. Nilai balik `count` adalah jumlah byte yang benar-benar terbaca, bisa lebih kecil dari `nbytes` kalau kena end-of-file. Kalau gagal, `count` bernilai -1 dan kode kesalahan disimpan di variabel global `errno`. Hasil setiap system call sebaiknya selalu dicek (hal PDF 82).

### Sebelas langkah pemanggilan read

Buku memecah `read(fd, buffer, nbytes)` menjadi 11 langkah pada Gambar 1-17 (hal PDF 82-84):

| Langkah | Yang terjadi | Ruang |
|---|---|---|
| 1-3 | Program mendorong parameter ke stack. Kompiler C mendorongnya terbalik, jadi urutannya `nbytes`, `&buffer`, lalu `fd`. Parameter pertama dan ketiga dilewatkan by value, `buffer` dilewatkan by reference (alamatnya) | user |
| 4 | Instruksi procedure call biasa ke prosedur pustaka `read` | user |
| 5 | Prosedur pustaka menaruh nomor system call di tempat yang diharapkan OS, umumnya sebuah register | user |
| 6 | Instruksi TRAP dijalankan, mode berpindah ke kernel dan eksekusi lompat ke alamat tetap di dalam kernel | batas |
| 7 | Kernel membaca nomor system call lalu melakukan dispatch ke handler yang benar lewat tabel pointer yang diindeks nomor tersebut | kernel |
| 8 | System call handler dijalankan | kernel |
| 9 | Kendali kembali ke prosedur pustaka di instruksi setelah TRAP | kernel ke user |
| 10 | Prosedur pustaka return ke program pemanggil seperti procedure call biasa | user |
| 11 | Program membersihkan stack dengan menaikkan stack pointer sebanyak parameter yang tadi didorong | user |

TRAP mirip procedure call karena alamat balik disimpan di stack, tapi berbeda dalam dua hal mendasar: TRAP berpindah ke kernel mode sebagai efek samping, dan TRAP tidak bisa melompat ke alamat sembarang, hanya ke satu lokasi tetap atau ke indeks pada tabel alamat lompat (hal PDF 83).

Langkah 9 ditulis "mungkin dikembalikan" dengan sengaja. System call bisa memblok pemanggilnya, misalnya membaca dari keyboard yang belum diketik apa pun. Kalau itu terjadi, OS mencari process lain untuk dijalankan, dan langkah 9 sampai 11 baru dieksekusi setelah data yang ditunggu tersedia (hal PDF 84).

### System call bukan library call

Pemetaan prosedur POSIX ke system call tidak satu lawan satu. Standar POSIX hanya mewajibkan sistem menyediakan sekitar 100 prosedur, tanpa menentukan apakah implementasinya berupa system call, library call, atau cara lain. Kalau sebuah prosedur bisa diselesaikan tanpa trap ke kernel, biasanya dikerjakan di user space demi performa. Mayoritas prosedur POSIX memang memicu system call, umumnya satu prosedur ke satu system call, tapi ada kasus satu system call melayani beberapa library call yang isinya cuma variasi kecil (hal PDF 84). Contoh library call murni adalah `malloc`, yang di baliknya memakai `brk`. `brk` sendiri tidak masuk POSIX karena programmer diarahkan memakai `malloc` (hal PDF 87).

### Manajemen proses

| Panggilan | Fungsi |
|---|---|
| `pid = fork()` | Membuat child process duplikat persis parent |
| `pid = waitpid(pid, &statloc, options)` | Menunggu child berhenti |
| `s = execve(name, argv, environp)` | Mengganti core image process dengan program lain |
| `exit(status)` | Mengakhiri process dan mengembalikan status |

`fork` adalah satu-satunya cara membuat process baru di POSIX. Salinannya identik sampai ke file descriptor dan register. Setelah fork keduanya berjalan sendiri-sendiri, dan karena data parent disalin, perubahan di satu sisi tidak memengaruhi sisi lain. Yang dibagi hanya text program karena bagian itu tidak berubah. Nilai balik `fork` adalah 0 di child dan **PID** (Process IDentifier) si child di parent, jadi keduanya tahu perannya masing-masing (hal PDF 84).

Shell adalah contoh pemakaian yang paling jelas. Shell membaca perintah, melakukan fork, child memanggil `execve` untuk menimpa dirinya dengan program yang diminta, sementara parent memanggil `waitpid` sampai child selesai lalu membaca perintah berikutnya. `waitpid` dengan parameter pertama -1 berarti menunggu child mana saja, dan `statloc` diisi status keluar child (hal PDF 86). Program C menerima `main(argc, argv, envp)`: `argc` jumlah item di baris perintah termasuk nama program, `argv` array pointer ke tiap string, dan `envp` pointer ke environment berisi pasangan `name = value`. Untuk `cp file1 file2`, nilai `argc` adalah 3 (hal PDF 87). Status keluar `exit` berkisar 0 sampai 255 dan sampai ke parent lewat `statloc`.

Memori process UNIX terbagi tiga segmen: text (kode), data (variabel), dan stack. Data tumbuh ke atas, stack tumbuh ke bawah, dan di antaranya ada celah kosong. Stack menempati celah itu otomatis, sedangkan perluasan segmen data harus diminta eksplisit lewat `brk` (hal PDF 87).

### Manajemen berkas

| Panggilan | Fungsi |
|---|---|
| `fd = open(file, how, ...)` | Membuka berkas untuk baca, tulis, atau keduanya |
| `s = close(fd)` | Menutup berkas |
| `n = read(fd, buffer, nbytes)` | Membaca data ke buffer |
| `n = write(fd, buffer, nbytes)` | Menulis data dari buffer |
| `position = lseek(fd, offset, whence)` | Menggeser pointer posisi berkas |
| `s = stat(name, &buf)` | Mengambil informasi status berkas |

Berkas harus dibuka dulu sebelum dibaca atau ditulis. Parameter `how` diisi `O_RDONLY`, `O_WRONLY`, atau `O_RDWR`, dan `O_CREAT` dipakai untuk membuat berkas baru. Hasilnya adalah **file descriptor** (penanda berkas terbuka) yang jadi pegangan untuk operasi berikutnya, dan `close` melepas descriptor itu supaya bisa dipakai ulang (hal PDF 87-88).

Tiap berkas punya pointer posisi yang otomatis maju saat akses berurutan. `lseek` memindahkan pointer itu supaya akses acak bisa dilakukan. Parameter ketiganya menentukan titik acuan: awal berkas, posisi sekarang, atau akhir berkas. Nilai baliknya posisi absolut dalam byte setelah pemindahan. `stat` mengambil metadata seperti mode berkas, ukuran, dan waktu modifikasi terakhir, sementara `fstat` melakukan hal sama untuk berkas yang sudah terbuka (hal PDF 88).

### Direktori dan sistem berkas

| Panggilan | Fungsi |
|---|---|
| `s = mkdir(name, mode)` | Membuat direktori baru |
| `s = rmdir(name)` | Menghapus direktori kosong |
| `s = link(name1, name2)` | Membuat entri baru `name2` yang menunjuk `name1` |
| `s = unlink(name)` | Menghapus entri direktori |
| `s = mount(special, name, flag)` | Menggabungkan sistem berkas ke pohon |
| `s = umount(special)` | Melepas sistem berkas |

`link` membuat satu berkas muncul di dua nama atau lebih, biasanya untuk berbagi berkas antaranggota tim. Berbagi berbeda dari menyalin: perubahan satu orang langsung terlihat semua orang karena berkasnya memang cuma satu. Kuncinya ada di **i-number**, nomor unik tiap berkas yang jadi indeks ke tabel i-node berisi pemilik, letak blok disk, dan seterusnya. Direktori pada dasarnya berkas berisi pasangan (i-number, nama ASCII). Di UNIX awal, satu entri direktori berukuran 16 byte, yaitu 2 byte untuk i-number dan 14 byte untuk nama. Jadi `link` hanya menambah entri direktori baru yang memakai i-number berkas yang sudah ada. Setelah `link("/usr/jim/memo", "/usr/ast/note")`, dua entri menunjuk i-number yang sama. `unlink` menghapus satu entri, dan berkas baru benar-benar dibuang dari disk kalau penghitung entri di i-node mencapai nol (hal PDF 88-89).

`mount` menyatukan dua sistem berkas jadi satu pohon. Contoh `mount("/dev/sdb0", "/mnt", 0)`: parameter pertama block special file untuk drive USB, kedua titik pasang di pohon, ketiga menentukan read-write atau read-only. Setelah dipasang, berkas di drive itu diakses lewat path biasa tanpa peduli perangkat fisiknya di mana (hal PDF 89-90).

### Panggilan lain-lain

`chdir` mengganti working directory sehingga path panjang tidak perlu diketik terus. `chmod` mengubah bit proteksi read-write-execute untuk owner, group, dan others, contohnya `chmod("file", 0644)`. `kill` mengirim signal ke process, dan kalau process tidak menyiapkan signal handler, kedatangan signal itu mematikannya. `time` mengembalikan detik sejak 1 Januari 1970 tengah malam. Pada sistem 32-bit nilai maksimumnya 2^32 - 1 detik, sekitar 136 tahun, jadi UNIX 32-bit akan kacau pada 2106 (hal PDF 90-91).

### Pembanding singkat: Win32 API

Model pemrograman Windows berbeda sejak akarnya. Program UNIX menjalankan kodenya lalu memanggil system call saat butuh layanan, sedangkan program Windows umumnya event driven: program utama menunggu event seperti tombol ditekan atau USB dicolok, lalu memanggil handler yang sesuai (hal PDF 91).

Perbedaan yang lebih penting untuk bahasan system call adalah tingkat kopling. Di UNIX hubungan library call dan system call nyaris satu lawan satu, dan POSIX cuma punya sekitar 100 prosedur. Microsoft justru sengaja memisahkan keduanya lewat **Win32 API** (Application Programming Interface), jumlahnya ribuan, supaya system call di bawahnya bisa diganti antarrilis tanpa merusak program lama. Akibatnya dari luar tidak bisa dibedakan mana yang benar-benar trap ke kernel dan mana yang selesai di user space, dan status itu bahkan bisa berbeda antarversi Windows (hal PDF 91-92).

Padanan kasarnya: `CreateProcess` menggabungkan pekerjaan `fork` dan `execve` sekaligus, `WaitForSingleObject` menunggu event termasuk process selesai, `ExitProcess` mengakhiri process. Untuk berkas ada `CreateFile`, `CloseHandle`, `ReadFile`, `WriteFile`, `SetFilePointer`, dan `GetFileAttributesEx`. Direktori dikelola `CreateDirectory`, `RemoveDirectory`, dan `SetCurrentDirectory`. Win32 tidak punya padanan untuk `link`, `mount`, `umount`, `chmod`, dan `kill`, karena antarmuka itu tidak mengenal link berkas, sistem berkas yang dipasang, keamanan, maupun signal. Windows Vista sudah punya sistem keamanan yang matang dan mendukung link berkas, sementara Windows 7 dan 8 menambah lagi fitur dan system call baru. Catatan terakhir dari buku, Win32 bukan antarmuka yang konsisten, dan penyebab utamanya adalah keharusan tetap kompatibel dengan antarmuka 16-bit Windows 3.x (hal PDF 92-93).

## 1.7 Struktur Sistem Operasi

Setelah sebelumnya melihat OS dari luar, yaitu dari sisi antarmuka programmer, bagian ini membongkar isinya. Tanenbaum membahas enam struktur yang pernah dipakai orang: monolithic, layered, microkernel, client server, virtual machine, dan exokernel. Enam ini bukan daftar semua kemungkinan, hanya contoh rancangan yang benar-benar pernah dijalankan di sistem nyata. (hal PDF 93)

### 1. Monolithic

Ini bentuk yang paling umum. Seluruh OS jalan sebagai satu program tunggal di kernel mode (mode istimewa prosesor). Semua prosedur dikompilasi lalu digabung oleh linker jadi satu binary besar, dan setiap prosedur bebas memanggil prosedur mana pun yang lain. Cepat, karena panggilan antarprosedur tidak melewati batas apa pun, tapi kalau ada ribuan prosedur yang saling panggil tanpa aturan, sistemnya jadi susah dipahami. Efek buruk lainnya lebih serius: satu prosedur crash, seluruh OS ikut mati. Tidak ada information hiding (penyembunyian informasi) sama sekali karena semua prosedur terlihat oleh semua prosedur.

Meski begitu, tetap ada pola dasarnya. Layanan diminta dengan menaruh parameter di tempat yang disepakati, misalnya di stack, lalu menjalankan instruksi trap yang memindahkan mesin dari user mode ke kernel mode. Kernel mengambil parameter itu, mencari nomor system call-nya di sebuah tabel, dan memanggil prosedur yang ada di slot ke-k. Strukturnya jadi tiga lapis: satu main program, sekumpulan service procedure untuk tiap system call, dan sekumpulan utility procedure yang dipakai bersama.

Bagian yang dimuat belakangan tetap didukung lewat ekstensi yang bisa di-load sesuai kebutuhan, seperti device driver dan file system. Di UNIX namanya shared library, di Windows DLL (Dynamic-Link Library), dan direktori `C:\Windows\system32` saja isinya lebih dari 1000 file .dll. (hal PDF 94-95)

### 2. Layered, contohnya THE

Generalisasi dari model tiga lapis di atas adalah menyusun OS sebagai hierarki layer, tiap layer dibangun di atas layer bawahnya. Sistem pertama yang begini adalah THE, dibuat E. W. Dijkstra dan mahasiswanya di Technische Hogeschool Eindhoven pada 1968, untuk komputer Belanda Electrologica X8 yang memorinya cuma 32K word 27 bit. Ada enam layer:

| Layer | Fungsi |
|---|---|
| 5 | Operator |
| 4 | Program pengguna |
| 3 | Manajemen I/O dan buffering |
| 2 | Komunikasi proses dengan konsol operator |
| 1 | Manajemen memori dan drum |
| 0 | Alokasi prosesor dan multiprogramming |

Layer 0 mengurus perpindahan antarproses saat interrupt atau timer habis, jadi di atasnya semua orang boleh menganggap dirinya proses sekuensial biasa. Layer 1 mengurus memori dan drum 512K word, sehingga proses tidak perlu tahu ia sedang berada di memori utama atau di drum. Layer 2 memberi tiap proses seolah konsol operator sendiri, layer 3 menyembunyikan keanehan perangkat I/O nyata di balik perangkat abstrak.

Versi lanjutan dari ide ini ada di MULTICS, yang memakai cincin konsentris, bukan tumpukan layer. Cincin dalam lebih istimewa daripada cincin luar, dan prosedur di cincin luar yang mau memanggil cincin dalam harus lewat semacam system call yang parameternya diperiksa dulu. Bedanya penting: layering di THE cuma alat bantu desain karena semuanya toh di-link jadi satu executable, sedangkan mekanisme ring di MULTICS benar-benar ada saat runtime dan dipaksakan oleh hardware. Karena dipaksakan hardware, ring bisa dipakai untuk menyusun subsistem pengguna, misalnya program penilai tugas jalan di ring n dan program mahasiswa di ring n+1 supaya nilainya tidak bisa diubah sendiri. (hal PDF 95-96)

### 3. Microkernel dan mechanism versus policy

Pendekatan layered menyisakan pertanyaan: batas kernel dan user ditaruh di mana? Argumen microkernel adalah taruh sesedikit mungkin di kernel mode, sebab bug di kernel langsung menjatuhkan sistem, sedangkan bug di proses user belum tentu fatal. Angkanya cukup mengintimidasi: kepadatan bug untuk sistem industri serius berkisar dua sampai sepuluh bug per seribu baris kode, jadi OS monolithic lima juta baris kemungkinan mengandung 10.000 sampai 50.000 bug kernel. Tanenbaum menyindir bahwa itulah sebabnya komputer diberi tombol reset, sementara TV dan mobil tidak.

Idenya: pecah OS jadi modul-modul kecil, hanya microkernel yang jalan di kernel mode, sisanya jalan sebagai proses user biasa yang lemah wewenangnya. Driver audio yang bermasalah cuma bikin suara kacau, tidak membekukan komputer. MINIX 3 adalah contoh ekstremnya, kernelnya sekitar 12.000 baris C plus 1400 baris assembler, mengurus penjadwalan, interrupt, interprocess communication (komunikasi antarproses) lewat pesan, dan menyediakan sekitar 40 kernel call. Driver clock ikut di kernel karena scheduler berhubungan erat dengannya, driver lain di user mode. Di luar kernel ada tiga lapis proses user mode: driver, server, lalu program pengguna. Driver tidak bisa menyentuh port I/O langsung, ia menyusun struktur berisi nilai yang mau ditulis lalu minta kernel melakukannya, sehingga kernel bisa memeriksa apakah driver itu memang berhak. Satu server yang menarik adalah reincarnation server, tugasnya memeriksa server dan driver lain, dan mengganti yang rusak otomatis tanpa campur tangan pengguna.

Microkernel jarang di desktop umum, kecuali OS X yang berbasis Mach, tapi mendominasi bidang real-time, industri, avionik, dan militer yang menuntut keandalan tinggi. Nama lain yang disebut: Integrity, K42, L4, PikeOS, QNX, Symbian.

Prinsip yang berkerabat dengan kernel minimal adalah memisahkan mechanism dari policy. Contohnya penjadwalan: mechanism, yaitu mencari proses runnable dengan prioritas tertinggi lalu menjalankannya, ditaruh di kernel; policy, yaitu menentukan siapa dapat prioritas berapa, boleh diurus proses user mode. Kernel jadi lebih kecil. (hal PDF 96-99)

### 4. Model Client Server

Variasi kecil dari microkernel: bedakan dua kelas proses, server yang menyediakan layanan dan client yang memakainya. Komunikasinya lewat message passing (pengiriman pesan), client menyusun pesan berisi permintaan, server mengerjakan lalu membalas. Generalisasinya jelas, client dan server tidak harus di mesin yang sama, bisa terhubung lewat jaringan lokal atau WAN. Client tidak perlu tahu pesannya diproses di mesinnya sendiri atau dikirim ke mesin lain, yang ia lihat cuma permintaan keluar dan jawaban masuk. Web berjalan persis seperti ini. (hal PDF 99)

### 5. Virtual Machine

Asal usulnya dari OS/360 yang murni batch. Banyak pengguna ingin bekerja interaktif, dan sistem timesharing resmi IBM yaitu TSS/360 terlambat, besar, dan lambat, sampai akhirnya ditinggalkan setelah menghabiskan sekitar 50 juta dolar. Kelompok di IBM Cambridge malah membuat CP/CMS yang kemudian jadi VM/370, dan keturunan langsungnya, z/VM, masih dipakai di mainframe zSeries sekarang.

Kuncinya satu pengamatan: sistem timesharing sebenarnya memberi dua hal sekaligus, yaitu multiprogramming dan mesin diperluas yang antarmukanya lebih enak daripada hardware telanjang. VM/370 memisahkan keduanya. Virtual machine monitor jalan di atas hardware asli dan hanya mengurus multiprogramming, lalu menyajikan beberapa virtual machine ke lapisan atas. Virtual machine ini bukan mesin diperluas, melainkan salinan persis hardware asli lengkap dengan kernel/user mode, I/O, dan interrupt. Karena identik dengan mesin asli, tiap virtual machine bisa menjalankan OS apa pun, dan sering kali OS-nya berbeda-beda. Pada VM/370, satu VM bisa menjalankan OS/360 sementara VM lain menjalankan CMS (Conversational Monitor System) untuk pengguna interaktif. System call dari program CMS ditangkap oleh OS di dalam VM itu sendiri, sedangkan instruksi I/O hardware yang dikeluarkan CMS ditangkap VM/370 lalu disimulasikan.

Dunia PC lama mengabaikan virtualisasi karena masalah hardware. Supaya bisa divirtualisasi, CPU harus melempar trap ke monitor saat instruksi privileged dijalankan di user mode (Popek dan Goldberg, 1974). Pentium dan pendahulunya justru mengabaikan instruksi seperti itu, jadi mustahil. Interpreter seperti Bochs bisa jalan tapi lambatnya satu sampai dua orde besaran. Riset Disco di Stanford (1997) dan Xen di Cambridge (2003) mengubah keadaan dan melahirkan produk komersial. Teknik binary translation, yaitu menerjemahkan blok kode saat itu juga lalu menyimpannya di cache untuk dipakai ulang, menghasilkan machine simulator yang jauh lebih cepat, tapi masih kurang untuk pemakaian komersial. Langkah berikutnya adalah menambahkan kernel module untuk pekerjaan berat, dan semua hypervisor komersial sekarang memakai strategi hibrida ini.

Bedanya tipe 1 dan tipe 2 sederhana saja: hypervisor tipe 2 menumpang host operating system beserta file system-nya untuk membuat proses dan menyimpan berkas, sehingga virtual disk-nya cuma satu file besar di host. Hypervisor tipe 1 tidak punya tumpuan apa-apa dan harus mengurus semuanya sendiri, termasuk mengelola partisi disk mentah. Tanenbaum sendiri sebenarnya keberatan dengan istilah tipe 2 karena bagian dari sistem itu jalan di kernel, ia lebih suka menyebutnya "type 1.7 hypervisor". Hypervisor populer yang disebut: VMware Workstation, Xen, KVM, VirtualBox, Hyper-V.

Pendekatan lain adalah paravirtualization, yaitu memodifikasi guest OS supaya instruksi bermasalahnya dibuang. Ini bukan virtualisasi sejati karena guest-nya sadar sedang divirtualisasi dan harus diubah, tapi hasilnya lebih cepat.

JVM (Java Virtual Machine) memakai ide virtual machine dengan cara berbeda. Compiler Java menghasilkan kode untuk arsitektur JVM, bukan untuk SPARC atau x86, dan kode itu dijalankan interpreter. Untungnya dua: kode bisa dikirim lewat Internet ke komputer mana pun yang punya interpreter JVM, dan kalau interpreternya dibuat benar, program yang masuk bisa diperiksa keamanannya dulu lalu dijalankan di lingkungan terlindungi.

Catatan tambahan di luar buku: container seperti Docker dan LXC tidak dibahas di subbab ini pada edisi 4. Posisinya kira-kira di antara virtual machine dan proses biasa, karena container berbagi satu kernel host dan hanya mengisolasi namespace serta membatasi resource, jadi tidak ada guest OS penuh. Konsekuensinya container jauh lebih ringan daripada VM tapi isolasinya lebih lemah, sebab bug kernel host langsung mengenai semua container. (hal PDF 100-103)

### 6. Exokernel

Kalau virtual machine menggandakan mesin, exokernel membaginya. Tiap pengguna diberi sebagian sumber daya nyata, misalnya VM pertama dapat blok disk 0 sampai 1023, VM kedua dapat 1024 sampai 2047. Program di kernel mode yang bernama exokernel (Engler dkk., 1995) hanya bertugas mengalokasikan sumber daya lalu memeriksa supaya tidak ada mesin yang menyentuh jatah tetangganya. Tiap virtual machine di user level tetap boleh menjalankan OS-nya sendiri.

Keuntungannya adalah menghemat satu lapisan pemetaan. Pada rancangan lain, tiap VM merasa punya disk sendiri dengan blok mulai dari 0, jadi monitor harus menyimpan tabel untuk menerjemahkan alamat disk dan semua sumber daya lain. Exokernel tidak perlu itu, ia cukup mencatat sumber daya mana milik VM mana. Pemisahan multiprogramming dari kode OS pengguna tetap didapat, tapi overhead-nya lebih kecil. (hal PDF 104)

### Tabel Perbandingan

| Arsitektur | Yang jalan di kernel mode | Kelebihan | Kekurangan | Contoh |
|---|---|---|---|---|
| Monolithic | Seluruh OS | Panggilan antarkomponen cepat, tidak ada overhead batas | Satu bug menjatuhkan seluruh sistem, tanpa information hiding, sulit dipahami | Linux, UNIX klasik, Windows |
| Layered | Semua layer (pada THE) | Rancangan rapi, tiap layer menyembunyikan detail layer bawah | Pada THE cuma alat bantu desain, tidak dipaksakan saat runtime | THE (Dijkstra, 1968) |
| Layered dengan ring | Cincin dalam | Proteksi dipaksakan hardware, bisa dipakai menyusun subsistem pengguna | Setiap panggilan lintas cincin harus diperiksa, ada biayanya | MULTICS |
| Microkernel | Kernel kecil saja (IPC, penjadwalan, interrupt) | Andal, driver rusak tidak mematikan sistem, bisa sembuh sendiri | Overhead message passing, jarang dipakai di desktop | MINIX 3, L4, QNX, Integrity |
| Client server | Umumnya microkernel, tapi tidak wajib | Bisa dipakai di satu mesin maupun jaringan, client tidak peduli lokasi server | Bergantung pada latensi pesan dan kesehatan jaringan | Web, sistem terdistribusi |
| Virtual machine | Hypervisor tipe 1, atau host OS untuk tipe 2 | Beberapa OS di satu mesin fisik, isolasi kuat, hemat biaya hosting | Butuh CPU yang virtualizable, ada lapisan pemetaan sumber daya | VM/370, z/VM, VMware, Xen, KVM |
| Exokernel | Exokernel (alokasi dan pemeriksaan izin) | Tidak perlu remapping sumber daya, overhead paling kecil | Sumber daya dibagi kaku, OS pengguna harus mengurus banyak hal sendiri | Exokernel MIT (Engler dkk., 1995) |

## 1.8-1.12 Dunia Menurut C, Riset OS, dan Penutup Bab

### 1.8 Dunia Menurut C (hal PDF 104-108)

Sistem operasi biasanya program C berukuran besar, kadang C++, yang digarap banyak programmer sekaligus. C, Java, dan Python sama-sama bahasa imperatif dengan tipe data dan statement kontrol yang mirip. Bedanya, C punya pointer eksplisit, yaitu variabel yang berisi alamat variabel lain. Pada contoh buku, `p = &c1` menyimpan alamat `c1` ke `p`, lalu `c2 = *p` menyalin isi yang ditunjuk `p`. Pointer secara teori bertipe, tapi compiler sering tetap menerima penugasan lintas tipe dengan sekadar warning, jadi ini sumber bug yang subur.

C tidak punya string bawaan, thread, class, object, type safety, maupun garbage collection (pembersih memori otomatis). Yang terakhir disebut Tanenbaum sebagai "show stopper" untuk OS. Semua memori dialokasikan dan dilepas sendiri lewat `malloc` dan `free`, dan kendali penuh itulah alasan C dipakai: OS sedikit banyak bersifat real time, sebab saat interrupt (sela) datang kadang cuma tersedia beberapa mikrodetik sebelum informasi hilang. Garbage collector yang jalan di waktu acak jelas tidak bisa ditoleransi.

**Header file.** Proyek OS berisi banyak berkas `.c` plus header `.h` yang memuat deklarasi bersama. Header bisa menampung makro penamaan konstanta (`#define BUFFER_SIZE 4096`), makro berparameter seperti `max(a, b)`, dan compilation bersyarat (`#ifdef X86`) yang dipakai untuk mengurung kode spesifik arsitektur.

**Kompilasi proyek besar.** Tiap `.c` dikompilasi jadi object file `.o` berisi instruksi biner mesin target, tanpa byte code seperti Java. Pass pertama compiler adalah C preprocessor yang mengembangkan `#include` dan makro. Karena OS bisa mencapai lima juta baris, mengompilasi ulang semuanya tiap ada perubahan tidak masuk akal. Di UNIX pelacakan ketergantungan diserahkan ke `make`, yang membaca Makefile dan hanya mengompilasi ulang object file yang sumbernya sudah berubah. Semua `.o` lalu digabung linker (penaut) bersama pustaka seperti `libc.a` menjadi satu binary siap jalan, secara tradisi bernama `a.out` (Gambar 1-30).

**Model run time.** Setelah di-link dan mesin di-boot ulang, OS masih bisa memuat bagian yang tidak ikut statis seperti device driver dan file system. Memorinya terbagi jadi segmen:

| Segmen | Sifat | Letak umum |
|---|---|---|
| text | kode program, tidak berubah saat eksekusi | dekat dasar memori |
| data | punya ukuran dan nilai awal, bisa tumbuh | di atas text, tumbuh ke atas |
| stack | mula-mula kosong, naik turun mengikuti pemanggilan fungsi | alamat virtual tinggi, tumbuh ke bawah |

Layout persisnya berbeda antar sistem. Yang pasti, kode OS dieksekusi langsung oleh perangkat keras, tanpa interpreter dan tanpa just in time compilation.

### 1.9 Riset Sistem Operasi (hal PDF 108-109)

Jarak dari ide ke dampak nyata sering 20 sampai 30 tahun. ARPA dibentuk Eisenhower tahun 1958 untuk merapikan rebutan anggaran riset Pentagon, bukan untuk menciptakan Internet, tapi pendanaannya ke riset packet switching melahirkan ARPANET pada 1969. Pola serupa terjadi di OS: timesharing serba guna lahir di M.I.T. awal 1960-an, mouse dan GUI dari Doug Engelbart di SRI akhir 1960-an. Riset masa kini menyasar keluhan yang sama, yaitu OS sekarang besar, kaku, tidak andal, dan penuh bug: debugging, crash recovery, manajemen energi, storage, I/O cepat, OS multicore, keamanan, dan virtualisasi. Catatan untuk mencari literatur, di ilmu komputer risetnya kebanyakan terbit di konferensi, bukan jurnal, terutama ACM, IEEE Computer Society, dan USENIX.

### 1.10 Peta Isi Buku (hal PDF 109-110)

Bab 2 process dan thread, bab 3 address space dan virtual memory, bab 4 file system, bab 5 I/O, bab 6 deadlock. Lalu topik lanjutan: bab 7 virtualisasi dan cloud, bab 8 multiprosesor dan sistem terdistribusi, bab 9 keamanan. Penutupnya studi kasus UNIX, Linux, dan Android (bab 10), Windows 8 (bab 11), dan prinsip desain OS (bab 12).

### 1.11 Satuan Metrik (hal PDF 110-111)

Awalan metrik dipakai dari milli (10^-3) sampai yocto (10^-24) dan Kilo (10^3) sampai Yotta (10^24). Karena milli dan micro sama-sama huruf m, dipakai "m" untuk milli dan mu untuk micro. Jebakannya ada di ukuran memori: industri memakai kilo berarti 2^10 = 1024 karena kapasitas memori selalu pangkat dua, jadi 1 MB memori itu 2^20 byte. Sebaliknya kecepatan jalur komunikasi tidak berpangkat dua, sehingga 10 Mbps benar-benar 10.000.000 bit per detik. Konvensi buku: KB, MB, GB untuk pangkat dua, Kbps, Mbps, Gbps untuk pangkat sepuluh.

### 1.12 Ringkasan Bab 1 (hal PDF 111-112)

- Dua sudut pandang OS: resource manager yang mengatur sumber daya secara efisien, dan extended machine yang menyajikan abstraksi lebih enak dipakai daripada mesin telanjang, yaitu process, address space, dan file.
- Sejarahnya bergerak dari OS yang menggantikan operator manusia, lewat batch system dan multiprogramming, sampai komputer pribadi.
- Konsep dasar semua OS: process, manajemen memori, manajemen I/O, file system, dan keamanan.
- Inti OS adalah kumpulan system call yang ditanganinya. Untuk UNIX ada empat kelompok: pembuatan dan pengakhiran process, baca tulis file, manajemen direktori, dan kelompok lain-lain.
- Struktur OS yang umum: monolitik, berlapis, microkernel, client server, virtual machine, dan exokernel.

---

## Istilah Kunci

| Istilah | Arti |
|---|---|
| `abstraction` | Objek buatan OS seperti file atau process yang menggantikan detail hardware, sehingga masalah besar pecah jadi dua bagian yang bisa dikerjakan |
| `address space` | Himpunan alamat memori dari 0 sampai batas tertentu yang boleh diakses sebuah process |
| `batch system` | Cara kerja generasi kedua yang mengumpulkan banyak job ke satu magnetic tape lalu menjalankannya berurutan tanpa campur tangan operator per job |
| `C preprocessor` | Pass pertama compiler yang memproses #include dan mengembangkan makro sebelum kode diteruskan ke tahap kompilasi berikutnya |
| `Cache hit` | Kondisi saat cache line yang dibutuhkan sudah ada di cache sehingga permintaan selesai sekitar dua clock cycle |
| `Client-server model` | Pembagian proses jadi server penyedia layanan dan client pemakainya yang berkomunikasi lewat pesan, berlaku baik di satu mesin maupun lintas jaringan |
| `computer utility` | Gagasan MULTICS yang menjual daya komputasi seperti listrik, tinggal menyambung sesuai kebutuhan, dan hidup lagi hari ini sebagai cloud computing |
| `control card` | Kartu perintah seperti $JOB, $RUN, dan $END yang memberi tahu OS apa yang harus dilakukan pada sebuah job, cikal bakal shell dan command-line interpreter |
| `disk driver` | Perangkat lunak yang bicara langsung ke hardware disk dan menyediakan operasi baca tulis blok tanpa membeberkan detail SATA |
| `distributed operating system` | OS yang tampak seperti satu sistem uniprocessor bagi penggunanya padahal berjalan di banyak prosesor, dengan lokasi program dan file diurus otomatis |
| `DMA (Direct Memory Access)` | Chip yang memindahkan data antara memory dan controller tanpa CPU ikut mengatur tiap byte |
| `Embedded system` | Komputer yang menempel di dalam perangkat non-komputer dan tidak menerima software pasangan pengguna karena semuanya sudah ada di ROM |
| `Exokernel` | Kernel yang membagi sumber daya nyata ke tiap virtual machine dan hanya memeriksa hak pakainya, sehingga tidak perlu lapisan pemetaan alamat |
| `extended machine` | Sudut pandang top-down yang melihat OS sebagai lapisan yang menyembunyikan hardware kasar di balik antarmuka yang rapi dan konsisten |
| `file descriptor` | Bilangan bulat kecil yang dikembalikan saat file berhasil dibuka dan dipakai untuk operasi baca tulis berikutnya |
| `fork` | Satu-satunya cara membuat process baru di POSIX, hasilnya duplikat persis parent dengan nilai balik 0 di child dan PID child di parent |
| `garbage collection` | Pembersihan memori otomatis yang sengaja tidak ada di C karena bisa jalan di waktu acak dan mengganggu penanganan interrupt |
| `Hard real-time` | Sistem yang harus menjamin secara mutlak bahwa aksi terjadi pada waktu tertentu, karena telat berarti gagal total |
| `header file` | Berkas .h berisi deklarasi, makro, dan compilation bersyarat yang dipakai bersama oleh banyak berkas .c |
| `Hypervisor tipe 1 dan tipe 2` | Tipe 1 jalan langsung di atas hardware dan mengurus penyimpanannya sendiri, tipe 2 menumpang host OS beserta file system-nya |
| `i-number dan i-node` | Nomor unik tiap berkas UNIX beserta entri tabel yang menyimpan pemilik, lokasi blok disk, dan jumlah entri direktori yang menunjuknya |
| `Interrupt vector` | Bagian memory berisi alamat interrupt handler, diindeks memakai nomor device yang menginterupsi |
| `Java Virtual Machine (JVM)` | Interpreter yang ditanam di ROM smart card untuk menjalankan applet Java yang diunduh ke kartu |
| `kernel mode` | Mode eksekusi istimewa dengan akses penuh ke seluruh hardware, lawannya user space tempat program biasa berjalan |
| `Layered system` | OS yang disusun sebagai hierarki layer, tiap layer memakai layanan layer di bawahnya dan menyembunyikan detailnya, seperti enam layer THE |
| `Library call` | Pemanggilan prosedur pustaka yang mungkin selesai di user space tanpa masuk kernel, misalnya malloc |
| `linker` | Program yang menggabungkan semua object file dan pustaka jadi satu binary siap eksekusi, tradisinya bernama a.out |
| `make dan Makefile` | Program dan berkas ketergantungan di UNIX yang membatasi kompilasi ulang hanya pada berkas yang benar-benar berubah |
| `Mechanism versus policy` | Prinsip menaruh cara melakukan sesuatu di kernel dan keputusan tentang nilainya di user space, misalnya kernel menjalankan proses berprioritas tertinggi tapi prioritasnya ditentukan proses user |
| `Microkernel` | Kernel minimal yang hanya mengurus interrupt, penjadwalan, dan komunikasi antarproses, sementara driver dan file system jalan sebagai proses user |
| `MMU (Memory Management Unit)` | Bagian CPU yang memetakan alamat yang dihasilkan program ke alamat fisik RAM |
| `Monolithic system` | Rancangan OS yang seluruh isinya dikompilasi jadi satu binary dan jalan di kernel mode, sehingga cepat tapi satu bug bisa menjatuhkan semuanya |
| `mounting` | Menempelkan sistem berkas terpisah, misalnya dari CD-ROM atau USB, ke sebuah direktori dalam pohon berkas utama |
| `multiprogramming` | Membagi memori jadi beberapa partisi berisi job berbeda supaya CPU bisa dipakai job lain saat satu job menunggu I/O |
| `pipe` | Pseudofile penyambung dua process, ditulis dan dibaca seolah file output dan file input biasa |
| `Pipeline` | Pemisahan unit fetch, decode, dan execute supaya beberapa instruksi diproses bersamaan di tahap berbeda |
| `pointer` | Variabel yang menyimpan alamat variabel atau struktur data lain, fitur C yang tidak ada di Java dan Python |
| `POSIX` | Standar IEEE berisi antarmuka system call minimal yang harus didukung sistem UNIX agar program bisa dipindah antar varian |
| `process` | Program yang sedang dijalankan beserta seluruh informasi yang dibutuhkan untuk menjalankannya |
| `process table` | Tabel sistem operasi berisi satu entri per process, menyimpan register dan status yang dipakai untuk melanjutkan process yang dihentikan |
| `PSW (Program Status Word)` | Register yang menyimpan condition code, prioritas CPU, dan bit mode user atau kernel |
| `resource manager` | Sudut pandang bottom-up yang melihat OS sebagai pengalokasi CPU, memori, dan perangkat I/O ke program yang bersaing memakainya |
| `Ring (MULTICS)` | Cincin proteksi konsentris tempat cincin dalam lebih istimewa daripada cincin luar, dan batasnya dipaksakan hardware saat runtime |
| `Sensor node` | Komputer mungil bertenaga baterai dengan radio dan sensor lingkungan yang menjalankan OS kecil bergaya event driven |
| `Soft real-time` | Sistem yang masih bisa menerima deadline terlewat sesekali tanpa menimbulkan kerusakan permanen |
| `space multiplexing` | Pembagian sumber daya dengan cara memotongnya, misalnya memori utama atau ruang disk dibagi ke beberapa pemakai sekaligus |
| `spooling` | Singkatan Simultaneous Peripheral Operation On Line, yaitu membaca job dari kartu ke disk lebih dulu agar OS bisa langsung memuat job berikutnya begitu ada partisi kosong |
| `stack segment` | Segmen memori yang mula-mula kosong lalu membesar dan mengecil mengikuti pemanggilan dan pengembalian fungsi |
| `Superscalar` | Desain CPU dengan banyak execution unit yang mengambil instruksi dari holding buffer sehingga eksekusi bisa out of order |
| `System call` | Permintaan layanan dari program pengguna ke kernel yang dijalankan lewat instruksi trap, bukan lewat procedure call biasa |
| `text segment` | Segmen memori berisi kode program yang normalnya tidak berubah selama eksekusi |
| `time multiplexing` | Pembagian sumber daya dengan cara bergiliran, misalnya CPU dipakai satu program lalu berpindah ke program lain |
| `timesharing` | Varian multiprogramming dengan setiap pengguna memegang terminal online sehingga CPU digilir ke pengguna yang benar-benar sedang minta layanan |
| `Transaction processing` | Model pemrosesan yang menangani sangat banyak permintaan kecil per detik, seperti pemrosesan cek bank atau reservasi pesawat |
| `TRAP` | Instruksi yang memindahkan mode ke kernel dan melompat ke alamat tetap di kernel, tidak bisa menuju alamat sembarang seperti procedure call |
| `User mode dan kernel mode` | Dua tingkat hak eksekusi CPU, program biasa berjalan di user mode dan hanya kode kernel yang boleh berjalan di kernel mode |
| `user space` | Wilayah eksekusi tanpa hak istimewa tempat program aplikasi, dan pada sebagian sistem juga layanan OS seperti file system, dijalankan |
| `virtual memory` | Teknik menaruh sebagian address space di memori utama dan sebagian di disk sehingga program bisa lebih besar dari memori fisik |
| `Win32 API` | Kumpulan ribuan prosedur Windows yang sengaja dipisahkan dari system call sebenarnya supaya implementasi kernel bisa berubah antarrilis |
| `working directory` | Direktori acuan tiap process untuk mengartikan path yang tidak diawali garis miring |
