# Copied from OSX plugin to oh-my-zsh
quick-look () {
	(( $# > 0 )) && qlmanage -p $* &> /dev/null &
}
