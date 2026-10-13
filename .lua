-- Deobfuscated by ccjvwsod on Discord
-- Detected obfuscation: Luraph v15
-- Local names are inferred from use (the original names are not in the bytecode)

pcall(function()
	if setthreadidentity then
		setthreadidentity(8)
	end
end)

local localPlayer = game:GetService("Players").LocalPlayer

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local tbl

tbl = {
	SelectedPetData = nil,
	AllAnimalsCache = nil,
	ListNeedsRedraw = true,
	MobileScaleObjects = {},
	RefreshMobileScale = nil,
}

do
	local UserInputService = game:GetService("UserInputService")
	local GuiService = game:GetService("GuiService")

	local function fn()
		local flag = false
		local flag2 = false
		local flag3 = false
		local flag4 = false

		pcall(function()
			flag = UserInputService.TouchEnabled
			flag2 = UserInputService.KeyboardEnabled
			flag3 = UserInputService.MouseEnabled
			flag4 = UserInputService.GamepadEnabled
		end)

		local flag5 = false

		pcall(function()
			flag5 = GuiService:IsTenFootInterface()
		end)

		if flag5 or flag4 and not flag and not flag2 then
			return "console"
		end

		if flag2 and flag3 then
			return "pc"
		end

		if flag then
			local currentCamera = workspace.CurrentCamera
			local viewportSize = currentCamera and currentCamera.ViewportSize or Vector2.new(390, 760)
			return math.min(viewportSize.X, viewportSize.Y) >= 600 and "tablet" or "phone"
		end

		return "pc"
	end

	local function fn2()
		_G.YesDevice = fn()
		_G.YesIsTouch = _G.YesDevice == "phone" or _G.YesDevice == "tablet"
		_G.YesIsPhone = _G.YesDevice == "phone"
		_G.YesIsTablet = _G.YesDevice == "tablet"
		_G.YesIsConsole = _G.YesDevice == "console"
	end

	fn2()
	local currentCamera = workspace.CurrentCamera

	if currentCamera then
		currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			fn2()
		end)
	end
end

do
	local tbl2 = { AUTO_STEAL = false, RADIUS = 12 }

	local tbl3 = {
		{
			min = Vector3.new(-337.4483, -3.898971, -122.39776),
			max = Vector3.new(-328.00458, -3.898971, 242.62563),
		},
		{
			min = Vector3.new(-327.25766, -3.899109, -122.22862),
			max = Vector3.new(-320.6009, -3.899109, 242.61226),
		},
		{
			min = Vector3.new(-319.7834, -3.89897, -122.22709),
			max = Vector3.new(-312.90833, -3.89897, 242.58562),
		},
		{
			min = Vector3.new(-312.44565, -3.899108, -122.38983),
			max = Vector3.new(-305.4899, -3.899108, 242.45682),
		},
		{
			min = Vector3.new(-305.03705, -3.89897, -122.23074),
			max = Vector3.new(-293.9575, -3.89897, 242.60687),
		},
		{
			min = Vector3.new(-491.4486, -3.898972, -122.25326),
			max = Vector3.new(-481.81174, -3.898972, 242.615),
		},
		{
			min = Vector3.new(-498.97107, -3.89897, -122.38277),
			max = Vector3.new(-491.74884, -3.89897, 242.61206),
		},
		{
			min = Vector3.new(-506.43674, -3.898972, -122.411476),
			max = Vector3.new(-499.31854, -3.898972, 242.61598),
		},
		{
			min = Vector3.new(-513.78357, -3.898972, -122.2233),
			max = Vector3.new(-506.80185, -3.898972, 242.62709),
		},
		{
			min = Vector3.new(-525.23694, -3.898972, -122.40981),
			max = Vector3.new(-514.265, -3.898972, 242.60893),
		},
	}

	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local localPlayer2 = Players.LocalPlayer
	local connection = nil

	local function fn()
		localPlayer2.DevEnableMouseLock = true
		localPlayer2.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam

		if connection then
			connection:Disconnect()
		end

		connection = RunService.RenderStepped:Connect(function()
			local currentCamera = workspace.CurrentCamera

			if currentCamera and currentCamera.CameraSubject and currentCamera.CameraType == Enum.CameraType.Custom then
				currentCamera.CFrame = currentCamera.CFrame
			end
		end)
	end

	fn()

	localPlayer2.CharacterAdded:Connect(function()
		task.wait(0.5)
		fn()
	end)

	local tbl4 = {}
	local tbl5 = {}
	local n = 0

	_G.getSafePollRate = function()
		if os.clock() < n then
			return 0.27
		end
		return 0.1
	end

	_G.triggerSafePollBoost = function()
		n = os.clock() + 3
	end

	local tbl6 = {}

	local function fn2()
		local character = localPlayer2.Character
		return character and character:FindFirstChild("HumanoidRootPart")
	end

	local function fn3(arg)
		for i, v in ipairs(tbl3) do
			if arg.X >= math.min(v.min.X, v.max.X) and arg.X <= math.max(v.min.X, v.max.X) and arg.Z >= math.min(v.min.Z, v.max.Z) and arg.Z <= math.max(v.min.Z, v.max.Z) then
				return i
			end
		end
	end

	local function fn4(arg)
		local parent = arg.Parent
		if not parent then
			return
		end

		if parent:IsA("Attachment") and parent.Parent then
			parent = parent.Parent
		end

		if parent:IsA("BasePart") then
			return parent.Position
		end

		if parent:IsA("Model") then
			return parent:GetPivot().Position
		end
	end

	local function fn5(arg)
		if not tbl then
			return false
		end
		local selectedPetData = tbl.SelectedPetData
		if not selectedPetData then
			return false
		end
		local model = arg:FindFirstAncestorOfClass("Model")
		if not model then
			return false
		end

		if selectedPetData.plot then
			if not arg:FindFirstAncestor(selectedPetData.plot) then
				return false
			end
		end

		if selectedPetData.slot then
			if arg:FindFirstAncestor(selectedPetData.slot) then
				return true
			end

			if model.Name == selectedPetData.slot then
				return true
			end

			if model.Parent and model.Parent.Name == selectedPetData.slot then
				return true
			end
		end

		if selectedPetData.name then
			local v = string.lower(selectedPetData.name)

			while model do
				if model.Name and string.lower(model.Name) == v then
					return true
				end
				model = model.Parent
			end
		end

		return false
	end

	local function fn6(arg, arg2)
		if not arg or not arg.Parent then
			return false
		end

		if not arg.Enabled then
			return false
		end
		local v = fn4(arg)
		if not v then
			return false
		end

		if arg:FindFirstAncestorOfClass("Model") then
			local plots = workspace:FindFirstChild("Plots")

			if plots then
				local model = arg:FindFirstAncestorWhichIsA("Model")

				while model and model.Parent ~= plots do
					model = model.Parent
				end

				if model then
					local plotSign = model:FindFirstChild("PlotSign")

					if plotSign then
						local surfaceGui = plotSign:FindFirstChildWhichIsA("SurfaceGui", true)
						surfaceGui = surfaceGui and surfaceGui:FindFirstChildWhichIsA("TextLabel", true)

						if surfaceGui then
							local str = surfaceGui.Text:lower()
							if str:find(game.Players.LocalPlayer.Name:lower(), 1, true) or str:find(game.Players.LocalPlayer.DisplayName:lower(), 1, true) then
								return false
							end
						end
					end
				end
			end
		end

		if _G.NEAREST_INSTANT_MODE == true then
			local v2 = fn3(arg2)
			local v3 = fn3(v)
			if not v2 or v2 ~= v3 then
				return false
			end
		end

		if _G.NEAREST_INSTANT_MODE ~= true then
			if not fn5(arg) then
				return false
			end
		end

		return (v - arg2).Magnitude <= math.min(tbl2.RADIUS, typeof(arg.MaxActivationDistance) == "number" and arg.MaxActivationDistance > 0 and arg.MaxActivationDistance or tbl2.RADIUS)
	end

	local function fn7(arg, arg2)
		local now = os.clock()
		local v = tbl5[arg]
		if v and now - v < arg2 then
			return false
		end
		tbl5[arg] = now
		return true
	end

	local function fn8(arg, arg2, arg3)
		if not arg or not arg.Parent then
			return
		end

		if not arg.Enabled then
			return
		end

		if not fn7(arg, arg3) then
			return
		end

		for i = 1, arg2 do
			pcall(function()
				fireproximityprompt(arg, 0)
			end)
		end
	end

	local function fn9(arg)
		if tbl4[arg] then
			return
		end
		tbl4[arg] = true

		local function fn10()
			local v = fn2()
			if not v then
				return
			end

			if fn6(arg, v.Position) then
				tbl2.AUTO_STEAL = true
				local now = os.clock()
				local v2 = tbl6[arg]

				if not v2 or now - v2 >= 0.08 then
					tbl6[arg] = now
					fn8(arg, 25, 0)
				end
			end
		end

		task.defer(function()
			fn10()
		end)

		pcall(function()
			arg:GetPropertyChangedSignal("Enabled"):Connect(function()
				if arg.Enabled then
					fn10()
				end
			end)
		end)

		arg.AncestryChanged:Connect(function()
			if not arg:IsDescendantOf(workspace) then
				tbl4[arg] = nil
				tbl5[arg] = nil
				tbl6[arg] = nil
			end
		end)
	end

	local function fn10()
		local plots = workspace:FindFirstChild("Plots")
		if not plots then
			return
		end

		for _, child in ipairs(plots:GetChildren()) do
			local animalPodiums = child:FindFirstChild("AnimalPodiums")

			if animalPodiums then
				for _, descendant in ipairs(animalPodiums:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") then
						fn9(descendant)
					end
				end
			end
		end
	end

	fn10()

	workspace.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("ProximityPrompt") and descendant:FindFirstAncestor("AnimalPodiums") then
			fn9(descendant)
		end
	end)

	task.spawn(function()
		while task.wait(_G.getSafePollRate()) do
			local v = fn2()

			if not v then
				tbl2.AUTO_STEAL = false
			else
				local position = v.Position
				local autoSteal = false

				for k in pairs(tbl4) do
					if fn6(k, position) then
						autoSteal = true

						if tbl2.AUTO_STEAL then
							fn8(k, 3, 0.12)
							autoSteal = true
						end
					end
				end

				tbl2.AUTO_STEAL = autoSteal
			end
		end
	end)
end

local players, runService, replicatedStorage, tweenService, workspace_, localPlayer2, playerGui, v, scale, v2
local fn

do
	local tbl2 = {
		Players = game:GetService("Players"),
		RunService = game:GetService("RunService"),
		UserInputService = game:GetService("UserInputService"),
		ReplicatedStorage = game:GetService("ReplicatedStorage"),
		TweenService = game:GetService("TweenService"),
		HttpService = game:GetService("HttpService"),
		Workspace = game:GetService("Workspace"),
		Lighting = game:GetService("Lighting"),
		GuiService = game:GetService("GuiService"),
		TeleportService = game:GetService("TeleportService"),
	}

	players = tbl2.Players
	runService = tbl2.RunService
	local userInputService = tbl2.UserInputService
	replicatedStorage = tbl2.ReplicatedStorage
	tweenService = tbl2.TweenService
	local httpService = tbl2.HttpService
	workspace_ = tbl2.Workspace
	localPlayer2 = players.LocalPlayer
	playerGui = localPlayer2:WaitForChild("PlayerGui")
	local obj = nil

	obj = setmetatable({}, { __index = function(arg, arg2)
		local net = replicatedStorage.Packages.Net

		if arg2:sub(1, 3) == "RE/" then
			arg2:sub(4)
		else
			if arg2:sub(1, 3) ~= "RF/" then
				return nil
			end
			arg2:sub(4)
		end

		local v3 = nil

		for k, v4 in net:GetChildren() do
			if v4.Name == arg2 then
				v3 = net:GetChildren()[k + 1]
				break
			else
				v3 = nil
			end
		end

		if v3 and not rawget(obj, arg2) then
			rawset(obj, arg2, v3)
		end

		return rawget(obj, arg2)
	end })

	local tbl3 = { LarpNet = function(arg, arg2)
		return obj[arg2]
	end }

	localPlayer2:GetMouse()

	local function fn2()
		return userInputService.TouchEnabled and not userInputService.KeyboardEnabled and not userInputService.MouseEnabled
	end

	v = fn2()
	scale = 0.79

	local tbl4 = {
		Positions = {
			AutoSteal = { X = 0, Y = 0, OffsetX = 14, OffsetY = 80 },
			TargetControls = { X = 0, Y = 0, OffsetX = 14 + 320 * scale + 10, OffsetY = 80 },
		},
		MenuKey = "LeftControl",
		MobileGuiScale = 0.5,
		StealNearest = false,
		StealHighest = true,
		StealPriority = false,
		DefaultToNearest = false,
		DefaultToHighest = false,
		DefaultToPriority = false,
		UILocked = false,
		HideAutoSteal = false,
		CompactAutoSteal = false,
		InstantSteal = false,
		nextBaseEnabled = false,
		XRay = false,
		PlayerESP = false,
		podiumESP = false,
		TurretESP = false,
		TrapESP = false,
		BrainrotESP = false,
		BrainrotESPMinGen = 10000000,
		AntiRagdoll = true,
		AntiBeeDisco = true,
		AntiDie = true,
		AutoTurret = false,
		AntiLag = false,
		CarpetSpeed = false,
		CarpetSpeedValue = 140,
		CarpetSpeedKey = "Q",
		InfJump = true,
		AutoKickOnSteal = false,
		FOV = 80,
		ResetCooldown = 2.5,
		ResetFlingTime = 5,
		PriorityList = {
			"Strawberry Elephant",
			"Meowl",
			"Skibidi Toilet",
			"Headless Horseman",
			"Dragon Gingerini",
			"Dragon Cannelloni",
			"Ketupat Bros",
			"Hydra Dragon Cannelloni",
			"La Supreme Combinasion",
			"Love Love Bear",
			"Ginger Gerat",
			"Cerberus",
			"Capitano Moby",
			"La Casa Boo",
			"Burguro and Fryuro",
			"Spooky and Pumpky",
			"Cooki and Milki",
			"Rosey and Teddy",
			"Popcuru and Fizzuru",
			"Reinito Sleighito",
			"Fragrama and Chocrama",
			"Garama and Madundung",
			"Ketchuru and Musturu",
			"La Secret Combinasion",
			"Tralaledon",
			"Tictac Sahur",
			"Ketupat Kepat",
			"Tang Tang Keletang",
			"Orcaledon",
			"La Ginger Sekolah",
			"Los Spaghettis",
			"Lavadorito Spinito",
			"Swaggy Bros",
			"La Taco Combinasion",
			"Los Primos",
			"Chillin Chili",
			"Tuff Toucan",
			"W or L",
			"Chillin Chili",
			"Chipso and Queso",
		},
	}

	DeepCopy = function(arg)
		if type(arg) ~= "table" then
			return arg
		end
		local tbl5 = {}

		for k, v3 in pairs(arg) do
			tbl5[k] = DeepCopy(v3)
		end

		return tbl5
	end

	MergeDefaults = function(arg, arg2)
		for k, v3 in pairs(arg2) do
			if type(v3) == "table" then
				if type(arg[k]) ~= "table" then
					arg[k] = DeepCopy(v3)
				else
					MergeDefaults(arg[k], v3)
				end
			elseif arg[k] == nil then
				arg[k] = v3
			end
		end
	end

	v2 = DeepCopy(tbl4)

	NormalizeKeyName = function(arg, arg2)
		if type(arg) ~= "string" or arg == "" then
			return arg2
		end

		local v3 = ({
			ALT = "LeftAlt",
			LALT = "LeftAlt",
			RALT = "RightAlt",
			CTRL = "LeftControl",
			CONTROL = "LeftControl",
			LCTRL = "LeftControl",
			RCTRL = "RightControl",
			SHIFT = "LeftShift",
			LSHIFT = "LeftShift",
			RSHIFT = "RightShift",
			WIN = "LeftSuper",
			CMD = "LeftSuper",
			META = "LeftSuper",
		})[string.upper(arg)] or arg

		return Enum.KeyCode[v3] and v3 or arg
	end

	PrettyKeyName = function(arg)
		local v3 = ({
			LeftAlt = "ALT",
			RightAlt = "RALT",
			LeftControl = "CTRL",
			RightControl = "RCTRL",
			LeftShift = "SHIFT",
			RightShift = "RSHIFT",
			LeftSuper = "WIN",
			RightSuper = "RWIN",
		})[arg]

		local str

		if v3 then
			str = v3
		else
			str = tostring(arg or "")
		end

		return str
	end

	if isfile and isfile("SlicedzHub.json") then
		pcall(function()
			local json = readfile("SlicedzHub.json")
			if not json or json == "" then
				return
			end
			local data = httpService:JSONDecode(json)
			if type(data) ~= "table" then
				return
			end
			local v3 = nil

			if type(data.PriorityList) == "table" then
				v3 = DeepCopy(data.PriorityList)
			end

			MergeDefaults(data, tbl4)

			if v3 ~= nil then
				data.PriorityList = v3
			end

			v2 = data
		end)
	end

	if v2.Positions then
		v2.Positions.Settings = { X = 0.5, Y = 0.5, OffsetX = 0, OffsetY = 0 }
	end

	if v2.LayoutRev ~= 4 then
		v2.Positions = v2.Positions or {}
		v2.Positions.AutoSteal = DeepCopy(tbl4.Positions.AutoSteal)
		v2.Positions.TargetControls = DeepCopy(tbl4.Positions.TargetControls)
		v2.LayoutRev = 4
		v2.FixedLayout = nil
		_needMigrationSave = true
	end

	EnsureSavedKeybinds = function()
		v2.SavedKeybinds = v2.SavedKeybinds or {}
		v2.SavedKeybinds.MenuKey = NormalizeKeyName(v2.SavedKeybinds.MenuKey or v2.MenuKey, tbl4.MenuKey or "LeftControl")
	end

	ApplySavedKeybindsToConfig = function()
		EnsureSavedKeybinds()
		v2.MenuKey = v2.SavedKeybinds.MenuKey
	end

	NormalizeAllKeybinds = function()
		EnsureSavedKeybinds()
		ApplySavedKeybindsToConfig()
	end

	NormalizeAllKeybinds()

	fn = function()
		if writefile then
			pcall(function()
				NormalizeAllKeybinds()
				local v3 = DeepCopy(v2)
				v3.MenuKey = v2.SavedKeybinds.MenuKey
				writefile("SlicedzHub.json", httpService:JSONEncode(v3))
			end)
		end
	end

	if _needMigrationSave then
		fn()
	end

	_G.StickyCarpetSpeed = v2.CarpetSpeed == true
	_G.StickyCarpetSpeedValue = math.clamp(tonumber(v2.CarpetSpeedValue) or 140, 20, 400)
	_G.StickyCarpetSpeedKeyName = type(v2.CarpetSpeedKey) == "string" and v2.CarpetSpeedKey or "Q"
	_G.StickyInfJump = v2.InfJump ~= false
	_G.StickyAutoKickOnSteal = v2.AutoKickOnSteal == true
	_G.StickyFOV = tonumber(v2.FOV) or 80
	_G.StickyResetCooldown = tonumber(v2.ResetCooldown) or 2.5
	_G.StickyResetFlingTime = tonumber(v2.ResetFlingTime) or 5
	_G.StickyAntiBee = v2.AntiBeeDisco ~= false
	_G.StickyAntiDieDisabled = v2.AntiDie == false

	local function fn3()
		v2.CarpetSpeedValue = math.clamp(tonumber(_G.StickyCarpetSpeedValue) or 140, 20, 400)
		v2.FOV = tonumber(_G.StickyFOV) or v2.FOV
		v2.ResetCooldown = tonumber(_G.StickyResetCooldown) or v2.ResetCooldown
		v2.ResetFlingTime = tonumber(_G.StickyResetFlingTime) or v2.ResetFlingTime
		v2.AntiBeeDisco = _G.StickyAntiBee ~= false
		v2.AntiDie = _G.StickyAntiDieDisabled ~= true

		if type(_G.StickyCarpetSpeedKeyName) == "string" then
			v2.CarpetSpeedKey = _G.StickyCarpetSpeedKeyName
		end

		if _G.StickyInfJump ~= nil then
			v2.InfJump = _G.StickyInfJump == true
		end

		if _G.StickyCarpetSpeed ~= nil then
			v2.CarpetSpeed = _G.StickyCarpetSpeed == true
		end

		if _G.StickyAutoKickOnSteal ~= nil then
			v2.AutoKickOnSteal = _G.StickyAutoKickOnSteal == true
		end
	end

	local v3 = nil

	_G.StickySaveConfigNow = function()
		pcall(function()
			fn3()
			local json = httpService:JSONEncode(v2)

			if json ~= v3 then
				v3 = json
				fn()
			end
		end)
	end
end

task.spawn(function()
	task.wait(5)

	while true do
		_G.StickySaveConfigNow()
		task.wait(5)
	end
end)

do
	local flag = false
	local tbl2 = {}

	_G.StickyOnBoot = function(arg)
		if type(arg) ~= "function" then
			return
		end

		if flag then
			task.spawn(arg)
			return
		end
		tbl2[#tbl2 + 1] = arg
	end

	task.spawn(function()
		local n = os.clock() + 30

		while not workspace:FindFirstChild("Plots") and os.clock() < n do
			task.wait(0.25)
		end

		local n2 = os.clock() + 15

		while os.clock() < n2 do
			local character = localPlayer2.Character
			if not (character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChildOfClass("Humanoid")) then
				task.wait(0.25)
				continue
			end
			break
		end

		task.wait(1.5)
		flag = true

		for _, v3 in ipairs(tbl2) do
			task.spawn(v3)
		end

		tbl2 = {}
	end)
end

game:GetService("Workspace")

do
	local Players = game:GetService("Players")
	local localPlayer3 = Players.LocalPlayer
	local v3 = v2
	local v4 = fn

	local function fn2(arg, arg2)
		local slicedzSyncToggleUI = _G.SlicedzSyncToggleUI

		if type(slicedzSyncToggleUI) == "function" then
			pcall(slicedzSyncToggleUI, arg, arg2)
		end
	end

	if _G.StickyXray == nil then
		_G.StickyXray = true
	end

	if _G.StickyXrayAlpha == nil then
		_G.StickyXrayAlpha = 0.9
	end

	local function fn3()
		local tbl2 = { "Base", "PlotSign", "FriendPanel", "Cash", "Laser", "Decorations", "Skin", "Unlock", "Purchases" }
		local obj = setmetatable({}, { __mode = "k" })
		local tbl3 = {}
		local n = 0

		local function fn4(arg, arg2)
			if not arg:IsA("BasePart") then
				return
			end

			if obj[arg] == nil then
				obj[arg] = arg.Transparency == arg2 and 0 or arg.Transparency
			end

			local v5 = obj[arg]
			if v5 >= 1 then
				return
			end
			local transparency = v5 + (1 - v5) * arg2

			if math.abs(arg.Transparency - transparency) > 0.01 then
				arg.Transparency = transparency
			end
		end

		local function fn5()
			while _G.StickyStealHold do
				task.wait(0.15)
			end
		end

		local function fn6(arg, arg2, arg3)
			if not arg or arg3 ~= n then
				return
			end
			fn4(arg, arg2)
			local n2 = 0

			for _, descendant in ipairs(arg:GetDescendants()) do
				if arg3 ~= n then
					return
				end
				fn4(descendant, arg2)
				n2 += 1

				if n2 % 250 == 0 then
					task.wait()
				end
			end

			tbl3[#tbl3 + 1] = arg.DescendantAdded:Connect(function(descendant)
				if arg3 == n then
					fn4(descendant, arg2)
				end
			end)
		end

		local function fn7(arg, arg2, arg3)
			if not arg or arg3 ~= n then
				return
			end

			for _,
