call pathogen#infect()

syntax on

set t_Co=256                        " 256 Colors
set nocompatible                    " Use Vim settings, rather then Vi settings (much better!).

filetype plugin on
set ofu=syntaxcomplete#Complete

" ================ General Config ====================
set title                           " Update terminal window title
set visualbell                      " Turn off sounds
set showmode                        " Show the current mode
set showcmd                         " Show incomplete commands
set autoread                        " Reload files changed outside of vim
set ttyfast                         " Use a fast terminal connection
set ruler                           " Show the line and column number of the cursor position
set backspace=indent,eol,start      " Allow backspace in insert mode
set laststatus=2                    " Always show a status line
set encoding=utf-8                  " Default character encoding
set scrolloff=3                     " Start scrolling 3 lines from the bottom
set showtabline=2                   " Always Show Tab Line
set hidden
set nu!
set guifont=Consolas:h14

" ================ Indentation =======================
set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set wrap                            " Wrap lines
set textwidth=79                    " Width of text strings
set formatoptions=qrn1              " Set format options
set smarttab

autocmd FileType c,cpp,java,php,tcl,md autocmd BufWritePre <buffer> :%s/\s\+$//e

" ================ Completion ========================
set wildmode=list:longest
set wildmenu                        " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~         "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.psd

" ================ Searching =========================
set ignorecase                      " Ignore case when searching
set smartcase                       " Don't ignore case if search contains upper-case characters
set gdefault                        " Substitude command (:s) always does global search
set incsearch                       " Find the next match as we type the search
set hlsearch                        " Highlight searches by default

" ================ Colors ============================
colorscheme molokai
set background=dark

autocmd VimEnter * SpaceHi          " Tab Highlighting

highlight LineNr ctermfg=235
highlight Comment ctermfg=236
highlight Pmenu ctermfg=lightgrey ctermbg=234
highlight PmenuSel ctermfg=white ctermbg=darkgrey
highlight clear SpellBad

" ================ Plugins ===========================
" SuperTab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose = 1

" NerdTree
map <silent> <leader>n :NERDTreeTabsToggle<CR>
let NERDTreeDirArrows=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '\.os$', '\.dylib$', '\.a$', 'DS_STORE', '\.jpg$', '\.png$', '\.gif$', '\.pdf' ]
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" delimitMate
au FileType php let delimitMate_matchpairs = "(:),[:],{:}"

" CloseTag
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" CTags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=26
let g:tagbar_compact = 1
noremap <silent> <leader>/ :TagbarToggle<cr>
let g:tagbar_type_php  = {'ctagstype' : 'php', 'kinds'     : [ 'i:interfaces', 'c:classes', 'd:constant definitions', 'f:functions' ] }
autocmd FileType php nested :TagbarOpen

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=0

" Remember Last Position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" ================ Remapping =========================
" Navigate rows rather than lines
nnoremap <down> gj
nnoremap <up> gk

" Map leader from \ to ,
let mapleader=","

" diff current vi buffer edits against original file
nmap <silent> <leader>d :w !diff -u % -<CR>

" Switch between split screens
map <leader>, <C-W>w

" Resize Split Windows
map + <c-w>+
map _ <c-w>-
map \| <c-w><
map \ <c-w>>

" Write/quit fixes
:command WQ wq
:command Wq wq
:command W w
:command Q q

" open notes file
map <silent> <leader>h :tabnew ~/scripts/mocavo/mocavo_scripts.py<cr>

" tabs
map <silent> <c-n> :tabnew<cr>
map } gt
map { gT

" Reselect visual block after indenting
vmap > > gv
vmap < < gv

" Git
map <silent> <leader>b :Gblame<cr>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

