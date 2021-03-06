
local TestUIListViewScene = class("TestUIListViewScene", function()
    return display.newScene("TestUIListViewScene")
end)

TestUIListViewScene.RADIO_BUTTON_IMAGES = {
    off = "RadioButtonOff.png",
    off_pressed = "RadioButtonOffPressed.png",
    off_disabled = "RadioButtonOffDisabled.png",
    on = "RadioButtonOn.png",
    on_pressed = "RadioButtonOnPressed.png",
    on_disabled = "RadioButtonOnDisabled.png",
}

function TestUIListViewScene:ctor()
    app:createGrid(self)

    self:createListView1()
    self:createListView2()
    self:createListView3()
    self:createListView4()

    app:createTitle(self, "Test UIListView")
    app:createNextButton(self)
end

function TestUIListViewScene:createListView1()
    self.listview = cc.ui.UIListView.new{
            viewRect = cc.rect(20, 80, 200, display.height - 150),
            -- bgColor = cc.c4b(250, 0, 0, 255),
            bg = "YellowBlock.png",
            showScrollBar = false,
            scrollWidth = 10}
        :registerHandler(handler(self, self.listViewDelegate1), cc.ui.UIListView.DELEGATE)
        :addTo(self)
        :reload()

    cc.ui.UILabel.new({
        text = "list with mixed item",
        size = 16,
        color = display.COLOR_BLACK,
    }):align(display.CENTER, 110, display.height - 50):addTo(self)
end

function TestUIListViewScene:listViewDelegate1(listview, name, idx, param)
    -- print("TestUIListViewScene listview delegate:" .. name, idx)

    if name == cc.ui.UIListView.CELL_TAG then
        local i = idx --math.random(4)
        local item

        if 1 == i then
            item = cc.ui.UILabel.new(
                {text = "text"..idx, size = 20,
                align = cc.ui.TEXT_ALIGN_CENTER,
                color = display.COLOR_WHITE})
            :pos(100, 20)
        elseif 2 == i then
            item = cc.ui.UIPushButton.new("GreenButton.png", {scale9 = true})
                :setButtonSize(160, 40)
                :setButtonLabel(cc.ui.UILabel.new({text = "Button" .. idx, size = 16, color = display.COLOR_BLUE}))
                :onButtonPressed(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_RED)
                end)
                :onButtonRelease(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_BLUE)
                end)
                :onButtonClicked(function(event)
                    print("TestUIListViewScene - Button" .. idx .. " clicked")
                end)
                :pos(100, 30)
        elseif 3 == i then
            item = cc.Node:create()
            cc.ui.UICheckBoxButton.new({off = "CheckBoxButton2Off.png", on = "CheckBoxButton2On.png",})
                :setButtonLabel(cc.ui.UILabel.new({text = "Checkbox" .. idx, size = 16,  color = display.COLOR_BLUE}))
                :setButtonLabelOffset(70, 0)
                :setButtonLabelAlignment(display.CENTER)
                :align(display.CENTER, 30, 30)
                :onButtonStateChanged(function(event)
                    if "on" == event.state then
                        printInfo("TestUIListViewScene - CheckBox" .. idx .. " state on")
                    elseif "off" == event.state then
                        printInfo("TestUIListViewScene - CheckBox" .. idx .. " state off")
                    end
                end)
                :addTo(item)
            cc.ui.UIPushButton.new("GreenButton.png", {scale9 = true})
                :setButtonSize(60, 40)
                :setButtonLabel(cc.ui.UILabel.new({text = "Button" .. idx, size = 16, color = display.COLOR_BLUE}))
                :onButtonPressed(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_RED)
                end)
                :onButtonRelease(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_BLUE)
                end)
                :onButtonClicked(function(event)
                    print("TestUIListViewScene - Button" .. idx .. " clicked")
                end)
                :align(display.CENTER, 165, 30)
                :addTo(item)
        elseif 4 == i then
            item = cc.ui.UICheckBoxButtonGroup.new(display.TOP_TO_BOTTOM)
                :addButton(cc.ui.UICheckBoxButton.new(TestUIListViewScene.RADIO_BUTTON_IMAGES)
                    :setButtonLabel(cc.ui.UILabel.new({text = "option 1", color = display.COLOR_BLACK}))
                    :setButtonLabelOffset(20, 0)
                    :align(display.LEFT_CENTER))
                :addButton(cc.ui.UICheckBoxButton.new(TestUIListViewScene.RADIO_BUTTON_IMAGES)
                    :setButtonLabel(cc.ui.UILabel.new({text = "option 2", color = display.COLOR_BLACK}))
                    :setButtonLabelOffset(20, 0)
                    :align(display.LEFT_CENTER))
                :addButton(cc.ui.UICheckBoxButton.new(TestUIListViewScene.RADIO_BUTTON_IMAGES)
                    :setButtonLabel(cc.ui.UILabel.new({text = "option 3", color = display.COLOR_BLACK}))
                    :setButtonLabelOffset(20, 0)
                    :align(display.LEFT_CENTER))
                :addButton(cc.ui.UICheckBoxButton.new(TestUIListViewScene.RADIO_BUTTON_IMAGES)
                    :setButtonLabel(cc.ui.UILabel.new({text = "option 4 disabled", color = display.COLOR_BLACK}))
                    :setButtonEnabled(false)
                    :setButtonLabelOffset(20, 0)
                    :align(display.LEFT_CENTER))
                :setButtonsLayoutMargin(0, 0, 0, 0)
                :onButtonSelectChanged(function(event)
                    printInfo("TestUIListViewScene - Option %d selected, Option %d unselected", event.selected, event.last)
                end)
        elseif 5 == i then
            item = cc.ui.UICheckBoxButton.new({off = "CheckBoxButton2Off.png", on = "CheckBoxButton2On.png",})
                :setButtonLabel(cc.ui.UILabel.new({text = "CheckBox" .. idx, size = 14,  color = display.COLOR_BLUE}))
                :setButtonLabelOffset(30, 0)
                :setButtonLabelAlignment(display.LEFT_CENTER)
                :onButtonStateChanged(function(event)
                    if "on" == event.state then
                        printInfo("TestUIListViewScene - CheckBox" .. idx .. " state on")
                    elseif "off" == event.state then
                        printInfo("TestUIListViewScene - CheckBox" .. idx .. " state off")
                    end
                end)
                :align(display.LEFT_CENTER, 10, 30)
        else
            item = cc.ui.UILabel.new(
                {text = "text"..idx, size = 20,
                align = cc.ui.TEXT_ALIGN_CENTER,
                color = display.COLOR_WHITE})
            :pos(100, 20)
        end

        item = listview:transItem(item)
        return item
    elseif name == cc.ui.UIListView.CELL_SIZE_TAG then
        if 1 == idx then
            return 200, 40
        elseif 2 == idx then
            return 200, 60
        elseif 3 == idx then
            return 200, 60
        elseif 4 == idx then
            return 200, 100
        elseif 5 == idx then
            return 200, 60
        else
            return 200, 40
        end
    elseif name == cc.ui.UIListView.COUNT_TAG then
        return 10
    elseif name == cc.ui.UIListView.CLICKED_TAG then
        print("TestUIListViewScene - clicked on " .. idx .. " point:(" .. param.x .. " ," .. param.y .. ")")
    end
end

function TestUIListViewScene:createListView2()
    self.listview = cc.ui.UIListView.new{
            viewRect = cc.rect(300, 80, 600, 100),
            bgColor = cc.c4b(200, 200, 200, 120),
            direction = cc.ui.UIListView.DIRECTION_HORIZONTAL,
            -- bg = "YellowBlock.png",
            showScrollBar = false,
            scrollWidth = 10}
        :registerHandler(handler(self, self.listViewDelegate2), cc.ui.UIListView.DELEGATE)
        :addTo(self)
        :reload()

    cc.ui.UILabel.new({
        text = "horizontal list with mixed item",
        size = 16,
        color = display.COLOR_BLACK,
    }):align(display.CENTER, 600, 200):addTo(self)
end

function TestUIListViewScene:listViewDelegate2(listview, name, idx, param)

    if name == cc.ui.UIListView.CELL_TAG then
        local i = idx --math.random(4)
        local item

        if 1 == i then
            item = cc.ui.UILabel.new(
                {text = "text"..idx, size = 20,
                align = cc.ui.TEXT_ALIGN_CENTER,
                color = display.COLOR_BLACK})
                :pos(60, 50)
        elseif 2 == i then
            item = cc.ui.UIPushButton.new("GreenButton.png", {scale9 = true})
                :setButtonSize(100, 40)
                :setButtonLabel(cc.ui.UILabel.new({text = "Button" .. idx, size = 16, color = display.COLOR_BLUE}))
                :onButtonPressed(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_RED)
                end)
                :onButtonRelease(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_BLUE)
                end)
                :onButtonClicked(function(event)
                    print("TestUIListViewScene - Button" .. idx .. " clicked")
                end)
                :pos(60, 50)
        else
            item = cc.ui.UILabel.new(
                {text = "text"..idx, size = 20,
                align = cc.ui.TEXT_ALIGN_CENTER,
                color = display.COLOR_BLACK})
            :pos(50, 50)
        end

        item = listview:transItem(item)
        return item
    elseif name == cc.ui.UIListView.CELL_SIZE_TAG then
        if 1 == idx then
            return 120, 100
        elseif 2 == idx then
            return 130, 100
        elseif 3 == idx then
            return 120, 100
        elseif 4 == idx then
            return 110, 100
        elseif 5 == idx then
            return 120, 100
        else
            return 110, 100
        end
    elseif name == cc.ui.UIListView.COUNT_TAG then
        return 7
    elseif name == cc.ui.UIListView.CLICKED_TAG then
        print("TestUIListViewScene clicked on " .. idx .. " point:(" .. param.x .. " ," .. param.y .. ")")
    end
end

function TestUIListViewScene:createListView3()
    self.listview = cc.ui.UIListView.new{
            viewRect = cc.rect(520, 240, 360, 360),
            -- bgColor = cc.c4b(200, 200, 200, 120),
            direction = cc.ui.UIListView.DIRECTION_VERTICAL,
            bg = "GreenBlock.png",
            showScrollBar = false,
            scrollWidth = 10}
        :registerHandler(handler(self, self.listViewDelegate3), cc.ui.UIListView.DELEGATE)
        :addTo(self)
        :reload()

    cc.ui.UILabel.new({
        text = "grid, in fact is a list",
        size = 16,
        color = display.COLOR_BLACK,
    }):align(display.CENTER, 700, display.height - 30):addTo(self)
end

function TestUIListViewScene:listViewDelegate3(listview, name, idx, param)

    if name == cc.ui.UIListView.CELL_TAG then
        local i = idx --math.random(4)
        local item

        item = display.newNode()
        idx = idx*3 - 2
        for i=1, 3 do
            cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
                :setButtonSize(120, 120)
                :setButtonLabel(cc.ui.UILabel.new({text = "Button" .. idx, size = 16, color = display.COLOR_BLUE}))
                :onButtonPressed(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_RED)
                end)
                :onButtonRelease(function(event)
                    event.target:getButtonLabel():setColor(display.COLOR_BLUE)
                end)
                :onButtonClicked(function(event)
                    print("TestUIListViewScene - " .. event.target:getButtonLabel():getString() .. " clicked")
                end)
                :pos(120*i - 60, 60)
                :addTo(item)
            idx = idx + 1
        end

        item = listview:transItem(item)
        return item
    elseif name == cc.ui.UIListView.CELL_SIZE_TAG then
        return 360, 120
    elseif name == cc.ui.UIListView.COUNT_TAG then
        return 3
    elseif name == cc.ui.UIListView.CLICKED_TAG then
        print("TestUIListViewScene clicked on " .. idx .. " point:(" .. param.x .. " ," .. param.y .. ")")
    end
end

function TestUIListViewScene:createListView4()
    self.listview = cc.ui.UIListView.new{
            viewRect = cc.rect(320, 240, 120, 240),
            -- bgColor = cc.c4b(200, 200, 200, 120),
            direction = cc.ui.UIListView.DIRECTION_VERTICAL,
            bg = "GreenBlock.png",
            showScrollBar = false,
            scrollWidth = 10}
        :registerHandler(handler(self, self.listViewDelegate4), cc.ui.UIListView.DELEGATE)
        :addTo(self)
        :reload()

    cc.ui.UILabel.new({
        text = "list",
        size = 16,
        color = display.COLOR_BLACK,
    }):align(display.CENTER, 380, 500):addTo(self)
end

function TestUIListViewScene:listViewDelegate4(listview, name, idx, param)

    if name == cc.ui.UIListView.CELL_TAG then
        local i = idx --math.random(4)
        local item

        item = cc.ui.UILabel.new(
                {text = "item"..idx, size = 20,
                align = cc.ui.TEXT_ALIGN_CENTER,
                color = display.COLOR_WHITE})
            :pos(40, 10)

        item = listview:transItem(item)
        if idx%2 == 1 then
            item:setBg("YellowBlock.png")
        end
        return item
    elseif name == cc.ui.UIListView.CELL_SIZE_TAG then
        return 120, 40
    elseif name == cc.ui.UIListView.COUNT_TAG then
        return 10
    elseif name == cc.ui.UIListView.CLICKED_TAG then
        print("TestUIListViewScene clicked on " .. idx .. " point:(" .. param.x .. " ," .. param.y .. ")")
    end
end

return TestUIListViewScene
