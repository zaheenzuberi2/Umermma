# Setup Guide — Umer Wazir MMA Website + Admin Panel

Three files work together:
- **index.html** — the public website
- **admin.html** — the password-protected panel for managing photos, fight records, and messages
- **supabase-schema.sql** — sets up the database

Total time: about 20–30 minutes, all free.

---

## Step 1 — Create a free Supabase account

1. Go to **https://supabase.com** and sign up (free tier is enough for this site).
2. Click **New Project**. Name it anything (e.g. "umer-wazir-mma").
3. Set a strong database password and save it somewhere safe.
4. Choose a region close to Pakistan (e.g. Singapore) and click **Create**.
5. Wait 1–2 minutes while it sets up.

## Step 2 — Get your API keys

1. In your new project, go to **Project Settings** (gear icon) → **API**.
2. Copy the **Project URL** (looks like `https://xxxxx.supabase.co`).
3. Copy the **anon public** key (a long string).
4. Open **index.html** in a text editor, find this near the bottom:
   ```
   const SUPABASE_URL = 'PASTE_YOUR_SUPABASE_URL_HERE';
   const SUPABASE_ANON_KEY = 'PASTE_YOUR_SUPABASE_ANON_KEY_HERE';
   ```
   Replace both with your real values.
5. Do the **same edit** in **admin.html** (it has an identical block near the bottom of the script).

## Step 3 — Create the database tables

1. In Supabase, go to **SQL Editor** (left sidebar) → **New Query**.
2. Open **supabase-schema.sql** from this folder, copy all of it, paste it into the query box.
3. Click **Run**. You should see "Success. No rows returned."

This creates three tables: `messages`, `gallery_photos`, and `tournaments`, each with proper privacy rules (visitors can only submit messages and view public content; only a logged-in admin can read messages or add/delete photos and records).

## Step 4 — Create a storage bucket for photos

1. In Supabase, go to **Storage** (left sidebar) → **New bucket**.
2. Name it exactly: `gallery`
3. Toggle **Public bucket** to ON (so photos display on the live site).
4. Click **Create bucket**.

## Step 5 — Create your admin login

1. In Supabase, go to **Authentication** → **Users** → **Add user**.
2. Enter an email and password for Zaheen (or whoever will manage the site).
3. Click **Create user**. Do **not** use the public sign-up — only create users this way, so no one else can register.

This email + password is what you'll use to log into `admin.html`.

## Step 6 — Put the site online (GitHub Pages)

1. Create a free GitHub account if you don't have one: **https://github.com**
2. Create a new repository (e.g. `umer-wazir-mma`).
3. Upload all files from this folder (**index.html**, **admin.html**, and this guide — the SQL file doesn't need to be uploaded) using "Add file → Upload files" in the GitHub web interface.
4. Go to the repository's **Settings → Pages**.
5. Under "Source," choose the `main` branch and save.
6. GitHub will give you a live URL like `https://yourusername.github.io/umer-wazir-mma/` within a minute or two.
7. Your admin panel will be at `https://yourusername.github.io/umer-wazir-mma/admin.html` — bookmark this for Zaheen.

## Step 7 — Buy a domain (optional but recommended for "professional")

- A `.com` domain costs roughly $10–15/year (Namecheap, GoDaddy, etc.).
- Once purchased, most registrars let you point it at your GitHub Pages site with a few DNS settings — GitHub's docs walk through this: **https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site**

---

## Using the admin panel day-to-day

Once set up, Zaheen (or you) can:
1. Go to the admin URL and log in with the email/password from Step 5.
2. **Messages tab** — see every sponsor/booking inquiry, mark read, delete spam.
3. **Gallery tab** — upload new fight/training photos with a caption; they appear on the live site automatically.
4. **Tournaments tab** — add new fight results (opponent, country, W/L, event, notes); they're appended to the fight ledger on the site automatically.

No coding needed for any of this after setup.

## If something doesn't work

- **Photos won't upload**: double check the bucket is named exactly `gallery` and is set to Public (Step 4).
- **Can't log in**: the user must be created via Authentication → Users (Step 5), not by trying to "sign up" anywhere — there is no public sign-up on purpose, for security.
- **Site loads but nothing dynamic works**: check that the SUPABASE_URL and SUPABASE_ANON_KEY were pasted correctly into *both* index.html and admin.html.
