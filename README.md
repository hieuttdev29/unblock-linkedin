# unblock-linkedin

Script tự động mở khóa **LinkedIn** trên máy **Windows** khi mạng công ty chặn LinkedIn bằng **DNS sinkhole** (phân giải `linkedin.com` về `127.0.0.1`).

Script thêm IP thật của LinkedIn vào file `hosts` của máy và xóa cache DNS — chạy **một lần**, không cần cài gì thêm. Hỗ trợ **Windows** và **macOS**.

---

## 🪟 Windows — cách dùng (đơn giản nhất)

1. Tải file **`unblock-linkedin.bat`** về máy.
2. **Double-click** vào file.
3. Bấm **Yes** ở cửa sổ *User Account Control (UAC)* — script tự xin quyền Administrator.
4. Chờ thấy dòng **`HOAN TAT!`** → **đóng hết trình duyệt**, mở lại và vào https://www.linkedin.com

> Script **chạy lại nhiều lần không bị trùng** (có kiểm tra entry đã tồn tại chưa).

### Cách chạy bằng CMD (tùy chọn)

Mở **CMD / PowerShell (Run as administrator)** rồi trỏ tới file, ví dụ lưu ở Downloads:

```bat
"%USERPROFILE%\Downloads\unblock-linkedin.bat"
```

---

## 🍎 macOS — cách dùng

1. Tải file **`unblock-linkedin.command`** về máy.
2. Double-click để chạy (mở trong Terminal). Nếu macOS báo *"không mở được vì không xác định nhà phát triển"*: chuột phải vào file → **Open** → **Open**; hoặc cấp quyền chạy bằng Terminal:
   ```bash
   chmod +x ~/Downloads/unblock-linkedin.command
   ```
3. Nhập **mật khẩu máy** khi được hỏi (sudo — gõ sẽ không hiện ký tự, cứ gõ rồi Enter).
4. Chờ thấy dòng **`HOAN TAT!`** → đóng hết trình duyệt, mở lại và vào https://www.linkedin.com

### Cách chạy bằng Terminal (tùy chọn)

```bash
bash ~/Downloads/unblock-linkedin.command
```

> Giống bản Windows, script này cũng **chạy lại nhiều lần không bị trùng**.

---

## 🔧 Script làm gì?

1. Tự nâng quyền **Administrator** (bắt buộc để sửa `hosts`).
2. Thêm vào `C:\Windows\System32\drivers\etc\hosts`:
   ```
   # LinkedIn-unblock
   104.18.41.41 www.linkedin.com
   104.18.41.41 linkedin.com
   104.18.41.41 platform.linkedin.com
   ```
3. Chạy `ipconfig /flushdns` để có hiệu lực ngay.

---

## ⚠️ Lưu ý quan trọng

- **IP có thể đổi:** `104.18.41.41` là IP Cloudflare của LinkedIn, **có thể thay đổi theo thời gian**. Khi đó script hết tác dụng và cần cập nhật IP mới.
  - Lấy IP mới (từ mạng không bị chặn hoặc hỏi DNS công cộng):
    ```bat
    nslookup www.linkedin.com 1.1.1.1
    ```
  - Sửa dòng `set "IP=..."` trong file `.bat` rồi chạy lại.
- **Tầng lọc SNI:** nếu gateway công ty còn chặn theo **SNI (DPI)**, một số máy có thể vẫn bị chập chờn (reset / 403). Trường hợp này `hosts` không xử lý được.
- **Giải pháp bền vững:** đề nghị IT **whitelist `*.linkedin.com`** trên thiết bị gateway (Ruijie) — fix 1 lần cho toàn bộ máy, không cần bảo trì, xử lý cả DNS lẫn SNI.

---

## 🧹 Gỡ bỏ (hoàn tác)

- **Windows:** mở `hosts` bằng Notepad (Run as administrator), xóa khối bắt đầu bằng `# LinkedIn-unblock`, lưu lại, rồi chạy `ipconfig /flushdns`.
- **macOS:** mở Terminal, chạy `sudo nano /etc/hosts`, xóa khối `# LinkedIn-unblock`, lưu (Ctrl+O, Enter, Ctrl+X), rồi chạy `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`.
