#!/bin/bash

DEFAULT_STATS_PASSWORD="hakuna"

DEFAULT_SIMBA_HOST="172.17.42.1:8000"
DEFAULT_ZAZUWS_HOST="172.17.42.1:5280"

HAPROXY_CFG_IN="/haproxy.cfg.in"
HAPROXY_CFG="/haproxy.cfg"

if [ -z "$SSL_KEY" ]; then
	echo "ERROR: SSL_KEY not found." >&2
	exit 1
fi

if [ -z "$STATS_PASSWORD" ]; then
	echo "NOTICE: STATS_PASSWORD not found. Using default."
	STATS_PASSWORD="$DEFAULT_STATS_PASSWORD"
fi

if [ -z "$SIMBA_HOST" ]; then
	echo "NOTICE: SIMBA_HOST not found. Using default $DEFAULT_SIMBA_HOST"
	SIMBA_HOST="$DEFAULT_SIMBA_HOST"
fi

if [ -z "$ZAZUWS_HOST" ]; then
	echo "NOTICE: ZAZUWS_HOST not found. Using default $DEFAULT_ZAZUWS_HOST"
	ZAZUWS_HOST="$DEFAULT_ZAZUWS_HOST"
fi

sed \
	-e "s|%SIMBA_HOST%|$SIMBA_HOST|g" \
	-e "s|%ZAZUWS_HOST%|$ZAZUWS_HOST|g" \
	"$HAPROXY_CFG_IN" > "$HAPROXY_CFG"

echo "$SSL_KEY" > /tmp/server.pem

cat "$HAPROXY_CFG"

exec haproxy -f "$HAPROXY_CFG"
