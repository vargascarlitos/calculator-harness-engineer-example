# Verificación — calculator

> Cómo demostrar que tu trabajo funciona. "Funciona en mi cabeza" no cuenta.
> La fuente de verdad es `./init.sh`: si pasa, el trabajo es verificable.

## Comandos canónicos

| Qué | Comando | Cuándo |
|-----|---------|--------|
| Compilar | `npm run build` (= `ng build`) | Debe pasar siempre |
| Tests (headless) | `npm run test:ci` | Antes de cerrar cualquier feature |
| Todo junto | `./init.sh` | Al empezar y antes de declarar `done` |
| App en vivo (humano) | `npm start` (= `ng serve`) | Comprobación visual manual |

> Los tests corren en **Chrome headless** vía Karma. Chrome debe estar
> instalado en la máquina; `init.sh` lo verifica.

## Cómo se verifica una feature

Cada criterio de `acceptance` en `feature_list.json` debe tener **al menos un
test que lo ejerce**. El mapeo es explícito:

- acceptance dice "`divide(a, 0)` lanza `Error('Division by zero')`"
  → `engine.spec.ts` tiene un `it` que hace `expect(() => divide(1, 0)).toThrowError('Division by zero')`.

Si un criterio no es testeable como está escrito, el problema es el criterio:
para y propón reformularlo, no lo declares hecho "a ojo".

## Regla de oro

- **Tests rojos = feature no terminada.** No se marca `done` con un solo test
  en rojo, ni con un warning de build tratado como error.
- **Sin tests nuevos = feature no terminada.** Código sin su test
  correspondiente no se acepta, aunque "se vea bien".
- El número de tests solo debe **subir o mantenerse**, nunca bajar sin
  justificación explícita en `progress/`.
