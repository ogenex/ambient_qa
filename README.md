# Team Workflow Survey

A 6-step operational bottleneck survey with a Supabase backend, hosted on GitHub Pages.
Includes a password-protected admin dashboard with charts and an AI analysis feature.

---

## Files

| File | Purpose |
|---|---|
| `index.html` | The 6-step survey form for your team |
| `admin.html` | Password-protected results dashboard with charts + AI analysis |
| `config.js` | Your Supabase credentials and admin password |
| `setup.sql` | Run once in Supabase to create the database table |

---

## Survey structure

| Step | Topic | Questions |
|---|---|---|
| 1 | About you | Name (optional) + Role selection (9 roles) |
| 2 | Where time goes | 2 open text + overhead ratio (radio) |
| 3 | Role in depth | 4 role-specific open-text questions |
| 4 | Repetition & errors | 2 open text + error impact (radio) + 1 optional |
| 5 | Knowledge & systems | 3 open text + documentation level (radio) |
| 6 | Wishlist | 2 open text + visibility confidence (radio) + 1 optional |

Each submission is automatically scored 0–100 as a bottleneck priority indicator.

---

## Setup — 3 steps

### Step 1 — Create the Supabase table

1. Go to [supabase.com](https://supabase.com) and create a free project
2. Open **SQL Editor → New Query**
3. Paste the contents of `setup.sql` and click **Run**

> If you previously ran the old `setup.sql`, the new one drops and recreates the table with the updated schema.

### Step 2 — Fill in config.js

```js
const CONFIG = {
  supabaseUrl:     'https://xxxx.supabase.co',
  supabaseAnonKey: 'eyJhbGci...',
  adminPassword:   'change-this-password',
};
```

Find your URL and anon key in: **Supabase → Project Settings → API**

### Step 3 — Deploy to GitHub Pages

```bash
git init
git add .
git commit -m "Team survey"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

Then go to **Settings → Pages → Source: Deploy from branch: main / (root)**.

---

## Sharing

- **Survey link:** `https://yourusername.github.io/your-repo/`
- **Admin link:** `https://yourusername.github.io/your-repo/admin.html`

---

## Admin dashboard features

- **Stats:** total responses, average score, high-priority count, undocumented process count
- **Charts:** role distribution (bar), score distribution (bar), overhead ratio, error impact, documentation level, visibility confidence (all inline bar charts)
- **Response table:** name, role, score, priority badge, key fields, time drain preview, submitted timestamp
- **CSV export:** all 20+ fields in one download
- **AI analysis:** paste your Anthropic API key (get it at console.anthropic.com) to generate a full bottleneck report with skill candidates — the key is never stored

---

## Security notes

- The Supabase anon key is intentionally in `config.js`. It is limited by the Row Level Security policies in `setup.sql` (anonymous insert and read only). For a production deployment, restrict the select policy to authenticated users.
- The Anthropic API key for the AI analysis is entered live in the admin page — it is never saved to disk or sent anywhere except the Anthropic API.
- Change `adminPassword` before deploying.
