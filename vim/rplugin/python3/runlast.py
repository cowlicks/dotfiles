'''
This plugin creates a vim command that re-runs the last shell command in the last vim terminal buffer.
This is useful for getting quick feedback while working on something. This workflow would look like:
* open a terminal in a vim window with `:terminal`
* run a shell command like `cargo check`
* Go back to editing and re-run the shell command from the previous step with :RerunLastThingInLastTerminal

Installation:
Save this file to "rplugin/python3" in a vim 'runtimepath' directory (~/.config/nvim/rplugin/python3/runlast.py for example).

Usage:
You probably want to map this command to a keybinding. I use "<leader>p" Drop the following in your .vimrc:
```
" save the current file and re-run the most recent command in the most recent terminal buffer
map <leader>p :w \|:RerunLastThingInLastTerminal <cr>
```

Development:
If you update this file in place you *might* need to run `:UpdateRemotePlugins` for the changes to take effect.

For a long time i've use a similiar command where I re-run the last thing in tmux. I did this with:
map ,t :w \|:! tmux send-keys -t 0:$(tmux display-message -p '\#I').1 C-l C-u "\!\!" Enter Enter <cr><cr>
But I wanted to be able to do this with a vim terminal buffer because it can take up less screen space.

Thank you whoever asked this question:
https://vi.stackexchange.com/questions/21449/send-keys-to-a-terminal-buffer
https://www.reddit.com/r/neovim/comments/qjkx12/send_upcr_to_term_buffer_using_chansend_to_run/
'''
import pynvim

rerun_command_name = 'RerunLastThingInLastTerminal'
cancel_command_name = 'CancelInLastTerminal'

string_to_rerun_last_thing = '"\\<C-l>\\<C-u>!!\\<cr>\\<cr>"'
string_to_cancel = '"\\<C-c>\\<cr>\\<cr>"'

global_terminal_channel_id_variable_name = 'g:last_terminal_chan_id'

@pynvim.plugin
class Rerunner(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.autocmd('TermOpen', sync=True)
    def record_terminal_channel_id(self):
        self.nvim.command(f'let {global_terminal_channel_id_variable_name} = b:terminal_job_id')

    @pynvim.command(rerun_command_name)
    def rerun_last_thing_in_last_terminal(self):
            self.nvim.command_output(f'call chansend(g:last_terminal_chan_id, {string_to_rerun_last_thing})')

    @pynvim.command(cancel_command_name)
    def cancel_in_last_terminal(self):
            self.nvim.command_output(f'call chansend(g:last_terminal_chan_id, {string_to_cancel})')
