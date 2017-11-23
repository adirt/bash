set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set nobackup		" don't keep a backup file
set nowritebackup		" don't keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                     " than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch           " search text incrementally
set nu                  " shows line numbers on each line
"set showmatch           " Show matching brace
set iskeyword+=$,#   " Stop using these things as word dividers

set autoindent          " auto indent
set si                  " smart indent

"avoid manespace identation
set cino=N-s
"sort friend indentation
set cinoptions+=g1,h2

"set nocp
filetype plugin on

" Spaces are better than a tab character
set expandtab           
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set guifont=Monaco:h18
      
"typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

:command WWW tabdo :w

set foldmethod=syntax
set foldlevelstart=200
map <SPACE> za

"------------------------------
" tab navigation like firefox
"------------------------------
map <C-Left> :tabprevious<CR>
map <C-Right> :tabnext<CR>
map <C-Up> :tabfirst <CR>
map <C-Down> :tablast<CR>
map <C-t> :tabnew <CR>

imap <C-Left> <ESC>:tabprevious<CR> i
imap <C-Right> <ESC>:tabnext<CR> i
imap <C-Up> <ESC>:tabfirst <CR>i
imap <C-Down> <ESC>:tablast<CR>i
imap <C-t> <ESC>:tabnew <CR>i
 
nmap <C-Left> :tabprevious<CR>
nmap <C-Right> :tabnext<CR>
nmap <C-Up> :tabfirst <CR>
nmap <C-Down> :tablast<CR>
nmap <C-t> : tabnew <CR>

"------------------------------
"move tabbs
"------------------------------
map <C-H> :execute "tabmove" tabpagenr() - 2<CR>
map <C-L> :execute "tabmove" tabpagenr()<CR>
map <C-J> :tabm 0<CR>
map <C-K> :tabm<CR>

imap <C-L> <ESC>:execute "tabmove" tabpagenr()<CR> i 
imap <C-J> <ESC>:tabm 0 <CR>i
imap <C-K> <ESC>:tabm<CR>i
 
nmap <C-H> :execute "tabmove" tabpagenr() - 2<CR>
nmap <C-L> :execute "tabmove" tabpagenr()<CR>
nmap <C-J> :tabm 0 <CR>
nmap <C-K> :tabm<CR>
"------------------------------
"Add some colors to teh tabs..
"------------------------------
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=Yellow
hi Title ctermfg=LightBlue ctermbg=Magenta

" Undo in Insert mode (CTRL+Z)
imap <c-z> <ESC>ui

nnoremap <C-a> :let @/=expand("<cword>")<Bar>split<Bar>normal n<CR>
nnoremap <C-A> :let @/='\<'.expand("<cword>").'\>'<Bar>split<Bar>normal n<CR>

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" Don't use Ex mode, use Q for formatting
map Q gq

"if has("terminfo")
  "set t_Co=16
  "set t_ABet t_AFe
  "set t_Co=16
"witch syntax highlighting on, when the terminal has colors
"" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
  "syntax on
  "set hlsearch
  "highlight cCommentL       ctermfg=6
  "highlight cCommentStart   ctermfg=6
  "highlight cComment        ctermfg=6
  "highlight cCommentSkip    ctermfg=6
  "highlight Number          ctermfg=LightRed
  "highlight TabLineSel ctermfg=Red ctermbg=Yellow
"endif

syntax enable
set background=dark
"colorscheme solarized


"----------------------------------------------------------------------
" Improved next (search) 
"----------------------------------------------------------------------
"nnoremap  n :call MyNext("n", 1)<CR> 
"nnoremap  N :call MyNext("N", -1)<CR>

function MyNext(cmd, next_dir)
  let v:errmsg = ""
  let initialLine = line('.') 
  exec "normal! ".(a:cmd) 
   if ((line('.') - initialLine) * a:next_dir < 0) 
   "Beep
   exec "normal \<ESC>"  
   endif 
endfunction 


"----------------------------------------------------------------------
" Go to start/Enf of block 
"----------------------------------------------------------------------
function GoToStartOfBlock()
   call searchpair ("{", "", "}")
   "normal %j
endfunction

function GoToEndOfBlock()
   "normal 0
   "let cur_line = line(".")
   "call search("{", "b")
   "let b_start = line(".")
   "normal %
   "let b_end = line(".")
   "while b_end < cur_line
      "call search("{", "b")
      "let b_start = line(".")
      "normal %
      "let b_end = line(".")
   "endwhile
   call searchpair ("{", "", "}")
endfunction

noremap <silent> { :call GoToStartOfBlock()<CR> 
noremap <silent> } :call GoToEndOfBlock()<CR>


"----------------------------------------------------------------------
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1    " show function parameters
let OmniCpp_MayCompleteDot = 1         " autocomplete after .
let OmniCpp_MayCompleteArrow = 1       " autocomplete after ->
let OmniCpp_MayCompleteScope = 1       " autocomplete after ::
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


function! Tab_Or_Complete()
   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
      return "\<C-N>"
   else
      return "\<Tab>"
   endif
endfunction

imap <Tab> <C-R>=Tab_Or_Complete()<CR>

"----------------------------------------------------------------------
" Rainbow
let g:rainbow_active = 1 

