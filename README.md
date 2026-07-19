# SlideTune Pro — Multi-Instrument Tuner with Accounts

A tuner for Voice, Trombone, Trumpet, French Horn, Tuba, Clarinet, Bass
Clarinet, Flute, Alto/Tenor/Bari Sax, and Bassoon — with free accounts that
save your intonation accuracy after every practice session, and a History
page to review it.

The tuner itself is a static page (same as before), but accounts + history
need a backend to store data safely. This uses **Supabase** (free tier) —
it gives you a login system and a database with no server code to write or
host yourself.

## One-time setup (about 5 minutes)

### 1. Create a Supabase project
Go to [supabase.com](https://supabase.com) → sign up (free) → **New
project**. Pick any name and password for the database (you won't need that
password day-to-day). Wait ~1 minute for it to finish provisioning.

### 2. Create the sessions table
In your new project, open the **SQL Editor** (left sidebar) → **New query**.
Paste in the entire contents of `schema.sql` (included in this package) and
click **Run**. This creates the table that stores practice sessions, and
locks it so each user can only ever see their own data.

### 3. Get your API keys
Go to **Project Settings → API**. You'll need two values:
- **Project URL** (looks like `https://xxxxxxxxxxxx.supabase.co`)
- **anon public** key (a long string starting with `eyJ...`)

Both of these are safe to put in a public webpage — they only allow the
access your row-level-security rules permit, which is "your own rows only."

### 4. Paste them into index.html
Open `index.html` in a text editor, find this near the top of the
`<script>` section:
```js
const SUPABASE_URL = "YOUR_SUPABASE_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
```
Replace the two placeholder strings with your actual Project URL and anon
key, save the file.

### 5. (Optional) Skip email confirmation for easier testing
By default Supabase makes new users click a confirmation link in their email
before they can log in. To skip that while you're testing: in Supabase, go
to **Authentication → Providers → Email** and turn off **Confirm email**.
You can turn it back on later if you want it for real users.

## Deploying to Render

Same as before — this is still a static site:

1. Push `index.html` and `render.yaml` to your GitHub repo (they can replace
   the old ones, or use a new repo — up to you).
2. On [dashboard.render.com](https://dashboard.render.com): **New → Static
   Site** → connect the repo.
3. Render reads `render.yaml` automatically. Click **Deploy Static Site**.

## What gets saved, and when

After you tap **Stop Tuning**, if you produced at least ~15 readable pitch
samples during that session, it saves one row: which instrument, your
average cents error, an accuracy percentage (100 − avg error, roughly), and
how many seconds you were actively producing a detectable pitch. Silence and
idle mic time aren't counted. You'll see a small "Session saved" note appear,
and it shows up immediately on the History page.

## Files

- `index.html` — the whole app
- `schema.sql` — run once in Supabase's SQL Editor to create the database table
- `render.yaml` — Render Blueprint config
- `README.md` — this file
