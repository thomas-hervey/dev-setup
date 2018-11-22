# System Configuration

## System Preferences
- `env` lists all environment variables like `$PATH` and `$HOME`
  - `$PATH` is a directory (split by `:`) for the system to find executables, such as when running `python` or `pip`
- All app preferences are saved under *~/Library/Preferences/* I've used this to repair issues, such as when `cmd+space` didn't switch screens to another app.
- I've switched my shell to *zsh* using *oh-my-zsh*. Preferences are under `~/.zshrc` instead of `~/.bash_profile` or `~/.bashrc`, as well as under `~/.oh-my-zsh`. I've activated a few oh-my-zsh plugins, but they're slow.

## Managers
- `brew` (homebrew) manages cask apps (`brew cask list`) and other packages (`brew list`). Check for issues `brew doctor`, clean `brew cleanup`, and update `brew update` and `brew upgrade`.
- `nvm` (node version manager)
- `pyenv` (python version manager)
  - `pyenv versions` list installed versions
  - `source (de)activate virtual_env_name` to (de)activate virtual environments, once one is made, such as an anaconda one using `conda create -n virtual_env_name python=3.5 anaconda`