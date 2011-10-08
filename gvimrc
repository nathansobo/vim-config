set guifont=Monaco:h15
set bg=dark
colorscheme solarized

" Start without the toolbar
set guioptions-=T
set guioptions-=L
set guioptions-=r

" Full size window
set columns=999
set lines=999

" *** MACVIM ONLY ***
if has("gui_macvim")

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-Enter for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>
endif

