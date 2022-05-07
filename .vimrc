if exists('g:vscode')
  echo 'Loading vscode settings successfully'
  so ~/.config/init.vscode.vim
else
  so ~/.config/vimrc
endif
