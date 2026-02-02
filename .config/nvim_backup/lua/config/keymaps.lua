-- Grep texto seleccionado en modo visual
vim.keymap.set("v", "<leader>sg", function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    
    if #lines == 0 then return end
    
    if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end
    
    local selected_text = table.concat(lines, "\n")
    selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")
    
    require("fzf-lua").live_grep({ search = selected_text })
end, { desc = "Grep selected text" })

-- Borrar todos los buffers excepto el actual
vim.keymap.set("n", "<leader>bq", ':%bdelete|edit #|normal`"<CR>', 
    { desc = "Delete other buffers" })

-- Guardar archivo con mensaje personalizado
function SaveFile()
    if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
        vim.notify("No file to save", vim.log.levels.WARN)
        return
    end
    
    local filename = vim.fn.expand("%:t")
    local success, err = pcall(function()
        vim.cmd("silent! write")
    end)
    
    if success then
        vim.notify(filename .. " Saved!")
    else
        vim.notify("Error: " .. err, vim.log.levels.ERROR)
    end
end

vim.keymap.set("n", "<C-s>", ":lua SaveFile()<CR>", { desc = "Save file" })

-- COMENTADOS PARA PROBAR DESPUÉS:
-- Deshabilitar mover líneas con Alt+j/k
-- vim.keymap.set("i", "<A-j>", "<Nop>", { noremap = true })
-- vim.keymap.set("i", "<A-k>", "<Nop>", { noremap = true })
-- vim.keymap.set("n", "<A-j>", "<Nop>", { noremap = true })
-- vim.keymap.set("n", "<A-k>", "<Nop>", { noremap = true })
