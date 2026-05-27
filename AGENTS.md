# AGENTS.md — Mapa de navegación para agentes de IA

> Punto de entrada para cualquier agente que trabaje en este repositorio.
> NO es una biblia de reglas: es un **mapa**. Lee solo lo que necesites cuando
> lo necesites (divulgación progresiva).

---

## 1. Antes de empezar (obligatorio)

1. Ejecuta `./init.sh` y verifica que termina sin errores (exit 0). Si falla,
   **para** y resuelve el entorno antes de tocar código.
2. Lee `progress/current.md` para saber en qué estado quedó la última sesión.
3. Lee `feature_list.json` y elige **una** tarea `pending`. Nunca más de una a la vez.

## 2. Mapa del repositorio

| Archivo / carpeta          | Qué contiene                                          | Cuándo leerlo |
|----------------------------|-------------------------------------------------------|---------------|
| `feature_list.json`        | Tareas con estado (pending/in_progress/done/blocked)  | Siempre, al empezar |
| `progress/current.md`      | Estado de la sesión actual                            | Siempre, al empezar |
| `progress/history.md`      | Bitácora append-only de sesiones anteriores           | Si necesitas contexto histórico |
| `docs/architecture.md`     | Capas y dirección de dependencias                     | Antes de implementar |
| `docs/conventions.md`      | Estilo TS/Angular, nombres, manejo de errores         | Antes de escribir código |
| `docs/verification.md`     | Comandos canónicos y cómo demostrar que funciona      | Antes de declarar `done` |
| `CHECKPOINTS.md`           | Criterios objetivos de "estado final correcto"        | Para auto-evaluarte / revisar |
| `.claude/agents/`          | Definiciones de leader, implementer, reviewer         | Si orquestas trabajo |
| `src/app/`                 | Código de la aplicación                               | Para implementar |

## 3. Reglas duras (no negociables)

- **Una sola feature a la vez.** No mezcles cambios de varias tareas.
- **No declares `done` sin verde.** `./init.sh` debe terminar en exit 0.
- **Documenta MIENTRAS trabajas** en `progress/current.md`, no al final.
- **Cero dependencias npm nuevas.** Si crees que necesitas una, para y repórtalo.
- **Si no sabes algo, búscalo en `docs/`** antes de inventarlo.

## 4. Cómo elegir una tarea

```
1. Abre feature_list.json
2. Filtra por status == "pending"
3. Coge la de menor "id" (el orden respeta las dependencias)
4. Cambia su status a "in_progress" y guarda
5. Anota en progress/current.md: feature, hora de inicio, plan breve
```

## 5. Cierre de sesión (lifecycle)

1. Ejecuta `./init.sh` — exit 0.
2. Si la tarea está acabada y revisada: marca `status: "done"` en `feature_list.json`.
3. Mueve el resumen de `progress/current.md` al final de `progress/history.md`.
4. Devuelve `progress/current.md` a su plantilla vacía.
5. No dejes archivos basura, `console.log` de debug, ni TODOs sin contexto.

## 6. Si te bloqueas

- Relee la sección relevante de `docs/`.
- Si una herramienta no hace lo que esperas, **no inventes un workaround**:
  documenta el bloqueo en `progress/current.md` con estado `blocked` y para.
