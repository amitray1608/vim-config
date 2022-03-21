set nocompatible
filetype off

set rtp+=/home/ryuzaki/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'SirVer/ultisnips'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'crusoexia/vim-monokai'
Plugin 'itchyny/lightline.vim'
Plugin 'morhetz/gruvbox'
Plugin 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plugin 'lifepillar/vim-solarized8'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()

let g:snipMate = { 'snippet_version' : 1 }
filetype plugin indent on
set laststatus=2
set mouse=a
set tabstop=2
set shiftwidth=2
set smarttab
set autoindent
set autoread
syntax on
set number
set softtabstop=0
set expandtab
set title
set clipboard=unnamedplus
"set nowrap

if !has('nvim')
set t_Co=256
endif

" Let's save undo info!
if !isdirectory($HOME."/.vim")
call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

let g:solarized_visibility='high'
syntax enable
set background=dark
"colorscheme sublimemonokai
"colorscheme solarized8_high
"colorscheme desert
packadd! dracula
syntax enable
colorscheme dracula
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

if has('nvim')
" For neovim 0.1.7
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
" For neovim 0.2
set guicursor=blah
else
if $TERM =~ '^xterm|rxvt'
" Insert mode
let &t_SI = "\e[5 q"
" Replace mode
if has("patch-7.4-687")
let &t_SR = "\e[3 q"
endif
" Normal mode
let &t_EI = "\e[2 q"

" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
endif
endif
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction


nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>
imap <C-d> <C-[>diwi
noremap <F4> :!<CR>
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
nnoremap <C-a> ggmqvG"+y'q
noremap <C-S> :w<CR>
noremap <C-T> :tabn<CR>
noremap <C-N> :tabe<CR>
noremap <F7> :make all && make test<CR>
noremap <F8> :!gnome-terminal -- bash -c " g++ -std=c++17 -Wall -O2 %:r.cpp -o %:r ; echo;echo; echo Press ENTER to continue; read line;exit; exec bash" <CR><CR>
autocmd Filetype python noremap <F9> :w \| :!gnome-terminal -- bash -c "python3 % ; echo;echo; echo Press ENTER to continue; read line;exit; exec bash" <CR><CR>
autocmd Filetype c,cpp noremap <F9> :w \| :!gnome-terminal -- bash -c "g++ -std=c++17 -pedantic -Wall -Wunused -Wuninitialized -Wfloat-equal -Woverflow -Wshadow -Wextra -Wconversion -DDEBUG %:r.cpp -o %:r ; echo;echo; echo Press ENTER to continue; read line;exit; exec bash" <CR><CR>
noremap <c-F10> :!gnome-terminal -- bash -c "./"%<"; echo;echo; echo Press ENTER to continue; read line;exit; exec bash" <CR><CR>
noremap <c-B> :!gnome-terminal -- bash -c "./"%<" < in ; echo;echo; echo Press ENTER to continue; read line;exit; exec bash" <CR><CR>
n
