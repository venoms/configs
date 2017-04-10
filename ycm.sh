#!/bin/bash
(
	cd ~/.vim/bundle/YouCompleteMe

	python install.py \
		--omnisharp-completer \
		--gocode-completer \
		--clang-completer
)


(
	cd ~/.vim/bundle/tern_for_vim
	npm install
)
