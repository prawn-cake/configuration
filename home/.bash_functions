# ngrep GET requests from host
function getcap { sudo ngrep -d $1 -W byline -qilw 'get' host $2| grep --color "^GET"; }
export -f getcap

# add-apt-key helper for fast solving "key is not available: NO_PUBKEY <KEY>"
function add-apt-key() {
	KEY=$1
	
	[ -z "$KEY" ] && echo "Passed empty PUBKEY. Use: add-apt-key <PUBKEY>" ||\
	(
		echo "Importing $KEY"
		gpg --keyserver subkeys.pgp.net --recv $KEY &&\
		gpg --export --armor $KEY | sudo apt-key add -
	)
}
export -f add-apt-key
