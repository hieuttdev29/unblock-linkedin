#!/bin/bash
# =========================================================
#  Mo khoa LinkedIn tren macOS (sua /etc/hosts + flush DNS)
#  Double-click de chay. Se hoi mat khau may (sudo).
# =========================================================

HOSTS="/etc/hosts"
IP="104.18.41.41"
MARKER="# LinkedIn-unblock"

echo "============================================"
echo "   Mo khoa LinkedIn (macOS)"
echo "============================================"
echo

if grep -q "$MARKER" "$HOSTS" 2>/dev/null; then
    echo "[i] Entry LinkedIn da ton tai trong /etc/hosts - bo qua them moi."
else
    echo "Can quyen quan tri de sua /etc/hosts."
    echo "Vui long nhap mat khau may (khi go se khong hien ky tu):"
    sudo bash -c "cat >> '$HOSTS'" <<EOF

$MARKER
$IP www.linkedin.com
$IP linkedin.com
$IP platform.linkedin.com
EOF
    echo "[+] Da them entry LinkedIn vao /etc/hosts."
fi

echo
echo "Dang xoa cache DNS..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder 2>/dev/null || true
echo "[+] Xong."

echo
echo "============================================"
echo "   HOAN TAT! Dong het trinh duyet va mo lai,"
echo "   roi truy cap https://www.linkedin.com"
echo "============================================"
echo
read -n 1 -s -r -p "Nhan phim bat ky de dong..."
echo
