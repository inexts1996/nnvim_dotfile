-- lua/plugins/roslyn.lua
return {
  -- 添加自定义 Mason 注册表
  {
    "mason.nvim",
    opts = {
      registries = {
        "github:Crashdummyy/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  -- 安装并配置 Roslyn LSP
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    config = function()
      require("roslyn").setup({
        config = {
          -- 这里可以添加额外的 LSP 设置
          settings = {
            ["csharp|inlay_hints"] = { csharp_enable_inlay_hints_for_implicit_variable_types = true },
          },
        },
      })
    end,
  },
}
