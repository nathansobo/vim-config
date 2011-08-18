" use Pathogen for plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" ***** EDITTING *****

" leader key for custom commands
let mapleader=','

" don't use the leader key as an escape sequence in insert mode
set noesckeys

" make Y consistent w/ D and C
map Y y$

" let tilde (toggle case) behave like an operator
set tildeop

" move up and down within wrapped lines
noremap j gj
noremap k gk

" Tab, shift-tab to increase/decrease indentation
imap <S-TAB> <C-o><S-TAB>
nmap <TAB> >>
nmap <S-TAB> <<
vmap <TAB> >gv
vmap <S-TAB> <gv

" Bubble lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Command-/ to toggle comments
let NERDSpaceDelims = 1
map <D-/> <plug>NERDCommenterToggle<CR>
imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

" Command-D to duplicate lines
map <D-d> yyP
vmap <D-d> yP

" Cut and paste lines
map <D-c> yy
map <D-x> dd

" Camel case motion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" autocomplete
inoremap <C-Space> <C-n>
inoremap <M-Space> <C-n>

" insert mode select word like textmate
imap <C-w> <Esc>vib

" ***** SEARCHING *****

set hlsearch
set incsearch
set ignorecase
set smartcase

" <Leader>-/ to clear search highlighting
noremap  <Leader>/ :let @/ = ""<CR>

" Command-Shift-F for Ack
map <D-F> :Ack<space>
vmap <D-F> :call AckVisual()<CR>

" Ack current word in command mode
function! AckCursor()
  let command = "ack ".expand("<cword>")
  cexpr system(command)
  cw
endfunction
function! AckVisual()
  normal gv"xy
  let command = "ack ".@x
  cexpr system(command)
  cw
endfunction
map <D-F3> :call AckCursor()<CR>
vmap <D-F3> :call AckVisual()<CR>


" ***** BUFFERS/FILES *****

" Let unsaved buffers exist in the background.
set hidden

" Don't prompt for file changes outside MacVim
set autoread

" autosave when changing buffers or losing focus.
set autowriteall
autocmd FocusLost * silent! wall

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" File tree browser - backslash
map \ :NERDTreeToggle<CR>

" File tree browser showing current file - pipe (shift-backslash)
map \| :NERDTreeFind<CR>
let NERDTreeMinimalUI=1

" Command-T
" macmenu File.New\ Tab key=<D-T>
let g:CommandTMaxHeight=10
map <leader>N :CommandT<CR>
map <D-N> :CommandT<CR>
imap <D-N> <Esc>:CommandT<CR>
map <leader>B :CommandTBuffer<CR>
map <D-B> :CommandTBuffer<CR>
imap <D-B> <Esc>:CommandTBuffer<CR>

" Open .vimrc file.  (Think Cmd , [Preferences...] but with Shift.)
map <D-<> :tabedit ~/.vimrc<CR>

" Copy current file path to system pasteboard.
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>

" Easy access to the shell.
map <Leader><Leader> :!

" run ctags again with gemhome added
map <leader>rt :!/usr/local/bin/ctags -R --exclude=.git --exclude=log * `rvm gemhome`/*<CR>
map <leader>T :!rdoc -f tags -o tags * `rvm gemhome` --exclude=.git --exclude=log


" ***** APPEARANCE *****

" folding
set foldmethod=indent
set nofoldenable

" Show typed command prefixes while waiting for operator.
set showcmd

" Make command completion act more like bash
set wildmode=list:longest

" Start scrolling when the cursor is within 3 lines of the edge.
set scrolloff=3

set nocompatible
filetype plugin indent on
syntax on

" Don't beep
set visualbell
set noerrorbells

" Line numbers, cursor position indicator
set laststatus=2
set number
set ruler

" Show (partial) command in the status line
set showcmd

" Highlight current row.
set cursorline

" Don't hard wrap long lines
set nowrap
set textwidth=0
set wrapmargin=0
set nolist
set linebreak

"show matching brackets
set showmatch

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

"Allow the cursor to display plast the line one char
set virtualedit=onemore


" ***** FILETYPES *****

" Insert ' => '
autocmd FileType ruby imap  <Space>=><Space>

" highlight JSON files as javascript
autocmd BufRead,BufNewFile *.json set filetype=javascript

" highlight jasmine_fixture files as HTML
autocmd BufRead,BufNewFile *.jasmine_fixture set filetype=html

" highlight some other filetypes as ruby
autocmd BufRead,BufNewFile *.thor set filetype=ruby
autocmd BufRead,BufNewFile *.god set filetype=ruby
autocmd BufRead,BufNewFile Gemfile* set filetype=ruby
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile soloistrc set filetype=ruby

" highlight some other filetypes as ruby
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd BufRead,BufNewFile *.text set filetype=text
autocmd BufRead,BufNewFile *README* set filetype=text

" make and git files use real tabs
autocmd FileType make set noexpandtab
autocmd BufRead,BufNewFile .git* set noexpandtab

" text files should autoindent, for writing outlines
autocmd FileType text set autoindent

