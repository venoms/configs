DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


set -e
# if bashrc doesn't exist, fill it in
ls ~/.bashrc || cp $DIR/.bashrc ~/.bashrc
# if bash_profile doesn't exist, fill it in
ls ~/.bash_profile || ln -s ~/.bashrc ~/.bash_profile

# evaluate our (potentially new) bashrc
. ~/.bashrc

installbundle=false
if ! ls ~/.vim/bundle; then
	installbundle=true

	echo "detected bundle..."
fi

if [ "$installbundle" = true ]; then
	echo "installing bundle..."
	mkdir -p  ~/.vim/bundle && \
		git clone \
		--depth 1 \
		http://github.com/zemnmez/Vundle.vim ~/.vim/bundle/Vundle.vim


	echo installing vundle packages
	sed '/vundle#end/{q;}' $DIR/.vimrc > ~/.vimrc
fi

function fnExists {
	command -v $1 > /dev/null 2>&1
}

packages="go npm vim ctags cmake"
if fnExists apacman; then
	apacman_packages="go npm gvim ctags cmake
		i3-wm i3lock i3status-git
		ack calc cloc chromium
		mumble nitrogen redshift rtorrent
		openssh openvpn pavucontrol pulseaudio
		lxappearance ttf-roboto-fontconfig pulseaudio-bluetooth
		adwaita-x-dark-and-light-theme adwaita-icon-theme adwaita-qt5
		adwaita-qt-common adwaita-qt4"
	if ! apacman --noconfirm --needed -S $apacman_packages; then
		echo "apacman seems to have failed, try interactive:"
		apacman --needed -S $apacman_packages
	fi
elif fnExists pacman; then
	echo "please install apacman"
elif fnExists brew; then
	brew install go npm vim ctags cmake
	brew cask install google-chrome iterm2 sublime-text flux
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

if [ "$installbundle" = true ]; then
	echo "installing ycm..."
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

	( cd ~/.vim/bundle/tern_for_vim && npm install ;)

	rm ~/.vimrc
	ln -s $DIR/.vimrc ~/.vimrc
fi
