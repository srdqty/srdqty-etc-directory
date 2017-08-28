source "${stdenv}/setup"

set -e

install -T -D -m444 "${src}" "${out}/share/postgresql-jdbc.jar"
