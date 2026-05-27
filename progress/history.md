# Bitácora (append-only)

> Una entrada por sesión cerrada. NUNCA se borra ni se reescribe lo anterior;
> solo se añade al final. Es el diario de bordo del proyecto.

---

## 2026-05-27 — Bootstrap del arnés

- Proyecto Angular creado con `ng new` y renombrado a `calculator`.
- Montado el arnés: `feature_list.json` (5 features de calculadora, todas
  `pending`), `docs/` (architecture, conventions, verification), `CHECKPOINTS.md`,
  `init.sh` (verifica entorno + Chrome, valida JSON, build + test headless).
- Baseline verde: 2 tests del scaffolding pasan.
- Pendiente al cerrar: aún sin features de calculadora implementadas; listo para
  que el bucle líder→implementer→reviewer tome la feature 1 (`calc_engine`).
