# Convenciones — calculator

> Reglas de estilo y forma. El revisor cita esta sección por número cuando
> rechaza un cambio.

## 1. TypeScript

- `strict` ya está activo en `tsconfig`. No lo desactives ni uses `any`.
- Tipa explícitamente parámetros y retornos de funciones públicas.
- Nada de `console.log` en el código de producción (solo en tests si hace falta).

## 2. Angular

- **Componentes standalone** (sin NgModules). Usa `imports: [...]` en el decorador.
- **Inyección con la función `inject()`**, no por constructor:
  `private calc = inject(CalculatorService);`
- Selectores con prefijo `app-` (p.ej. `app-display`, `app-keypad`).
- Los templates usan la sintaxis de control de flujo nueva (`@if`, `@for`),
  no `*ngIf` / `*ngFor`.

## 3. Nombres

- Archivos en `kebab-case`: `calculator.service.ts`, `note-list.ts`.
- Clases en `PascalCase`; métodos y variables en `camelCase`.
- Un elemento testeable desde fuera lleva `data-testid="..."` (no te apoyes en
  clases CSS ni en el orden del DOM para seleccionar en tests).

## 4. Manejo de errores

- El `engine.ts` SÍ lanza excepciones en casos inválidos (p.ej. división por cero
  lanza `Error('Division by zero')`).
- La capa de servicio/UI NO deja propagar excepciones al usuario: las traduce a
  un estado mostrable (p.ej. display `'Error'`). El usuario nunca ve un stack trace.

## 5. Tests

- Framework: **Jasmine + Karma** (lo que trae Angular). No añadas otro runner.
- Usa `TestBed` para componentes y servicios. Para `engine.ts` (puro) basta con
  llamar a las funciones directamente, sin TestBed.
- Limpia el estado global en `beforeEach` (p.ej. `localStorage.clear()` si lo usas).
- Un test por comportamiento descrito en `acceptance`. Nombres descriptivos:
  `it('suma dos operandos', ...)`, no `it('works', ...)`.
- No mocks innecesarios: si puedes usar el objeto real (un servicio simple), úsalo.
