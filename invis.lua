-- my eyes hurt, let me read again
-- pov: scrolling through this source code lmao
local nv_players = game:GetService("Players")
local nv_run_service = game:GetService("RunService")
local nv_input_service = game:GetService("UserInputService")
local nv_starter_gui = game:GetService("StarterGui")
local nv_tween_service = game:GetService("TweenService")
local nv_collection_service = game:GetService("CollectionService")
local nv_http_service = game:GetService("HttpService")
local nv_player = nv_players.LocalPlayer
local PARENT
local nv_script_version = "0.0.0.0.6"
local nv_script_name = "spookvisibility2025e" --nicevisibility10000e
local nv_script_state = "Alpha"
local nv_script_build = 13
local nv_univsersal_formatted_name = nv_script_name.." v"..nv_script_version.." ["..nv_script_state.." b"..nv_script_build.."]"
--[[nvm i suck at this]]
--local nv_safe_to_use = false -- not yet, we gotta wait for the game to load or a new version
local nv__global_success, nv__global_result = pcall(function()
	local nv_core_gui_success, nv_core_gui_result = pcall(function() 
		return game:GetService("CoreGui") 
	end)
	local can_access_core = function()
		if not nv_core_gui_success or not nv_core_gui_result then return false end
		return nv_core_gui_result:FindFirstChild("RobloxGui") ~= nil
	end
	PARENT = gethui() or can_access_core() and nv_core_gui_result or nv_player:WaitForChild("PlayerGui")
	local compare_versions = function(v1, v2)
		local prefix1 = v1:match("^([A-Z])") or ""
		local prefix2 = v2:match("^([A-Z])") or ""
		if prefix1 ~= prefix2 then
			if prefix1 < prefix2 then return -1 else return 1 end
		end
		local p1, p2 = {}, {}
		for num in v1:gmatch("%d+") do table.insert(p1, tonumber(num)) end
		for num in v2:gmatch("%d+") do table.insert(p2, tonumber(num)) end
		for i = 1, math.max(#p1, #p2) do
			local n1, n2 = p1[i] or 0, p2[i] or 0
			if n1 < n2 then return -1 elseif n1 > n2 then return 1 end
		end
		return 0
	end
	if compare_versions(_G.nicevis_version or "0", nv_script_version) >= 0 then
	    print("NV is already up-to-date globally")
	else
	    if _G.nicevis_interface then
	        _G.nicevis_interface:ClearAllChildren()
	    end
	    print("Updating NV globally")
	    _G.nicevis_version = nv_script_version
	end
end)
local message = function(title, text, ptime, icon, button1, button2)
	pcall(function()
		nv_starter_gui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = ptime or 3,
			Icon = icon,
			Button1 = button1,
			Button2 = button2
		})
	end)
end
local gamePlaceId = tostring(game.PlaceId)
local BUTTON_TAG = "NV_script_button"
local scripts_json_url = "https://raw.githubusercontent.com/Buddy-Gian251/Roblox-Invisibility-by-nicehouse10000e/main/scripts.json"
local choices_title_size = 20
local SBS_TAG = "SOUNDBOARD_BUTTONS"
local buttons_is_visible = false
local currently_dragged = {}
local sfx_ids = {}
local bgm_ids = {}
local sounds_json_url = "https://raw.githubusercontent.com/Buddy-Gian251/Roblox-Invisibility-by-nicehouse10000e/main/audio_files.json"
local get_month_number = function() return tonumber(os.date("%m")) end
local get_week_number = function() return tonumber(os.date("%W")) end
local get_day_number = function() return tonumber(os.date("%d")) end
_G.NV_OFFSET = _G.NV_OFFSET or 500
_G.NV_CFSPEED = _G.NV_CFSPEED or 50
_G.NV_OFFSET_BOOL = _G.NV_OFFSET_BOOL or false
_G.NV_SPEED_ENABLED = _G.NV_SPEED_ENABLED or false
_G.NV_SPEED_CONNECTION = _G.NV_SPEED_CONNECTION or nil
_G.NV_DIED = _G.NV_DIED or false
_G.NV_CHARACTER = _G.NV_CHARACTER or nil
_G.NV_HUMANOID = _G.NV_HUMANOID or nil
_G.NV_HRP = _G.NV_HRP or nil
_G.NV_CAM = _G.NV_CAM or nil
_G.NV_Y_FREEZE_CONNECTION = _G.NV_Y_FREEZE_CONNECTION or nil
_G.NV_SPOOFC_CONNECTION = _G.NV_SPOOFC_CONNECTION or nil
_G.NV_Y_ADJUST_CONNECTION = _G.NV_Y_ADJUST_CONNECTION or nil
_G.NV_FROZEN_Y = _G.NV_FROZEN_Y or 0
_G.NV_Y_FROZEN = _G.NV_Y_FROZEN or false
local offset = _G.NV_OFFSET
local CFSpeed = _G.NV_CFSPEED
local offset_bool = _G.NV_OFFSET_BOOL
local speed_enabled = _G.NV_SPEED_ENABLED
local speed_connection = _G.NV_SPEED_CONNECTION
local died = _G.NV_DIED
local univ_character = _G.NV_CHARACTER
local univ_humanoid = _G.NV_HUMANOID
local univ_hrp = _G.NV_HRP
local univ_cam = _G.NV_CAM
local y_freeze_connection = _G.NV_Y_FREEZE_CONNECTION
local spoofc_connection = _G.NV_SPOOFC_CONNECTION
local y_adjust_connection = _G.NV_Y_ADJUST_CONNECTION
local frozen_y = _G.NV_FROZEN_Y
local y_frozen = _G.NV_Y_FROZEN
local vertical_dir = 0
local make_interface_styles = function(item)
	if not (item:IsA("Frame") or item:IsA("TextLabel") or item:IsA("TextButton") or item:IsA("TextBox")) then return end
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Thickness = 1
	stroke.Transparency = 0.5
	stroke.Parent = item
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 80))
	})
	gradient.Rotation = 90
	gradient.Parent = item
end
local make_draggable = function(UIItem, y_draggable, x_draggable)
	local dragging = false
	local dragStart = nil
	local startPos = nil
	local holdStartTime = nil
	local holdConnection = nil
	UIItem.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or 
			input.UserInputType == Enum.UserInputType.Touch then
			holdStartTime = tick()
			dragStart = input.Position
			startPos = UIItem.Position
			holdConnection = nv_run_service.RenderStepped:Connect(function()
				if not dragging and (tick() - holdStartTime) >= 1 then
					message("Drag feature", "you can now drag "..(UIItem.Name or "this UI").." anywhere.", 2)
					dragging = true
					currently_dragged[UIItem] = true
					holdConnection:Disconnect()
					holdConnection = nil
				end
			end)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					if holdConnection then
						holdConnection:Disconnect()
						holdConnection = nil
					end
					if dragging then
						dragging = false
						task.delay(0.5, function()
							currently_dragged[UIItem] = nil
						end)
					end
				end
			end)
		end
	end)
	nv_input_service.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
			input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart

			local newXOffset = x_draggable ~= false and (startPos.X.Offset + delta.X) or startPos.X.Offset
			local newYOffset = y_draggable ~= false and (startPos.Y.Offset + delta.Y) or startPos.Y.Offset

			UIItem.Position = UDim2.new(
				startPos.X.Scale, newXOffset,
				startPos.Y.Scale, newYOffset
			)
		end
	end)
end
local can_run_load_string = function()
	local success, err = pcall(function()
		loadstring("print('hello world')")
	end)
	if success then
		return true
	else
		return false
	end
end
local random_string = function()
	local length = math.random(32,64)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end
local nv_main_gui = _G.nicevis_interface
if not nv_main_gui then
	if _G.nicevis_interface and _G.nicevis_interface.Parent then
		_G.nicevis_interface:Destroy()
		_G.nicevis_interface = nil
	end
	nv_main_gui = Instance.new("ScreenGui")
	nv_main_gui.Enabled = true
	nv_main_gui.IgnoreGuiInset = true
	nv_main_gui.ResetOnSpawn = false
	nv_main_gui.Parent = PARENT
	_G.nicevis_interface = nv_main_gui
end
nv_main_gui.Name = random_string()
local sounds_folder = nv_main_gui:FindFirstChild("PLAYING_SOUNDS")
if not sounds_folder then
	sounds_folder = Instance.new("Folder")
end
sounds_folder.Name = "PLAYING_SOUNDS"
sounds_folder.Parent = nv_main_gui
local frame_colors = {
	tc1 = {}, -- will use targetColor
	tc2 = {}, -- will use targetColor2
	tc3 = {}, -- will use targetColor3
	tc4 = {}, -- will use targetColor4
}
local getkeys_fromtable = function(t)
	local keys = {}
	for k in pairs(t) do
		table.insert(keys, k)
	end
	return keys
end
local getRandomValueFromTable = function(t)
	local keys = {}
	for k in pairs(t) do
		table.insert(keys, k)
	end
	if #keys == 0 then return nil end
	local randomKey = keys[math.random(1, #keys)]
	return t[randomKey]
end
local get_sounds_from_json = function()
	if not sounds_json_url or sounds_json_url == "" then
		message("Error", "Missing JSON URL. Please provide a valid JSON URL for your Roblox audio files.", 4)
		return
	end
	local success, result = pcall(function()
		return game:HttpGet(sounds_json_url)
	end)
	if not success then
		message("Error", "Failed to fetch JSON file.", 4)
		warn("[NV JSON] Fetch failed:", result)
		return
	end
	local decodeSuccess, decoded = pcall(function()
		return nv_http_service:JSONDecode(result)
	end)
	if not decodeSuccess or type(decoded) ~= "table" then
		message("Error", "Invalid JSON format. Please check your JSON file.", 4)
		warn("[NV JSON] Decode failed:", decoded)
		return
	end
	if decoded.sfx_ids and type(decoded.sfx_ids) == "table" then
		sfx_ids = decoded.sfx_ids
	else
		warn("[NV JSON] No 'sfx_ids' found in JSON.")
	end
	if decoded.bgm_ids and type(decoded.bgm_ids) == "table" then
		bgm_ids = decoded.bgm_ids
	else
		warn("[NV JSON] No 'bgm_ids' found in JSON.")
	end
	message("Success", "Audio data loaded successfully.", 3)
	print("[NV JSON] SFX IDs loaded:", #getkeys_fromtable(sfx_ids))
	print("[NV JSON] BGM IDs loaded:", #getkeys_fromtable(bgm_ids))
end
local play_sound = function(assetid, pbvolume, pbspeed, looped, delete_when_stopped)
	local sound = Instance.new("Sound")
	local loaded = false
	local timeout = 10
	local sound_success, sound_result
	sound.SoundId = "rbxassetid://" .. assetid
	sound.Volume = pbvolume or 0.5
	sound.PlaybackSpeed = pbspeed or 1
	sound.Looped = looped or false
	sound.Parent = sounds_folder
	sound.Loaded:Connect(function()
		loaded = true
	end)
	task.spawn(function()
		sound_success, sound_result = pcall(function()
			local elapsed = 0
			local connection
			connection = nv_run_service.Heartbeat:Connect(function(dt)
				if loaded then
					connection:Disconnect()
					return true
				end
				elapsed += dt
				if elapsed >= timeout then
					connection:Disconnect()
					error(("Sound (assetid: %s) failed to load within %d seconds."):format(assetid, timeout))
				end
			end)
		end)
	end)
	sound:Play()
	sound.Ended:Connect(function()
		if delete_when_stopped and type(delete_when_stopped) == "boolean" then
			task.wait(1)
			sound:Destroy()
		end
	end)
	return sound
end
local cast_choices = function(choices, hasCancel, timeout, choice_message, callback)
	if not choices or type(choices) ~= "table" or choices == {} then return end
	play_sound("128438193391727", 5, 1, false, true)
	local choice_mainframe = Instance.new("Frame")
	local choice_title = Instance.new("TextLabel")
	local choice_text_label = Instance.new("TextLabel")
	local choice_buttonframe = Instance.new("Frame")
	local choice_buttonslayout = Instance.new("UIListLayout")
	choice_mainframe.Size = UDim2.new(0, 200, 0, 200)
	choice_mainframe.Position = UDim2.new(0.5, 0, 0.5, 0)
	choice_mainframe.AnchorPoint = Vector2.new(0.5, 0.5)
	choice_mainframe.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	choice_mainframe.BackgroundTransparency = 0.8
	choice_mainframe.ZIndex = 10000
	choice_mainframe.Parent = nv_main_gui
	choice_title.Size = UDim2.new(1, 0, 0, choices_title_size)
	choice_title.Text = nv_script_name.."://CHOICE-PATROL"
	choice_title.TextColor3 = Color3.fromRGB(255, 255, 255)
	choice_title.TextScaled = true
	choice_title.BackgroundTransparency = 1
	choice_title.TextTransparency = 0
	choice_title.ZIndex = choice_mainframe.ZIndex + 1
	choice_title.Parent = choice_mainframe
	choice_text_label.Size = UDim2.new(1, 0, 0.9, -choices_title_size)
	choice_text_label.Position = UDim2.new(0, 0, 0, choices_title_size)
	choice_text_label.Text = tostring(choice_message)
	choice_text_label.TextColor3 = Color3.fromRGB(255, 255, 255)
	choice_text_label.TextScaled = true
	choice_text_label.BackgroundTransparency = 1
	choice_text_label.TextTransparency = 0
	choice_text_label.ZIndex = choice_mainframe.ZIndex + 1
	choice_text_label.Parent = choice_mainframe
	choice_buttonframe.Size = UDim2.new(1, 0, 0.1, 0)
	choice_buttonframe.Position = UDim2.new(0, 0, 0.9, 0)
	choice_buttonframe.BackgroundTransparency = 1
	choice_buttonframe.ZIndex = choice_mainframe.ZIndex + 1
	choice_buttonframe.Parent = choice_mainframe
	choice_buttonslayout.FillDirection = Enum.FillDirection.Horizontal
	choice_buttonslayout.Padding = UDim.new(0, 5)
	choice_buttonslayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	choice_buttonslayout.VerticalAlignment = Enum.VerticalAlignment.Center
	choice_buttonslayout.VerticalFlex = Enum.UIFlexAlignment.Fill
	choice_buttonslayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
	choice_buttonslayout.Parent = choice_buttonframe
	for key, value in pairs(choices) do
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 0, 30)
		button.Position = UDim2.new(0, 0, 0, 0)
		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		button.BackgroundTransparency = 0.5
		button.Text = value
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextTransparency = 0
		button.TextScaled = true
		button.ZIndex = choice_mainframe.ZIndex + 2
		button.Font = Enum.Font.Gotham
		button.Parent = choice_buttonframe
		button.Activated:Connect(function()
			callback(value, button)
			choice_mainframe:Destroy()
		end)
	end
	if hasCancel and type(hasCancel) == "boolean" then
		local cancel_button = Instance.new("TextButton")
		cancel_button.Size = UDim2.new(0.5, 0, 0, 30)
		cancel_button.AnchorPoint = Vector2.new(0.5, 0.5)
		cancel_button.Position = UDim2.new(0.5, 0, 1, 60)
		cancel_button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		cancel_button.BackgroundTransparency = 0.5
		cancel_button.Text = "Cancel"
		cancel_button.TextColor3 = Color3.fromRGB(255, 255, 255)
		cancel_button.TextTransparency = 0
		cancel_button.TextScaled = true
		cancel_button.ZIndex = choice_mainframe.ZIndex + 2
		cancel_button.Font = Enum.Font.Gotham
		cancel_button.Parent = choice_mainframe
		cancel_button.Activated:Connect(function()
			callback("Cancel")
			choice_mainframe:Destroy()
		end)
	end
	if timeout and type(timeout) == "number" then
		if timeout <= 0 then return end
		task.delay(timeout, function()
			callback("Cancel")
			choice_mainframe:Destroy()
		end)
	end
end
local current_bgm = ""
local play_bgm_using_function = function()
	local bgm_id = getRandomValueFromTable(bgm_ids)
	if bgm_id then
		current_bgm = play_sound(bgm_id, 0.5, 1, true, false)
	end
end
local toggle_bgm = function()
	local found_sound = nil
	if not current_bgm then return end
	for _, v in ipairs(sounds_folder:GetChildren()) do
		if v:IsA("Sound") then
			if v.SoundId == "rbxassetid://"..current_bgm then
				found_sound = v
				break
			end
		end
	end
	if not found_sound then return end
	if found_sound.IsPaused then
		found_sound:Resume()
	else
		found_sound:Pause()
	end
end
local adjust_layout = function(object, adjust_x, adjust_y)
	local layout = object:FindFirstChildWhichIsA("UIListLayout") or object:FindFirstChildWhichIsA("UIGridLayout")
	local padding = object:FindFirstChildWhichIsA("UIPadding")
	if not layout then
		warn("Layout adjusting error: No UIListLayout or UIGridLayout found inside " .. object.Name)
		return
	end
	local updateCanvasSize = function()
		task.wait()
		local absContentSize = layout.AbsoluteContentSize

		local padX, padY = 0, 0
		if padding then
			padX = (padding.PaddingLeft.Offset + padding.PaddingRight.Offset)
			padY = (padding.PaddingTop.Offset + padding.PaddingBottom.Offset)
		end
		local totalX = absContentSize.X + padX + 10
		local totalY = absContentSize.Y + padY + 10

		if adjust_x and adjust_y then
			object.CanvasSize = UDim2.new(0, totalX, 0, totalY)
		elseif adjust_x then
			object.CanvasSize = UDim2.new(0, totalX, object.CanvasSize.Y.Scale, object.CanvasSize.Y.Offset)
		elseif adjust_y then
			object.CanvasSize = UDim2.new(object.CanvasSize.X.Scale, object.CanvasSize.X.Offset, 0, totalY)
		end
	end
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
	object.ChildAdded:Connect(updateCanvasSize)
	object.ChildRemoved:Connect(updateCanvasSize)
	updateCanvasSize()
end
local set_colors = function() 
	local current_month = get_month_number()
	local current_day = get_day_number()
	local current_week = get_week_number()
	--print(current_month, current_day, current_week)
	local targetColor = Color3.fromRGB(166, 166, 166)
	local targetColor2 = Color3.fromRGB(136, 136, 136)
	local targetColor3 = Color3.fromRGB(91, 91, 91)
	local targetColor4 = Color3.fromRGB(50, 50, 50)
	if (current_month == 10 and current_day >= 27) or (current_month == 11 and current_day <= 6) then
		targetColor = Color3.fromRGB(255, 170, 0)
		targetColor2 = Color3.fromRGB(177, 118, 0)
		targetColor3 = Color3.fromRGB(40, 0, 0)
		targetColor4 = Color3.fromRGB(136, 32, 0)
	elseif (current_month == 11 and current_day >= 7 and current_day <= 26) then
		targetColor = Color3.fromRGB(255, 151, 47)
		targetColor2 = Color3.fromRGB(255, 79, 20)
		targetColor3 = Color3.fromRGB(80, 60, 0)
		targetColor4 = Color3.fromRGB(80, 70, 59)
	elseif (current_month == 11 and current_day >= 27) or (current_month == 12 and current_day <= 26) then
		targetColor = Color3.fromRGB(108, 228, 255)
		targetColor2 = Color3.fromRGB(98, 208, 255)
		targetColor3 = Color3.fromRGB(0, 80, 0)
		targetColor4 = Color3.fromRGB(80, 0, 0)
	elseif (current_month == 12 and current_day >= 27) or (current_month == 1 and current_day <= 6) then
		targetColor = Color3.fromRGB(255, 255, 0)
		targetColor2 = Color3.fromRGB(0, 255, 255)
		targetColor3 = Color3.fromRGB(0, 0, 60)
		targetColor4 = Color3.fromRGB(50, 50, 50)
	end
	local applyColorToUIElement = function(ui, color)
		if not ui:IsA("GuiObject") then return end
		if ui:IsA("Frame")
			or ui:IsA("ImageLabel")
			or ui:IsA("ImageButton")
			or ui:IsA("ScrollingFrame")
			or ui:IsA("ViewportFrame") then
			ui.BackgroundColor3 = color
		elseif ui:IsA("TextLabel")
			or ui:IsA("TextButton")
			or ui:IsA("TextBox") then
			ui.BackgroundColor3 = color
		end
	end
	local setframecolors = function()
		for _, ui in ipairs(frame_colors.tc1) do
			applyColorToUIElement(ui, targetColor)
		end
		for _, ui in ipairs(frame_colors.tc2) do
			applyColorToUIElement(ui, targetColor2)
		end
		for _, ui in ipairs(frame_colors.tc3) do
			applyColorToUIElement(ui, targetColor3)
		end
		for _, ui in ipairs(frame_colors.tc4) do
			applyColorToUIElement(ui, targetColor4)
		end
	end
	setframecolors()
end
local can_acces_clipboard = function()
	local success, result = pcall(function()
		setclipboard("GAMEID: "..game.PlaceId)
	end)
	if success then 
		return true
	else
		return false
	end
end
cast_choices({"Sure!", "No, maybe later"}, true, 10, "Do you want to follow the creator?", function(value, button)
	local lowered_choice_0001 = string.lower(value)
	if lowered_choice_0001 == string.lower("Sure!") then
		if not can_acces_clipboard() then
			message("Clipboard error", "Unable to access clipboard, try using a different executor.")
			return
		end
		setclipboard("https://www.roblox.com/users/3051475661/profile")
	else
		message("Creator Following", "You can follow anytime!")
	end
end)
local main_frame = Instance.new("ScrollingFrame")
local main_layout = Instance.new("UIListLayout")
local buttons_frame = Instance.new("ScrollingFrame")
local buttons_layout = Instance.new("UIListLayout")
local buttons_toggle = Instance.new("TextButton")
local scripts_frame = Instance.new("ScrollingFrame")
local scripts_layout = Instance.new("UIListLayout")
local controls_frame = Instance.new("Frame")
local soundboard_frame = Instance.new("ScrollingFrame")
local soundboard_layout = Instance.new("UIGridLayout")
local title = Instance.new("TextLabel")
local toggle_button = Instance.new("TextButton")
main_frame.Size = UDim2.new(0, 250, 0, 210)
main_frame.Position = UDim2.new(0.5, -125, 0.5, -130)
main_frame.Parent = nv_main_gui
main_layout.Padding = UDim.new(0, 5)
main_layout.FillDirection = Enum.FillDirection.Vertical
main_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
main_layout.VerticalAlignment = Enum.VerticalAlignment.Top
main_layout.SortOrder = Enum.SortOrder.LayoutOrder
main_layout.Parent = main_frame
buttons_frame.Size = UDim2.new(0, 250, 0, 200)
buttons_frame.Position = UDim2.new(0, 0, 0, 200)
buttons_frame.Visible = true
buttons_frame.Parent = nv_main_gui
buttons_frame.BackgroundTransparency = 0
buttons_frame.ClipsDescendants = true
buttons_layout.Padding = UDim.new(0, 5)
buttons_layout.FillDirection = Enum.FillDirection.Vertical
buttons_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
buttons_layout.VerticalAlignment = Enum.VerticalAlignment.Top
buttons_layout.SortOrder = Enum.SortOrder.LayoutOrder
buttons_layout.Parent = buttons_frame
buttons_toggle.Size = UDim2.new(0, 100, 0, 30)
buttons_toggle.Position = UDim2.new(0.5, -50, 0, 40)
buttons_toggle.Text = "Toggle buttons"
buttons_toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
buttons_toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
buttons_toggle.Parent = nv_main_gui
scripts_frame.Size = UDim2.new(0, 200, 0, 150)
scripts_frame.Position = UDim2.new(0.5, -100, 0.5, -150)
scripts_frame.Visible = false 
scripts_frame.Parent = nv_main_gui
scripts_layout.Padding = UDim.new(0, 5)
scripts_layout.FillDirection = Enum.FillDirection.Vertical
scripts_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
scripts_layout.VerticalAlignment = Enum.VerticalAlignment.Top
scripts_layout.SortOrder = Enum.SortOrder.LayoutOrder
scripts_layout.Parent = scripts_frame
controls_frame.Size = UDim2.new(0, 200, 0, 150)
controls_frame.Position = UDim2.new(0.5, -100, 0.5, -150)
controls_frame.Visible = false 
controls_frame.Parent = nv_main_gui
soundboard_frame.Size = UDim2.new(0, 200, 0, 200)
soundboard_frame.Position = UDim2.new(0.5, -100, 0.5, -150)
soundboard_frame.Visible = false
soundboard_frame.Parent = nv_main_gui
soundboard_layout.Parent = soundboard_frame
soundboard_layout.SortOrder = Enum.SortOrder.Name
soundboard_layout.CellSize = UDim2.new(0, 80, 0, 20)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = nv_univsersal_formatted_name
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
--title.TextSize = 18
title.Parent = main_frame
title.TextScaled = true
toggle_button.Size = UDim2.new(0, 30, 0, 30)
toggle_button.Position = UDim2.new(0.5, -15, 0, 10)
toggle_button.Text = "SVe" -- NVe
toggle_button.Font = Enum.Font.SourceSansBold
toggle_button.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle_button.TextSize = 14
toggle_button.Parent = nv_main_gui
make_draggable(toggle_button)
make_interface_styles(toggle_button)
make_draggable(main_frame)
make_draggable(controls_frame)
make_interface_styles(main_frame)
make_interface_styles(controls_frame)
make_interface_styles(buttons_frame)
make_draggable(buttons_frame)
make_interface_styles(scripts_frame)
make_draggable(scripts_frame)
make_draggable(buttons_toggle)
make_draggable(soundboard_frame)
make_interface_styles(soundboard_frame)
adjust_layout(buttons_frame, false, true)
adjust_layout(main_frame, false, true)
adjust_layout(soundboard_frame, true, true)
adjust_layout(scripts_frame, false, true)
local create_sound_board_buttons = function()
	for _, v in ipairs(soundboard_frame:GetChildren()) do
		if v:IsA("TextButton") and nv_collection_service:HasTag(v, SBS_TAG) then
			v:Destroy()
		end
	end
	for name, id in pairs(sfx_ids) do
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 140, 0, 32)
		button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.Font = Enum.Font.SourceSansSemibold
		button.TextScaled = true
		button.Text = name
		button.Parent = soundboard_frame
		nv_collection_service:AddTag(button, SBS_TAG)
		make_interface_styles(button)
		button.Activated:Connect(function()
			play_sound(id, 1, 1, false, true) 
		end)
	end
end
local create_veditor = function(name, variable, callback)
	local container = Instance.new("Frame")
	local label = Instance.new("TextLabel")
	local box = Instance.new("TextBox")
	container.Size = UDim2.new(1, -5, 0, 25)
	container.BackgroundTransparency = 1
	container.Parent = main_frame
	label.Size = UDim2.new(0.5, -5, 1, 0)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name .. " :"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container
	box.Size = UDim2.new(0.5, -10, 1, 0)
	box.Position = UDim2.new(0.5, 5, 0, yPos)
	box.Text = tostring(variable)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.ClearTextOnFocus = false
	box.Parent = container
	box.FocusLost:Connect(function()
		local num = tonumber(box.Text)
		if num then
			callback(num)
			box.Text = tostring(num)
		else
			box.Text = tostring(variable)
		end
	end)
end
local create_button = function(text, color, callback)
	local button = Instance.new("TextButton")
	local stroke = Instance.new("UIStroke")
	button.Size = UDim2.new(1, -10, 0, 30)
	button.Position = UDim2.new(0, 0, 0, 0)
	button.BackgroundColor3 = color
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 16
	button.Parent = buttons_frame
	stroke.Thickness = 2
	stroke.Parent = button
	table.insert(frame_colors.tc2, stroke)
	button.MouseButton1Click:Connect(function()
		nv_tween_service:Create(button, TweenInfo.new(0.1), {
			BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		}):Play()
		task.wait(0.1)
		nv_tween_service:Create(button, TweenInfo.new(0.2), {
			BackgroundColor3 = color
		}):Play()
		callback()
	end)
end
local moveCharacter = function(directionVector, dt)
	if not (univ_hrp and univ_cam) then return end
	local camCFrame = univ_cam.CFrame
	local right = camCFrame.RightVector
	local forward = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z).Unit
	local up = Vector3.new(0, 1, 0)
	local moveVector = right * directionVector.X + forward * directionVector.Z + up * directionVector.Y
	univ_hrp.CFrame += moveVector * (CFSpeed * dt)
	if directionVector.Y ~= 0 then
		frozen_y += directionVector.Y * (CFSpeed / 2) * dt
	end
end
local create_control_button = function(text, x, y, dirVector)
	local button = Instance.new("TextButton")
	local stroke = Instance.new("UIStroke")
	local holding = false
	button.Size = UDim2.new(0, 50, 0, 50)
	button.Position = UDim2.new(0, x, 0, y)
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 20
	button.Text = text
	button.Parent = controls_frame
	stroke.Thickness = 2
	stroke.Parent = button
	table.insert(frame_colors.tc2, stroke)
	button.MouseButton1Down:Connect(function()
		holding = true
		while holding do
			local dt = nv_run_service.RenderStepped:Wait()
			moveCharacter(dirVector, dt)
		end
	end)
	button.MouseButton1Up:Connect(function()
		holding = false
	end)
	button.MouseLeave:Connect(function()
		holding = false
	end)
end
local stop_all_loops = function()
	if speed_connection then speed_connection:Disconnect() speed_connection = nil end
	if y_freeze_connection then y_freeze_connection:Disconnect() y_freeze_connection = nil end
	if spoofc_connection then spoofc_connection:Disconnect() spoofc_connection = nil end
	if univ_humanoid then univ_humanoid.CameraOffset = Vector3.new(0, 0, 0) end
end
local setup_death_connection = function()
	if not univ_humanoid then return end
	univ_humanoid.Died:Connect(function()
		died = true
		stop_all_loops()
		message("Notice", "You died, loops are disabled.", 3)
	end)
end
local refresh_universal_variables = function()
	univ_character = nv_player.Character or nv_player.CharacterAdded:Wait()
	univ_humanoid = univ_character:FindFirstChildOfClass("Humanoid")
	univ_hrp = univ_character:FindFirstChild("HumanoidRootPart")
	univ_cam = workspace.CurrentCamera
	died = false
	y_frozen = false
	if univ_character and univ_humanoid and univ_hrp and univ_cam then message("Variables Refreshed", "All universal references updated.", 2) setup_death_connection() else warn("[Refresh] Some universal variables could not be found.") end
end
local spoof_cam = function()
	if spoofc_connection then return end
	spoofc_connection = nv_run_service.Heartbeat:Connect(function() if univ_humanoid then univ_humanoid.CameraOffset = Vector3.new(0, -offset, 0) end end)
end
local stop_spoof_cam = function() if spoofc_connection then spoofc_connection:Disconnect() spoofc_connection = nil end if univ_humanoid then univ_humanoid.CameraOffset = Vector3.new(0, 0, 0) end end
local freeze_y_axis = function(hrp)
	if y_freeze_connection then return end
	y_frozen = true
	frozen_y = hrp.Position.Y
	y_freeze_connection = nv_run_service.Heartbeat:Connect(function()
		local pos = hrp.Position
		hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
		hrp.CFrame = CFrame.new(pos.X, frozen_y, pos.Z) * hrp.CFrame.Rotation
	end)
end
local unfreeze_y_axis = function()
	if y_freeze_connection then
		y_freeze_connection:Disconnect()
		y_freeze_connection = nil
	end
	y_frozen = false
	frozen_y = nil
end
local start_cframe_speed = function()
	if speed_connection then return end
	speed_connection = nv_run_service.RenderStepped:Connect(function(dt)
		if died then
			speed_connection:Disconnect()
			speed_connection = nil
			return
		end
		if not (univ_humanoid and univ_hrp) then return end
		local finalDir = univ_humanoid.MoveDirection
		if finalDir.Magnitude > 0 then
			univ_hrp.CFrame += finalDir.Unit * (CFSpeed * dt)
		end
	end)
end
local handle_y_freeze_modification = function(direction)
	if not y_frozen then return end
	if y_adjust_connection then y_adjust_connection:Disconnect() end
	y_adjust_connection = nv_run_service.Heartbeat:Connect(function(dt)
		if not y_frozen then
			y_adjust_connection:Disconnect()
			y_adjust_connection = nil
			return
		end
		frozen_y += direction * (CFSpeed * dt / 2) 
	end)
end
local stop_y_freeze_modification = function()
	if y_adjust_connection then
		y_adjust_connection:Disconnect()
		y_adjust_connection = nil
	end
end
local stop_cframe_speed = function() if speed_connection then speed_connection:Disconnect() speed_connection = nil end end
local set_offset = function()
	if died then
		message("Error", "Cannot toggle offset while dead!", 3)
		stop_all_loops()
		return
	end
	if not (univ_character and univ_humanoid and univ_hrp and univ_cam) then
		refresh_universal_variables()
		return
	end
	local offset_local = offset
	local hrp = univ_hrp
	local character = univ_character
	if offset_bool then
		hrp.CFrame = hrp.CFrame * CFrame.new(0, offset_local, 0)
		spoof_cam()
		freeze_y_axis(hrp)
		message("Offset Enabled", "Y movement locked", 3)
	else
		unfreeze_y_axis()
		hrp.CFrame = hrp.CFrame * CFrame.new(0, -offset_local, 0)
		stop_spoof_cam()
		message("Offset Disabled", "Y movement restored", 3)
	end
end
local cast_scripts_from_json = function()
	if not scripts_json_url or scripts_json_url == "" then message("Error", "Missing JSON URL, please provide a JSON URL for your roblox scripts", 4) return end
	local visibleIndex = 0
	local success, result = pcall(function() return game:HttpGet(scripts_json_url) end)
	local decodeSuccess, decoded = pcall(function() return nv_http_service:JSONDecode(result) end)
	if not success then message("Error", "Failed to fetch JSON scripts.", 4) warn("[NV JSON] Fetch failed:", result) return end
	if not decodeSuccess or type(decoded) ~= "table" then message("Error", "Invalid JSON structure.", 4) warn("[NV JSON] Decode failed:", decoded) return end
	for _, v in ipairs(scripts_frame:GetChildren()) do
		if v:IsA("TextButton") and nv_collection_service:HasTag(v, BUTTON_TAG) then
			v:Destroy()
		end
	end
	for _, scriptData in ipairs(decoded) do
		if type(scriptData) ~= "table" then continue end
		local name = tostring(scriptData.name or "Unnamed Script")
		local colorTable = scriptData.color
		local color = Color3.fromRGB(80, 80, 80)
		local specifiedGame = tostring(scriptData.specified_game or "")
		local code = scriptData.code or ""
		if typeof(colorTable) == "table" and #colorTable == 3 then color = Color3.fromRGB(colorTable[1], colorTable[2], colorTable[3]) end
		if specifiedGame == "" or specifiedGame == "nil" or specifiedGame == tostring(gamePlaceId) then
			visibleIndex += 1
			local text_button = Instance.new("TextButton")
			text_button.Size = UDim2.new(0, 200, 0, 40)
			text_button.Position = UDim2.new(0.5, -100, 0, 50 + ((visibleIndex - 1) * 50))
			text_button.BackgroundColor3 = color
			text_button.Text = name
			text_button.TextColor3 = Color3.new(1, 1, 1)
			--text_button.TextSize = 18
			text_button.Parent = scripts_frame
			text_button.TextScaled = true
			nv_collection_service:AddTag(text_button, BUTTON_TAG)
			text_button.MouseButton1Click:Connect(function()
				if not can_run_load_string() then 
					message("Loadstring Error", "Your executor doesn't support loadstring, use another executor and try again", 5)
					return
				end
				if scriptData.patched == true then
					message("Executing Patched Script", "The script you tried to execute is patched, it will no longer work as expected, a pop-up message will be shown if you decide to execute it.", 3)
					cast_choices(
						{ "Yes, Execute Anyway", "Cancel" }, true, 15, "Confirm patched script execution?", function(choice, chosenButton)
							local lowered = string.lower(choice)
							if choice == string.lower("Yes, Execute Anyway") then
								message("Running Script", name, 2)
								local ok, err = pcall(function()
									loadstring(code)()
								end)
								if ok then
									message("Success", "Patched script executed successfully, if you come to experience problems, please don't blame the creator.", 2)
								else
									message("Error", "Script failed: " .. tostring(err), 5)
								end
							elseif choice == string.lower("Cancel") then
								message("Cancelled", "Script execution terminated.", 2)
							end
						end
					)
				else
					message("Running Script", name, 2)
					local ok, err = pcall(function() loadstring(code)() end)
					if ok then
						message("Success", "Script executed successfully.", 2)
					else
						message("Error", "Script failed: " .. tostring(err), 5)
					end
				end
			end)
		end
	end
end
--HEY! if I simplify this, it breaks, try it
create_veditor(
    "offset",
    offset,
    function(num)
        offset = num
        message("Variable Updated", "Offset set to " .. num, 2)
    end
)
create_veditor(
	"CFSpeed", 
	CFSpeed, 
	function(num) 
		CFSpeed = num 
		message("Variable Updated", "CFSpeed set to " .. num, 2) 
	end
)
create_button(
	"Scripts Menu", 
	Color3.fromRGB(155, 155, 155), 
	function() 
		scripts_frame.Visible = not scripts_frame.Visible 
		if scripts_frame.Visible then 
			cast_scripts_from_json() 
		end 
	end
)
create_button(
	"Refresh Variables", 
	Color3.fromRGB(70, 130, 180), 
	function() 
	refresh_universal_variables() 
	end
)
create_button(
	"CFrame Speed", 
	Color3.fromRGB(60, 179, 113), 
	function() 
		speed_enabled = not speed_enabled 
		if speed_enabled then 
			start_cframe_speed() 
			message("Speed", "CFrame speed enabled.", 2) 
		else 
			stop_cframe_speed() 
			message("Speed", "CFrame speed disabled.", 2) 
		end 
	end
)
create_button(
	"Toggle Offset", 
	Color3.fromRGB(255, 140, 0), 
	function() 
		offset_bool = not offset_bool set_offset() 
	end
)
create_button(
	"Soundboard", 
	Color3.fromRGB(90,200,40), 
	function() 
		soundboard_frame.Visible = not soundboard_frame.Visible 
		if soundboard_frame.Visible then 
			create_sound_board_buttons() 
		end 
	end
)
create_button(
	"Show Controls", 
	Color3.fromRGB(255, 165, 0), 
	function() 
		controls_frame.Visible = not controls_frame.Visible 
	end
)
create_button("Toggle BGM", Color3.fromRGB(128,234,294), function() toggle_bgm() end)
create_control_button("Q", 10, 10, Vector3.new(0, -1, 0)) 
create_control_button("E", 140, 10, Vector3.new(0, 1, 0)) 
create_control_button("W", 70, 10, Vector3.new(0, 0, 1)) 
create_control_button("A", 10, 70, Vector3.new(-1, 0, 0)) 
create_control_button("S", 70, 70, Vector3.new(0, 0, -1)) 
create_control_button("D", 140, 70, Vector3.new(1, 0, 0)) 
table.insert(frame_colors.tc1, main_frame)
table.insert(frame_colors.tc1, scripts_frame)
table.insert(frame_colors.tc1, controls_frame)
table.insert(frame_colors.tc1, buttons_frame)
table.insert(frame_colors.tc1, toggle_button)
table.insert(frame_colors.tc2, title)
table.insert(frame_colors.tc2, soundboard_frame)
task.spawn(function() while true do task.wait(4) set_colors() end end)
get_sounds_from_json()
nv_input_service.InputBegan:Connect(function(input, processed) 
	if processed then return end 
	if input.KeyCode == Enum.KeyCode.F2 then 
		offset_bool = not offset_bool set_offset() 
	elseif input.KeyCode == Enum.KeyCode.F3 then 
		refresh_universal_variables() 
	elseif input.KeyCode == Enum.KeyCode.F4 then 
		speed_enabled = not speed_enabled 
		if speed_enabled and not died then 
			start_cframe_speed() 
			message("Speed", "CFrame speed enabled.", 2) 
		else 
			stop_cframe_speed() 
			message("Speed", "CFrame speed disabled.", 2) 
		end 
	elseif input.KeyCode == Enum.KeyCode.Q then 
		handle_y_freeze_modification(-1) 
	elseif input.KeyCode == Enum.KeyCode.E then 
		handle_y_freeze_modification(1) 
	end 
end)
nv_input_service.InputEnded:Connect(function(input) 
	if input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.E then 
		stop_y_freeze_modification() 
	end 
end)
toggle_button.Activated:Connect(function()
	if next(currently_dragged) then return end
	if not nv_main_gui or not nv_main_gui.Parent then return end
	if not main_frame or not main_frame.Parent then return end
	if not scripts_frame or not scripts_frame.Parent then return end
	if not controls_frame or not controls_frame.Parent then return end
	if main_frame.Visible then
		buttons_is_visible = buttons_frame.Visible
		main_frame.Visible = false
		scripts_frame.Visible = false
		controls_frame.Visible = false
		controls_frame.Visible = false
		buttons_frame.Visible = false
		buttons_toggle.Visible = false
		soundboard_frame.Visible = false
	else
		main_frame.Visible = true
		buttons_frame.Visible = buttons_is_visible
		buttons_toggle.Visible = true
	end
end)
buttons_toggle.Activated:Connect(function()
	if next(currently_dragged) then return end
	if not nv_main_gui or not nv_main_gui.Parent then return end
	if not main_frame or not main_frame.Parent then return end
	if not scripts_frame or not scripts_frame.Parent then return end
	if not controls_frame or not controls_frame.Parent then return end
	if not main_frame.Visible then return end
	if buttons_frame.Visible then buttons_frame.Visible = false else buttons_frame.Visible = buttons_is_visible or true end
end)
refresh_universal_variables()
nv_player.CharacterAdded:Connect(function() task.wait(1) refresh_universal_variables() end)
task.wait(5)
local formatted_message = 'Loading :'..nv_univsersal_formatted_name
message("niceloader v1.0", formatted_message, 3)

