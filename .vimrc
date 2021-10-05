syntax on
set t_Co=256
colors zenburn
set number

" STATUS LINE

set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

" TAB COMPLETION

set wildmode=longest,list,full
set wildmenu
