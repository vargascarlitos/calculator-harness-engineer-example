# CHECKPOINTS — Evaluación del estado final

> En sistemas multi-agente no se evalúa el camino, se evalúa el destino.
> Estos son los checkpoints objetivos que un revisor (humano o IA) usa para
> decidir si el proyecto está sano. El reviewer marca `[x]`/`[ ]` y rechaza el
> cierre si queda algún box vacío.

## C1 — El arnés está completo

- [ ] Existen los archivos base: `AGENTS.md`, `init.sh`, `feature_list.json`,
      `progress/current.md`.
- [ ] Existen los 3 docs: `docs/architecture.md`, `docs/conventions.md`,
      `docs/verification.md`.
- [ ] `./init.sh` termina con exit code 0.

## C2 — El estado es coherente

- [ ] Como mucho una feature en `in_progress` en `feature_list.json`.
- [ ] Toda feature `done` tiene tests asociados que pasan.
- [ ] `progress/current.md` está vacío o describe solo la sesión activa.

## C3 — El código respeta la arquitectura

- [ ] La dirección de dependencias se respeta (engine ← service ← components ←
      app); ningún componente contiene lógica aritmética propia.
- [ ] `engine.ts` no importa nada del proyecto ni de Angular.
- [ ] Cero dependencias npm nuevas respecto al `package.json` del scaffolding.
- [ ] No hay `console.log` ni `any` sueltos, ni TODOs sin contexto.

## C4 — La verificación es real

- [ ] `npm run build` pasa sin errores.
- [ ] `npm run test:ci` muestra > 0 tests y todos verdes.
- [ ] Cada criterio de `acceptance` de la feature trabajada tiene su test.
- [ ] El número total de tests no bajó sin justificación en `progress/`.

## C5 — La sesión se cerró bien

- [ ] No hay archivos basura sin trackear (`*.tmp`, builds fuera de `.gitignore`).
- [ ] `progress/history.md` tiene una entrada por la última sesión.
- [ ] La feature trabajada está reflejada en su estado correcto en `feature_list.json`.
