/*
 * Tugas P6 Sistem Operasi: Signal
 * Nama  : Ghaisan Khoirul Badruzaman
 * NIM   : 251524048
 * Kelas : 2B
 *
 * Program berjalan terus dan setiap 1 detik mencetak berapa kali signal 1 sampai 5 sudah diterima.
 * Signal dikirim dari terminal lain: cari PID dengan ps -aux, lalu kill -<nomor signal> <PID>.
 *   1 = SIGHUP, 2 = SIGINT, 3 = SIGQUIT, 4 = SIGILL, 5 = SIGTRAP
 * Karena SIGINT (Ctrl+C) dan SIGQUIT (Ctrl+\) ikut ditangkap, program tidak berhenti dengan Ctrl+C.
 * Program dihentikan dengan signal yang tidak ditangkap, misalnya kill -9 <PID> (SIGKILL).
 *
 * Kompilasi : gcc -Wall -o signal Tugas_P6_2B_048.c
 * Jalankan  : ./signal
 */
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

/* nama signal nomor 1 sampai 5 di Linux, indeks 0 tidak dipakai */
static const char *nama_signal[] = {"", "SIGHUP", "SIGINT", "SIGQUIT", "SIGILL", "SIGTRAP"};

/* jumlah signal yang masuk, diubah di dalam handler jadi tipenya volatile sig_atomic_t */
static volatile sig_atomic_t masuk[6];

/*
 * Handler dipanggil kernel setiap ada signal 1 sampai 5 yang masuk.
 * Isinya cuma menambah hitungan, karena printf tidak aman dipanggil di dalam handler.
 * Pesan "Caught signal" dicetak oleh main.
 */
static void handler(int sig)
{
    masuk[sig]++;
}

int main(void)
{
    int dilaporkan[6] = {0};    /* jumlah signal yang sudah dicetak pesannya */
    struct sigaction sa = {0};
    int s;

    /* daftarkan handler yang sama untuk signal 1 sampai 5 */
    sa.sa_handler = handler;
    sigemptyset(&sa.sa_mask);
    for (s = 1; s <= 5; s++)
        sigaction(s, &sa, NULL);

    printf("Program running.\n");
    while (1) {
        /* cetak pesan untuk setiap signal yang masuk sejak putaran sebelumnya */
        for (s = 1; s <= 5; s++)
            while (dilaporkan[s] < masuk[s]) {
                dilaporkan[s]++;
                printf("\nCaught signal %d (%s). %d.\n", s, nama_signal[s], dilaporkan[s]);
            }

        /* jumlah tiap signal dalam format nomor:jumlah */
        printf("Working... 1:%d 2:%d 3:%d 4:%d 5:%d\n",
               dilaporkan[1], dilaporkan[2], dilaporkan[3], dilaporkan[4], dilaporkan[5]);
        fflush(stdout);   /* langsung tampil walau output diarahkan ke file atau pipe */

        /* sleep berhenti lebih cepat kalau ada signal masuk, jadi pesan langsung tampil */
        sleep(1);
    }
    return 0;
}
