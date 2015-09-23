DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


set -e

mkdir -p  ~/.vim/bundle && git clone --depth 1 http://github.com/zemnmez/Vundle.vim ~/.vim/bundle/Vundle.vim


sed '/vundle#end/{q;}' $DIR/.vimrc > ~/.vimrc


vim -c 'BundleInstall!' -c q

params="install.py --omnisharp-completer --gocode-completer --clang-completer"

function installycm {
	if [[ "$(python -c "import sys;print(sys.version_info[0])")" == "3" ]]; then
		if ! python2 $params; then
			echo "can't find python2"
			exit
		fi
	else
		python $params
	fi
}

( cd ~/.vim/bundle/YouCompleteMe ; installycm ;) # it breaks if you don't end with a winky face

rm ~/.vimrc
$DIR/link.sh
