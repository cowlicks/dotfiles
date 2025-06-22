-- Terminal Rerun Plugin
-- Save this file as lua/terminal-rerun/init.lua in your neovim config directory

local M = {}

-- Store the last terminal buffer job id
M.last_terminal_chan_id = nil

-- Function to record terminal job id when terminal is opened
local function record_terminal_id()
    local buf = vim.api.nvim_get_current_buf()
    local chan_id = vim.b[buf].terminal_job_id
    if chan_id then
        M.last_terminal_chan_id = chan_id
    end
end

-- Function to clear scrollback and screen
local function clear_terminal()
    -- Temporarily set scrollback to 1 to clear history
    vim.o.scrollback = 1
    vim.cmd('sleep 100m')
    vim.o.scrollback = 10000
    
    -- Send Ctrl-L to clear the screen
    if M.last_terminal_chan_id then
        vim.fn.chansend(M.last_terminal_chan_id, vim.api.nvim_replace_termcodes('<C-l>', true, true, true))
    end
end

-- Function to rerun last command
function M.rerun_last_command()
    if not M.last_terminal_chan_id then
        vim.notify("No terminal found", vim.log.levels.ERROR)
        return
    end
    
    -- Clear terminal
    clear_terminal()
    
    -- Send commands to rerun last command
    local keys = vim.api.nvim_replace_termcodes('<C-u>!!<CR><CR>', true, true, true)
    vim.fn.chansend(M.last_terminal_chan_id, keys)
end

-- Function to send Ctrl-C to terminal
function M.send_ctrl_c()
    if not M.last_terminal_chan_id then
        vim.notify("No terminal found", vim.log.levels.ERROR)
        return
    end
    
    local keys = vim.api.nvim_replace_termcodes('<C-c><CR><CR>', true, true, true)
    vim.fn.chansend(M.last_terminal_chan_id, keys)
end

-- Setup function
function M.setup()
    -- Create autocmd to record terminal job id
    vim.api.nvim_create_autocmd("TermOpen", {
        callback = record_terminal_id,
    })
    
    -- Create user commands
    vim.api.nvim_create_user_command('RerunLastThingInLastTerminal', M.rerun_last_command, {})
    vim.api.nvim_create_user_command('CancelInLastTerminal', M.send_ctrl_c, {})
    
    -- Optional: You could set up the keymaps here if you want
    -- Or keep them in your existing config
    -- vim.keymap.set('n', '<leader>p', ':w<CR>:RerunLastThingInLastTerminal<CR>', { silent = true })
    -- vim.keymap.set('n', '<leader>c', ':w<CR>:CancelInLastTerminal<CR>', { silent = true })
end

return M
