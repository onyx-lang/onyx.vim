# Onyx.vim

Syntax highlighting for Onyx in Vim and NeoVim.

## Installation

Use your package manager of choice to include this repository.

Here an example using [Plug](https://github.com/junegunn/vim-plug) for *Vim*.

```vim
Plug 'onyx-lang/onyx.vim'
```

Here an example using [Packer](https://github.com/wbthomason/packer.nvim) for *NeoVim*.

```lua
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'onyx-lang/onyx.vim'
end)
```

## Configuration

You need to tell Vim/NeoVim to use the `onyx` syntax for `.onyx` files.
This can be done in the following way.

*Vim* - `.vimrc`

```vim
augroup onyx_ft
    au!
    autocmd BufNewFile,BufRead *.onyx set syntax=onyx
augroup END
```

*NeoVim* - `init.lua`

```lua
vim.filetype.add {
    extension = {
        onyx = "onyx",
    },
    pattern = {
        [".*onyx$"] = "onyx",
    },
}
```
