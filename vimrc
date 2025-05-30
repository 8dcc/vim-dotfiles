" https://github.com/8dcc/vim-dotfiles

"--- COLORS AND STYLE --------------------------------------------------------

"set t_Co=256
"language en_US
set termguicolors
colorscheme molokai-custom
set number relativenumber

syntax on
let g:load_doxygen_syntax=1     " Enable doxygen syntax

set colorcolumn=81  " Char limit for writing code. 81 so 80 is outside of it
set nowrap

"--- CLIPBOARD ---------------------------------------------------------------

set clipboard=unnamedplus       " Use system clipboard. See :checkhealth

"--- UNDO --------------------------------------------------------------------

set undofile

if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p")
endif

set undodir=~/.vim/undo

"--- CASE --------------------------------------------------------------------

set ignorecase      " Ignore lowercase or upercase when searching
set smartcase       " Overwrite if we are searching with a uppercase

"--- TABS AND SPLITS ---------------------------------------------------------

" Replace tabs with spaces (in this case 4)
set tabstop=4
set shiftwidth=4
set expandtab

" Remove 'r' and 'o' from formatoptions for removing autocomments on newline
"autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Make splits split to the right and below instead of up and left
set splitbelow
set splitright

" TODO: Explain
set hidden

"--- FOLDING -----------------------------------------------------------------

set foldmethod=syntax       " Syntax folding method
set foldcolumn=0            " No column by default
set foldlevel=999           " Start with everything unfolded
set nofoldenable            " Disable folding by default when opening a buffer

"--- CURSORS -----------------------------------------------------------------

set mouse=a                             " Enable mouse
let &t_SI = "\e[6 q"                    " Line mode in insert mode
let &t_EI = "\e[2 q"                    " Block mode in everything else

"--- FORMATTING --------------------------------------------------------------

" Use clang-format for formatting when using 'gq'. The program needs to read
" from stdin and write to stdout. See:
"   https://github.com/rhysd/vim-clang-format/issues/125
set formatprg=clang-format

"--- REMAPED KEYS ------------------------------------------------------------

" Remove yanking when deleting
nnoremap d "_d
vnoremap d "_d

" Move lines with Alt+<Dir>
nnoremap <A-Down> :m .+1<CR>
nnoremap <A-Up> :m .-2<CR>
vnoremap <A-Down> :m '>+1<CR>gv
vnoremap <A-Up> :m '<-2<CR>gv

" These are masked in DWM by default, but work with my build
nnoremap <A-j> :m .+1<CR>
nnoremap <A-k> :m .-2<CR>
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"--- TERMINAL MODE -----------------------------------------------------------

" Exit terminal mode with esc only
:tnoremap <Esc> <C-\><C-n>

" Remove line numbers when we open a terminal
if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber
endif

"--- STATUS LINE -------------------------------------------------------------

set statusline=
set statusline+=\ %F\ %M\ %R

" From here justify to the right
set statusline+=%=

" Moved the file file type to the right
set statusline+=\ %Y\ \|\ ascii:\ \%3b\ \|\ row:\ %2l\ col:\ %2c\ \|\ %3p%%
set laststatus=2

"--- TAB FILE COMPLETION -----------------------------------------------------

set wildmode=longest,list,full
set wildmenu

"--- FILENAMES (TABLINE) -----------------------------------------------------

if has('gui')
    set guioptions-=e
    set guitablabel=\[%N\]\ %t\ %M
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
                let file = 'Unnamed'
            endif

            let s .= file.(getbufvar(buflist[winnr - 1], "&mod") ? '+' : '').' '
            let i = i + 1
        endwhile

        let s .= '%T%#TabLineFill#%='
        "let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction

    " Only show tabs when there are 2 or more open.
    set stal=1

    " TODO: The color of the current tab is not being set. Perhaps related
    " to 'TabLineSel' above.
    set tabline=%!MyTabLine()

    highlight link TabNum Special

    " Tab keybinds
    map    <C-Tab>    :tabnext<CR>
    imap   <C-Tab>    <C-O>:tabnext<CR>
    map    <C-S-Tab>  :tabprev<CR>
    imap   <C-S-Tab>  <C-O>:tabprev<CR>
endif

"--- PLUGIN SETTINGS ---------------------------------------------------------

" [8dcc/vim-fourmolu]
let g:fourmolu_executable = "fourmolu"
let g:fourmolu_write = 0

" Unfortunately custom commands must start with an uppercase letter
command HaskellFmt FourmoluFmt

" [lukas-reineke/indent-blankline.nvim]
" You might wanna use '¦' (instead of '│') if there are spaces between lines.
let g:indentLine_char = '│'

" See lukas-reineke/indent-blankline.nvim#469
let g:indent_blankline_show_trailing_blankline_indent = v:false

" --- PLUGINS ----------------------------------------------------------------

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
Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v3.8.5' }
Plug 'junegunn/vim-easy-align'
Plug 'rhysd/vim-clang-format'
Plug '8dcc/vim-fourmolu'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'axvr/org.vim'
Plug 'jamessan/vim-gnupg'

call plug#end()
