-- ─────────────────────────────────────────────────────────────
--  Run this in: Supabase Dashboard → SQL Editor → New Query
--  Drop the old table first if you ran setup.sql previously.
-- ─────────────────────────────────────────────────────────────

drop table if exists survey_responses;

create table survey_responses (
  id           uuid        default gen_random_uuid() primary key,
  submitted_at timestamptz default now(),

  -- Step 1 — Identity
  name         text,
  role         text        not null,
  role_name    text        not null,

  -- Bottleneck score (0–100, calculated client-side on submit)
  score        integer,

  -- Step 2 — Time
  time1        text,
  time2        text,
  ratio        text,

  -- Step 3 — Role-specific (4 open-text answers keyed by question id)
  role_answers jsonb,

  -- Step 4 — Repetition & errors
  rep1         text,
  err1         text,
  err_impact   text,
  rep2         text,

  -- Step 5 — Knowledge & systems
  know1        text,
  know2        text,
  sys1         text,
  doc_level    text,

  -- Step 6 — Wishlist
  wish1        text,
  wish2        text,
  visibility   text,
  extra        text
);

alter table survey_responses enable row level security;

create policy "public_insert"
  on survey_responses for insert
  to anon with check (true);

create policy "public_select"
  on survey_responses for select
  to anon using (true);
