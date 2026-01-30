# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on **LazyVim**. The configuration extends LazyVim with custom plugins for C#/.NET development, Neovide GUI support, and AI integration.

## Commands

**Plugin Management:**
- `:Lazy` - Open lazy.nvim dashboard
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync plugins with lazy-lock.json

**Code Formatting:**
```bash
stylua lua/    # Format all Lua files
```

**LSP/Mason:**
- `:Mason` - Open Mason package manager for LSP servers, formatters, linters

## Architecture

```
lua/
├── config/           # Core configuration (loaded by LazyVim)
│   ├── lazy.lua      # Plugin manager bootstrap and setup
│   ├── options.lua   # Neovim options (extends LazyVim defaults)
│   ├── keymaps.lua   # Custom key mappings
│   └── autocmds.lua  # Auto commands
└── plugins/          # Plugin specifications (auto-loaded by lazy.nvim)
    ├── colorscheme.lua   # Theme configs (evergarden active)
    ├── neovide.lua       # Neovide GUI settings
    └── roslyn.lua        # C#/Roslyn LSP setup
```

**Entry Point:** `init.lua` requires `config.lazy` which bootstraps lazy.nvim and imports LazyVim.

**Plugin Pattern:** Each file in `lua/plugins/` returns a table of plugin specs that lazy.nvim merges with LazyVim's defaults.

## LazyVim Extras Enabled

From `lazyvim.json`:
- `ai.claudecode` - Claude Code integration
- `coding.nvim-cmp` - Completion framework
- `lang.dotnet` - .NET/C# language support
- `lang.markdown` - Markdown editing
- `util.project` - Project management

## Code Style

- **Formatter:** StyLua (2-space indent, 120 column width)
- **Config:** `stylua.toml`

## Key Customizations

- **Colorscheme:** Evergarden (winter variant, green accent)
- **C# LSP:** Uses roslyn.nvim with custom Mason registry (`github:Crashdummyy/mason-registry`)
- **Neovide:** JetBrains Maple Mono font, railgun cursor animation, 120Hz refresh
