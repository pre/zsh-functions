# man-preview - open a specified man page in Preview
# copied from corresponding oh-my-zsh plugin
man-preview () {
	man -t "$@" | open -f -a Preview
}
