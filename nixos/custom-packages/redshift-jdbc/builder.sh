source "${stdenv}/setup"

set -e

install -T -D -m444 "${src}" "${out}/share/redshift-jdbc.jar"
