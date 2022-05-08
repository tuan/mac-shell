if vim.g.vscode then
  vim.cmd([[source ~/mac-shell/vscode.vim]])
else 
  require('settings')
end
