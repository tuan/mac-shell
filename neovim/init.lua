if vim.g.vscode then
  vim.cmd([[source ~/mac-shell/neovim/vscode.vim]])
else 
  require('settings')
end
