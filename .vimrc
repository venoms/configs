"Vundle init
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 

"Vundle plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-repeat'
Plugin 'marijnh/tern_for_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-sleuth'
Plugin 'guns/xterm-color-table.vim'
Plugin 'tpope/vim-characterize'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'fatih/vim-go'
Plugin 'Valloric/MatchTagAlways'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-afterimage'
Plugin 'zemnmez/chimera-vim'
Plugin 'tmhedberg/matchit'

call vundle#end()

"indentation
"disallow incr. decr. octal values with C-A C-X
"decimal numbers starting with 0 will not be treated as
"octal values
set nrformats-=octal

"copy indent from previous line when starting a new line
set autoindent

"make a crosshair to current character with
"column and row highlighted
set cursorline
set cursorcolumn

"don't enable filetype based indentation
"!filetype plugin indent on
"I use tabs everywhere anyway because I'm a horrible person

"Run some plugins on filetype
filetype plugin on

"Syntax highlighting
syntax on

"Use a 256 colour terminal please
set t_Co=256

"My chimera colourscheme
colors chimera

" indent guides (tenuous)
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#808080 ctermbg=102


" don't not indent these tags, still a little unsure about this but w/e
let g:html_indent_inctags = "html,body,head,tbody" 

"let tab be eight spaces (a lota spaces)
set tabstop=4
set shiftwidth=4

"I like my tabs, thanks
set noexpandtab

"timeout combo commands instead of waiting forever
set ttimeout
set ttimeoutlen=100

"display cursor position
set ruler

"line numbers
set number

"show live matches for search
set incsearch

"show last command
set showcmd

"Enhanced command completion (completion box) 
set wildmenu

"Auto read in changed files
set autoread

"Allow mouse input (I'm a scrub)
set mouse=a
"http://majutsushi.github.io/tagbar/
nmap <F8> :TagbarToggle<CR>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-m> :call NumberToggle()<cr>
nmap <F8> :TagbarToggle<CR>

"stop checking my python
let g:syntastic_python_checkers=[]

"make gocode insert imports on save
let g:go_fmt_command = "goimports"
