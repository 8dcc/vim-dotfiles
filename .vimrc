" https://github.com/r4v10l1/vim-dotfiles
" I swear to god if that zesty ass bitch tries to copy my shit I will go crazy

" ---------- COLORS AND STYLE --------

" set t_Co=256
"language en_US
syntax on
set termguicolors
set number relativenumber
colors molokai

" ---------- CLIPBOARD ----------

set clipboard=unnamedplus

" ---------- CASE ----------

set ignorecase
set smartcase

" ---------- TABS AND SPLITS ----------

set tabstop=4
set shiftwidth=4
set expandtab       " This replaces tabs with spaces (in this case 4)

" Removes 'r' and 'o' from formatoptions. Removes autocomments on newline
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

set splitbelow      " Make splits split to the right and below instead of up and left
set splitright

" ---------- FOLDING ----------

set foldmethod=syntax       " Syntax folding method
set foldcolumn=0            " No column by default
set foldlevel=999           " Start with everything unfolded
set nofoldenable            " Disable folding by default when opening a buffer

" ---------- CURSORS --------

set mouse=a                             " Enable mouse
let &t_SI = "\e[6 q"                    " Line mode in insert mode
let &t_EI = "\e[2 q"                    " Block mode in everything else
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0   " Had some problems and this fixed it (nvim issue 6005)
"set guicursor=

" ---------- PLUGIN SETTINGS --------

" r4v10l1/vim-fourmolu
let g:fourmolu_executable = "fourmolu"
let g:fourmolu_write = 0
command HaskellFmt FourmoluFmt          " Unfortunately custom commands must start with an uppercase letter

" lukas-reineke/indent-blankline.nvim
let g:indentLine_char = '│'     " You might wanna use '¦' if there are spaces between lines
let g:indent_blankline_show_trailing_blankline_indent = v:false     " See lukas-reineke/indent-blankline.nvim#469

" ---------- REMAPED KEYS --------

" Remove yanking when deleting
nnoremap d "_d
vnoremap d "_d

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ---------- TERMINAL MODE --------

" For exiting terminal mode with esc only
:tnoremap <Esc> <C-\><C-n>

" Remove line numbers when we open a terminal
autocmd TermOpen * setlocal nonumber norelativenumber

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
"Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'rhysd/vim-clang-format'
Plug 'r4v10l1/vim-fourmolu'

call plug#end()
