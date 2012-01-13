" use pathogen for plugins
set nocompatible
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"-------------------------------------------
"                 OPTIONS
"-------------------------------------------

filetype plugin indent on
syntax on

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" autocomplete (insert mode)
set complete=.,w,b
set pumheight=10
set completeopt=menu

" autocomplete (command line mode)
set wildmode=list:longest

" don't allow bindings starting with escape in insert mode
set noesckeys

" let unsaved buffers exist in the background.
set hidden

" autosave, autoload
set autoread
set autowriteall
autocmd FocusLost * silent! wall

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

" directory for swp files
if has('unix') || has('mac')
  set backupdir=/tmp
  set directory=/tmp
end

"-------------------------------------------
"                MAPPINGS
"-------------------------------------------

" leader key for custom mappings
let mapleader=','

" move up and down within wrapped lines
noremap j gj

" make Y consistent w/ D and C
noremap k gk
nmap Y y$

" increase/decrease indentation in visual mode with tab/shift-tab
xmap <TAB> >gv
xmap <S-TAB> <gv

" autocomplete
inoremap <C-Space> <C-n>
inoremap <M-Space> <C-p>

" clear the command line and search highlighting
noremap <C-l>     :nohlsearch<CR>
noremap <leader>/ :nohlsearch<CR>

" copy current file path to system pasteboard.
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>

" regenerate tags, with or without gemhome included
map <leader>rt :!ctags -R --exclude=.git --exclude=log *<CR>
map <leader>rT :!ctags -R --exclude=.git --exclude=log * `rvm gemhome`/*<CR>

" jump to a tag in vertical split. ('control-w ]' already does this with a horizontal split)
nnoremap <C-w><C-]>  :exec      "vertical belowright stag" expand("<cword>")<CR>
nnoremap <C-w>g<C-]> :exec      "vertical belowright stselect" expand("<cword>")<CR>
vnoremap <C-w><C-]>  :<C-w>exec "vertical belowright stag" GetCurrentVisualSelection()<CR>
vnoremap <C-w>g<C-]> :<C-w>exec "vertical belowright stselect" GetCurrentVisualSelection()<CR>

"-------------------------------------------
"                 PLUGIN CONFIG
"-------------------------------------------

" commentary - toggle comments
nmap <D-/> <plug>CommentaryLine
xmap <D-/> <plug>Commentarygv
imap <D-/> <C-o><plug>CommentaryLine
map <leader>c <plug>Commentary
nmap <leader>cc <plug>CommentaryLine

" ack - search in project
noremap  <D-F> :Ack!<space>
vnoremap <D-F> :<C-w>exec "Ack! '" . GetCurrentVisualSelection() . "'"<CR>

" nerdtree - project drawer
map \  :NERDTreeToggle<CR>
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

"-------------------------------------------
"                 AUTO-COMMANDS
"-------------------------------------------

" json
autocmd BufRead,BufNewFile *.json set filetype=javascript

" jasmine fixtures
autocmd BufRead,BufNewFile *.jasmine_fixture set filetype=html

" ruby
autocmd BufRead,BufNewFile *.thor set filetype=ruby
autocmd BufRead,BufNewFile *.god set filetype=ruby
autocmd BufRead,BufNewFile Gemfile* set filetype=ruby
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile soloistrc set filetype=ruby
autocmd FileType ruby imap  <Space>=><Space>

" plain text
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd BufRead,BufNewFile *.text set filetype=text
autocmd BufRead,BufNewFile *README* set filetype=text
autocmd FileType text set autoindent

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

command! -nargs=+ Qfdo call Qfdo(<q-args>)
function! Qfdo(command)
  let buffer_numbers = {}
  for fixlist_entry in getqflist()
    let buffer_numbers[fixlist_entry['bufnr']] = 1
  endfor
  let buffer_number_list = keys(buffer_numbers)

  for num in buffer_number_list
    try
      silent exec 'buffer' num
      exec a:command
      update
    catch
      echo "Aborted."
      return
    endtry
  endfor
  echo "Done."
endfunction

command! -nargs=* -complete=file GS call GlobalReplace(<q-args>)
function! GlobalReplace(args)
  let args = split(a:args)
  let substitute_pattern = args[0]
  let paths = args[1:]
  let separator = matchstr(substitute_pattern, '^.')
  let search_pattern = split(substitute_pattern, separator, 1)[1]

  call DoGrep(search_pattern, paths)
  exec "Qfdo %S" . substitute_pattern
endfunction

function! DoGrep(search_pattern, paths)
  let grep_command = exists(':Ggrep') ? "Ggrep " : "Ack! "
  let cmd = grep_command . a:search_pattern . ' ' . join(a:paths, ' ')
  echo cmd
  silent exec cmd
  copen
  wincmd p
endfunction

" Compile coffeescript and put it in a vertical window
map <leader>cs :CoffeeCompile vert<cr>


" Kill trailing whitespace on save
"
function! KillTrailingWhitespace()
  let winview = winsaveview()
  exec ':%s/\s\+$//e'
  call winrestview(winview)
endfunction

autocmd BufWritePre * :call KillTrailingWhitespace()

noremap <leader>ev :vsplit $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>es :vsplit ~/.vim/snippets<cr>

"-------------------------------------------
"                 LOCAL CONFIG
"-------------------------------------------

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

