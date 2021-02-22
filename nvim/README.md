# Neovim

## Installing

### Windows

1. Download and install the nightly version of [Neovim](https://github.com/neovim/neovim/releases).
   It must be extracted to the `C:\tools` directory (i.e. the binary should be found at `C:\tools\Neovim\bin\nvim-qt.exe`) so that the context menu registry hacks work.
   The nightly version is required so that the language server plugin works.

2. Install [Vim-Plug](https://github.com/junegunn/vim-plug).

3. Link the nvim configuration file by running `mklink /H %LOCALAPPDATA%\nvim\init.vim init.vim` from the console.

4. Run Neovim and execute the command `:PlugInstall` to install plugins.

5. (Optional) Install the context menu shortcuts with by running the `add_context_menu_shortcuts.reg` file.

## Updating

1. Run the `:PlugInstall` command to install any new plugins.

## Uninstalling

### Windows

1. (Optional) Remove the context menu shortcuts by running the `remove_context_menu_shortcuts.reg` file.

2. Remove the Neovim configuration data by deleting the directory `%LOCALAPPDATA%\nvim`.

3. Remove the Neovim program by deleting the directory `C:\tools\Neovim`.

