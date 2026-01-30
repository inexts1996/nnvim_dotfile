# LazyVim 中 Unity + C# 开发环境配置指南

## 概述

本文档介绍如何在 LazyVim 中配置 Roslyn LSP 用于 Unity/C# 开发，获得完整的代码补全、跳转定义、inlay hints 等功能。

## 前提条件

- Neovim 0.10+
- LazyVim 配置
- .NET SDK 已安装
- 已启用 LazyVim extra: `lang.dotnet`

## 配置步骤

### 1. 创建插件配置文件

创建 `lua/plugins/roslyn.lua`：

```lua
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
  -- Mason 注册表配置（添加 roslyn 支持）
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
      broad_search = true,  -- 支持嵌套解决方案结构
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
```

### 2. 安装 Roslyn LSP 服务器

1. 重启 Neovim
2. 运行 `:Mason`
3. 搜索 `roslyn` 并按 `i` 安装

### 3. 配置说明

| 配置项 | 说明 |
|--------|------|
| `csharp_ls = false` | 禁用 LazyVim 默认的 csharp_ls，避免冲突 |
| `filewatching = "off"` | Unity 生成大量临时文件，关闭文件监视提升性能 |
| `broad_search = true` | 支持 Unity 嵌套项目结构 |
| `openFiles` 分析范围 | 只分析打开的文件，避免全解决方案分析导致卡顿 |
| `dotnet_search_reference_assemblies` | 支持搜索 Unity API 等外部库 |

## 使用方法

### 首次打开项目

1. 打开 Unity 项目中的任意 `.cs` 文件
2. 运行 `:Roslyn target`
3. 选择项目的 `.sln` 解决方案文件
4. 等待 LSP 初始化完成

### 常用命令

| 命令 | 说明 |
|------|------|
| `:Roslyn target` | 选择/切换解决方案 |
| `:Roslyn restart` | 重启 LSP |
| `gd` | 跳转到定义（支持反编译外部库） |
| `gr` | 查找引用 |
| `K` | 显示悬浮文档 |

### 验证 LSP 状态

```vim
:lua print(vim.inspect(vim.lsp.get_clients()))
```

应该能看到 `roslyn` 客户端信息。

## 常见问题

### Q: 打开 .cs 文件后没有补全

**A:** 运行 `:Roslyn target` 手动选择解决方案文件。

### Q: 出现 csharp_ls 相关提示

**A:** 确保在配置中设置了 `csharp_ls = false`。

### Q: LSP 启动时报 spawn 错误

**A:** 检查 Mason 中 roslyn 是否已安装，运行 `:Mason` 确认。

### Q: 大型 Unity 项目卡顿

**A:** 确保配置了：
- `filewatching = "off"`
- `dotnet_analyzer_diagnostics_scope = "openFiles"`
- `dotnet_compiler_diagnostics_scope = "openFiles"`

## 功能特性

配置完成后支持：

- 智能代码补全（包括未导入的命名空间）
- 跳转到定义（支持反编译外部库如 Unity API）
- 查找引用
- Inlay hints（参数名、类型提示）
- Code Lens（引用计数）
- 符号搜索
- 代码诊断
