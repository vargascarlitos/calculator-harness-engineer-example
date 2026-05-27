# Informe de implementación — Feature 1: calc_engine

- **Fecha:** 2026-05-27
- **Estado:** in_progress (pendiente de review; NO marcada `done`)

## Archivos creados

- `src/app/calculator/engine.ts` — funciones puras `add`, `subtract`, `multiply`, `divide`, cada una con firma `(a: number, b: number) => number`. `divide(a, 0)` lanza `Error('Division by zero')`. No importa nada del proyecto ni de Angular (respeta `docs/architecture.md`).
- `src/app/calculator/engine.spec.ts` — suite Jasmine que llama a las funciones directamente (sin TestBed, por ser lógica pura, según `docs/conventions.md` §5).

## Decisiones

- Tipado explícito de parámetros y retorno; sin `any`, sin `console.log` (conventions §1).
- El engine SÍ lanza la excepción en división por cero (conventions §4); la traducción a estado mostrable corresponde a la capa de servicio (feature 2), fuera de scope aquí.
- Para comparaciones con decimales uso `toBeCloseTo` para evitar falsos negativos por aritmética de punto flotante (p. ej. `0.1 + 0.2`).
- Cero dependencias npm nuevas.

## Cobertura de acceptance

- 4 operaciones con positivos, negativos y decimales: cubiertas (3 `it` por operación + casos extra).
- División por cero: `expect(() => divide(1, 0)).toThrowError('Division by zero')`.

## Resultado de `./init.sh`

- Exit code: 0
- Build: `ng build` pasa.
- Tests: TOTAL 15 SUCCESS (2 base previos + 13 nuevos del engine).
