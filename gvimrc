set guifont=Monaco:h15
set bg=dark
colorscheme ir_black

" Start without the toolbar
set guioptions-=T
set guioptions-=L
set guioptions-=r

" Full size window
set columns=999
set lines=999

" highlight current row.
set cursorline

" *** MACVIM ONLY ***
if has("gui_macvim")

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-Enter for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>
endif

"-------------------------------------------
"                 LOCAL CONFIG
"-------------------------------------------

if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

