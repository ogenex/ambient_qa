-- ─────────────────────────────────────────────────────────────
--  Run this in: Supabase Dashboard → SQL Editor → New Query
-- ─────────────────────────────────────────────────────────────

create table if not exists survey_responses (
  id           uuid        default gen_random_uuid() primary key,
  submitted_at timestamptz default now(),
  name         text,
  department   text        not null,
  satisfaction integer     not null check (satisfaction between 1 and 5),
  challenge    text        not null,
  suggestion   text
);

-- Allow anyone to INSERT (submit a survey)
alter table survey_responses enable row level security;

create policy "public_insert"
  on survey_responses for insert
  to anon
  with check (true);

-- Allow anyone to SELECT (admin page uses anon key — password-gated in JS)
create policy "public_select"
  on survey_responses for select
  to anon
  using (true);
