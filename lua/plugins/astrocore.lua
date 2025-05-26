-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>ft"] = {
          function()
            require("snacks").picker.todo_comments { ---@diagnostic disable-line: undefined-field
              keywords = { "TODO", "FIX", "FIXME" },
              dirs = { vim.api.nvim_buf_get_name(0) },
            }
          end,
          desc = "Search TODOs in current file",
        },
        -- Alternative to search TODOs in current file, less efficient than the one above
        -- ["<Leader>ft"] = {
        --   function()
        --     local current_file_path = vim.fn.expand("%:p")
        --     require("snacks").picker.todo_comments({keywords = {"TODO", "FIX", "FIXME"}, ---@diagnostic disable-line: undefined-field
        --       transform = function(item)
        --         local item_path = vim.fn.fnamemodify(item.cwd .. '/' .. item.file, ':p')
        --         return item_path == current_file_path
        --       end
        --     })
        --   end,
        --   desc = "Search TODOs in current file",
        -- },
        --
        ["dd"] = {
          function()
            local line = vim.fn.getline "."
            return vim.trim(line) == "" and [["_dd]] or "dd"
          end,
          expr = true,
          desc = "Delete line (no yank if empty)",
        },
        ["cc"] = {
          function()
            local line = vim.fn.getline "."
            return vim.trim(line) == "" and [["_cc]] or "cc"
          end,
          expr = true,
          desc = "Change line (no yank if empty)",
        },
        -- ["<Leader>fw"] = {
        --   function ()
        --     require("")
        --   end
        -- }
        --
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
