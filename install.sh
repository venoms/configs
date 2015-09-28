DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


set -e
ls ~/.bashrc || cp $DIR/.bashrc ~/.bashrc
ls ~/.bash_profile || ln -s ~/.bashrc ~/.bash_profile

. ~/.bashrc

echo installing vundle
mkdir -p  ~/.vim/bundle && git clone --depth 1 http://github.com/zemnmez/Vundle.vim ~/.vim/bundle/Vundle.vim


echo installing vundle packages
sed '/vundle#end/{q;}' $DIR/.vimrc > ~/.vimrc

function exists {
	command -v $1 > /dev/null 2>&1
}

packages="go npm vim ctags cmake"
if exists apacman; then
	apacman -S $packages
elif exists pacman; then
	pacman -S $packages
elif exists brew; then
	brew install $packages
else
	echo "Script doesn't support your package manager :("

	if uname -a | grep "Darwin"; then
		echo Maybe install brew?
	fi
fi


vim -c 'BundleInstall!' +qall

npmpackages="typescript"
npm install -g $npmpackages

gopackages="golang.org/x/tools/cmd/goimports github.com/nsf/gocode golang.org/x/tools/cmd/oracle github.com/golang/lint/golint github.com/rogpeppe/godef golang.org/x/tools/cmd/gorename github.com/kisielk/errcheck github.com/jstemmer/gotags"

if [ -z "$GOPATH" ]; then
	mkdir -p ~/go || true
	export GOPATH=~/go
	echo
fi
go get -u $gopackages

installparams="install.py --omnisharp-completer --gocode-completer --clang-completer"

function installycm {
	if [[ "$(python -c "import sys;print(sys.version_info[0])")" == "3" ]]; then
		if ! python2 $installparams; then
			echo "can't find python2"
			exit
		fi
	else
		python $installparams
	fi
}

( cd ~/.vim/bundle/YouCompleteMe ; installycm ;) # it breaks if you don't end with a winky face

rm ~/.vimrc
ln -s $DIR/.vimrc ~/.vimrc
