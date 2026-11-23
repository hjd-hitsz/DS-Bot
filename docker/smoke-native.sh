#!/bin/sh
# Runs the packaged plugin and the native DSH model route in a clean container.
set -eu

test ! -e /data/profiles/web
test ! -e /data/pi-agent
if command -v pi >/dev/null || command -v pi-acp >/dev/null; then
  echo 'Expected a native DSH image without PI Agent' >&2
  exit 1
fi

export DSH_HOST=127.0.0.1 DSH_LISTEN_PORT=3096 DSH_TELEMETRY_DISABLED=1
DEEPSEEK_BASE_URL= DEEPSEEK_API_KEY= /usr/local/bin/entrypoint.sh --help > /tmp/dsh-init.log
test -r /data/profiles/web/cordis.patch.yml
test "$(readlink -f /data/profiles/web/node_modules/ds-bot)" = /opt/dsh-template/profiles/web/node_modules/ds-bot
cat > /data/profiles/web/cordis.patch.yml <<'YAML'
- id: bot
  config:
    checkRatio: 0.45
- id: llm-deepseek
  config:
    models:
      - { id: deepseek-flash, contextWindow: 100000, maxTokens: 8000, inputModalities: [text, image] }
      - { id: deepseek-v4-pro, contextWindow: 100000, maxTokens: 8000 }
- id: directory-picker
  disabled: true
- insert:
    - id: directory-picker-browse
      name: '@deepseek-ai/dsh-host-directory-picker-browse'
    - id: ui-directory-picker-browse
      name: '@deepseek-ai/dsh-client-ui-directory-picker-browse'
YAML

export MOCK_PORT=8796 MOCK_LOG=/data/mock.jsonl MOCK_DELAY_MS=300
export DEEPSEEK_BASE_URL=http://127.0.0.1:8796/v1 DEEPSEEK_API_KEY=mock-key
export DSBOT_SMOKE_HOME=/data

node /repo/ds-bot/dev/mock-llm.mjs /data > /tmp/mock.out 2>&1 &
mock_pid=$!
/usr/local/bin/entrypoint.sh > /data/web.log 2>&1 &
web_pid=$!
trap 'kill "$web_pid" "$mock_pid" 2>/dev/null || true' EXIT

attempts=0
until grep -q 'dsh web: http' /data/web.log; do
  attempts=$((attempts + 1))
  if [ "$attempts" -ge 90 ] || ! kill -0 "$web_pid" || ! kill -0 "$mock_pid"; then
    sed '/token=/d' /data/web.log /tmp/mock.out >&2
    exit 1
  fi
  sleep 1
done

node /repo/ds-bot/dev/smoke.mjs native "$DSH_LISTEN_PORT"
