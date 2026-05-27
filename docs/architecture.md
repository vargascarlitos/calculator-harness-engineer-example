# Arquitectura — calculator

> Qué significa "hacer un buen trabajo" en este proyecto a nivel de estructura.
> Si tu cambio rompe una de estas reglas, está mal aunque los tests pasen.

## Capas y dirección de dependencias

```
┌──────────────────────────────────────────┐
│  app.ts (raíz)        ← ensambla la UI     │
├──────────────────────────────────────────┤
│  components/          ← UI (display, keypad)│
│      depende de →                           │
├──────────────────────────────────────────┤
│  calculator/calculator.service.ts ← estado  │
│      depende de →                           │
├──────────────────────────────────────────┤
│  calculator/engine.ts ← funciones puras     │
│      depende de → (nada)                    │
└──────────────────────────────────────────┘
```

**Las flechas solo van hacia abajo.** Regla dura:

- `engine.ts` no importa NADA del proyecto (ni Angular). Son funciones puras.
- `calculator.service.ts` usa `engine.ts`, pero NO conoce componentes ni el DOM.
- Los componentes usan el servicio. NO contienen lógica aritmética propia
  (si un componente hace `a + b`, está mal: eso vive en el engine).
- `app.ts` solo ensambla componentes; no contiene lógica.

## Estructura de carpetas prevista

```
src/app/
├── calculator/
│   ├── engine.ts            + engine.spec.ts
│   └── calculator.service.ts + calculator.service.spec.ts
├── components/
│   ├── display/  display.ts  + display.spec.ts
│   └── keypad/   keypad.ts   + keypad.spec.ts
├── app.ts / app.html / app.spec.ts
```

`src/app/` solo debe contener estos módulos. Si necesitas crear algo fuera de
este árbol, es señal de que el cambio se salió del scope de la feature: para y
repórtalo.

## Dependencias externas

- **Cero dependencias nuevas de npm.** Solo Angular y lo que ya trae el
  `package.json` del scaffolding. Si crees que necesitas una librería, para y
  repórtalo como bloqueo; casi siempre la respuesta es "no la necesitas".
