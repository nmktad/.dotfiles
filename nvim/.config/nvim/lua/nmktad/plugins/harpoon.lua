return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  enabled = true,
  keys = function()
    local harpoon = require 'harpoon'
    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end
      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    return {
      -- Harpoon marked files 1 through 4
      {
        '<space>1',
        function()
          harpoon:list():select(1)
        end,
        desc = 'Harpoon buffer 1',
      },
      {
        '<space>2',
        function()
          harpoon:list():select(2)
        end,
        desc = 'Harpoon buffer 2',
      },
      {
        '<space>3',
        function()
          harpoon:list():select(3)
        end,
        desc = 'Harpoon buffer 3',
      },
      {
        '<space>4',
        function()
          harpoon:list():select(4)
        end,
        desc = 'Harpoon buffer 4',
      },
      {
        '<space>5',
        function()
          harpoon:list():select(5)
        end,
        desc = 'Harpoon buffer 5',
      },

      -- Harpoon user interface.
      {
        '<leader>ht',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Toggle Menu',
      },
      {
        '<leader>ha',
        function()
          harpoon:list():add()
        end,
        desc = 'Harpoon add file',
      },

      -- Use Telescope as Harpoon user interface.
      {
        '<leader>htt',
        function()
          toggle_telescope(harpoon:list())
        end,
        desc = 'Open Harpoon window',
      },
    }
  end,
  config = function()
    require('harpoon').setup {}
  end,
}
