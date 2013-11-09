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

# fix vim backups
function fix-vim-backups() {
	[ -f ~/.vimrc ] && grep 'set backup' ~/.vimrc &&\
	(
		VIM_BACKUP_DIR=$HOME/$(grep 'set backupdir' ~/.vimrc|cut -d '=' -f2|sed 's/\$HOME\///')
		echo "Found vim backup dir: $VIM_BACKUP_DIR"
		[ ! -d $VIM_BACKUP_DIR ] && mkdir -p $VIM_BACKUP_DIR && echo "Fixed" || echo "No need to fix"
	)
}
export -f fix-vim-backups
