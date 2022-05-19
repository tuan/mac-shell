let mapleader=" "

call plug#begin('~/.vim/vscode-plugged')
  " change surround, e.g. cs"' to change " to '
  Plug 'tpope/vim-surround'

  " fix dot repeat
  Plug 'tpope/vim-repeat'

  " use vscode easymotion when in vscode mode
  Plug 'asvetliakov/vim-easymotion'

  " select by indentation level: ai, ii, aI, iI
  Plug 'michaeljsmith/vim-indent-object'

  " <leader>w,b,e
  Plug 'bkad/CamelCaseMotion'

  " go replace
  Plug 'inkarkat/vim-ReplaceWithRegister'

  " text targets
  " add n or l to target next or previous (last) target, eg in'
  Plug 'wellle/targets.vim'

  " sneak
  Plug 'justinmk/vim-sneak'

  " highlight uniq char of every word in current line
  Plug 'unblevable/quick-scope'

call plug#end()

" Ignoring case
set ignorecase
set smartcase

" Incremental searching
set incsearch

" copy to clipboard
noremap <leader>y "+y

" paste from yank register
noremap zp "0]p
noremap zP "0]P

" sneak should respect vim ignore case settings
let g:sneak#use_ic_scs  = 1

" camel case motion
let g:camelcasemotion_key = '\'

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}

"" vscode only settings
nnoremap \m <Cmd>call VSCodeNotify('bookmarks.toggle')<CR>
nnoremap \l <Cmd>call VSCodeNotify('bookmarks.listFromAllFiles')<CR>
" fuzzy find
nnoremap \f <Cmd>call VSCodeNotify('fuzzySearch.activeTextEditor')<CR>

"quick scope hilight
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine
