#!/bin/bash
# =========================================================
#  Mo khoa Outlook tren macOS (sua /etc/hosts + flush DNS)
#  Double-click de chay. Se hoi mat khau may (sudo).
# =========================================================

HOSTS="/etc/hosts"
IP="40.100.4.200"
MARKER="# Outlook-unblock"
DOMAINS="outlook.live.com outlook.com www.outlook.com outlook.office.com outlook.office365.com outlook.cloud.microsoft substrate.office.com attachments.office.net"

echo "============================================"
echo "   Mo khoa Outlook (macOS)"
echo "============================================"
echo

if grep -q "$MARKER" "$HOSTS" 2>/dev/null; then
    echo "[i] Entry Outlook da ton tai trong /etc/hosts - bo qua them moi."
else
    echo "Can quyen quan tri de sua /etc/hosts."
    echo "Vui long nhap mat khau may (khi go se khong hien ky tu):"
    {
        echo
        echo "$MARKER"
        for d in $DOMAINS; do echo "$IP $d"; done
    } | sudo tee -a "$HOSTS" >/dev/null
    echo "[+] Da them entry Outlook vao /etc/hosts."
fi

echo
echo "Dang xoa cache DNS..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder 2>/dev/null || true
echo "[+] Xong."

echo
echo "============================================"
echo "   HOAN TAT! Dong het trinh duyet va mo lai,"
echo "   roi truy cap https://outlook.live.com"
echo "============================================"
echo
read -n 1 -s -r -p "Nhan phim bat ky de dong..."
echo
