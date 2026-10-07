#!/bin/bash
# Nama  : Ghaisan Khoirul Badruzaman
# NIM   : 251524048
# Kelas : 2B-D4
# P5 Shell Script - User Management
# Membuat user dari file teks berformat user:group, memeriksa user dan
# group yang sudah ada, lalu mengatur folder group dan permission-nya.
# Pemakaian: sudo ./buat_user.sh users.txt

DAFTAR="${1:-users.txt}"
BASE=/company
SHARED=$BASE/shared
LOG_USER=users-created.txt
LOG_AKSI=actions.log

if [ "$(id -u)" -ne 0 ]; then
    echo "Script ini harus dijalankan dengan sudo"
    exit 1
fi
if [ ! -f "$DAFTAR" ]; then
    echo "File $DAFTAR tidak ditemukan"
    exit 1
fi

# kedua log dibuat ulang setiap kali script dijalankan
> "$LOG_USER"
> "$LOG_AKSI"

# tampilkan pesan di layar dan catat ke actions.log
pesan() {
    echo "$1"
    echo "$1" >> "$LOG_AKSI"
}

# nama user Linux: huruf kecil, angka, - dan _, diawali huruf atau _
nama_valid() {
    [[ "$1" =~ ^[a-z_][a-z0-9_-]*$ ]]
}

# pastikan group, folder group, dan akses baca ke shared sudah ada
declare -A SUDAH_DICEK
cek_group() {
    local g="$1"
    [ -n "${SUDAH_DICEK[$g]}" ] && return
    SUDAH_DICEK[$g]=1
    if getent group "$g" > /dev/null; then
        pesan "Group $g sudah ada"
    else
        groupadd "$g" && pesan "Group $g berhasil dibuat"
    fi
    if [ -d "$BASE/$g" ]; then
        pesan "Folder $BASE/$g sudah ada"
    else
        mkdir -p "$BASE/$g"
        chown root:"$g" "$BASE/$g"
        chmod 2770 "$BASE/$g"
        pesan "Folder $BASE/$g berhasil dibuat (root:$g, permission 2770)"
    fi
    if ! getfacl -p "$SHARED" 2> /dev/null | grep -q "^group:$g:"; then
        setfacl -m g:"$g":r-x "$SHARED"
        setfacl -d -m g:"$g":r-x "$SHARED"
        pesan "Group $g diberi akses read-only ke $SHARED"
    fi
}

pesan "Membaca daftar user dari $DAFTAR"
while IFS=: read -r user grup || [ -n "$user" ]; do
    grup="${grup%$'\r'}"
    [ -z "$user" ] || [ -z "$grup" ] && continue
    cek_group "$grup"
    # nama sudah dipakai: minta nama lain per baris sampai dapat yang belum ada
    while id "$user" > /dev/null 2>&1; do
        pesan "User $user sudah ada"
        read -r -p "Masukkan nama user lain untuk $user ($grup): " baru < /dev/tty
        if nama_valid "$baru"; then
            pesan "Nama user $user diganti menjadi $baru"
            user="$baru"
        else
            echo "Nama user tidak valid, pakai huruf kecil, angka, - atau _"
        fi
    done
    if useradd -m -s /bin/bash "$user"; then
        pesan "User $user berhasil dibuat dengan home folder /home/$user"
        usermod -aG "$grup" "$user" && pesan "User $user berhasil ditambahkan ke group $grup"
        echo "$user:$grup" >> "$LOG_USER"
    else
        pesan "User $user gagal dibuat"
    fi
done < "$DAFTAR"

pesan "Selesai, $(wc -l < "$LOG_USER") user berhasil dibuat"
