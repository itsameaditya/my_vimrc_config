cd C:\Users\Aditya\CP "the location where your programs are stored

set laststatus=2
set noshowmode

:let mapleader = "\<Space>"

set encoding=utf-8

set nocompatible              
filetype off                  
"<===================clears highlights==================>
nnoremap <esc> :noh<return><esc>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"<<<<<<Aesthetics =====================>>>>>>>>>>
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdcommenter'
Plugin 'rafi/awesome-vim-colorschemes'
" <<<<<<<<<<<<<<<<<<<<<<<<===============================important=============>>>
Plugin '907th/vim-auto-save'
Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
Plugin 'dense-analysis/ale'
Plugin 'djoshea/vim-autoread'

" <============================================>


call vundle#end()            " required
filetype plugin indent on    " required

"autosave
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save = 1 


"<========================moves current line up or down ==============================>
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

"<==========UI/UI===============================>
set wildmenu "graphical auto complete menu
set lazyredraw "redraws the screne when it needs to
set showmatch "highlights matching brackets
set incsearch "search as characters are entered
set hlsearch "highlights matching searches



set nocompatible            
filetype off                 

source $VIMRUNTIME/vimrc_example.vim
nnoremap <leader>cc= :0r C:/Users/Aditya/template.cpp<CR> 


" <<<<<<<<======================================NERDTREE==============================>>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


"<====================remapping basic configs ==============================================>
set clipboard=unnamed
au GUIEnter * simalt ~x
set hls
set is
set ts=4
set sw=4
set si
set noswapfile
set gfn=Fixedsys:h14

" <<<<<<<<==== font==========>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"if has("gui_running")
"  if has("gui_gtk2")
"    set guifont=Inconsolata\ 12
"  elseif has("gui_macvim")
"    set guifont=Menlo\ Regular:h14
"  elseif has("gui_win32")
"    set guifont=Consolas:h11:cANSI
 " endif
"endif


nnoremap <esc> :noh<return><esc>

imap jj <Esc>
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}


"<============================running c++ file===========================>
autocmd filetype cpp nnoremap <f5> :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <cr>
autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++17 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
"<==============================do not touch this part===============================================>
set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
