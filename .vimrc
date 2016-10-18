" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .myvimrc                                           :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: zaz <zaz@staff.42.fr>                      +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2013/06/15 12:36:36 by zaz               #+#    #+#              "
"    Updated: 2016/10/18 06:50:04 by hhismans         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'valloric/youcompleteme'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"let g:ycm_global_extra_conf = '/nfs/2014/h/hhismans'
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_disable_for_file_larger_than_kb = 0
"let g:ycm_extra_conf_globlist = ['~/work/*']

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set term=xterm-256color
"nnoremap ccom i/********************************<esc>o   <esc>o<bs><bs><bs><bs>********************************/<esc>ka


" Syntastic
"let g:syntastic_cpp_compiler_options = -Wall -Wextra -Werror -I."
"let g:syntastic_cpp_check_header = 1

"Put your custom Vim configuration here
"execute pathogen#infect()
"filetype plugin indent on

syntax on
set nowrap
set mouse=a
set ruler
set colorcolumn=80
set showmatch
set list
" Showing tab
set listchars=tab:>-,trail:-
highlight SpecialKey guifg=grey ctermfg=darkgrey


set nocompatible
set number

"Better command completion
set wildmenu
set wildmode=list:longest

"comment
autocmd FileType c,objc setlocal comments=s:/*,m:**,ex:*/



nnoremap com i/*<esc>o<esc>o/<esc>kA
nnoremap ccom i/*<esc>oNAME<tab><tab><tab>:<tab><esc>oDESCRIPTION<tab>:<tab><esc>oINPUT<tab><tab>:<tab><esc>oRETURN VALUE<tab>:<tab><esc>o/<esc>kkkkA

"Show current line
set cursorline
set background=dark
colorscheme hybrid
".h buf
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! :Stdheader\<cr>"
  execute "normal! i#ifndef " . gatename
  execute "normal! o# define " . gatename
  execute "normal! Go#endif"
  normal! kk
endfunction
autocmd BufNewFile *.{h} call <SID>insert_gates()

"hpp buf
function! s:insert_class_hpp()
  let gatename_h = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  let gatename = substitute((expand("%:t")), ".class.hpp", "", "g")
  execute "normal! :Stdheader\<cr>"
  execute "normal! i#ifndef " . gatename_h
  execute "normal! o# define " . gatename_h
  execute "normal! o"
  execute "normal! oclass " . gatename
  execute "normal! o{"
  execute "normal! opublic:"
  execute "normal! o". gatename . "( void );"
  execute "normal! o". gatename . "( ". gatename . " const & src );"
  execute "normal! o~". gatename . "( void );"
  execute "normal! o"
  execute "normal! o". gatename . " &	operator=( ". gatename . " const & rhs);"
  execute "normal! oprivate:"
  execute "normal! o};"
  execute "normal! Go#endif"
  normal! kk
endfunction
autocmd BufNewFile *.{class.hpp} call <SID>insert_class_hpp()

function! s:insert_class_cpp()
  let gatename = substitute((expand("%:t")), ".class.cpp", "", "g")
  execute "normal! :Stdheader\<cr>"
  execute "normal! i" . gatename . "::" . gatename . "( void )"
  execute "normal! o{"
  execute "normal! o}"
  execute "normal! o"
  execute "normal! o" . gatename . "::" . gatename . "( " . gatename . " const & src )"
  execute "normal! o{"
  execute "normal! o}"
  execute "normal! o"
  execute "normal! o" . gatename . "::~" . gatename . "( void )"
  execute "normal! o{"
  execute "normal! o}"
  execute "normal! o". gatename." &" . gatename . "::operator=( " . gatename . " const & rhs )"
  execute "normal! o{"
  execute "normal! o}"
  normal! kk
endfunction
autocmd BufNewFile *.{class.cpp} call <SID>insert_class_cpp()

autocmd BufNewFile *.class.php  0r ~/DIV/template/tmpl.class.php


" auto open or close NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" NERDTree -----------------------------

" toggle nerdtree display
map <F5> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

inoremap  jk <esc>

vnoremap wh :tabprev
vnoremap wh :tabprev<cr>
nnoremap wh :tabprev
nnoremap wh :tabprev<cr>
"inoremap wh :tabprev
"inoremap wh :tabprev<cr>

vnoremap wl :tabnext
vnoremap wl :tabnext<cr>
nnoremap wl :tabnext
nnoremap wl :tabnext<cr>
"inoremap wl :tabnext
"inoremap wl :tabnext
