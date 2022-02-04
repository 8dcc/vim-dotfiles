syntax on
" set t_Co=256
set termguicolors
colors molokai
set number

set tabstop=4
set shiftwidth=4
"set expandtab

" ---------- TERMINAL MODE --------

" For exiting terminal mode with esc only
:tnoremap <Esc> <C-\><C-n>

" ---------- STATUS LINE ----------

set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
" set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

" ---------- TAB FILE COMPLETION ---------

set wildmode=longest,list,full
set wildmenu

" --------- FILENAMES (TABLINE) ----------

if has('gui')
  set guioptions-=e
endif
if exists("+showtabline")
  function MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#') " Colors
      let s .= ' '
      let wn = tabpagewinnr(i,'$')

      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#') " Colors
      let s .= '[' . i . ']'  " Page number
      let s .= ' ' " Space after page number
      let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#') " Colors
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        " let file = '[No Name]'
        let file = 'Unnamed'
      endif
      let s .= file.(getbufvar(buflist[winnr - 1], "&mod")?'+':'').' '
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    "let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
  highlight link TabNum Special
  map    <C-Tab>    :tabnext<CR>
  imap   <C-Tab>    <C-O>:tabnext<CR>
  map    <C-S-Tab>  :tabprev<CR>
  imap   <C-S-Tab>  <C-O>:tabprev<CR>
endif

set hidden
set guitablabel=\[%N\]\ %t\ %M

" --------- PLUGINS ---------

" Install and run vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'Townk/vim-autoclose'
Plug 'mg979/vim-visual-multi'

call plug#end()
