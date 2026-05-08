# Team Pulse Survey

A lightweight team survey with a Supabase backend and admin results dashboard, hosted on GitHub Pages.

---

## Files

| File | Purpose |
|---|---|
| `index.html` | The survey form your team fills out |
| `admin.html` | Password-protected results dashboard |
| `config.js` | Your Supabase credentials + admin password |
| `setup.sql` | Run once in Supabase to create the database table |

---

## Setup — 3 steps

### Step 1 — Create the Supabase database

1. Go to [supabase.com](https://supabase.com) and create a free project
2. Open **SQL Editor → New Query**
3. Paste the contents of `setup.sql` and click **Run**

### Step 2 — Add your credentials to config.js

1. In Supabase, go to **Project Settings → API**
2. Copy your **Project URL** and **anon public** key
3. Open `config.js` and fill them in:

```js
const CONFIG = {
  supabaseUrl:     'https://xxxx.supabase.co',
  supabaseAnonKey: 'eyJhbGci...',
  adminPassword:   'change-this-password',  // ← pick something private
};
```

### Step 3 — Deploy to GitHub Pages

1. Create a new GitHub repository (can be private)
2. Push all four files to the `main` branch:
   ```bash
   git init
   git add .
   git commit -m "Initial survey"
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```
3. Go to **Settings → Pages → Source** and set to `Deploy from branch: main / (root)`
4. GitHub will give you a URL like `https://yourusername.github.io/your-repo/`

---

## Sharing the survey

- **Survey link:** `https://yourusername.github.io/your-repo/`
- **Admin link:** `https://yourusername.github.io/your-repo/admin.html`

Send the main link to team members. Keep the admin link to yourself.

---

## Customising the survey questions

Open `index.html` and find the `QUESTIONS` array near the top of the `<script>` block.

Each question looks like this:

```js
{
  id: 'satisfaction',   // must match a column in your Supabase table
  type: 'scale',        // text | textarea | select | scale | options
  text: 'How satisfied are you with team communication?',
  hint: '1 = very dissatisfied, 5 = very satisfied.',
  min: 'Very dissatisfied',
  max: 'Very satisfied',
},
```

If you add or rename questions, also update `setup.sql` to add the matching column.

---

## Security notes

- The Supabase **anon key** is safe to include in public JS — it is restricted by the Row Level Security policies in `setup.sql` (insert-only for the public; select requires the same key but is password-gated in the admin UI).
- For a production deployment, restrict the `public_select` policy to authenticated users only and use Supabase Auth on the admin page.
- Change `adminPassword` in `config.js` before deploying.
