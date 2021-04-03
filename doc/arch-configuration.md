# Soundcard

The default seems to be the HDMI - change it to PCM

## .asoundrc

```
defaults.pcm.card 1
defaults.ctl.card 1
```

# Vim 

## .vimrc

```vim
"if $COLORTERM == 'gnome-terminal' || $TERM == 'putty-256color'
  set t_Co=256
  colorscheme xoria256
"else
"  colorscheme darkblue
"endif
map <F2> :tabprevious<CR>
map <F3> :tabnext<CR>
map <F4> :set invwrap<CR>
map <F5> :set invnumber<CR>
map <F7> :let @/ = ""<CR>
map <F8> :make<CR>
set nowrap
set shiftwidth=4
set softtabstop=4
set tabstop=8
set expandtab
set number
"set smartindent
filetype indent on
set scrolloff=5
set path+=./headers/
syntax on
let python_highlight_builtins=1
au BufRead SCons* set ft=python
```

# Bash

## .bashrc

This setup uses 256-color terminal feature.

```shell
function set_prompt {
  local LVL=''
  if ((SHLVL > 1)); then
    LVL="($SHLVL)"
  fi
  if [ -n "$VIRTUAL_ENV" ]; then
    LVL="[`basename $VIRTUAL_ENV`]"
  fi

  local C0='\[\e[m\]'
  local C1='\[\e[0;32m\]'
  local C2='\[\e[1;34m\]'
  local C3='\[\e[1;32m\]'
  local C_LB='\[\e[38;5;27m\]'
  local C_LG='\[\e[38;5;77m\]'
#PS1='\[\e[0;32m\]\u@\w\$\[\e[0m\] '
#export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
#export PS1="$C1\u$C0 $C2\w$C0 $C3\$$C0 "
  export PS1="$C_LG\u$C0 $C_LB\w$C0 $C3$LVL\$$C0 "
}
```

# Nano

## .nanorc

```
include /usr/share/nano/python.nanorc
include /usr/share/nano/sh.nanorc
```

# Tmux

## .tmuxrc

```ini
# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1
```

# i3
## .config/i3/config

```ini


bindsym XF86MonBrightnessUp exec xbacklight -inc 20  # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 20  # decrease screen brightness
```
