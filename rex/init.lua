-- tmux kill-pane: closing the last pane also closes the tab
rex.action{
  name = "close_pane_or_tab",
  title = "Close Pane (or Tab if Last)",
  run = function(ctx, args)
    local view = rex.session.view{}
    local count
    for _, w in ipairs((view and view.windows) or {}) do
      local n, here = 0, false
      for _, l in ipairs(w.layers or {}) do
        for _, b in ipairs(l.blocks or {}) do
          n = n + 1
          if b.block_id == ctx.block_id then here = true end
        end
      end
      if here then count = n end
    end
    if count == 1 then
      rex.client.queue("client.tab.close", {})
    else
      rex.client.queue("pane.close", {})
    end
  end,
}

-- Migrated from ~/.tmux.conf (prefix ctrl+space)
rex.bind("ctrl+space>ctrl+space", "pane.send_key", { key = "ctrl+space" })
rex.bind("ctrl+space>r", "client.config.reload")
rex.bind("ctrl+space>shift+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+space>\\", "pane.split", { direction = "right" })
rex.bind("ctrl+space>-", "pane.split", { direction = "down" })
rex.bind("ctrl+space>shift+-", "pane.split", { direction = "down" })
rex.bind("ctrl+space>c", "client.tab.new")
rex.bind("ctrl+space>x", "close_pane_or_tab")
rex.bind("ctrl+space>ctrl+j", "pane.resize", { amount = 15, direction = "down" })
rex.bind("ctrl+space>ctrl+k", "pane.resize", { amount = 15, direction = "up" })
rex.bind("ctrl+space>ctrl+h", "pane.resize", { amount = 15, direction = "left" })
rex.bind("ctrl+space>ctrl+l", "pane.resize", { amount = 15, direction = "right" })
rex.bind("ctrl+space>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+space>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+space>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+space>l", "pane.focus", { direction = "right" })
rex.bind("alt+h", "pane.focus", { direction = "left" })
rex.bind("alt+j", "pane.focus", { direction = "down" })
rex.bind("alt+k", "pane.focus", { direction = "up" })
rex.bind("alt+l", "pane.focus", { direction = "right" })

-- Repeat mode for tmux bind -r
rex.mode("repeat", { exclusive = true })
rex.bind("ctrl+space>ctrl+r", "client.mode.enter", { name = "repeat" })
rex.bind("repeat/enter", "client.mode.exit")
rex.bind("repeat/escape", "client.mode.exit")
rex.bind("repeat/ctrl+j", "pane.resize", { amount = 15, direction = "down" })
rex.bind("repeat/ctrl+k", "pane.resize", { amount = 15, direction = "up" })
rex.bind("repeat/ctrl+h", "pane.resize", { amount = 15, direction = "left" })
rex.bind("repeat/ctrl+l", "pane.resize", { amount = 15, direction = "right" })

-- tmux default: prefix + number jumps to tab (base-index 1)
rex.bind("ctrl+space>1", "client.tab.goto", { index = 1 })
rex.bind("ctrl+space>2", "client.tab.goto", { index = 2 })
rex.bind("ctrl+space>3", "client.tab.goto", { index = 3 })
rex.bind("ctrl+space>4", "client.tab.goto", { index = 4 })
rex.bind("ctrl+space>5", "client.tab.goto", { index = 5 })
rex.bind("ctrl+space>6", "client.tab.goto", { index = 6 })
rex.bind("ctrl+space>7", "client.tab.goto", { index = 7 })
rex.bind("ctrl+space>8", "client.tab.goto", { index = 8 })
rex.bind("ctrl+space>9", "client.tab.goto", { index = 9 })
