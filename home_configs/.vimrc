" Nathan Parker's .vimrc

" ====== Syntastic =====
" https://github.com/scrooloose/syntastic/blob/master/doc/syntastic.txt
"filetype off  " Required!
" set rtp+=~/.vim/bundle/vundle
" call vundle#rc()
" Self-manage Vundle
"Bundle 'gmarik/vundle'
"Bundle 'scrooloose/syntastic'
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 0

" === My visual style ===
set background=dark
syntax on
if has("gui_running")
  " Custom color file, from ~.vim/colors/
  "color midnight
  "color fog
  color desert
endif

" Pick a font
set guifont=Courier\ 10\ Pitch\ 12
"set guifont=DejaVu\ Sans\ Mono\ 12
set title


"What does this do?
"nmap <C-]> :exe 'Gtlist ' . expand('<cword>')<CR>

" Clang C++ formatter
noremap <C-K> :ClangFormat<CR>
inoremap <C-K> <C-O>:ClangFormat<CR>



" ====== Everything else ======

" Hit ctrl-x to go into "paste" mode, so you don't
" screw up all the indenting. (Screws up YCM!)
"set pastetoggle=<C-x>

" Always show status line, even when editing just one file
set laststatus=2

" Change tabs to 8 spaces. NO TAB CHARS
setlocal tabstop=8
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal textwidth=80

setlocal autoindent
setlocal cindent

" Don't highlight trailing spaces or leading tabs (set nolist)
"set nolist

" Highlight search results
set hlsearch

" Jump to last position in file
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

autocmd BufEnter *.txt set tw=80

" From yos..l@g 2008/12/03:
" Enable spell checking, even in program source files. Hit <F4> to highlight
" highlight spelling errors. Hit it again to turn highlighting off.
"
" And, if you cannot remember the keybindings, and/or too lazy to type
"
"     :help spell

" and read the manual, here is a brief reminder:
" ]s Next misspelled word
" [s Previous misspelled word
" z= Make suggestions for current word
" zg Add to good words list
"
if has("spell")
  setlocal spell spelllang=en_us  " American English spelling.
  set spellfile=~/.words.utf8.add " My ownn word list.

  " Toggle spelling with F4 key.
  map <F4> :set spell!<CR><Bar>:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)<CR>

  " Change the default highlighting colors and terminal attributes
  highlight SpellBad cterm=underline ctermfg=yellow ctermbg=gray

  " Limit list of suggestions to the top 10 items
  set sps=best,10

  "Turn spelling off by default for English UK.
  "Center is correctly spelled. Centre is not, and
  "shows with spell local colors. Misspelled words
  "show like soo.
  set nospell
endif
