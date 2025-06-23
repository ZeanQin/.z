## Sessions

- `tmux new-session -A -s default` - start a new session or attach to an existing session named `default`
- `ctrl + space` `d` - detach from the session
- `tmux kill-session -t default` - kill the session named `default`

## Windows

- `ctrl + space` `c` - create a new window
- `ctrl + space` `,` - rename the current window
- `ctrl + space` `&` - close the current window

- `ctrl + space` `1...9` - jump to the window by number

## Panes

- `ctrl + space` `|` - create new pane vertically
- `ctrl + space` `\` - create new pane vertically
- `ctrl + space` `_` - create new pane horizontally
- `ctrl + space` `-` - create new pane horizontally
- `ctrl + space` `x` - close the current pane

- `ctrl + space` `l` - select pane to the right
- `ctrl + space` `h` - select pane to the left
- `ctrl + space` `k` - select pane to the above
- `ctrl + space` `j` - select pane to the down

- `ctrl + space` `q` `1...9` - jump to the pain by number

> Use mouse to resize pane

- `ctrl + space` `{` - swap pane with previous one 
- `ctrl + space` `}` - swap pane with next one 

## References
- https://builtin.com/articles/tmux-config
- https://tmuxcheatsheet.com
- https://gist.github.com/spicycode/1229612
- https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf
