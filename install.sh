DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


set -e

mkdir -p  ~/.vim/bundle && git clone --depth 1 http://github.com/zemnmez/Vundle.vim ~/.vim/bundle/Vundle.vim


sed '/vundle#end/{q;}' $DIR/.vimrc > ~/.vimrc


vim -c 'BundleInstall!' -c q

( cd ~/.vim/bundle/YouCompleteMe && ./install.py --omnisharp-completer --gocode-completer --clang-completer && brew install npm && npm install -g typescript ;)


rm ~/.vimrc
$DIR/link.sh
