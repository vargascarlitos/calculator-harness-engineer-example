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

---

## 2026-05-27 — Feature 1: calc_engine (DONE)

- Bucle líder→implementer→reviewer sobre la feature 1 (`calc_engine`).
- Implementer creó `src/app/calculator/engine.ts` (funciones puras `add`,
  `subtract`, `multiply`, `divide`; `divide(a,0)` lanza `Error('Division by zero')`)
  y `engine.spec.ts` (4 operaciones con positivos/negativos/decimales + división
  por cero; `toBeCloseTo` para flotantes).
- Reviewer aprobó contra docs/ y CHECKPOINTS.md; marcó la feature `done`.
- `init.sh` final: exit 0 (build OK, 15 tests SUCCESS).
- Informes: `progress/impl_calc_engine.md`, `progress/review_calc_engine.md`.
- Siguiente: feature 2 (`calc_service`).
