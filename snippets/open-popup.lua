-- description: Layout for plugin to be capable to open "popup" areas
-- from plugin: Grauly/xdg-mime.yazi
-- confirmed working up to version: 25.2.26
-- as of date: 2025/04/09

-- adapted from actual plugin

local open_ui_if_not_open = ya.sync(function(self)
    if not self.children then
        self.children = Modal:children_add(self, 10)
    end
    ya.render()
end)

local close_ui_if_open = ya.sync(function(self)
    if self.children then
        Modal:children_remove(self.children)
        self.children = nil
    end
    ya.render()
end)

--see https://github.com/yazi-rs/plugins/blob/a1738e8088366ba73b33da5f45010796fb33221e/mount.yazi/main.lua#L3 for a direct toggle

local M = {}

--entry point, async
function M:entry(job)
    --note: this example only opens the area, it does NOT close it
    open_ui_if_not_open()
end

-- Modal functions

-- called on first open, sync when
function M:new(area)
    self:layout(area)
    return self
end

-- Not a modal function but a helper to get the layout
-- basically split the layout into a 50% wide and 80% tall centered area
function M:layout(area)
    local h_chunks = ui.Layout()
        :direction(ui.Layout.HORIZONTAL)
        :constraints({
            ui.Constraint.Percentage(25),
            ui.Constraint.Percentage(50),
            ui.Constraint.Percentage(25)
        })
        :split(area)
    local v_chunks = ui.Layout()
        :direction(ui.Layout.VERTICAL)
        :constraints({
            ui.Constraint.Percentage(10),
            ui.Constraint.Percentage(80),
            ui.Constraint.Percentage(10)
        })
        :split(h_chunks[2])

    self.draw_area = v_chunks[2]
end

function M:reflow()
    return { self }
end

-- actually draw the content, is synced
function M:redraw()
    -- basically stolen from https://github.com/yazi-rs/plugins/blob/a1738e8088366ba73b33da5f45010796fb33221e/mount.yazi/main.lua#L144
    return {
        ui.Clear(self.draw_area),
        ui.Border(ui.Border.ALL)
            :area(self.draw_area)
            :type(ui.Border.ROUNDED)
            :style(ui.Style():fg("blue"))
            :title(ui.Line("Title"):align(ui.Line.CENTER)),
	-- make the actual content here, this is a list of ui commands. See https://yazi-rs.github.io/docs/plugins/layout/ to see some of the available options
    }
end


return M
