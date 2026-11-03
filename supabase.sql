-- Cartera: tablas y reglas de seguridad.
-- Pégalo en Supabase → SQL Editor → New query y pulsa Run. Se puede ejecutar más de una vez.

create table if not exists public.gastos (
  id        text primary key,
  user_id   uuid not null default auth.uid() references auth.users (id) on delete cascade,
  cents     integer not null check (cents > 0),
  concepto  text not null,
  cat       text not null,
  fecha     date not null,
  metodo    text not null default 'tarjeta',
  nota      text not null default '',
  ia        boolean not null default false,
  creado    timestamptz not null default now()
);
create index if not exists gastos_user_fecha on public.gastos (user_id, fecha desc);

create table if not exists public.ajustes (
  user_id      uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  presupuesto  integer not null default 0,
  presupuestos jsonb not null default '{}'::jsonb,
  aprendido    jsonb not null default '{}'::jsonb
);

-- Cada persona solo ve y cambia lo suyo
alter table public.gastos  enable row level security;
alter table public.ajustes enable row level security;

drop policy if exists "gastos propios"  on public.gastos;
drop policy if exists "ajustes propios" on public.ajustes;
create policy "gastos propios"  on public.gastos  for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "ajustes propios" on public.ajustes for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
