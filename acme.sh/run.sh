source ../common/utils.sh
source cert_utils.sh
./lib/acme.sh --register-account -m my@example.com
domains=$(cat ../current.json | jq -r '.domains[] | select(.mode | IN("direct", "cdn", "worker", "relay", "auto_cdn_ip", "old_xtls_direct", "sub_link_only")) | .domain')

for d in $domains; do
	get_cert $d
done

domains=$(cat ../current.json | jq -r '.domains[] | select(.mode | IN("fake")) | .domain')

for d in $domains; do
	get_self_signed_cert $d
done
