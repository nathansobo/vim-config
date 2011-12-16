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

if exists("loaded_nerd_tree")
  augroup AuNERDTreeCmd
  autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()
endif

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

"-------------------------------------------
"                 LOCAL CONFIG
"-------------------------------------------

if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

