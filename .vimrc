set nocompatible              " be iMproved
filetype off                  " required!

set runtimepath^=~/.vim/bundle/ctrlp.vim

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
let g:solarized_termtrans=1
colorscheme solarized
se background=dark

autocmd FileType make setlocal noexpandtab

