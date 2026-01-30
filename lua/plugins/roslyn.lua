return {
  -- 禁用 LazyVim 默认的 csharp_ls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        csharp_ls = false,
      },
    },
  },
  -- Mason 注册表配置
  {
    "mason.nvim",
    opts = {
      registries = {
        "github:Crashdummyy/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  -- Roslyn LSP
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      filewatching = "off", -- Unity 项目关闭以提升性能
      broad_search = true, -- 支持嵌套解决方案结构
      lock_target = false,
    },
    config = function(_, opts)
      require("roslyn").setup(opts)

      vim.lsp.config("roslyn", {
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        settings = {
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
          },
        },
      })
    end,
  },
}
