#!/usr/bin/env bash
# init.sh — Verificación e inicialización del entorno (calculator / Angular)
#
# Lo ejecuta el agente al COMENZAR una sesión y antes de declarar cualquier
# feature como `done`. Si falla, la sesión no debe avanzar.
#
# Orden: lo barato primero (entorno, archivos, JSON) y el build/test al final,
# para fallar rápido sin gastar minutos compilando.

set -u
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; NC='\033[0m'
ok()   { printf "${GREEN}[OK]${NC}    %s\n" "$1"; }
warn() { printf "${YELLOW}[WARN]${NC}  %s\n" "$1"; }
fail() { printf "${RED}[FAIL]${NC}  %s\n" "$1"; }

EXIT_CODE=0
cd "$(dirname "$0")" || exit 1

echo "── 1. Verificando entorno ─────────────────────────────"

if ! command -v node >/dev/null 2>&1; then fail "node no está instalado"; exit 1; fi
ok "node -> $(node --version)"

if ! command -v npm >/dev/null 2>&1; then fail "npm no está instalado"; exit 1; fi
ok "npm -> $(npm --version)"

# Node >= 20 (requisito de Angular 20)
NODE_MAJOR=$(node -p "process.versions.node.split('.')[0]")
if [ "$NODE_MAJOR" -lt 20 ]; then
  fail "Se requiere Node >= 20 (tienes $(node --version))"; EXIT_CODE=1
else
  ok "Versión de Node compatible"
fi

# Dependencias instaladas
if [ ! -d "node_modules" ]; then
  fail "Falta node_modules. Ejecuta 'npm install' antes de continuar."; EXIT_CODE=1
else
  ok "node_modules presente"
fi

# Chrome para los tests headless (dependencia oculta de Karma)
CHROME_MAC="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [ -n "${CHROME_BIN:-}" ] && [ -x "${CHROME_BIN}" ]; then
  ok "Chrome -> \$CHROME_BIN"
elif [ -x "$CHROME_MAC" ]; then
  ok "Chrome -> Google Chrome.app"
elif command -v google-chrome >/dev/null 2>&1 || command -v chromium >/dev/null 2>&1; then
  ok "Chrome/Chromium en PATH"
else
  warn "No se detectó Chrome. Los tests headless pueden fallar (instala Chrome o exporta CHROME_BIN)."
fi

echo ""
echo "── 2. Verificando archivos base del arnés ──────────────"

for f in AGENTS.md feature_list.json progress/current.md \
         docs/architecture.md docs/conventions.md docs/verification.md CHECKPOINTS.md; do
  if [ ! -f "$f" ]; then fail "Falta archivo base: $f"; EXIT_CODE=1; else ok "Existe $f"; fi
done

echo ""
echo "── 3. Validando feature_list.json ──────────────────────"

node - <<'JS'
const fs = require('fs');
try {
  const data = JSON.parse(fs.readFileSync('feature_list.json', 'utf8'));
  const valid = new Set(['pending', 'in_progress', 'done', 'blocked']);
  const inProgress = data.features.filter(f => f.status === 'in_progress');
  if (inProgress.length > 1) {
    console.log(`[FAIL]  Hay ${inProgress.length} features en in_progress (máximo 1)`);
    process.exit(1);
  }
  for (const f of data.features) {
    if (!valid.has(f.status)) {
      console.log(`[FAIL]  Estado inválido en feature ${f.id}: ${f.status}`);
      process.exit(1);
    }
  }
  console.log(`[OK]    feature_list.json válido (${data.features.length} features)`);
} catch (e) {
  console.log(`[FAIL]  feature_list.json inválido: ${e.message}`);
  process.exit(1);
}
JS
if [ $? -ne 0 ]; then EXIT_CODE=1; fi

echo ""
echo "── 4. Build ────────────────────────────────────────────"
if npm run build >/tmp/calc_build.log 2>&1; then
  ok "ng build pasa"
else
  fail "ng build falló — revisa /tmp/calc_build.log"; tail -15 /tmp/calc_build.log; EXIT_CODE=1
fi

echo ""
echo "── 5. Tests (headless) ─────────────────────────────────"
if npm run test:ci >/tmp/calc_test.log 2>&1; then
  ok "$(grep -Eo 'TOTAL: [0-9]+ SUCCESS' /tmp/calc_test.log | tail -1 || echo 'Todos los tests pasan')"
else
  fail "Hay tests rotos — revisa /tmp/calc_test.log"; tail -20 /tmp/calc_test.log; EXIT_CODE=1
fi

echo ""
echo "── 6. Resumen ──────────────────────────────────────────"
if [ $EXIT_CODE -eq 0 ]; then
  ok "Entorno listo. Puedes empezar a trabajar."
else
  fail "Entorno NO está listo. Resuelve los errores antes de avanzar."
fi
exit $EXIT_CODE
