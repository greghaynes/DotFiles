set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'

filetype plugin indent on     " required!

se ts=4
se sw=4
se expandtab
se nu
se ruler
se smartindent
se colorcolumn=80
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

syntax enable
colorscheme desert
se background=dark

autocmd FileType make setlocal noexpandtab

