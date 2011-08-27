" use Pathogen for plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


"-------------------------------------------
"                 EDITING
"-------------------------------------------

filetype plugin indent on
set nocompatible

" leader key for custom commands
let mapleader=','

" don't allow bindings starting with escape in insert mode
set noesckeys

" let tilde (toggle case) behave like an operator
set tildeop

" move up and down within wrapped lines
noremap j gj
noremap k gk

" when moving by word, respect camel case and underscore boundaries
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" make Y consistent w/ D and C
map Y y$

" increase/decrease indentation
imap <S-TAB> <C-o><<
nmap <TAB> >>
nmap <S-TAB> <<
vmap <TAB> >gv
vmap <S-TAB> <gv

" bubble lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" command-/ to toggle comments
let NERDSpaceDelims = 1
map <D-/> <plug>NERDCommenterToggle<CR>
imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

" duplicate lines and selections - command-d
map <D-d> yyP
vmap <D-d> yP

" autocomplete - insert and command modes
set complete=.,w,b
set pumheight=6
set completeopt=menu
set wildmode=list:longest
inoremap <C-Space> <C-n>
inoremap <M-Space> <C-n>

" reindent the entire file and return to original position
noremap <Leader>= gg=G``

" get out of insert mode w/ jk
imap kj <Esc>

" query replace
nnoremap <D-r> :%s//gc<Left><Left><Left>
vnoremap <D-r> :s//gc<Left><Left><Left>


"-------------------------------------------
"                SEARCHING
"-------------------------------------------

set hlsearch
set incsearch
set ignorecase
set smartcase

" command-shift-F for ack - search in project
map <D-F> :Ack!<space>
vmap <D-F> :call AckVisual()<CR>
function! AckVisual()
  normal gv"xy
  let command = "ack '".@x."'"
  cexpr system(command)
  cw
endfunction

" <Leader>-/ to clear search highlighting
noremap  <Leader>/ :nohls<CR>


"-------------------------------------------
"               BUFFERS/FILES
"-------------------------------------------

" Let unsaved buffers exist in the background.
set hidden

" Don't prompt for file changes outside MacVim
set autoread

" autosave when changing buffers or losing focus.
set autowriteall
autocmd FocusLost * silent! wall

" Directories for swp files
if has('unix') || has('mac')
  set backupdir=/tmp
  set directory=/tmp
end

" NERDTree - project drawer
"  - toggle drawer
"  - go to current file
map \ :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1

" command-T - open files with fuzzy matching
let g:CommandTMaxHeight=10
map <leader>N :CommandT<CR>
map <D-N> :CommandT<CR>
imap <D-N> <Esc>:CommandT<CR>
map <leader>B :CommandTBuffer<CR>
map <D-B> :CommandTBuffer<CR>
imap <D-B> <Esc>:CommandTBuffer<CR>

" open .vimrc file.  (Think Cmd , [Preferences...] but with Shift.)
map <D-<> :tabedit ~/.vimrc<CR>

" copy current file path to system pasteboard.
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>

" easy access to the shell.
map <Leader><Leader> :!

" run ctags, with or without gemhome included
map <leader>rt :!/usr/local/bin/ctags -R --exclude=.git --exclude=log *<CR>
map <leader>rT :!/usr/local/bin/ctags -R --exclude=.git --exclude=log * `rvm gemhome`/*<CR>

" next and previous tag
noremap <D-]> :tnext<CR>
noremap <D-[> :tprevious<CR>


"-------------------------------------------
"                 APPEARANCE
"-------------------------------------------

syntax on

" folding
set foldmethod=indent
set nofoldenable

" Show typed command prefixes while waiting for operator.
set showcmd

" Start scrolling when the cursor is within 3 lines of the edge.
set scrolloff=3

" Don't beep
set visualbell
set noerrorbells

" Line numbers, cursor position indicator
set laststatus=2
set number
set ruler

" Show (partial) command in the status line
set showcmd

" don't highlight current row.
set nocursorline

" Don't hard wrap long lines
set nowrap
set textwidth=0
set wrapmargin=0
set nolist
set linebreak

" show matching brackets
set showmatch

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·


"-------------------------------------------
"                 FILETYPES
"-------------------------------------------

" Insert ' => '
autocmd FileType ruby imap  <Space>=><Space>

" text files should autoindent, for making outlines
autocmd FileType text set autoindent

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

" plain text 
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd BufRead,BufNewFile *.text set filetype=text
autocmd BufRead,BufNewFile *README* set filetype=text

" make and git files use real tabs
autocmd FileType make set noexpandtab
autocmd BufRead,BufNewFile .git* set noexpandtab
