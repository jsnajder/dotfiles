set completeopt=longest,menu

set wildmode=longest,list

command Puh execute "highlight Normal ctermfg=grey ctermbg=darkblue"

" execute pathogen#infect()
" syntax on
" filetype plugin indent on

" Pathogen load 
filetype off

call pathogen#infect() 
call pathogen#helptags()

filetype plugin indent on 
syntax on

