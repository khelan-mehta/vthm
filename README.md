# vthm

ESG / sustainability dashboard. **The source is encrypted** (AES-256-CBC, PBKDF2 with 600,000 iterations) in `dashboard.tar.gz.enc`. You need the key from your handover document to open it.

## Decrypt

You need `openssl` (3.x) and `tar`. macOS and Linux have both. On Windows, use **Git Bash** (it ships with Git for Windows and includes both).

1. Clone the repo and save the 64-character key from your handover document into a file named `dashboard.key` in the repo root. The file is git-ignored, so don't commit it.

   ```bash
   git clone https://github.com/khelan-mehta/vthm.git
   cd vthm
   printf '%s' 'PASTE-KEY-HERE' > dashboard.key
   ```

2. Decrypt:

   ```bash
   ./decrypt.sh            # or: ./decrypt.sh path/to/dashboard.key
   ```

   This is the same as running:

   ```bash
   openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000 -pass file:dashboard.key      -in dashboard.tar.gz.enc | tar -xzf -
   ```

   The source unpacks into `dashboard/`, which is git-ignored. A wrong key fails with `bad decrypt`.

3. Run it. Full instructions are in `dashboard/SETUP.md`.

   ```bash
   cd dashboard
   npm install
   npm run dev
   ```

## Re-encrypt after changes

```bash
./encrypt.sh
git add dashboard.tar.gz.enc && git commit -m "Update dashboard"
```
