-- Run this in your Supabase project's SQL Editor (one time setup).
-- It creates the table that stores each practice session's accuracy,
-- and locks it down so users can only ever see or write their own rows.

create table if not exists practice_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  instrument text not null,
  avg_cents_error numeric not null,
  accuracy numeric not null,
  duration_seconds numeric not null,
  created_at timestamptz not null default now()
);

alter table practice_sessions enable row level security;

create policy "Users can insert their own sessions"
  on practice_sessions for insert
  with check (auth.uid() = user_id);

create policy "Users can view their own sessions"
  on practice_sessions for select
  using (auth.uid() = user_id);
