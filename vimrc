call pathogen#infect()
call pathogen#helptags()
set autoindent
set number
set showcmd
set mouse=a
set ts=2
set sw=2
set expandtab
set foldmethod=manual
set number

set listchars=tab:>.,trail:.
set list
set hlsearch

if $SHELL =~ '/bin/fish'
  set shell=/bin/bash
endif

filetype plugin indent on
set ofu=syntaxcomplete#Complete
:highlight Pmenu ctermbg=brown gui=bold
syntax on

set foldmethod=indent
set nofoldenable

set wildmode=longest,list
set wildmenu

colorscheme molokai
set guifont=terminus

map <leader>n :NERDTreeToggle<enter>
map <leader>s :w<enter>:SyntasticCheck<enter>:Errors<enter>
map <leader>c :CoffeeCompile<enter>
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

" This bit is responsible for setting s to correspond to single character inserts
function! RepeatChar(char, count)
   return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>


let coffee_compile_vert = 1
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['ruby', 'php'],
                           \ 'passive_filetypes': ['puppet', 'java', 'c'] }

let g:syntastic_error_symbol='E'
let g:syntastic_warning_symbol='W'
let g:instant_markdown_slow=1


autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
au BufNewFile,BufRead *.thrift set filetype=thrift
au BufNewFile,BufRead *.fish   set filetype=fish
au BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType ruby   setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType java   setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType markdown setlocal tw=79 syntax=off
