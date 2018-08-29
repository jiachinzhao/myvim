" Vundle
" ---------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required
"filetype Plugin on
set nomodeline
set fdm=syntax
set t_Co=256

" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install Plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
"Plug 'gmarik/Vundle.vim'
" Plug 'SirVer/ultisnips'

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#begin('~/.vim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/neocomplete'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go'
Plug 'adamclerk/vim-razor'
Plug 'pangloss/vim-javascript'
Plug 'myint/indent-finder'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'ponzellus/AnsiEsc'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'Yggdroot/indentLine'
Plug 'KurtPreston/vim-autoformat-rails'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'godlygeek/tabular'
Plug 'konfekt/fastfold'
Plug 'christoomey/vim-tmux-navigator'
Plug 'posva/vim-vue'
Plug 'maksimr/vim-jsbeautify'
Plug 'buoto/gotests-vim'
" Plug 'plasticboy/vim-markdown'
" Plug 'suan/vim-instant-markdown'

" All of your Plugins must be added before the following line
"
"
call plug#end()            " required
filetype plugin indent on    " required

" self settings
" ---------------------------------------------------------------------------
syntax on
set nowrap
set nu ai
set ts=4 sw=4
set completeopt-=preview
set bg=dark
set clipboard=unnamed
syntax on
set background=dark
" colorscheme jellybeans
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936
let g:indentLine_color_term = 236

"Automatically remove trailing spaces when saving a file.
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
let g:neocomplete#enable_at_startup = 1
" let g:airline#extensions#tabline#enabled = 1

au FileType ruby let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

au BufNewFile,BufRead,BufWrite *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix

"au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2 softtabstop=2 shiftwidth=2
"\ set tabstop=2 |
"\ set softtabstop=2 |
"\ set shiftwidth=2

au BufWrite *.rb :silent! call AutoFormatRails()<CR>

au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/thrift.vim

" vim-go settings
" ---------------------------------------------------------------------------
let g:go_disable_autoinstall = 1
let g:go_fmt_command = "goimports"
" let g:go_auto_type_info = 1

" tagbar
let g:tagbar_right = 1
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
	\ }

" syntastic
" ---------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_go_checkers = ['golint', 'govet', 'errorcheck']
let g:syntastic_aggregate_errors = 1


au FileType go let g:syntastic_auto_loc_list = 0

" key mapping
" ---------------------------------------------------------------------------
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)

nmap <C-h> :CtrlPBuffer<CR>
nmap <C-y> :NERDTreeToggle<CR>

map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'go'
        exec "!time go run %"
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    endif
endfunc
if exists('$TMUX')
   set term=screen-256color
endif
