function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

let mapleader=" "

call plug#begin()
  " change surround, e.g. cs"' to change " to '
  Plug 'tpope/vim-surround'

  " fix dot repeat
  Plug 'tpope/vim-repeat'

  " comment code
  Plug 'tpope/vim-commentary', Cond(!exists('g:vscode'))

  " <leader><leader>w,b,e
  " use normal easymotion when in vim mode
  Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
  " use vscode easymotion when in vscode mode
  Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })

  " <leader>/, ?, g/
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch.vim'

  " select by indentation level: ai, ii, aI, iI
  Plug 'michaeljsmith/vim-indent-object'

  " <leader>w,b,e
  Plug 'bkad/CamelCaseMotion'

  " fzf
  Plug 'junegunn/fzf', Cond(!exists('g:vscode'))
  Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))

  " theme
  Plug 'dracula/vim', Cond(!exists('g:vscode'), {'as':'dracular'})

  " status bar
  Plug 'vim-airline/vim-airline', Cond(!exists('g:vscode'))
  Plug 'vim-airline/vim-airline-themes', Cond(!exists('g:vscode'))

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

" fuzzy search
map <leader>/ <Plug>(incsearch-fuzzy-/)
map <leader>? <Plug>(incsearch-fuzzy-?)
map <leader>g/ <Plug>(incsearch-fuzzy-stay)

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

" highlight yank
if (has('nvim'))
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}
endif

if exists('g:vscode')
  " vscode only settings
  nnoremap zm <Cmd>call VSCodeNotify('bookmarks.toggle')<CR>
  nnoremap zl <Cmd>call VSCodeNotify('bookmarks.listFromAllFiles')<CR>

  "quick scope hilight
  highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
else
  set showcmd
  set autoindent

  " use space instead of tab
  set expandtab
  set smarttab

  " tab size
  set shiftwidth=2
  set softtabstop=2

  " Enable mouse support in console
  set mouse=a

  " Got backspace
  set backspace=2

  " Line Numbers PWN!
  set relativenumber

  " Highlight the current lint
  set cul

  " Cool tab completion stuff
  set wildmenu
  set wildmode=list:longest,full

  "fzf
  nmap <leader>b :Buffers<CR>
  nmap <leader>f :Files<CR>
  set rtp+=/opt/homebrew/opt/fzf

  let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!*.{min.js,swp,o,zip}"
  \ -g "!{.git,node_modules,vendor}/*" '

  command! -bang -nargs=* Find call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

  " remap jj to ESC
  imap jj <Esc>

  " theme
  colorscheme dracula

  if has("gui_running")
    set guifont=Inconsolata:h18
  endif
endif

