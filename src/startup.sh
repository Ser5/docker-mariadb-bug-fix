#!/bin/bash
set -eo pipefail
shopt -s nullglob



mysql_get_config() {
	local conf="$1"; shift
	mysqld --verbose --help 2>/dev/null \
		| awk -v conf="$conf" '$1 == conf && /^[^ \t]/ { sub(/^[^ \t]+[ \t]+/, ""); print; exit }'
}


DATADIR="$(mysql_get_config 'datadir')"


if [ ! -d "$DATADIR/mysql" ]; then
	mkdir -p "$DATADIR"

	chown -R mysql:mysql "$DATADIR"

	runuser -u mysql -g mysql -- mariadb-install-db \
		--datadir="$DATADIR" --rpm --auth-root-authentication-method=normal \
		--skip-test-db \
		--old-mode='UTF8_IS_UTF8MB3' \
		--default-time-zone=SYSTEM --enforce-storage-engine= \
		--skip-log-bin \
		--expire-logs-days=0 \
		--loose-innodb_buffer_pool_load_at_startup=0 \
		--loose-innodb_buffer_pool_dump_at_shutdown=0
fi


runuser -u mysql -g mysql -- mysqld

while true; do sleep 100; done
