return {
  { -- further customize the options set by the community
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    --@type CatppuccinOptions
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      -- transparent_background = true,
      integrations = {
        -- sandwich = false,
        neotree = true,
        symbols_outline = true,
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
        indent_blankline = true,
        noice = true,
        mini = true,
        flash = true,
        -- leap = true,
        markdown = true,
        -- neotest = true,
        cmp = true,
        blink_cmp = true,
        lsp_trouble = true,
      },
      styles = {
        comments = { "italic" },
        loops = { "italic" },
        keywords = { "italic" },
        strings = {},
        variables = {},
      },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.overlay0 },
          NeoTreeDotfile = { fg = colors.overlay0 },
          NeoTreeMessage = { fg = colors.surface2},
          SnacksPickerListCursorLine = { bg = "#223547" },
          SnacksPickerSelected = { fg = colors.lavender },
        }
      end,
    },
  },
}
