" https://github.com/r4v10l1/vim-dotfiles
" I swear to god if that zesty ass bitch tries to copy my shit I will go crazy

" ---------- COLORS AND STYLE --------

" set t_Co=256
syntax on
set termguicolors
set number
colors molokai
"language en_US

"set cursorline
let g:indentLine_char = '│'

" ---------- TABS AND SPLITS ----------

set tabstop=4
set shiftwidth=4
set expandtab       " This replaces tabs with spaces (in this case 4)

set splitbelow
set splitright

" ---------- FOLDING ----------

set foldmethod=syntax       " Syntax folding method
set foldcolumn=0            " No column by default
set foldlevel=999           " Start with everything unfolded
set nofoldenable

" ---------- CURSORS --------

set mouse=a         " Enable mouse
let &t_SI = "\e[6 q"                    " Line mode in insert mode
let &t_EI = "\e[2 q"                    " Block mode in everything else
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0   " Had some problems and this fixed it (nvim issue 6005)
set guicursor=

" ---------- REMAPED KEYS --------

nnoremap d "_d
vnoremap d "_d

" ---------- TERMINAL MODE --------

" For exiting terminal mode with esc only
:tnoremap <Esc> <C-\><C-n>

" ---------- STATUS LINE ----------

set statusline=
set statusline+=\ %F\ %M\ %R
set statusline+=%=									" From here justify to the right
" set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" set statusline+=\ ascii:\ \%b\ \|\ row:\ %2l\ col:\ %2c\ percent:\ %3p%%
set statusline+=\ %Y\ \|\ ascii:\ \%3b\ \|\ row:\ %2l\ col:\ %2c\ \|\ %3p%%		" Moved the file file type to the righ

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
"Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
Plug 'ollykel/v-vim'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'

call plug#end()
