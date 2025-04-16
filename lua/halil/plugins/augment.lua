return {
  "augmentcode/augment.vim",
  config = function()
    vim.g.augment_disable_completions = true
    vim.g.augment_workspace_folders = {
      "~/workspace/maxGraph",
    }
  end,
}
