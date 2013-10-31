se ts=4
se sw=4
se expandtab
se nu
se ruler
se smartindent

execute pathogen#infect()
syntax enable
filetype plugin indent on

se background=dark
let g:solarized_termcolors = &t_Co
let g:solarized_termtrans = 0
colorscheme solarized

autocmd FileType make setlocal noexpandtab

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=80
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
