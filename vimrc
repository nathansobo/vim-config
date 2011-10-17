" use Pathogen for plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"-------------------------------------------
"                 EDITING
"-------------------------------------------

filetype plugin indent on
set nocompatible

" leader key for custom mappings
let mapleader=','

" don't allow bindings starting with escape in insert mode
set noesckeys

" move up and down within wrapped lines
noremap j gj
noremap k gk

" make Y consistent w/ D and C
map Y y$

" increase/decrease indentation
xmap <TAB> >gv
xmap <S-TAB> <gv

" command-/ to toggle comments
let NERDSpaceDelims = 1
map <D-/> <plug>NERDCommenterToggle<CR>
xmap <D-/> <plug>NERDCommenterToggle<CR>gv
imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

" command mode autocomplete - like bash
set wildmode=list:longest

" insert mode autocomplete - menu, only from open buffers
set complete=.,w,b
set pumheight=10
set completeopt=menu
inoremap <C-Space> <C-n>
inoremap <M-Space> <C-p>

" reindent the entire file and return to original position
noremap <Leader>= gg=G``

"-------------------------------------------
"                SEARCHING
"-------------------------------------------

set hlsearch
set incsearch
set ignorecase
set smartcase

" clears the command line and search highlighting
noremap <C-l>     :nohlsearch<CR><C-l>
noremap <leader>/ :nohlsearch<CR><C-l>

" command-shift-F for ack - search in project
noremap  <D-F> :Ack!<space>
vnoremap <D-F> :<C-w>exec "Ack! '" . GetCurrentVisualSelection() . "'"<CR>

"-------------------------------------------
"               BUFFERS/FILES
"-------------------------------------------

" let unsaved buffers exist in the background.
set hidden

" don't prompt for file changes outside vim
set autoread

" autosave when changing buffers or losing focus.
set autowriteall
autocmd FocusLost * silent! wall

" directory for swp files
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
let g:NERDTreeChDirMode=2

" command-T - open files with fuzzy matching
let g:CommandTMaxHeight=10
map <leader>N :CommandT<CR>
map <D-N> :CommandT<CR>
imap <D-N> <Esc>:CommandT<CR>
map <leader>B :CommandTBuffer<CR>
map <D-B> :CommandTBuffer<CR>
imap <D-B> <Esc>:CommandTBuffer<CR>

" copy current file path to system pasteboard.
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>

" run ctags, with or without gemhome included
map <leader>rt :!ctags -R --exclude=.git --exclude=log *<CR>
map <leader>rT :!ctags -R --exclude=.git --exclude=log * `rvm gemhome`/*<CR>

" jump to a tag in a window to the right.
nnoremap <C-w><C-]>  :exec      "vertical belowright stag" expand("<cword>")<CR>
nnoremap <C-w>g<C-]> :exec      "vertical belowright stselect" expand("<cword>")<CR>
vnoremap <C-w><C-]>  :<C-w>exec "vertical belowright stag" GetCurrentVisualSelection()<CR>
vnoremap <C-w>g<C-]> :<C-w>exec "vertical belowright stselect" GetCurrentVisualSelection()<CR>

"-------------------------------------------
"                 APPEARANCE
"-------------------------------------------

syntax on

" folding
set foldmethod=indent
set nofoldenable

" show typed command prefixes while waiting for operator.
set showcmd

" start scrolling when the cursor is within 3 lines of the edge.
set scrolloff=3

" don't beep
set visualbell
set noerrorbells

" line numbers, cursor position indicator
set laststatus=2
set number
set ruler

" show (partial) command in the status line
set showcmd

" don't hard wrap long lines
set nowrap
set textwidth=0
set wrapmargin=0
set nolist
set linebreak

" show matching brackets
set showmatch

" whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

"-------------------------------------------
"                 FILETYPES
"-------------------------------------------

" insert ' => '
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

"-------------------------------------------
"                 FUNCTIONS
"-------------------------------------------

function! GetCurrentVisualSelection()
  let reg_save = @x
  normal! gv"xy
  let selection = @x
  let @x = reg_save
  return selection
endfunction

"-------------------------------------------
"                 LOCAL CONFIG
"-------------------------------------------

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

