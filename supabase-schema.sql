-- ============================================================
-- Muhammad Umer Wazir — Website Database Schema
-- Run this entire file in: Supabase Dashboard > SQL Editor > New Query > Run
-- ============================================================

-- 1) MESSAGES (sponsor / booking inquiries from the contact form)
create table if not exists messages (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  organization text,
  message text not null,
  is_read boolean default false,
  created_at timestamptz default now()
);

alter table messages enable row level security;

-- Anyone on the internet can SUBMIT a message (the contact form)...
create policy "Public can insert messages"
  on messages for insert
  to anon
  with check (true);

-- ...but only a LOGGED-IN admin can read/update/delete them.
create policy "Only admin can read messages"
  on messages for select
  to authenticated
  using (true);

create policy "Only admin can update messages"
  on messages for update
  to authenticated
  using (true);

create policy "Only admin can delete messages"
  on messages for delete
  to authenticated
  using (true);


-- 2) GALLERY PHOTOS
create table if not exists gallery_photos (
  id uuid primary key default gen_random_uuid(),
  image_url text not null,
  caption text,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table gallery_photos enable row level security;

-- Anyone can VIEW gallery photos (it's a public website).
create policy "Public can view gallery"
  on gallery_photos for select
  to anon, authenticated
  using (true);

-- Only a logged-in admin can add/remove photos.
create policy "Only admin can insert gallery"
  on gallery_photos for insert
  to authenticated
  with check (true);

create policy "Only admin can delete gallery"
  on gallery_photos for delete
  to authenticated
  using (true);


-- 3) TOURNAMENTS / FIGHT RECORD
create table if not exists tournaments (
  id uuid primary key default gen_random_uuid(),
  opponent text not null,
  opponent_country text,
  result text default 'W',          -- 'W' or 'L'
  event_name text,
  notes text,
  event_date date,
  created_at timestamptz default now()
);

alter table tournaments enable row level security;

create policy "Public can view tournaments"
  on tournaments for select
  to anon, authenticated
  using (true);

create policy "Only admin can insert tournaments"
  on tournaments for insert
  to authenticated
  with check (true);

create policy "Only admin can delete tournaments"
  on tournaments for delete
  to authenticated
  using (true);

-- ============================================================
-- After running this, go to Storage (left sidebar) and create
-- a new PUBLIC bucket named exactly:  gallery
-- (Instructions in SETUP-GUIDE.md, Step 4)
-- ============================================================
