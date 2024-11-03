# Neovim Configuration

My personal Neovim configuration with Go development support.

![Cover](./cover.png)

## Prerequisites

- Neovim >= 0.9.0
- Git
- GCC (for TreeSitter)
- ripgrep (for Telescope fuzzy finder)
- Go (for Go development)

## Installation

### 1. Backup your existing config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone this repository

```bash
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
```

### 3. Install required Go tools

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install golang.org/x/tools/cmd/goimports@latest
```

### 4. Start Neovim

The first time you start Neovim, it will:

1. Install lazy.nvim (package manager)
2. Install all plugins
3. Install LSP servers via Mason

Run these commands after first install:

```vi
:Lazy sync
:TSInstall go
:Mason
```

In Mason, ensure these are installed:

- gopls
- gofumpt
- goimports
- staticcheck

## Key Features

- File Explorer (NvimTree)
- LSP Support
- Autocompletion
- Fuzzy Finding
- Go Development Support
- Auto-formatting
- Git Integration

## Key Mappings

### General

- `<Space>` - Leader key
- `<Space>e` - Toggle file explorer
- `<Space>ff` - Find files
- `<Space>fg` - Find text in files
- `<Space>w` - Save file
- `<Ctrl>h/j/k/l` - Navigate splits

### Go Development

- `<Space>gt` - Run tests
- `<Space>gr` - Run program
- `<Space>gi` - Go Install
- `<Space>gim` - Go Implement
- `<Space>gd` - Go to Definition

### Code Navigation

- `gd` - Go to definition
- `gr` - Find references
- `K` - Show documentation
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code action

### Completion

- `<Tab>` - Next completion
- `<S-Tab>` - Previous completion
- `<CR>` - Accept completion
- `<Ctrl>Space` - Show completion menu

## Structure

```
~/.config/nvim/
├── init.lua           # Main configuration file
└── lazy-lock.json     # Plugin lock file
```

## Updating

To update plugins:

```vim
:Lazy update
```

To update Go tools:

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install golang.org/x/tools/cmd/goimports@latest
```

## Troubleshooting

### If plugins aren't working

1. Clear Neovim data:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

2. Restart Neovim and run:

```vim
:Lazy sync
:TSInstall go
```

### If LSP isn't working

1. Check Mason installation:

```vim
:Mason
```

2. Verify Go tools installation:

```bash
which gopls
which gofumpt
which goimports
```

3. Check LSP status in Neovim:

```vim
:LspInfo
```
m
