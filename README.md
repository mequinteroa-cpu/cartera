# Cartera

Web app de gastos personales para iPhone. Se instala desde Safari (Compartir → Añadir a pantalla de inicio) y abre a pantalla completa.

- `index.html`: la app (Ionic 8 en modo iOS, sin compilación).
- `config.js`: dirección y clave pública (anon) del proyecto de Supabase.
- `supabase.sql`: tablas y reglas de seguridad; se ejecuta una vez en el SQL Editor de Supabase.
- `sw.js` y `manifest.webmanifest`: instalación y funcionamiento sin conexión.
