pcall(function()
	local CoreGui = game:GetService("CoreGui")
	for _, obj in ipairs(CoreGui:GetChildren()) do
		if obj.Name == "PurpleGlowEffect" or obj.Name == "ModuleBindingSystem" then
			obj:Destroy()
		end
	end
end)
pcall(function()
	local lp = game:GetService("Players").LocalPlayer
	if lp and lp:FindFirstChild("PlayerGui") then
		for _, obj in ipairs(lp.PlayerGui:GetChildren()) do
			if obj.Name == "PurpleGlowEffect" or obj.Name == "ModuleBindingSystem" then
				obj:Destroy()
			end
		end
	end
end)

if getgenv().UnloadNeverLoseScript then
	pcall(function()
		getgenv().UnloadNeverLoseScript()
	end)
	task.wait(0.1)
end

-- Using Library --
local sourceCode
pcall(function()
	sourceCode = game:HttpGet("http://127.0.0.1:8000/source.luau?nocache=" .. os.time())
end)
if not sourceCode or type(sourceCode) ~= "string" or #sourceCode < 100 then
	if readfile then
		pcall(function()
			if isfile and isfile("source.luau") then
				sourceCode = readfile("source.luau")
			end
		end)
	end
end
if not sourceCode or type(sourceCode) ~= "string" or #sourceCode < 100 then
	pcall(function()
		sourceCode = game:HttpGet("https://raw.githubusercontent.com/desc13374/neverloseui/refs/heads/main/source.luau?nocache=" .. os.time())
	end)
end

assert(sourceCode and #sourceCode > 100, "Failed to load NeverLose library source code.")

-- Comprehensive Dynamic Memory Patch: Completely eliminate "Parent property is locked" errors
sourceCode = sourceCode:gsub("([^\n%w_])([%w_]+%.Parent%s*=%s*nil)", function(prefix, match)
	if prefix:find("pcall") then return prefix .. match end
	return prefix .. "pcall(function() " .. match .. " end)"
end)
sourceCode = sourceCode:gsub("([^\n%w_])([%w_]+%.Parent%s*=%s*NeverLose%.ScreenGui)", function(prefix, match)
	if prefix:find("pcall") then return prefix .. match end
	return prefix .. "pcall(function() " .. match .. " end)"
end)
sourceCode = sourceCode:gsub("([^\n%w_])([%w_]+%.Parent%s*=%s*Window%.SurfaceGui)", function(prefix, match)
	if prefix:find("pcall") then return prefix .. match end
	return prefix .. "pcall(function() " .. match .. " end)"
end)
sourceCode = sourceCode:gsub("([^\n%w_])([%w_]+%.Parent%s*=%s*NeverLose%.GlobalSurfaceGui)", function(prefix, match)
	if prefix:find("pcall") then return prefix .. match end
	return prefix .. "pcall(function() " .. match .. " end)"
end)
sourceCode = sourceCode:gsub("([^\n%w_])([%w_]+%.Parent%s*=%s*TabContainer)", function(prefix, match)
	if prefix:find("pcall") then return prefix .. match end
	return prefix .. "pcall(function() " .. match .. " end)"
end)

local loadFn = loadstring or (getgenv and getgenv().loadstring)
assert(loadFn, "loadstring function is not available in this environment.")

local execFunc, loadErr = loadFn(sourceCode)
if not execFunc then
	error("[NeverLose Load Error]: Failed to compile library: " .. tostring(loadErr))
end

local NeverLose = execFunc()
assert(NeverLose, "[NeverLose Load Error]: Library returned nil.")
NeverLose.EnabledBlur = false
local isUnloaded = false

-- Creating Notification --
local Notification = NeverLose:CreateNotification();

-- Progressive Loading Notification --
local loaderNotify = nil
pcall(function()
	loaderNotify = Notification.new({
		Title = "Scorp",
		Content = "Loading script 1 of 10",
		Duration = 12
	})
end)

local function setLoadProgress(step)
	pcall(function()
		if loaderNotify and loaderNotify.UpdateText then
			loaderNotify:UpdateText("Scorp", string.format("Loading script %d of 10", step))
		end
	end)
end

setLoadProgress(1)

-- Creating Logger --
local Logging = NeverLose:CreateLogger();

-- Debug Logger System --
local function logDebug(icon, msg, duration)
	pcall(function()
		-- print("[NeverLose Debug]", msg)
		if Logging and Logging.new then
			Logging.new(icon or "gear", msg, duration or 3.5)
		end
	end)
end

-- Catch runtime errors (filtering out internal game script errors) --
pcall(function()
	game:GetService("LogService").MessageOut:Connect(function(message, messageType)
		if messageType == Enum.MessageType.MessageError then
			local msgStr = tostring(message)
			-- Filter out internal game script errors & stack traces
			if not msgStr:find("ReplicatedStorage%.Objects") 
			   and not msgStr:find("ReplicatedStorage%.Services")
			   and not msgStr:find("ReplicatedStorage%.Packages")
			   and not msgStr:find("Stack Begin")
			   and not msgStr:find("Stack End")
			   and not msgStr:find("Script '")
			   and not msgStr:find("Script %\"") then
				logDebug("gear", "[Lua Error]: " .. msgStr, 5)
			end
		end
	end)
end)

-- Creating Indicator --
setLoadProgress(2)
local Indicator = NeverLose:CreateIndicator();

-- Creating Window --
setLoadProgress(3)
local window = NeverLose:CreateWindow({
	Logo = NeverLose.GlobalLogo,
	Name = "Scorp",
	Content = "Movement Verison",
	Size = NeverLose.Scales.Default,
	ConfigFolder = "NeverLoseConfigs",
	Enable3DRenderer = false,
	Keybind = "Insert"
});



-- Creating Watermark --
local Watermark = window:Watermark();


-- Movement Settings State --
setLoadProgress(4)
local MovementSettings = {
	WindowsEnabled = true,
	WatermarkEnabled = true,
	KeybindsEnabled = true,
	KeybindsMode = "Default",
	Bhop = false,
	AirStrafe = false,
	AirStrafeMode = "Beta",
	AirStrafeSpeed = 40,
	StrafeMode = "View Movement",
	Speed = false,
	SpeedValue = 16,
	JumpBug = false,
	JumpBugPower = 75,
	PixelSurf = false,
	PixelSurfMode = "Easy",
	PixelSurfGlowColor = Color3.fromRGB(168, 85, 247),
	PixelSurfGlowIntensity = 65,
	PixelSurfFollowCamera = false,
	PixelSurfEasyNoClip = false,
	EdgeBug = false,
	AutoAlign = false,
	AutoGround = false,
	TextureBug = false,
	LongJump = false,
	LongJumpBoost = 50,
	LongJumpFollowCamera = false,
	DisableMovementKeys = false,
	Nulls = false,
	AirStuck = false,
	AirStuckSaveSpeed = false,
	AirStuckGodMode = false,
	AirStuckSavedVelocity = nil,
	AirJump = false,
	InfJump = false,
	Fly = false,
	FlySpeed = 50,
	FreeCam = false,
	FreeCamSpeed = 40,
	NoClip = false,
	Blink = false,
	BlinkSpeed = 30,
	AutoBacksliding = false,
	CheckpointsEnabled = false,
	CheckpointSlot = 1,
	CheckpointKeepVelocity = true,
	CheckpointKeepAngles = true,
	CheckpointTeleportMode = "Instant",
	CheckpointSlots = {nil, nil, nil, nil, nil},
	CheckpointSmoothActive = false,
	CheckpointSmoothTarget = nil,
	IndicatorVisibility = {
		pixelsurf = true,
		jumpbug = true,
		edgebug = true,
		autoalign = true,
		autoground = true,
		texturebug = true,
		longjump = true,
		airstuck = true,
		airjump = true,
		noclip = true,
		blink_enabled = true,
		self_revive_enabled = true,
		autobacksliding = true,
	}
}

-- Particles Settings State --
local ParticlesSettings = {
	Enabled = true,
	Mode = "Trails",
	TrailMode = "3D",
	TrailStyle3D = "Default",
	TrailStyle2D = "Default",
	TrailColor = Color3.fromRGB(0, 255, 255)
}

-- Weather / Test Settings State --
local TestSettings = {
	Enabled = false,
	TestEnabled = false,
	Mode = "Snow",
	Glow = 50,
	Count = 150,
	Speed = 20,
	Color = Color3.fromRGB(255, 255, 255)
}

-- Debug Settings State --
local DebugSettings = {
	Enabled = false
}

-- Flag to Setting Key Mapping --
local FlagToSettingKey = {
	["bhop"] = "Bhop",
	["airstrafe"] = "AirStrafe",
	["speed_enabled"] = "Speed",
	["jumpbug"] = "JumpBug",
	["pixelsurf"] = "PixelSurf",
	["edgebug"] = "EdgeBug",
	["autoalign"] = "AutoAlign",
	["autoground"] = "AutoGround",
	["texturebug"] = "TextureBug",
	["longjump"] = "LongJump",
	["disable_keys"] = "DisableMovementKeys",
	["nulls"] = "Nulls",
	["airstuck"] = "AirStuck",
	["airjump"] = "AirJump",
	["infjump"] = "InfJump",
	["fly_enabled"] = "Fly",
	["freecam_enabled"] = "FreeCam",
	["noclip"] = "NoClip",
	["blink_enabled"] = "Blink",
	["autobacksliding"] = "AutoBacksliding",
	["particles_enabled"] = "ParticlesEnabled",
	["test_enabled"] = "TestEnabled",
}

-- Left Indicators Panel Elements --
local LeftIndicators = {
	noclip = Indicator.new({ Name = "NC", Icon = 'crosshairs', Color = 'White' }),
	airstuck = Indicator.new({ Name = "AS", Icon = 'crosshairs', Color = 'White' }),
	blink_enabled = Indicator.new({ Name = "BL", Icon = 'crosshairs', Color = 'White' }),
	jumpbug = Indicator.new({ Name = "JB", Icon = 'crosshairs', Color = 'White' }),
	autoground = Indicator.new({ Name = "AG", Icon = 'crosshairs', Color = 'White' }),
	edgebug = Indicator.new({ Name = "EB", Icon = 'crosshairs', Color = 'White' }),
	autoalign = Indicator.new({ Name = "AA", Icon = 'crosshairs', Color = 'White' }),
	texturebug = Indicator.new({ Name = "TB", Icon = 'crosshairs', Color = 'White' }),
	autobacksliding = Indicator.new({ Name = "BS", Icon = 'crosshairs', Color = 'White' }),
}

local NC = LeftIndicators.noclip
local AS = LeftIndicators.airstuck
local BL = LeftIndicators.blink_enabled
local JB = LeftIndicators.jumpbug
local AG_Indicator = LeftIndicators.autoground

local function updateWatermarkDisplay()
	local windowsEnabled = MovementSettings.WindowsEnabled ~= false
	local watermarkEnabled = MovementSettings.WatermarkEnabled ~= false
	if Watermark then
		Watermark:SetRender(windowsEnabled and watermarkEnabled)
	end
end

local function updateKeybindsDisplay()
	local windowsEnabled = MovementSettings.WindowsEnabled ~= false
	local enabled = windowsEnabled and (MovementSettings.KeybindsEnabled ~= false)
	local mode = MovementSettings.KeybindsMode or "Default"

	local showLeft = enabled and (mode == "Default" or mode == "Both")
	local showMovement = enabled and (mode == "Movement" or mode == "Both")

	local indicatorVis = MovementSettings.IndicatorVisibility or {}

	for flag, ind in pairs(LeftIndicators) do
		local settingKey = FlagToSettingKey[flag]
		local isFeatureActive = settingKey and (MovementSettings[settingKey] == true)
		local isIndicatorAllowed = indicatorVis[flag] ~= false
		if ind and ind.SetRender then
			ind:SetRender(showLeft and isFeatureActive and isIndicatorAllowed)
		end
	end

	if _G.SetMovementHUDVisible then
		_G.SetMovementHUDVisible(showMovement)
	end
end



-- Add Tab Label --
setLoadProgress(5)
window:AddTabLabel('AIMBOT')

local fpsBlock = Watermark:AddBlock("chart-four-vertical-bars", "60 FPS")
local userBlock = Watermark:AddBlock("circle-person", game:GetService("Players").LocalPlayer.DisplayName or game:GetService("Players").LocalPlayer.Name)
local UITogg = Watermark:AddBlock("cube-vertexes", "Scorp")

UITogg:Input(function()
	window:ToggleInterface()
end)

task.spawn(function()
	local RunService = game:GetService("RunService")
	local frameCount = 0
	local lastTime = os.clock()
	
	RunService.RenderStepped:Connect(function()
		frameCount = frameCount + 1
	end)
	
	while task.wait(0.3) do
		pcall(function()
			local now = os.clock()
			local elapsed = now - lastTime
			if elapsed > 0 then
				local fps = math.floor((frameCount / elapsed) + 0.5)
				fpsBlock:SetText(tostring(fps) .. " FPS")
			end
			frameCount = 0
			lastTime = now
		end)
	end
end)

-- Multi-pass Rig & Joint CFrame Solver for ViewportFrame 3D Models --
local function solveRigCFrames(model)
	if not model then return end

	-- Destroy animators/scripts/highlights to ensure clean neutral pose
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("Animator") or desc:IsA("AnimationController") or desc:IsA("Pose") or desc:IsA("Keyframe") or desc:IsA("Script") or desc:IsA("LocalScript") then
			pcall(function() desc:Destroy() end)
		elseif desc:IsA("Highlight") then
			pcall(function() desc:Destroy() end)
		end
	end

	-- Identify Primary/Root Part
	local root = model.PrimaryPart
		or model:FindFirstChild("HumanoidRootPart")
		or model:FindFirstChild("Torso")
		or model:FindFirstChild("UpperTorso")
		or model:FindFirstChild("LowerTorso")
		or model:FindFirstChild("Head")

	if not root then return end

	model.PrimaryPart = root
	root.CFrame = CFrame.new(0, 0, 0)
	root.Anchored = true

	local positioned = { [root] = true }

	-- Collect all joint objects (Motor6D, Weld, ManualWeld)
	local joints = {}
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("Motor6D") or desc:IsA("Weld") or desc:IsA("ManualWeld") then
			table.insert(joints, desc)
			if desc:IsA("Motor6D") then
				pcall(function() desc.Transform = CFrame.new() end)
			end
		end
	end

	-- Multi-pass tree traversal: position child parts from parent CFrames
	for pass = 1, 8 do
		local progress = false
		for _, joint in ipairs(joints) do
			local p0 = joint.Part0
			local p1 = joint.Part1
			if p0 and p1 then
				if joint:IsA("Motor6D") then
					pcall(function() joint.Transform = CFrame.new() end)
				end

				if positioned[p0] and not positioned[p1] then
					pcall(function()
						p1.CFrame = p0.CFrame * joint.C0 * joint.C1:Inverse()
					end)
					p1.Anchored = true
					positioned[p1] = true
					progress = true
				elseif positioned[p1] and not positioned[p0] then
					pcall(function()
						p0.CFrame = p1.CFrame * joint.C1 * joint.C0:Inverse()
					end)
					p0.Anchored = true
					positioned[p0] = true
					progress = true
				end
			end
		end
		if not progress then break end
	end

	-- Fallback limb alignment (Head, Arms, Legs to Torso) if Motor6D joints were missing or broken
	local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("LowerTorso") or root
	local upperTorso = model:FindFirstChild("UpperTorso") or torso
	local lowerTorso = model:FindFirstChild("LowerTorso") or torso

	if torso then
		-- Head
		local head = model:FindFirstChild("Head")
		if head then
			if not positioned[head] then
				head.CFrame = upperTorso.CFrame * CFrame.new(0, 1.35, 0)
				positioned[head] = true
			end
			head.Anchored = true
			head.Transparency = 0
			for _, child in ipairs(head:GetChildren()) do
				if child:IsA("Decal") then
					child.Transparency = 0
				end
			end
		end

		-- R6 Left Arm
		local lArm = model:FindFirstChild("Left Arm")
		if lArm and not positioned[lArm] then
			lArm.CFrame = torso.CFrame * CFrame.new(-1.5, 0, 0)
			lArm.Anchored = true
			positioned[lArm] = true
		end

		-- R6 Right Arm
		local rArm = model:FindFirstChild("Right Arm")
		if rArm and not positioned[rArm] then
			rArm.CFrame = torso.CFrame * CFrame.new(1.5, 0, 0)
			rArm.Anchored = true
			positioned[rArm] = true
		end

		-- R6 Left Leg
		local lLeg = model:FindFirstChild("Left Leg")
		if lLeg and not positioned[lLeg] then
			lLeg.CFrame = torso.CFrame * CFrame.new(-0.5, -2, 0)
			lLeg.Anchored = true
			positioned[lLeg] = true
		end

		-- R6 Right Leg
		local rLeg = model:FindFirstChild("Right Leg")
		if rLeg and not positioned[rLeg] then
			rLeg.CFrame = torso.CFrame * CFrame.new(0.5, -2, 0)
			rLeg.Anchored = true
			positioned[rLeg] = true
		end

		-- R15 Left Arm (Upper, Lower, Hand)
		local lUpperArm = model:FindFirstChild("LeftUpperArm")
		if lUpperArm then
			if not positioned[lUpperArm] then
				lUpperArm.CFrame = upperTorso.CFrame * CFrame.new(-1.4, 0.3, 0)
				lUpperArm.Anchored = true
				positioned[lUpperArm] = true
			end
			local lLowerArm = model:FindFirstChild("LeftLowerArm")
			if lLowerArm and not positioned[lLowerArm] then
				lLowerArm.CFrame = lUpperArm.CFrame * CFrame.new(0, -0.9, 0)
				lLowerArm.Anchored = true
				positioned[lLowerArm] = true
			end
			local lHand = model:FindFirstChild("LeftHand")
			if lHand and not positioned[lHand] then
				lHand.CFrame = (lLowerArm or lUpperArm).CFrame * CFrame.new(0, -0.7, 0)
				lHand.Anchored = true
				positioned[lHand] = true
			end
		end

		-- R15 Right Arm (Upper, Lower, Hand)
		local rUpperArm = model:FindFirstChild("RightUpperArm")
		if rUpperArm then
			if not positioned[rUpperArm] then
				rUpperArm.CFrame = upperTorso.CFrame * CFrame.new(1.4, 0.3, 0)
				rUpperArm.Anchored = true
				positioned[rUpperArm] = true
			end
			local rLowerArm = model:FindFirstChild("RightLowerArm")
			if rLowerArm and not positioned[rLowerArm] then
				rLowerArm.CFrame = rUpperArm.CFrame * CFrame.new(0, -0.9, 0)
				rLowerArm.Anchored = true
				positioned[rLowerArm] = true
			end
			local rHand = model:FindFirstChild("RightHand")
			if rHand and not positioned[rHand] then
				rHand.CFrame = (rLowerArm or rUpperArm).CFrame * CFrame.new(0, -0.7, 0)
				rHand.Anchored = true
				positioned[rHand] = true
			end
		end

		-- R15 Left Leg (Upper, Lower, Foot)
		local lUpperLeg = model:FindFirstChild("LeftUpperLeg")
		if lUpperLeg then
			if not positioned[lUpperLeg] then
				lUpperLeg.CFrame = lowerTorso.CFrame * CFrame.new(-0.5, -0.9, 0)
				lUpperLeg.Anchored = true
				positioned[lUpperLeg] = true
			end
			local lLowerLeg = model:FindFirstChild("LeftLowerLeg")
			if lLowerLeg and not positioned[lLowerLeg] then
				lLowerLeg.CFrame = lUpperLeg.CFrame * CFrame.new(0, -0.9, 0)
				lLowerLeg.Anchored = true
				positioned[lLowerLeg] = true
			end
			local lFoot = model:FindFirstChild("LeftFoot")
			if lFoot and not positioned[lFoot] then
				lFoot.CFrame = (lLowerLeg or lUpperLeg).CFrame * CFrame.new(0, -0.7, 0)
				lFoot.Anchored = true
				positioned[lFoot] = true
			end
		end

		-- R15 Right Leg (Upper, Lower, Foot)
		local rUpperLeg = model:FindFirstChild("RightUpperLeg")
		if rUpperLeg then
			if not positioned[rUpperLeg] then
				rUpperLeg.CFrame = lowerTorso.CFrame * CFrame.new(0.5, -0.9, 0)
				rUpperLeg.Anchored = true
				positioned[rUpperLeg] = true
			end
			local rLowerLeg = model:FindFirstChild("RightLowerLeg")
			if rLowerLeg and not positioned[rLowerLeg] then
				rLowerLeg.CFrame = rUpperLeg.CFrame * CFrame.new(0, -0.9, 0)
				rLowerLeg.Anchored = true
				positioned[rLowerLeg] = true
			end
			local rFoot = model:FindFirstChild("RightFoot")
			if rFoot and not positioned[rFoot] then
				rFoot.CFrame = (rLowerLeg or rUpperLeg).CFrame * CFrame.new(0, -0.7, 0)
				rFoot.Anchored = true
				positioned[rFoot] = true
			end
		end
	end

	-- Align Accessories (Hats, Hair, Outerwear) if handle wasn't solved by joint
	for _, acc in ipairs(model:GetChildren()) do
		if acc:IsA("Accessory") or acc:IsA("Hat") then
			local handle = acc:FindFirstChild("Handle")
			if handle and handle:IsA("BasePart") then
				if not positioned[handle] then
					local handleAtt = handle:FindFirstChildOfClass("Attachment")
					if handleAtt then
						for _, bodyPart in ipairs(model:GetChildren()) do
							if bodyPart:IsA("BasePart") and positioned[bodyPart] then
								local match = bodyPart:FindFirstChild(handleAtt.Name)
								if match and match:IsA("Attachment") then
									handle.CFrame = bodyPart.CFrame * match.CFrame * handleAtt.CFrame:Inverse()
									handle.Anchored = true
									positioned[handle] = true
									break
								end
							end
						end
					end
				end
				handle.Anchored = true
				positioned[handle] = true

				-- Align secondary accessory parts welded to Handle
				for _, desc in ipairs(acc:GetDescendants()) do
					if desc:IsA("BasePart") then
						desc.Anchored = true
						desc.CanCollide = false
						desc.CanTouch = false
						desc.CanQuery = false
						desc.Massless = true
						desc.LocalTransparencyModifier = 0
						desc.Transparency = 0
					end
					if desc:IsA("Weld") or desc:IsA("WeldConstraint") or desc:IsA("Motor6D") then
						local p0 = desc.Part0
						local p1Part = desc.Part1
						if p0 and p1Part then
							if positioned[p0] and not positioned[p1Part] then
								p1Part.CFrame = p0.CFrame * (desc:IsA("Motor6D") and (desc.C0 * desc.C1:Inverse()) or (p0.CFrame:Inverse() * p1Part.CFrame))
								p1Part.Anchored = true
								positioned[p1Part] = true
							elseif positioned[p1Part] and not positioned[p0] then
								p0.CFrame = p1Part.CFrame * (desc:IsA("Motor6D") and (desc.C1 * desc.C0:Inverse()) or (p1Part.CFrame:Inverse() * p0.CFrame))
								p0.Anchored = true
								positioned[p0] = true
							end
						end
					end
				end
			end
		end
	end

	-- Set all BaseParts to Anchored, Massless, non-collidable for crisp ViewportFrame rendering
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("BasePart") then
			desc.Anchored = true
			desc.CanCollide = false
			desc.CanTouch = false
			desc.CanQuery = false
			desc.Massless = true
			desc.LocalTransparencyModifier = 0
			if desc == root or desc.Name == "HumanoidRootPart" or desc.Name == "RootPart" then
				desc.Transparency = 1
			else
				desc.Transparency = 0
			end
		elseif desc:IsA("Decal") or desc:IsA("Texture") then
			pcall(function()
				desc.LocalTransparencyModifier = 0
				desc.Transparency = 0
			end)
		end
	end
end

-- Helper 3D Viewport Generator & Customizer --
local function create3DCharacterViewport(containerFrame, options)
	options = options or {}
	local baseCamDistance = options.camDistance or 11.5
	local baseCamYaw = options.camYaw or math.pi
	local baseCamPitch = options.camPitch or 0.05
	local baseTargetY = options.targetY or 0.3
	local baseFov = options.fov or 36
	local enableCustomizer = options.enableCustomizer == true

	local targetCameraY = baseTargetY
	local targetCameraX = 0
	local targetCamDistance = baseCamDistance
	local targetFov = baseFov

	local currentCameraY = baseTargetY
	local currentCameraX = 0
	local currentCamDistance = baseCamDistance
	local currentFov = baseFov

	local camYaw = baseCamYaw
	local camPitch = baseCamPitch

	containerFrame.ClipsDescendants = false
	containerFrame.BackgroundTransparency = 1

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "CharacterViewport"
	viewport.Size = UDim2.new(1, 0, 1, 0)
	viewport.Position = UDim2.new(0, 0, 0, 0)
	viewport.BackgroundTransparency = 1
	viewport.BorderSizePixel = 0
	viewport.LightColor = Color3.fromRGB(255, 255, 255)
	viewport.LightDirection = Vector3.new(-1, -1.5, -2).Unit
	viewport.Ambient = Color3.fromRGB(220, 220, 225)
	viewport.Parent = containerFrame

	local vpCorner = Instance.new("UICorner")
	vpCorner.CornerRadius = UDim.new(0, 8)
	vpCorner.Parent = viewport

	local worldModel = Instance.new("WorldModel")
	worldModel.Name = "PreviewWorldModel"
	worldModel.Parent = viewport

	local previewCam = Instance.new("Camera")
	previewCam.Name = "PreviewCamera"
	previewCam.FieldOfView = currentFov
	previewCam.Parent = viewport
	viewport.CurrentCamera = previewCam

	local isDraggingViewport = false
	local dragStartPos = Vector2.zero
	local clickStartPos = Vector2.zero
	local startYaw = 0
	local startPitch = 0

	local dragButton = Instance.new("TextButton")
	dragButton.Name = "ViewportDragButton"
	dragButton.Size = UDim2.new(1, 0, 1, 0)
	dragButton.Position = UDim2.new(0, 0, 0, 0)
	dragButton.BackgroundTransparency = 1
	dragButton.Text = ""
	dragButton.ZIndex = 10
	dragButton.Parent = containerFrame

	local currentPreviewModel = nil
	local activeEquippedItem = { Head = "Default", Torso = "Default", Legs = "Default" }

	-- Rebuild Character --
	local function rebuildPreviewCharacter()
		pcall(function()
			if currentPreviewModel then
				currentPreviewModel:Destroy()
				currentPreviewModel = nil
			end

			local lp = game:GetService("Players").LocalPlayer
			local char = lp and lp.Character
			local clone = nil

			-- Primary attempt: Fetch clean Roblox Avatar Model from UserId
			-- (Avoids game-specific modifications in Evade, Phantom Forces, etc., where lp.Character parts are made transparent, ragdolled, or destroyed)
			if lp and lp.UserId and lp.UserId > 0 then
				pcall(function()
					clone = game:GetService("Players"):CreateHumanoidModelFromUserId(lp.UserId)
				end)
			end

			-- Secondary attempt: Fetch via HumanoidDescription
			if not clone and lp and lp.UserId and lp.UserId > 0 then
				pcall(function()
					local desc = game:GetService("Players"):GetHumanoidDescriptionFromUserId(lp.UserId)
					if desc then
						clone = game:GetService("Players"):CreateModelFromDescription(desc, Enum.HumanoidRigType.R15)
					end
				end)
			end

			-- Tertiary attempt: Clone player's in-game Character if CreateHumanoidModelFromUserId is unavailable
			if not clone and char then
				local oldArchivable = char.Archivable
				char.Archivable = true
				clone = char:Clone()
				char.Archivable = oldArchivable
			end

			-- Fallback: Generate detailed 3D dummy if all methods failed
			if not clone then
				clone = Instance.new("Model")
				clone.Name = "FallbackDummy"
				local root = Instance.new("Part", clone)
				root.Name = "HumanoidRootPart"
				root.Size = Vector3.new(2, 2, 1)
				root.Transparency = 1

				local torso = Instance.new("Part", clone)
				torso.Name = "Torso"
				torso.Size = Vector3.new(2, 2, 1)
				torso.Color = Color3.fromRGB(40, 42, 50)

				local head = Instance.new("Part", clone)
				head.Name = "Head"
				head.Size = Vector3.new(1.2, 1.2, 1.2)
				head.Color = Color3.fromRGB(220, 220, 230)

				local neck = Instance.new("Motor6D", torso)
				neck.Name = "Neck"
				neck.Part0 = torso
				neck.Part1 = head
				neck.C0 = CFrame.new(0, 1, 0)
				neck.C1 = CFrame.new(0, -0.6, 0)

				local rootJoint = Instance.new("Motor6D", root)
				rootJoint.Name = "RootJoint"
				rootJoint.Part0 = root
				rootJoint.Part1 = torso

				local lArm = Instance.new("Part", clone)
				lArm.Name = "Left Arm"
				lArm.Size = Vector3.new(1, 2, 1)
				lArm.Color = Color3.fromRGB(40, 42, 50)

				local rArm = Instance.new("Part", clone)
				rArm.Name = "Right Arm"
				rArm.Size = Vector3.new(1, 2, 1)
				rArm.Color = Color3.fromRGB(40, 42, 50)

				local lLeg = Instance.new("Part", clone)
				lLeg.Name = "Left Leg"
				lLeg.Size = Vector3.new(1, 2, 1)
				lLeg.Color = Color3.fromRGB(25, 27, 35)

				local rLeg = Instance.new("Part", clone)
				rLeg.Name = "Right Leg"
				rLeg.Size = Vector3.new(1, 2, 1)
				rLeg.Color = Color3.fromRGB(25, 27, 35)

				clone.PrimaryPart = root
			end

			-- Ensure Humanoid exists so ViewportFrame renders clothing (shirts, pants) properly
			if clone then
				local humanoid = clone:FindFirstChildOfClass("Humanoid")
				if not humanoid then
					humanoid = Instance.new("Humanoid")
					humanoid.Parent = clone
				end
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end

			-- Apply explicit skin colors from BodyColors if available
			local bodyColors = clone:FindFirstChildOfClass("BodyColors")
			if bodyColors then
				pcall(function()
					local head = clone:FindFirstChild("Head")
					if head and head:IsA("BasePart") then head.Color = bodyColors.HeadColor3 end
					local torso = clone:FindFirstChild("Torso") or clone:FindFirstChild("UpperTorso")
					if torso and torso:IsA("BasePart") then torso.Color = bodyColors.TorsoColor3 end
					local rArm = clone:FindFirstChild("Right Arm") or clone:FindFirstChild("RightUpperArm")
					if rArm and rArm:IsA("BasePart") then rArm.Color = bodyColors.RightArmColor3 end
					local lArm = clone:FindFirstChild("Left Arm") or clone:FindFirstChild("LeftUpperArm")
					if lArm and lArm:IsA("BasePart") then lArm.Color = bodyColors.LeftArmColor3 end
					local rLeg = clone:FindFirstChild("Right Leg") or clone:FindFirstChild("RightUpperLeg")
					if rLeg and rLeg:IsA("BasePart") then rLeg.Color = bodyColors.RightLegColor3 end
					local lLeg = clone:FindFirstChild("Left Leg") or clone:FindFirstChild("LeftUpperLeg")
					if lLeg and lLeg:IsA("BasePart") then lLeg.Color = bodyColors.LeftLegColor3 end
				end)
			end

			-- Solve exact limb & accessory joint CFrames and anchor all parts
			solveRigCFrames(clone)

			clone.Parent = worldModel
			solveRigCFrames(clone)
			task.defer(function() solveRigCFrames(clone) end)

			currentPreviewModel = clone
		end)
	end

	rebuildPreviewCharacter()

	pcall(function()
		local lp = game:GetService("Players").LocalPlayer
		if lp then
			lp.CharacterAdded:Connect(function()
				task.wait(0.5)
				rebuildPreviewCharacter()
			end)
		end
	end)

	-- Update Camera Render --
	local function updateCameraCFrame()
		local tCenter = Vector3.new(currentCameraX, currentCameraY, 0)
		local rotCFrame = CFrame.Angles(0, camYaw, 0) * CFrame.Angles(camPitch, 0, 0)
		local camPos = tCenter + (rotCFrame * Vector3.new(0, 0, currentCamDistance))
		previewCam.FieldOfView = currentFov
		previewCam.CFrame = CFrame.new(camPos, tCenter)
	end

	updateCameraCFrame()

	-- Smooth Camera & Pos Lerping --
	local RunService = game:GetService("RunService")
	NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
		if not viewport or not viewport.Parent or not viewport.Visible then return end
		dt = math.clamp(dt, 0.001, 0.1)
		local lerpSpeed = dt * 10
		currentCameraY = currentCameraY + (targetCameraY - currentCameraY) * lerpSpeed
		currentCameraX = currentCameraX + (targetCameraX - currentCameraX) * lerpSpeed
		currentCamDistance = currentCamDistance + (targetCamDistance - currentCamDistance) * lerpSpeed
		currentFov = currentFov + (targetFov - currentFov) * lerpSpeed
		updateCameraCFrame()
	end))

	-- Bottom Right Gear Settings Button (Inventory ONLY) --
	if enableCustomizer then
		local gearBtn = Instance.new("TextButton")
		gearBtn.Name = "3DViewportSettingsBtn"
		gearBtn.Size = UDim2.new(0, 18, 0, 18)
		gearBtn.Position = UDim2.new(1, -26, 1, -26)
		gearBtn.BackgroundTransparency = 1
		gearBtn.BorderSizePixel = 0
		gearBtn.Text = "⚙"
		gearBtn.TextColor3 = Color3.fromRGB(200, 205, 220)
		gearBtn.Font = Enum.Font.GothamBold
		gearBtn.TextSize = 14
		gearBtn.ZIndex = 50
		gearBtn.Parent = containerFrame

		local gearIcon = Instance.new("ImageLabel")
		gearIcon.Name = "GearIcon"
		gearIcon.Size = UDim2.new(1, 0, 1, 0)
		gearIcon.Position = UDim2.new(0, 0, 0, 0)
		gearIcon.BackgroundTransparency = 1
		gearIcon.Image = "rbxassetid://6031280882"
		gearIcon.ImageColor3 = Color3.fromRGB(200, 205, 220)
		gearIcon.ZIndex = 51
		gearIcon.Parent = gearBtn

		-- Settings Pop-Up Frame (Opens Upward - Styled like Neverlose Dropdown Menu) --
		local gearMenu = Instance.new("Frame")
		gearMenu.Name = "3DViewportSettingsMenu"
		gearMenu.Size = UDim2.new(0, 145, 0, 98)
		gearMenu.Position = UDim2.new(1, -155, 1, -130)
		gearMenu.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
		gearMenu.BackgroundTransparency = 0.05
		gearMenu.BorderSizePixel = 0
		gearMenu.ClipsDescendants = true
		gearMenu.Visible = false
		gearMenu.ZIndex = 52
		gearMenu.Parent = containerFrame

		local menuCorner = Instance.new("UICorner")
		menuCorner.CornerRadius = UDim.new(0, 10)
		menuCorner.Parent = gearMenu

		local menuStroke = Instance.new("UIStroke")
		menuStroke.Color = Color3.fromRGB(45, 48, 58)
		menuStroke.Transparency = 0.5
		menuStroke.Thickness = 1
		menuStroke.Parent = gearMenu

		local menuLayout = Instance.new("UIListLayout")
		menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
		menuLayout.Padding = UDim.new(0, 4)
		menuLayout.Parent = gearMenu

		local menuPadding = Instance.new("UIPadding")
		menuPadding.PaddingTop = UDim.new(0, 6)
		menuPadding.PaddingBottom = UDim.new(0, 6)
		menuPadding.PaddingLeft = UDim.new(0, 6)
		menuPadding.PaddingRight = UDim.new(0, 6)
		menuPadding.Parent = gearMenu

		-- Helper to style menu buttons matching Neverlose item rows --
		local function createMenuButton(name, text, textColor, isRed)
			local btn = Instance.new("TextButton")
			btn.Name = name
			btn.Size = UDim2.new(1, 0, 0, 26)
			btn.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
			btn.BackgroundTransparency = 1
			btn.BorderSizePixel = 0
			btn.Text = text
			btn.TextColor3 = textColor or Color3.fromRGB(220, 225, 235)
			btn.Font = Enum.Font.GothamMedium
			btn.TextSize = 12
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.ZIndex = 53
			btn.Parent = gearMenu

			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 6)
			btnCorner.Parent = btn

			local btnPad = Instance.new("UIPadding")
			btnPad.PaddingLeft = UDim.new(0, 10)
			btnPad.PaddingRight = UDim.new(0, 10)
			btnPad.Parent = btn

			local tweenService = game:GetService("TweenService")
			btn.MouseEnter:Connect(function()
				tweenService:Create(btn, TweenInfo.new(0.15), {
					BackgroundTransparency = 0,
					BackgroundColor3 = isRed and Color3.fromRGB(45, 25, 30) or Color3.fromRGB(30, 34, 46)
				}):Play()
			end)

			btn.MouseLeave:Connect(function()
				tweenService:Create(btn, TweenInfo.new(0.15), {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(25, 28, 38)
				}):Play()
			end)

			return btn
		end

		local autoRotateBtn = createMenuButton("AutoRotateBtn", "Auto Rotate: OFF", Color3.fromRGB(220, 225, 235), false)
		local resetCamBtn = createMenuButton("ResetCamBtn", "Reset Camera", Color3.fromRGB(220, 225, 235), false)
		local resetSkinBtn = createMenuButton("ResetSkinBtn", "Reset Equipped", Color3.fromRGB(240, 85, 85), true)

		local autoSpinActive = false
		gearBtn.MouseButton1Click:Connect(function()
			gearMenu.Visible = not gearMenu.Visible
		end)

		autoRotateBtn.MouseButton1Click:Connect(function()
			autoSpinActive = not autoSpinActive
			autoRotateBtn.Text = autoSpinActive and "Auto Rotate: ON" or "Auto Rotate: OFF"
			autoRotateBtn.TextColor3 = autoSpinActive and Color3.fromRGB(80, 220, 120) or Color3.fromRGB(220, 225, 240)
		end)

		resetCamBtn.MouseButton1Click:Connect(function()
			camYaw = baseCamYaw
			camPitch = baseCamPitch
			targetCamDistance = baseCamDistance
			targetCameraY = baseTargetY
			targetCameraX = 0
			targetFov = baseFov
			gearMenu.Visible = false
		end)

		resetSkinBtn.MouseButton1Click:Connect(function()
			activeEquippedItem.Head = "Default"
			activeEquippedItem.Torso = "Default"
			activeEquippedItem.Legs = "Default"
			pcall(function()
				if currentPreviewModel then
					for _, child in ipairs(currentPreviewModel:GetChildren()) do
						if child.Name:find("Equipped3DAccessory_") then
							child:Destroy()
						end
					end
					local head = currentPreviewModel:FindFirstChild("Head")
					if head then head.Transparency = 0 end
					local rLeg = currentPreviewModel:FindFirstChild("Right Leg") or currentPreviewModel:FindFirstChild("RightLowerLeg")
					if rLeg then rLeg.Transparency = 0 end
				end
			end)
			gearMenu.Visible = false
		end)

		NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
			if autoSpinActive and not isDraggingViewport then
				camYaw = camYaw + dt * 0.8
			end
		end))
	end

	-- Catalog Panel & Customizer System --
	local catalogFrame = Instance.new("Frame")
	catalogFrame.Name = "3DCustomizerCatalogFrame"
	catalogFrame.Size = UDim2.new(0.48, 0, 1, 0)
	catalogFrame.Position = UDim2.new(1.1, 0, 0, 0)
	catalogFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
	catalogFrame.BackgroundTransparency = 0
	catalogFrame.BorderSizePixel = 0
	catalogFrame.ZIndex = 15
	catalogFrame.Parent = containerFrame

	local catHeader = Instance.new("TextLabel")
	catHeader.Name = "CatalogHeader"
	catHeader.Size = UDim2.new(1, -20, 0, 25)
	catHeader.Position = UDim2.new(0, 10, 0, 10)
	catHeader.BackgroundTransparency = 1
	catHeader.Text = "CUSTOMIZATION"
	catHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
	catHeader.Font = Enum.Font.GothamBold
	catHeader.TextSize = 13
	catHeader.TextXAlignment = Enum.TextXAlignment.Left
	catHeader.Parent = catalogFrame

	local catSubHeader = Instance.new("TextLabel")
	catSubHeader.Name = "CatalogSubHeader"
	catSubHeader.Size = UDim2.new(1, -20, 0, 16)
	catSubHeader.Position = UDim2.new(0, 10, 0, 32)
	catSubHeader.BackgroundTransparency = 1
	catSubHeader.Text = "Select 3D item to equip"
	catSubHeader.TextColor3 = Color3.fromRGB(150, 155, 175)
	catSubHeader.Font = Enum.Font.Gotham
	catSubHeader.TextSize = 11
	catSubHeader.TextXAlignment = Enum.TextXAlignment.Left
	catSubHeader.Parent = catalogFrame

	local catScroll = Instance.new("ScrollingFrame")
	catScroll.Name = "CatalogScroll"
	catScroll.Size = UDim2.new(1, -16, 1, -95)
	catScroll.Position = UDim2.new(0, 8, 0, 52)
	catScroll.BackgroundTransparency = 1
	catScroll.BorderSizePixel = 0
	catScroll.ScrollBarThickness = 3
	catScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 65, 80)
	catScroll.Parent = catalogFrame

	local catLayout = Instance.new("UIListLayout")
	catLayout.SortOrder = Enum.SortOrder.LayoutOrder
	catLayout.Padding = UDim.new(0, 6)
	catLayout.Parent = catScroll

	catLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		catScroll.CanvasSize = UDim2.fromOffset(0, catLayout.AbsoluteContentSize.Y + 10)
	end)

	-- Action Control Buttons Frame --
	local actionControls = Instance.new("Frame")
	actionControls.Name = "ActionControls"
	actionControls.Size = UDim2.new(1, -16, 0, 32)
	actionControls.Position = UDim2.new(0, 8, 1, -38)
	actionControls.BackgroundTransparency = 1
	actionControls.ZIndex = 16
	actionControls.Parent = catalogFrame

	local backBtn = Instance.new("TextButton")
	backBtn.Name = "BackBtn"
	backBtn.Size = UDim2.new(0.48, 0, 1, 0)
	backBtn.Position = UDim2.new(0, 0, 0, 0)
	backBtn.BackgroundColor3 = Color3.fromRGB(30, 33, 42)
	backBtn.Text = "← Back"
	backBtn.TextColor3 = Color3.fromRGB(240, 240, 250)
	backBtn.Font = Enum.Font.GothamMedium
	backBtn.TextSize = 12
	backBtn.Parent = actionControls

	local backCorner = Instance.new("UICorner")
	backCorner.CornerRadius = UDim.new(0, 6)
	backCorner.Parent = backBtn

	local applyBtn = Instance.new("TextButton")
	applyBtn.Name = "ApplyBtn"
	applyBtn.Size = UDim2.new(0.48, 0, 1, 0)
	applyBtn.Position = UDim2.new(0.52, 0, 0, 0)
	applyBtn.BackgroundColor3 = Color3.fromRGB(45, 90, 220)
	applyBtn.Text = "✓ Apply Skin"
	applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	applyBtn.Font = Enum.Font.GothamBold
	applyBtn.TextSize = 12
	applyBtn.Parent = actionControls

	local applyCorner = Instance.new("UICorner")
	applyCorner.CornerRadius = UDim.new(0, 6)
	applyCorner.Parent = applyBtn

	local currentActivePart = nil
	local TweenService = game:GetService("TweenService")
	local tweenFast = TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

	-- Zoom Camera to Body Part & Open Catalog --
	local function zoomToBodyPart(partName)
		currentActivePart = partName
		if partName == "Head" then
			targetCameraY = 1.8
			targetCameraX = -0.6
			targetCamDistance = 6.5
			targetFov = 30
			catHeader.Text = "HEAD CUSTOMIZATION"
			TweenService:Create(catalogFrame, tweenFast, { Position = UDim2.new(0.50, 0, 0, 0) }):Play()
		elseif partName == "Torso" then
			targetCameraY = 0.5
			targetCameraX = -0.6
			targetCamDistance = 6.2
			targetFov = 28
			catHeader.Text = "TORSO CUSTOMIZATION"
			TweenService:Create(catalogFrame, tweenFast, { Position = UDim2.new(0.50, 0, 0, 0) }):Play()
		elseif partName == "Legs" then
			targetCameraY = -0.8
			targetCameraX = -0.6
			targetCamDistance = 5.5
			targetFov = 28
			catHeader.Text = "LEGS CUSTOMIZATION"
			TweenService:Create(catalogFrame, tweenFast, { Position = UDim2.new(0.50, 0, 0, 0) }):Play()
		else
			currentActivePart = nil
			targetCameraY = baseTargetY
			targetCameraX = 0
			targetCamDistance = baseCamDistance
			targetFov = baseFov
			TweenService:Create(catalogFrame, tweenFast, { Position = UDim2.new(1.1, 0, 0, 0) }):Play()
		end
	end

	backBtn.MouseButton1Click:Connect(function()
		zoomToBodyPart("Reset")
	end)

	-- Apply equipped mods to real Roblox character --
	local function applyToRealPlayer()
		pcall(function()
			local lp = game:GetService("Players").LocalPlayer
			local char = lp and lp.Character
			if not char then return end

			if activeEquippedItem.Head == "Headless" then
				local head = char:FindFirstChild("Head")
				if head then head.Transparency = 1 end
			elseif activeEquippedItem.Head == "Default" then
				local head = char:FindFirstChild("Head")
				if head then head.Transparency = 0 end
			end

			if activeEquippedItem.Legs == "Korblox" then
				local rLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("RightLowerLeg")
				if rLeg then rLeg.Transparency = 1 end
			elseif activeEquippedItem.Legs == "Default" then
				local rLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("RightLowerLeg")
				if rLeg then rLeg.Transparency = 0 end
			end
		end)
	end

	applyBtn.MouseButton1Click:Connect(function()
		applyToRealPlayer()
	end)	-- Roblox Official Catalog Asset Cache --
	local catalogAssetCache = {}

	local function getRealRobloxCatalogModel(assetId)
		if not assetId or assetId == 0 then return nil end
		if catalogAssetCache[assetId] then
			return catalogAssetCache[assetId]:Clone()
		end

		local result = nil
		pcall(function()
			local objs = game:GetObjects("rbxassetid://" .. tostring(assetId))
			if objs and objs[1] then
				result = objs[1]
				catalogAssetCache[assetId] = result:Clone()
			end
		end)
		return result
	end

	-- Helper 3D Item Model Generator for Catalog Cards --
	local function buildDetailed3DItem(itemId, assetId, parentWorldModel)
		local itemModel = Instance.new("Model")
		itemModel.Name = "3DItem_" .. itemId

		-- Headless Preview: Display Player's Actual Avatar with Head.Transparency = 1 --
		if itemId == "Headless" then
			pcall(function()
				local lp = game:GetService("Players").LocalPlayer
				local char = lp and lp.Character
				if char then
					local oldArch = char.Archivable
					char.Archivable = true
					local avatarClone = char:Clone()
					char.Archivable = oldArch
					if avatarClone then
						solveRigCFrames(avatarClone)
						local head = avatarClone:FindFirstChild("Head")
						if head then
							head.Transparency = 1
							local face = head:FindFirstChildOfClass("Decal")
							if face then face.Transparency = 1 end
						end
						avatarClone.Parent = itemModel
						itemModel.Parent = parentWorldModel
					end
				end
			end)
			return itemModel
		end

		-- Attempt loading official Roblox Catalog Asset --
		local realAsset = getRealRobloxCatalogModel(assetId)
		if realAsset then
			pcall(function()
				for _, part in ipairs(realAsset:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Anchored = true
						part.CanCollide = false
					end
				end

				if realAsset:IsA("Accessory") or realAsset:IsA("Hat") then
					local handle = realAsset:FindFirstChild("Handle")
					if handle then
						handle.Parent = itemModel
						handle.CFrame = CFrame.new(0, 0, 0)
					else
						realAsset.Parent = itemModel
					end
				else
					realAsset.Parent = itemModel
				end
			end)
			itemModel.Parent = parentWorldModel
			return itemModel
		end

		-- High Quality Custom 3D Mesh Fallback Models --
		if itemId == "Fedora" then
			local hatBase = Instance.new("Part")
			hatBase.Size = Vector3.new(1.4, 0.4, 1.4)
			hatBase.Color = Color3.fromRGB(220, 35, 45)
			hatBase.Material = Enum.Material.SmoothPlastic
			hatBase.Position = Vector3.new(0, 0, 0)
			hatBase.Anchored = true
			hatBase.Parent = itemModel

			local hatCrown = Instance.new("Part")
			hatCrown.Size = Vector3.new(0.9, 0.65, 0.9)
			hatCrown.Color = Color3.fromRGB(220, 35, 45)
			hatCrown.Material = Enum.Material.SmoothPlastic
			hatCrown.Position = Vector3.new(0, 0.3, 0)
			hatCrown.Anchored = true
			hatCrown.Parent = itemModel

			local band = Instance.new("Part")
			band.Size = Vector3.new(0.95, 0.15, 0.95)
			band.Color = Color3.fromRGB(25, 25, 30)
			band.Material = Enum.Material.SmoothPlastic
			band.Position = Vector3.new(0, 0.15, 0)
			band.Anchored = true
			band.Parent = itemModel
		elseif itemId == "Dominus" then
			local hoodMain = Instance.new("Part")
			hoodMain.Size = Vector3.new(1.4, 1.4, 1.4)
			hoodMain.Color = Color3.fromRGB(245, 245, 250)
			hoodMain.Material = Enum.Material.SmoothPlastic
			hoodMain.Position = Vector3.new(0, 0.1, 0)
			hoodMain.Anchored = true
			hoodMain.Parent = itemModel

			local innerVoid = Instance.new("Part")
			innerVoid.Size = Vector3.new(0.9, 0.9, 0.6)
			innerVoid.Color = Color3.fromRGB(10, 10, 15)
			innerVoid.Material = Enum.Material.SmoothPlastic
			innerVoid.Position = Vector3.new(0, 0.05, -0.45)
			innerVoid.Anchored = true
			innerVoid.Parent = itemModel

			local eyeL = Instance.new("Part")
			eyeL.Size = Vector3.new(0.18, 0.18, 0.18)
			eyeL.Shape = Enum.PartType.Ball
			eyeL.Color = Color3.fromRGB(255, 255, 255)
			eyeL.Material = Enum.Material.Neon
			eyeL.Position = Vector3.new(-0.25, 0.12, -0.65)
			eyeL.Anchored = true
			eyeL.Parent = itemModel

			local eyeR = Instance.new("Part")
			eyeR.Size = Vector3.new(0.18, 0.18, 0.18)
			eyeR.Shape = Enum.PartType.Ball
			eyeR.Color = Color3.fromRGB(255, 255, 255)
			eyeR.Material = Enum.Material.Neon
			eyeR.Position = Vector3.new(0.25, 0.12, -0.65)
			eyeR.Anchored = true
			eyeR.Parent = itemModel

			for _, side in ipairs({ -1, 1 }) do
				local feather = Instance.new("Part")
				feather.Size = Vector3.new(0.12, 1.2, 0.45)
				feather.Color = Color3.fromRGB(245, 245, 250)
				feather.Material = Enum.Material.SmoothPlastic
				feather.CFrame = CFrame.new(side * 0.75, 0.3, -0.1) * CFrame.Angles(math.rad(20), 0, side * math.rad(-30))
				feather.Anchored = true
				feather.Parent = itemModel
			end
		elseif itemId == "Valkyrie" then
			local helm = Instance.new("Part")
			helm.Size = Vector3.new(1.1, 0.5, 1.1)
			helm.Color = Color3.fromRGB(245, 190, 40)
			helm.Material = Enum.Material.Metal
			helm.Anchored = true
			helm.Position = Vector3.new(0, 0, 0)
			helm.Parent = itemModel

			local wingL = Instance.new("Part")
			wingL.Size = Vector3.new(0.12, 1.1, 0.55)
			wingL.Color = Color3.fromRGB(255, 215, 60)
			wingL.Material = Enum.Material.Metal
			wingL.CFrame = CFrame.new(-0.6, 0.35, -0.1) * CFrame.Angles(math.rad(25), 0, math.rad(-20))
			wingL.Anchored = true
			wingL.Parent = itemModel

			local wingR = Instance.new("Part")
			wingR.Size = Vector3.new(0.12, 1.1, 0.55)
			wingR.Color = Color3.fromRGB(255, 215, 60)
			wingR.Material = Enum.Material.Metal
			wingR.CFrame = CFrame.new(0.6, 0.35, -0.1) * CFrame.Angles(math.rad(25), 0, math.rad(20))
			wingR.Anchored = true
			wingR.Parent = itemModel
		elseif itemId == "Domino" then
			local crown = Instance.new("Part")
			crown.Size = Vector3.new(1.2, 0.45, 1.2)
			crown.Color = Color3.fromRGB(20, 22, 28)
			crown.Material = Enum.Material.SmoothPlastic
			crown.Anchored = true
			crown.Position = Vector3.new(0, 0, 0)
			crown.Parent = itemModel

			for i = 1, 4 do
				local stud = Instance.new("Part")
				stud.Size = Vector3.new(0.2, 0.2, 0.2)
				stud.Shape = Enum.PartType.Ball
				stud.Color = Color3.fromRGB(240, 245, 255)
				stud.Material = Enum.Material.SmoothPlastic
				stud.Anchored = true
				local angle = (i * math.pi / 2)
				stud.Position = Vector3.new(math.sin(angle)*0.5, 0.18, math.cos(angle)*0.5)
				stud.Parent = itemModel
			end
		elseif itemId == "Visor" then
			local visor = Instance.new("Part")
			visor.Size = Vector3.new(1.1, 0.35, 0.4)
			visor.Color = Color3.fromRGB(0, 230, 255)
			visor.Material = Enum.Material.Neon
			visor.Anchored = true
			visor.Position = Vector3.new(0, 0, 0)
			visor.Parent = itemModel

			local frameL = Instance.new("Part")
			frameL.Size = Vector3.new(0.1, 0.45, 0.5)
			frameL.Color = Color3.fromRGB(40, 45, 60)
			frameL.Material = Enum.Material.Metal
			frameL.Position = Vector3.new(-0.55, 0, 0.05)
			frameL.Anchored = true
			frameL.Parent = itemModel

			local frameR = Instance.new("Part")
			frameR.Size = Vector3.new(0.1, 0.45, 0.5)
			frameR.Color = Color3.fromRGB(40, 45, 60)
			frameR.Material = Enum.Material.Metal
			frameR.Position = Vector3.new(0.55, 0, 0.05)
			frameR.Anchored = true
			frameR.Parent = itemModel
		elseif itemId == "Korblox" then
			local legBase = Instance.new("Part")
			legBase.Size = Vector3.new(0.35, 1.2, 0.35)
			legBase.Color = Color3.fromRGB(25, 28, 38)
			legBase.Material = Enum.Material.SmoothPlastic
			legBase.Position = Vector3.new(0, 0.2, 0)
			legBase.Anchored = true
			legBase.Parent = itemModel

			local peg = Instance.new("Part")
			peg.Size = Vector3.new(0.18, 0.7, 0.18)
			peg.Color = Color3.fromRGB(0, 180, 255)
			peg.Material = Enum.Material.Neon
			peg.Position = Vector3.new(0, -0.5, 0)
			peg.Anchored = true
			peg.Parent = itemModel
		else
			local headPart = Instance.new("Part")
			headPart.Size = Vector3.new(1.0, 1.0, 1.0)
			headPart.Shape = Enum.PartType.Ball
			headPart.Color = Color3.fromRGB(220, 225, 235)
			headPart.Material = Enum.Material.SmoothPlastic
			headPart.Position = Vector3.new(0, 0, 0)
			headPart.Anchored = true
			headPart.Parent = itemModel
		end

		itemModel.Parent = parentWorldModel
		return itemModel
	end

	-- Apply Item to Preview Model --
	local function equipItemOnPreview(category, itemName, assetId)
		activeEquippedItem[category] = itemName
		if not currentPreviewModel then return end

		pcall(function()
			-- Remove ANY old attached 3D customizer accessories --
			for _, child in ipairs(currentPreviewModel:GetChildren()) do
				if child.Name:find("Equipped3DAccessory_") then
					child:Destroy()
				end
			end

			if category == "Head" then
				local head = currentPreviewModel:FindFirstChild("Head")
				if head then
					if itemName == "Headless" then
						head.Transparency = 1
						local face = head:FindFirstChildOfClass("Decal")
						if face then face.Transparency = 1 end
					else
						head.Transparency = 0
						local face = head:FindFirstChildOfClass("Decal")
						if face then face.Transparency = 0 end

						if itemName ~= "Default" then
							task.spawn(function()
								local accModel = buildDetailed3DItem(itemName, assetId, currentPreviewModel)
								accModel.Name = "Equipped3DAccessory_" .. category
								local root = accModel:FindFirstChildWhichIsA("BasePart") or accModel:FindFirstChild("Handle")
								if root and head and head.Parent then
									accModel:PivotTo(head.CFrame * CFrame.new(0, 0.1, 0))
								end
							end)
						end
					end
				end
			elseif category == "Legs" then
				local rLeg = currentPreviewModel:FindFirstChild("Right Leg") or currentPreviewModel:FindFirstChild("RightLowerLeg")
				if rLeg then
					if itemName == "Korblox" then
						rLeg.Transparency = 0.95
						task.spawn(function()
							local pegModel = buildDetailed3DItem("Korblox", assetId, currentPreviewModel)
							pegModel.Name = "Equipped3DAccessory_" .. category
							if rLeg and rLeg.Parent then
								pegModel:PivotTo(rLeg.CFrame * CFrame.new(0, -0.1, 0))
							end
						end)
					else
						rLeg.Transparency = 0
					end
				end
			end
		end)
	end

	-- Populate Catalog Cards --
	local catalogItemsData = {
		Head = {
			{ Name = "Default Head", ItemId = "Default", AssetId = 0 },
			{ Name = "Headless Horseman", ItemId = "Headless", AssetId = 134082579 },
			{ Name = "Red Sparkle Time Fedora", ItemId = "Fedora", AssetId = 72082328 },
			{ Name = "Dominus Empyreus", ItemId = "Dominus", AssetId = 21070012 },
			{ Name = "Golden Valkyrie Wings", ItemId = "Valkyrie", AssetId = 1365767 },
			{ Name = "Domino Crown", ItemId = "Domino", AssetId = 1031429 },
		},
		Torso = {
			{ Name = "Default Torso", ItemId = "Default", AssetId = 0 },
			{ Name = "Tactical Armor", ItemId = "Tactical", AssetId = 363294371 },
			{ Name = "Neon Core Aura", ItemId = "NeonCore", AssetId = 125835698 },
		},
		Legs = {
			{ Name = "Default Legs", ItemId = "Default", AssetId = 0 },
			{ Name = "Korblox Peg Leg", ItemId = "Korblox", AssetId = 139607718 },
			{ Name = "Cybernetic Skeleton", ItemId = "CyberLegs", AssetId = 30339366 },
		}
	}

	local function populateCatalog(category)
		for _, child in ipairs(catScroll:GetChildren()) do
			if child:IsA("Frame") or child:IsA("TextButton") then
				child:Destroy()
			end
		end

		local items = catalogItemsData[category] or {}
		for _, item in ipairs(items) do
			local card = Instance.new("Frame")
			card.Name = "ItemCard_" .. item.ItemId
			card.Size = UDim2.new(1, 0, 0, 52)
			card.BackgroundColor3 = Color3.fromRGB(22, 25, 33)
			card.BorderSizePixel = 0
			card.Parent = catScroll

			local cCorner = Instance.new("UICorner")
			cCorner.CornerRadius = UDim.new(0, 6)
			cCorner.Parent = card

			local cStroke = Instance.new("UIStroke")
			cStroke.Color = Color3.fromRGB(45, 48, 58)
			cStroke.Transparency = 0.7
			cStroke.Parent = card

			-- Mini Rotating 3D Item Viewport --
			local miniVP = Instance.new("ViewportFrame")
			miniVP.Size = UDim2.new(0, 44, 0, 44)
			miniVP.Position = UDim2.new(0, 4, 0.5, -22)
			miniVP.BackgroundTransparency = 1
			miniVP.BorderSizePixel = 0
			miniVP.LightColor = Color3.fromRGB(255, 255, 255)
			miniVP.LightDirection = Vector3.new(-0.3, -0.7, -1).Unit
			miniVP.Ambient = Color3.fromRGB(235, 235, 240)
			miniVP.Parent = card

			local miniWorld = Instance.new("WorldModel", miniVP)
			local miniCam = Instance.new("Camera", miniVP)
			miniCam.FieldOfView = 40
			miniVP.CurrentCamera = miniCam

			-- Build 3D item model asynchronously in background thread --
			task.spawn(function()
				buildDetailed3DItem(item.ItemId, item.AssetId, miniWorld)
			end)

			local itemYaw = 0
			NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
				if miniVP and miniVP.Parent then
					itemYaw = itemYaw + dt * 2
					miniCam.CFrame = CFrame.new(Vector3.new(math.sin(itemYaw)*4.2, 0.3, math.cos(itemYaw)*4.2), Vector3.new(0, 0, 0))
				end
			end))

			local itemLabel = Instance.new("TextLabel")
			itemLabel.Size = UDim2.new(1, -60, 0, 20)
			itemLabel.Position = UDim2.new(0, 52, 0, 6)
			itemLabel.BackgroundTransparency = 1
			itemLabel.Text = item.Name
			itemLabel.TextColor3 = Color3.fromRGB(240, 240, 250)
			itemLabel.Font = Enum.Font.GothamMedium
			itemLabel.TextSize = 12
			itemLabel.TextXAlignment = Enum.TextXAlignment.Left
			itemLabel.Parent = card

			local statusLabel = Instance.new("TextLabel")
			statusLabel.Size = UDim2.new(1, -60, 0, 16)
			statusLabel.Position = UDim2.new(0, 52, 0, 26)
			statusLabel.BackgroundTransparency = 1
			statusLabel.Text = (activeEquippedItem[category] == item.ItemId) and "Equipped" or "Click to Preview"
			statusLabel.TextColor3 = (activeEquippedItem[category] == item.ItemId) and Color3.fromRGB(80, 220, 120) or Color3.fromRGB(140, 145, 160)
			statusLabel.Font = Enum.Font.Gotham
			statusLabel.TextSize = 10
			statusLabel.TextXAlignment = Enum.TextXAlignment.Left
			statusLabel.Parent = card

			local selectBtn = Instance.new("TextButton")
			selectBtn.Size = UDim2.new(1, 0, 1, 0)
			selectBtn.BackgroundTransparency = 1
			selectBtn.Text = ""
			selectBtn.Parent = card

			selectBtn.MouseButton1Click:Connect(function()
				equipItemOnPreview(category, item.ItemId, item.AssetId)
				populateCatalog(category)
			end)
		end
	end

	-- User Input Dragging & Part Raycast Click Detection --
	local UserInputService = game:GetService("UserInputService")

	dragButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDraggingViewport = true
			dragStartPos = UserInputService:GetMouseLocation()
			clickStartPos = dragStartPos
			startYaw = camYaw
			startPitch = camPitch
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDraggingViewport = false
			local mouseUpPos = UserInputService:GetMouseLocation()
			if (mouseUpPos - clickStartPos).Magnitude < 6 and enableCustomizer then
				-- Handle True 3D Raycast Click Detection on Preview Character --
				local inset = game:GetService("GuiService"):GetGuiInset()
				local vpPos = containerFrame.AbsolutePosition
				local relX = mouseUpPos.X - inset.X - vpPos.X
				local relY = mouseUpPos.Y - inset.Y - vpPos.Y

				if relX >= 0 and relX <= containerFrame.AbsoluteSize.X and relY >= 0 and relY <= containerFrame.AbsoluteSize.Y then
					local relNormX = relX / containerFrame.AbsoluteSize.X
					local relNormY = relY / containerFrame.AbsoluteSize.Y

					-- Only trigger if click is horizontally ON the character (middle 44% width of viewport) --
					local minX = 0.28
					local maxX = 0.72
					if catalogFrame and catalogFrame.Position.X.Scale < 1.0 then
						-- When catalog panel is open on the right, character is shifted left --
						minX = 0.05
						maxX = 0.48
					end

					if relNormX >= minX and relNormX <= maxX then
						if relNormY < 0.35 then
							zoomToBodyPart("Head")
							populateCatalog("Head")
						elseif relNormY >= 0.35 and relNormY < 0.66 then
							zoomToBodyPart("Torso")
							populateCatalog("Torso")
						else
							zoomToBodyPart("Legs")
							populateCatalog("Legs")
						end
					end
				end
			end
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseWheel then
			local mousePos = UserInputService:GetMouseLocation()
			local GuiService = game:GetService("GuiService")
			local inset = GuiService:GetGuiInset()
			local mX = mousePos.X - inset.X
			local mY = mousePos.Y - inset.Y

			-- Do NOT zoom camera if mouse is scrolling over catalog panel --
			local isOverCatalog = false
			if catalogFrame then
				local cPos = catalogFrame.AbsolutePosition
				local cSize = catalogFrame.AbsoluteSize
				if mX >= cPos.X and mX <= cPos.X + cSize.X and mY >= cPos.Y and mY <= cPos.Y + cSize.Y then
					isOverCatalog = true
				end
			end

			if not isOverCatalog then
				local fPos = containerFrame.AbsolutePosition
				local fSize = containerFrame.AbsoluteSize
				if mX >= fPos.X and mX <= fPos.X + fSize.X and mY >= fPos.Y and mY <= fPos.Y + fSize.Y then
					targetCamDistance = math.clamp(targetCamDistance - input.Position.Z * 1.2, 3.5, 22.0)
				end
			end
		end
		if isDraggingViewport and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local currentPos = UserInputService:GetMouseLocation()
			local delta = currentPos - dragStartPos
			camYaw = startYaw - (delta.X * 0.012)
			camPitch = math.clamp(startPitch - (delta.Y * 0.008), -0.5, 0.6)
		end
	end)

	return {
		Rebuild = rebuildPreviewCharacter,
		Viewport = viewport,
		Camera = previewCam,
		ZoomToPart = zoomToBodyPart
	}
end

-- Creating Tab --

local Rage = window:AddTab({
	Icon = 'crosshairs',
	Name = "Rage",
})

local Legit = window:AddTab({
	Icon = 'mouse-scrollwheel',
	Name = "Legit"
})

window:AddTabLabel('COMMON')

local Visuals = window:AddTab({
	Icon = 'image',
	Name = "Visuals"
})

local Inventory = window:AddTab({
	Icon = 'file-box',
	Name = "Inventory",
	Type = "Single"
})

local Miscellaneous = window:AddTab({
	Icon = 'three-stacked-squares-tilted',
	Name = "Miscellaneous"
})

window:AddTabLabel('OTHER')

local Players = window:AddTab({
	Icon = 'circle-person',
	Name = "Players"
})

local PlayersMain = Players:AddSection({
	Name = "PLAYERS",
	Position = 'left'
})

local VisualsEnemy = Visuals:AddSection({
	Name = "ENEMY",
	Position = 'left'
})

local VisualsLocal = Visuals:AddSection({
	Name = "LOCAL",
	Position = 'left'
})
local LocalVisualsState = {
	Chams = false,
	ChamsMode = "Default",
	ChamsColor = Color3.fromRGB(78, 127, 252),
	Overlay = false,
	OverlayColor = Color3.fromRGB(255, 255, 255),
	Glow = false,
	GlowMode = "Default",
	GlowColor = Color3.fromRGB(160, 80, 255)
}

local function updateLocalPlayerVisuals()
	pcall(function()
		local lp = game:GetService("Players").LocalPlayer
		local char = lp and lp.Character
		if not char then return end

		-- Chams / Highlight --
		local hl = char:FindFirstChild("LocalChamsHighlight")
		if LocalVisualsState.Chams then
			if not hl then
				hl = Instance.new("Highlight")
				hl.Name = "LocalChamsHighlight"
				hl.Parent = char
			end

			local color = LocalVisualsState.ChamsColor or Color3.fromRGB(78, 127, 252)
			local mode = LocalVisualsState.ChamsMode or "Default"

			if mode == "Flat" then
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.FillColor = color
				hl.FillTransparency = 0
				hl.OutlineColor = color
				hl.OutlineTransparency = 1
			elseif mode == "Glow" then
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.FillColor = color
				hl.FillTransparency = 0.85
				hl.OutlineColor = color
				hl.OutlineTransparency = 0
			elseif mode == "Wireframe" then
				hl.DepthMode = Enum.HighlightDepthMode.Occluded
				hl.FillTransparency = 1
				hl.OutlineColor = color
				hl.OutlineTransparency = 0
			elseif mode == "WireframeOnTop" then
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.FillTransparency = 1
				hl.OutlineColor = color
				hl.OutlineTransparency = 0
			elseif mode == "Metalic" then
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.FillColor = color
				hl.FillTransparency = 0.35
				hl.OutlineColor = color
				hl.OutlineTransparency = 0
			elseif mode == "Glass" then
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.FillColor = color
				hl.FillTransparency = 0.75
				hl.OutlineColor = Color3.fromRGB(255, 255, 255)
				hl.OutlineTransparency = 0
			else -- Default (Normal)
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.FillColor = color
				hl.FillTransparency = 0.5
				hl.OutlineColor = Color3.fromRGB(255, 255, 255)
				hl.OutlineTransparency = 0
			end
		else
			if hl then hl:Destroy() end
		end

		-- Overlay Chams (ForceField Material Effect) --
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				if LocalVisualsState.Overlay then
					if not part:FindFirstChild("OriginalMaterial") then
						local s = Instance.new("StringValue")
						s.Name = "OriginalMaterial"
						s.Value = tostring(part.Material.Name)
						s.Parent = part
					end
					if not part:FindFirstChild("OriginalColor") then
						local c = Instance.new("Color3Value")
						c.Name = "OriginalColor"
						c.Value = part.Color
						c.Parent = part
					end
					part.Material = Enum.Material.ForceField
					if LocalVisualsState.OverlayColor then
						part.Color = LocalVisualsState.OverlayColor
					end
				else
					local orig = part:FindFirstChild("OriginalMaterial")
					if orig then
						pcall(function() part.Material = Enum.Material[orig.Value] end)
						orig:Destroy()
					end
					local origColor = part:FindFirstChild("OriginalColor")
					if origColor then
						pcall(function() part.Color = origColor.Value end)
						origColor:Destroy()
					end
				end
			end
		end

		-- Glow (Outer Light & Bright Outline Glow) --
		local glowHl = char:FindFirstChild("LocalGlowHighlight")
		if LocalVisualsState.Glow then
			if not glowHl then
				glowHl = Instance.new("Highlight")
				glowHl.Name = "LocalGlowHighlight"
				glowHl.Parent = char
			end
			local glowCol = LocalVisualsState.GlowColor or Color3.fromRGB(160, 80, 255)
			glowHl.FillColor = glowCol
			glowHl.OutlineColor = glowCol
			glowHl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

			if LocalVisualsState.GlowMode == "Pulse" then
				local t = (tick() * 5) % (math.pi * 2)
				local alpha = 0.2 + 0.7 * math.abs(math.sin(t))
				glowHl.FillTransparency = 0.5 + (0.4 * alpha)
				glowHl.OutlineTransparency = 1 - alpha
			else -- Default
				glowHl.FillTransparency = 0.8
				glowHl.OutlineTransparency = 0
			end
		else
			if glowHl then glowHl:Destroy() end
		end
	end)
end

-- Smooth render loop for animated Glow Pulse --
pcall(function()
	local RunService = game:GetService("RunService")
	RunService.RenderStepped:Connect(function()
		if LocalVisualsState and LocalVisualsState.Glow and LocalVisualsState.GlowMode == "Pulse" then
			local lp = game:GetService("Players").LocalPlayer
			local char = lp and lp.Character
			local glowHl = char and char:FindFirstChild("LocalGlowHighlight")
			if glowHl then
				local t = (tick() * 5) % (math.pi * 2)
				local alpha = 0.2 + 0.7 * math.abs(math.sin(t))
				glowHl.FillTransparency = 0.5 + (0.4 * alpha)
				glowHl.OutlineTransparency = 1 - alpha
			end
		end
	end)
end)

task.spawn(function()
	local lp = game:GetService("Players").LocalPlayer
	if lp then
		lp.CharacterAdded:Connect(function()
			task.wait(0.5)
			updateLocalPlayerVisuals()
		end)
	end
end)

-- Create Single Model row with three-dots (...) option window --
local modelRow = VisualsLocal:AddLabel("Model")
local modelOptionWindow = modelRow:AddOption()

if modelOptionWindow then
	pcall(function()
		local chamsItem = modelOptionWindow:AddLabel("Chams")
		chamsItem:AddToggle({
			Default = false,
			Flag = "local_model_chams",
			Callback = function(val)
				LocalVisualsState.Chams = val
				updateLocalPlayerVisuals()
			end
		})

		local chamsOpt = chamsItem:AddOption()
		chamsOpt:AddLabel("Mode"):AddDropdown({
			Values = {"Default", "Flat", "Glow", "Wireframe", "Metalic", "Glass", "WireframeOnTop"},
			Default = "Default",
			Flag = "local_chams_mode",
			Callback = function(val)
				LocalVisualsState.ChamsMode = val
				updateLocalPlayerVisuals()
			end
		})

		chamsOpt:AddLabel("Color"):AddColorPicker({
			Default = Color3.fromRGB(78, 127, 252),
			Flag = "local_chams_color",
			Callback = function(col)
				LocalVisualsState.ChamsColor = col
				updateLocalPlayerVisuals()
			end
		})
	end)

	pcall(function()
		local overlayItem = modelOptionWindow:AddLabel("Overlay Chams")
		overlayItem:AddToggle({
			Default = false,
			Flag = "local_model_overlay",
			Callback = function(val)
				LocalVisualsState.Overlay = val
				updateLocalPlayerVisuals()
			end
		})

		local overlayOpt = overlayItem:AddOption()
		overlayOpt:AddLabel("Color"):AddColorPicker({
			Default = Color3.fromRGB(255, 255, 255),
			Flag = "local_overlay_color",
			Callback = function(col)
				LocalVisualsState.OverlayColor = col
				updateLocalPlayerVisuals()
			end
		})
	end)

	pcall(function()
		local glowItem = modelOptionWindow:AddLabel("Glow")
		glowItem:AddToggle({
			Default = false,
			Flag = "local_model_glow",
			Callback = function(val)
				LocalVisualsState.Glow = val
				updateLocalPlayerVisuals()
			end
		})

		local glowOpt = glowItem:AddOption()
		glowOpt:AddLabel("Mode"):AddDropdown({
			Values = {"Default", "Pulse"},
			Default = "Default",
			Flag = "local_glow_mode",
			Callback = function(val)
				LocalVisualsState.GlowMode = val
				updateLocalPlayerVisuals()
			end
		})

		glowOpt:AddLabel("Color"):AddColorPicker({
			Default = Color3.fromRGB(160, 80, 255),
			Flag = "local_glow_color",
			Callback = function(col)
				LocalVisualsState.GlowColor = col
				updateLocalPlayerVisuals()
			end
		})
	end)
end

local VisualsOther = Visuals:AddSection({
	Name = "OTHER",
	Position = 'right'
})

local VisualsWorld = Visuals:AddSection({
	Name = "WORLD",
	Position = 'right'
})

local InvPreviewSection = Inventory:AddSection({
	Name = "PREVIEW",
	Position = 'left'
})

local InvMain = Inventory:AddSection({
	Name = "SKIN CHANGER",
	Position = 'right'
})

local invContainerTarget = InvPreviewSection.Idx or InvPreviewSection.Container or InvPreviewSection.Frame

if invContainerTarget then
	pcall(function()
		local parentFrame = invContainerTarget.Parent
		if parentFrame then
			parentFrame.ClipsDescendants = false
			parentFrame.Size = UDim2.new(1, -5, 0, 390)
			pcall(function()
				parentFrame:GetPropertyChangedSignal("Size"):Connect(function()
					if parentFrame.Size.Y.Offset < 380 then
						parentFrame.Size = UDim2.new(1, -5, 0, 390)
					end
				end)
			end)
		end
	end)

	local invViewportCard = Instance.new("Frame")
	invViewportCard.Name = "InvViewportCard"
	invViewportCard.Size = UDim2.new(1, 0, 0, 380)
	invViewportCard.BackgroundTransparency = 1
	invViewportCard.BorderSizePixel = 0
	invViewportCard.Parent = invContainerTarget

	local invViewportHolder = Instance.new("Frame")
	invViewportHolder.Name = "InvViewportHolder"
	invViewportHolder.Size = UDim2.new(1, 0, 1, 0)
	invViewportHolder.Position = UDim2.new(0, 0, 0, 0)
	invViewportHolder.BackgroundTransparency = 1
	invViewportHolder.BorderSizePixel = 0
	invViewportHolder.Parent = invViewportCard

	create3DCharacterViewport(invViewportHolder, { camDistance = 11.5, camYaw = math.pi, targetY = 0.3, enableCustomizer = true })
end

local MiscMovement = Miscellaneous:AddSection({
	Name = "MOVEMENT",
	Position = 'left'
})

local MiscOther = Miscellaneous:AddSection({
	Name = "OTHER",
	Position = 'right'
})

local MiscRecode = Miscellaneous:AddSection({
	Name = "RECODE",
	Position = 'left'
})

-- Movement Settings already declared at top --

-- Auto-Save & Persistent Config System --
local HttpService = game:GetService("HttpService")
local CONFIG_FILE_PATH = "Neverlose_Movement_SaveData.json"

local configDirty = false

local function saveConfig()
	configDirty = true
end

local function forceSaveConfigNow()
	if not configDirty then return end
	configDirty = false
	pcall(function()
		if writefile then
			local serializedCheckpoints = {}
			if MovementSettings.CheckpointSlots then
				for i = 1, 5 do
					local slot = MovementSettings.CheckpointSlots[i]
					if slot and slot.CFrame then
						serializedCheckpoints[tostring(i)] = {
							CFrame = {slot.CFrame:GetComponents()},
							Velocity = slot.Velocity and {slot.Velocity.X, slot.Velocity.Y, slot.Velocity.Z} or {0, 0, 0},
							CameraCFrame = slot.CameraCFrame and {slot.CameraCFrame:GetComponents()} or nil
						}
					end
				end
			end

			local serializedBinds = {}
			if ModuleBinds then
				for flag, data in pairs(ModuleBinds) do
					local keyName = nil
					local keyType = nil
					if data.Key then
						if typeof(data.Key) == "EnumItem" then
							keyName = data.Key.Name
							keyType = tostring(data.Key.EnumType)
						else
							keyName = tostring(data.Key)
							keyType = "String"
						end
					end
					serializedBinds[flag] = {
						Key = keyName,
						KeyType = keyType,
						Mode = data.Mode
					}
				end
			end

			local saveTable = {
				MovementSettings = MovementSettings,
				ParticlesSettings = ParticlesSettings,
				TestSettings = TestSettings,
				DebugSettings = DebugSettings,
				CheckpointSlots = serializedCheckpoints,
				ModuleBinds = serializedBinds
			}
			writefile(CONFIG_FILE_PATH, HttpService:JSONEncode(saveTable))
		end
	end)
end

local function loadConfig()
	pcall(function()
		if isfile and isfile(CONFIG_FILE_PATH) then
			local raw = readfile(CONFIG_FILE_PATH)
			if raw and #raw > 0 then
				local data = HttpService:JSONDecode(raw)
				if data then
					if data.MovementSettings then
						for k, v in pairs(data.MovementSettings) do
							if k ~= "CheckpointSlots" and k ~= "CheckpointSmoothTarget" then
								MovementSettings[k] = v
							end
						end
					end
					if data.ParticlesSettings then
						for k, v in pairs(data.ParticlesSettings) do
							ParticlesSettings[k] = v
						end
					end
					if data.TestSettings then
						for k, v in pairs(data.TestSettings) do
							TestSettings[k] = v
						end
					end
					if data.DebugSettings then
						for k, v in pairs(data.DebugSettings) do
							DebugSettings[k] = v
						end
					end
					if data.CheckpointSlots then
						MovementSettings.CheckpointSlots = {nil, nil, nil, nil, nil}
						for iStr, slot in pairs(data.CheckpointSlots) do
							local idx = tonumber(iStr)
							if idx and slot and slot.CFrame then
								MovementSettings.CheckpointSlots[idx] = {
									CFrame = CFrame.new(unpack(slot.CFrame)),
									Velocity = slot.Velocity and Vector3.new(unpack(slot.Velocity)) or Vector3.zero,
									CameraCFrame = slot.CameraCFrame and CFrame.new(unpack(slot.CameraCFrame)) or nil
								}
							end
						end
					end
					if data.ModuleBinds and ModuleBinds then
						for flag, savedData in pairs(data.ModuleBinds) do
							if not ModuleBinds[flag] then
								ModuleBinds[flag] = { Key = nil, Mode = "TOGGLE", Callback = nil, State = false }
							end
							if savedData.Key then
								if savedData.Key ~= "MouseButton1" and savedData.Key ~= "MouseButton2" then
									pcall(function()
										if savedData.KeyType == "Enum.KeyCode" then
											ModuleBinds[flag].Key = Enum.KeyCode[savedData.Key]
										elseif savedData.KeyType == "Enum.UserInputType" then
											ModuleBinds[flag].Key = Enum.UserInputType[savedData.Key]
										end
									end)
								end
							end
							if savedData.Mode then
								ModuleBinds[flag].Mode = savedData.Mode
							end
						end
					end
				end
			end
		end
	end)
end

loadConfig()
ParticlesSettings.Enabled = true
ParticlesSettings.TrailMode = ParticlesSettings.TrailMode or "3D"
ParticlesSettings.TrailStyle3D = ParticlesSettings.TrailStyle3D or "Default"
ParticlesSettings.TrailStyle2D = ParticlesSettings.TrailStyle2D or "Default"
ParticlesSettings.TrailColor = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255)
TestSettings.Color = TestSettings.Color or Color3.fromRGB(255, 255, 255)

task.spawn(function()
	while task.wait(3) do
		if isUnloaded then
			forceSaveConfigNow()
			break
		end
		if configDirty then
			forceSaveConfigNow()
		end
	end
end)

local testWeatherFolder = nil
local testWeatherConn = nil
local activeWeatherMode = nil

local particlesFolder = nil
local particlesConn = nil
local particlesConn2 = nil
local activeParticlesMode = nil
local particlesExtraCleanups = {}

local function clearParticles()
	pcall(function()
		if particlesConn then
			particlesConn:Disconnect()
			particlesConn = nil
		end
	end)
	pcall(function()
		if particlesConn2 then
			particlesConn2:Disconnect()
			particlesConn2 = nil
		end
	end)
	for _, cleanupFn in ipairs(particlesExtraCleanups) do
		pcall(cleanupFn)
	end
	table.clear(particlesExtraCleanups)
	pcall(function()
		if particlesFolder then
			particlesFolder:Destroy()
			particlesFolder = nil
		end
	end)
	pcall(function()
		local lp = game:GetService("Players").LocalPlayer
		if lp and lp.Character then
			local root = lp.Character:FindFirstChild("HumanoidRootPart") or lp.Character:FindFirstChild("Torso")
			if root then
				if root:FindFirstChild("Visual3DTrail") then root.Visual3DTrail:Destroy() end
				if root:FindFirstChild("TrailAtt0") then root.TrailAtt0:Destroy() end
				if root:FindFirstChild("TrailAtt1") then root.TrailAtt1:Destroy() end
			end
		end
	end)
	activeParticlesMode = nil
end

local function updateParticles(forceRebuild)
	if isUnloaded or not ParticlesSettings.Enabled then
		clearParticles()
		return
	end

	local mode = ParticlesSettings.Mode or "Trails"

	if not forceRebuild and particlesFolder and particlesFolder.Parent and activeParticlesMode == mode then
		return
	end

	clearParticles()
	activeParticlesMode = mode

	local lp = game:GetService("Players").LocalPlayer
	if not lp then return end

	particlesFolder = Instance.new("Folder")
	particlesFolder.Name = "ParticlesEffectFolder"
	particlesFolder.Parent = workspace

	if mode == "Trails" then
		local trailMode = ParticlesSettings.TrailMode or "3D"
		local trailStyle3D = ParticlesSettings.TrailStyle3D or "Default"
		local trailStyle2D = ParticlesSettings.TrailStyle2D or "Default"
		local trailColor = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255)

		if trailMode == "3D" then
			if trailStyle3D == "Default" then
				local function setup3DRibbonTrail(char)
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
					if not root then return end

					local att0 = root:FindFirstChild("TrailAtt0") or Instance.new("Attachment")
					att0.Name = "TrailAtt0"
					att0.Position = Vector3.new(0, 1.2, 0)
					att0.Parent = root

					local att1 = root:FindFirstChild("TrailAtt1") or Instance.new("Attachment")
					att1.Name = "TrailAtt1"
					att1.Position = Vector3.new(0, -1.2, 0)
					att1.Parent = root

					local trail = root:FindFirstChild("Visual3DTrail") or Instance.new("Trail")
					trail.Name = "Visual3DTrail"
					trail.Attachment0 = att0
					trail.Attachment1 = att1
					trail.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, trailColor),
						ColorSequenceKeypoint.new(1, trailColor)
					})
					trail.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.1),
						NumberSequenceKeypoint.new(1, 1)
					})
					trail.Lifetime = 0.75
					trail.LightEmission = 0.8
					trail.LightInfluence = 0
					trail.FaceCamera = true
					trail.MaxLength = 0
					trail.Parent = root
				end

				if lp.Character then setup3DRibbonTrail(lp.Character) end
				local cConn = lp.CharacterAdded:Connect(setup3DRibbonTrail)
				table.insert(particlesExtraCleanups, function()
					pcall(function() cConn:Disconnect() end)
				end)

			elseif trailStyle3D == "Neon" then
				local lastSpawnPos = nil
				local minDistance = 0.4

				particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
					local char = lp.Character
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
					if not root then return end

					local currentPos = root.Position
					if lastSpawnPos and (currentPos - lastSpawnPos).Magnitude < minDistance then return end
					lastSpawnPos = currentPos

					local part = Instance.new("Part")
					local sz = 0.5 + math.random() * 0.3
					part.Name = "3DNeonTrail"
					part.Size = Vector3.new(sz, sz, sz)
					part.Shape = Enum.PartType.Ball
					part.CFrame = CFrame.new(currentPos)
					part.Anchored = true
					part.CanCollide = false
					part.Material = Enum.Material.Neon
					part.Color = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255)
					part.Transparency = 0.15
					part.Parent = particlesFolder

					local sparkle = Instance.new("ParticleEmitter")
					sparkle.Texture = "rbxassetid://10849912115"
					sparkle.Size = NumberSequence.new(0.05, 0)
					sparkle.Lifetime = NumberRange.new(0.3, 0.6)
					sparkle.Rate = 6
					sparkle.Speed = NumberRange.new(0.2, 0.6)
					sparkle.Transparency = NumberSequence.new(0.2, 1)
					sparkle.Color = ColorSequence.new(part.Color)
					sparkle.LightEmission = 1
					sparkle.LightInfluence = 0
					sparkle.Parent = part

					local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(1.2), {Transparency = 1, Size = Vector3.new(0, 0, 0)})
					tween:Play()
					tween.Completed:Connect(function() pcall(function() part:Destroy() end) end)
				end)

			elseif trailStyle3D == "Minecraft" then
				local lastSpawnPos = nil
				local minDistance = 0.5

				particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
					local char = lp.Character
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
					if not root then return end

					local currentPos = root.Position
					if lastSpawnPos and (currentPos - lastSpawnPos).Magnitude < minDistance then return end
					lastSpawnPos = currentPos

					local block = Instance.new("Part")
					block.Name = "3DMinecraftBlock"
					local bSize = 0.35 + math.random() * 0.15
					block.Size = Vector3.new(bSize, bSize, bSize)
					block.Shape = Enum.PartType.Block
					block.CFrame = CFrame.new(currentPos + Vector3.new((math.random()-0.5)*0.4, (math.random()-0.5)*0.4, (math.random()-0.5)*0.4)) * CFrame.Angles(math.rad(math.random(0,360)), math.rad(math.random(0,360)), math.rad(math.random(0,360)))
					block.Anchored = true
					block.CanCollide = false
					block.Material = Enum.Material.SmoothPlastic
					block.Color = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255)
					block.Transparency = 0.1
					block.Parent = particlesFolder

					local crit = Instance.new("ParticleEmitter")
					crit.Texture = "rbxassetid://10849912115"
					crit.Size = NumberSequence.new(0.08, 0)
					crit.Lifetime = NumberRange.new(0.2, 0.5)
					crit.Rate = 0
					crit.Speed = NumberRange.new(0.5, 1.5)
					crit.SpreadAngle = Vector2.new(-180, 180)
					crit.Color = ColorSequence.new(block.Color)
					crit.LightEmission = 0.9
					crit.Parent = block
					crit:Emit(2)

					local endCFrame = block.CFrame * CFrame.new(0, -0.3, 0) * CFrame.Angles(math.rad(45), math.rad(45), 0)
					local tween = game:GetService("TweenService"):Create(block, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Transparency = 1,
						Size = Vector3.new(0, 0, 0),
						CFrame = endCFrame
					})
					tween:Play()
					tween.Completed:Connect(function() pcall(function() block:Destroy() end) end)
				end)

			elseif trailStyle3D == "Test" then
				local lastSpawnPos = nil
				local minDistance = 0.6

				particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
					local char = lp.Character
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
					if not root then return end

					local currentPos = root.Position
					if lastSpawnPos and (currentPos - lastSpawnPos).Magnitude < minDistance then return end
					lastSpawnPos = currentPos

					local ring = Instance.new("Part")
					ring.Name = "3DTestRing"
					ring.Size = Vector3.new(0.8, 0.1, 0.8)
					ring.Shape = Enum.PartType.Cylinder
					ring.CFrame = root.CFrame * CFrame.Angles(0, 0, math.rad(90))
					ring.Anchored = true
					ring.CanCollide = false
					ring.Material = Enum.Material.Neon
					ring.Color = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255)
					ring.Transparency = 0.2
					ring.Parent = particlesFolder

					local pulse = Instance.new("ParticleEmitter")
					pulse.Texture = "rbxassetid://10849912115"
					pulse.Size = NumberSequence.new(0.1, 0)
					pulse.Lifetime = NumberRange.new(0.4, 0.7)
					pulse.Rate = 0
					pulse.Speed = NumberRange.new(1, 3)
					pulse.SpreadAngle = Vector2.new(-90, 90)
					pulse.Color = ColorSequence.new(ring.Color)
					pulse.LightEmission = 1
					pulse.Parent = ring
					pulse:Emit(3)

					local tween = game:GetService("TweenService"):Create(ring, TweenInfo.new(1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						Transparency = 1,
						Size = Vector3.new(2.5, 0.05, 2.5)
					})
					tween:Play()
					tween.Completed:Connect(function() pcall(function() ring:Destroy() end) end)
				end)
			end

		elseif trailMode == "2D" then
			if trailStyle2D == "Default" then
				local lastSpawnPos = nil
				local minDistance = 0.4

				particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
					local char = lp.Character
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
					if not root then return end

					local currentPos = root.Position
					if lastSpawnPos and (currentPos - lastSpawnPos).Magnitude < minDistance then return end
					lastSpawnPos = currentPos

					local part = Instance.new("Part")
					part.Name = "2DDefaultPart"
					part.Size = Vector3.new(0.1, 0.1, 0.1)
					part.CFrame = CFrame.new(currentPos)
					part.Anchored = true
					part.CanCollide = false
					part.Transparency = 1
					part.Parent = particlesFolder

					local pe = Instance.new("ParticleEmitter")
					pe.Name = "2DGlowParticle"
					pe.Texture = "rbxassetid://10849912115"
					pe.Size = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.6),
						NumberSequenceKeypoint.new(1, 0)
					})
					pe.Lifetime = NumberRange.new(0.5, 0.8)
					pe.Rate = 0
					pe.Speed = NumberRange.new(0.1, 0.4)
					pe.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.1),
						NumberSequenceKeypoint.new(1, 1)
					})
					pe.Color = ColorSequence.new(ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255))
					pe.LightEmission = 0.9
					pe.Orientation = Enum.ParticleOrientation.FacingCamera
					pe.Parent = part

					pe:Emit(3)
					game:GetService("Debris"):AddItem(part, 1.0)
				end)

			elseif trailStyle2D == "Smoke" then
				local lastSpawnPos = nil
				local minDistance = 0.5

				particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
					local char = lp.Character
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
					if not root then return end

					local currentPos = root.Position
					if lastSpawnPos and (currentPos - lastSpawnPos).Magnitude < minDistance then return end
					lastSpawnPos = currentPos

					local part = Instance.new("Part")
					part.Name = "2DSmokePart"
					part.Size = Vector3.new(0.1, 0.1, 0.1)
					part.CFrame = CFrame.new(currentPos + Vector3.new(0, -0.2, 0))
					part.Anchored = true
					part.CanCollide = false
					part.Transparency = 1
					part.Parent = particlesFolder

					local col = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255)

					local smoke = Instance.new("ParticleEmitter")
					smoke.Name = "SmokeChunk"
					smoke.Texture = "rbxassetid://13470377227"
					smoke.Size = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.7),
						NumberSequenceKeypoint.new(0.4, 1.6),
						NumberSequenceKeypoint.new(1, 0.3)
					})
					smoke.Lifetime = NumberRange.new(0.6, 1.0)
					smoke.Rate = 0
					smoke.Speed = NumberRange.new(0.1, 0.5)
					smoke.VelocitySpread = 25
					smoke.Rotation = NumberRange.new(0, 360)
					smoke.RotSpeed = NumberRange.new(-25, 25)
					smoke.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.05),
						NumberSequenceKeypoint.new(0.5, 0.3),
						NumberSequenceKeypoint.new(1, 1.0)
					})
					smoke.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, col),
						ColorSequenceKeypoint.new(0.5, col),
						ColorSequenceKeypoint.new(1, Color3.new(col.R * 0.4, col.G * 0.4, col.B * 0.4))
					})
					smoke.LightEmission = 0.65
					smoke.LightInfluence = 0
					smoke.Orientation = Enum.ParticleOrientation.FacingCamera
					smoke.Parent = part

					local embers = Instance.new("ParticleEmitter")
					embers.Name = "SmokeEmbers"
					embers.Texture = "rbxassetid://10849912115"
					embers.Size = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.14),
						NumberSequenceKeypoint.new(1, 0)
					})
					embers.Lifetime = NumberRange.new(0.4, 0.7)
					embers.Rate = 0
					embers.Speed = NumberRange.new(0.8, 2.2)
					embers.SpreadAngle = Vector2.new(-60, 60)
					embers.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.0),
						NumberSequenceKeypoint.new(1, 1.0)
					})
					embers.Color = ColorSequence.new(col)
					embers.LightEmission = 0.9
					embers.LightInfluence = 0
					embers.Orientation = Enum.ParticleOrientation.FacingCamera
					embers.Parent = part

					smoke:Emit(3)
					embers:Emit(2)

					game:GetService("Debris"):AddItem(part, 1.2)
				end)
			end
		end

	elseif mode == "Orbit" then
		local spheres = {}
		local RADIUS = 10
		local SPEED = 3
		local COUNT = 6
		local BALL_SIZE = 1
		local SMOOTHNESS = 0.15

		local function createOrbits()
			for _, s in pairs(spheres) do pcall(function() s:Destroy() end) end
			spheres = {}
			for i = 1, COUNT do
				local p = Instance.new("Part")
				p.Size = Vector3.new(BALL_SIZE, BALL_SIZE, BALL_SIZE)
				p.Shape = Enum.PartType.Ball
				p.Material = Enum.Material.Neon
				p.Color = Color3.fromRGB(0, 255, 255)
				p.Anchored = true
				p.CanCollide = false
				p.Parent = particlesFolder

				local a0 = Instance.new("Attachment", p)
				a0.Position = Vector3.new(0, 0.5, 0)
				local a1 = Instance.new("Attachment", p)
				a1.Position = Vector3.new(0, -0.5, 0)

				local trail = Instance.new("Trail")
				trail.Attachment0 = a0
				trail.Attachment1 = a1
				trail.Lifetime = 0.6
				trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(170, 0, 255))
				trail.Transparency = NumberSequence.new(0.1, 0.8)
				trail.WidthScale = NumberSequence.new(1.2, 0)
				trail.LightEmission = 0.8
				trail.Parent = p

				local glow = Instance.new("PointLight")
				glow.Color = Color3.fromRGB(0, 200, 255)
				glow.Brightness = 1.5
				glow.Range = 6
				glow.Shadows = false
				glow.Parent = p

				local dust = Instance.new("ParticleEmitter")
				dust.Texture = "rbxassetid://10849912115"
				dust.Size = NumberSequence.new(0.05, 0)
				dust.Lifetime = NumberRange.new(0.4, 0.8)
				dust.Rate = 6
				dust.Speed = NumberRange.new(0.1, 0.3)
				dust.Transparency = NumberSequence.new(0.2, 1)
				dust.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
				dust.LightEmission = 1
				dust.LightInfluence = 0
				dust.Parent = p

				table.insert(spheres, p)
			end
		end

		createOrbits()

		particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
			local char = lp.Character
			local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
			if not root then return end

			if #spheres == 0 then createOrbits() end
			local t = tick()
			for i, p in ipairs(spheres) do
				local angle = (t * SPEED) + (i * (math.pi * 2 / COUNT))
				local offset = Vector3.new(math.cos(angle) * RADIUS, math.sin(t * 2 + i) * 1.5 + 2, math.sin(angle) * RADIUS)
				local goalPos = root.Position + offset
				p.Position = p.Position:Lerp(goalPos, SMOOTHNESS)
				local hue = (t * 0.08 + i / COUNT) % 1
				p.Color = Color3.fromHSV(hue, 0.9, 1)
				local glow = p:FindFirstChildOfClass("PointLight")
				if glow then glow.Color = Color3.fromHSV(hue, 0.8, 1) end
				local dust = p:FindFirstChildOfClass("ParticleEmitter")
				if dust then dust.Color = ColorSequence.new(Color3.fromHSV(hue, 0.9, 1)) end
			end
		end)

	elseif mode == "Aura Pulse" then
		local CONFIG = {
			ColorPurple = Color3.fromRGB(160, 32, 240),
			ColorBlue = Color3.fromRGB(0, 140, 255),
			PulseInterval = 1.6,
			ExpansionTime = 1.1,
			MaxSize = 18,
			OrbitRadius = 3.6,
			OrbitSpeed = 2.8,
			OrbBaseSize = 0.5,
			SpringMass = 1.0,
			SpringDamping = 4.5,
			SpringStiffness = 45.0,
		}

		local function createVector3Spring(mass, damping, stiffness)
			local spring = {x = Vector3.new(), v = Vector3.new(), target = Vector3.new(), mass = mass or 1, damping = damping or 4, stiffness = stiffness or 40}
			function spring:update(dt)
				local displacement = self.x - self.target
				local force = -self.stiffness * displacement - self.damping * self.v
				local acceleration = force / self.mass
				self.v = self.v + acceleration * dt
				self.x = self.x + self.v * dt
				return self.x
			end
			return spring
		end

		local pulseCounter = 0
		local function getNextColor()
			pulseCounter = (pulseCounter % 4) + 1
			if pulseCounter <= 2 then return CONFIG.ColorPurple, CONFIG.ColorBlue else return CONFIG.ColorBlue, CONFIG.ColorPurple end
		end

		local sparkleEmitters = {}
		local function createCometOrb(color)
			local orb = Instance.new("Part")
			orb.Shape = Enum.PartType.Ball
			orb.Size = Vector3.new(CONFIG.OrbBaseSize, CONFIG.OrbBaseSize, CONFIG.OrbBaseSize)
			orb.Material = Enum.Material.Neon
			orb.Color = color
			orb.Anchored = true
			orb.CanCollide = false
			orb.CanTouch = false
			orb.CanQuery = false
			orb.CastShadow = false
			orb.Parent = particlesFolder

			local glowGui = Instance.new("BillboardGui")
			glowGui.Size = UDim2.new(3.2, 0, 3.2, 0)
			glowGui.AlwaysOnTop = false
			glowGui.LightInfluence = 0
			glowGui.Parent = orb

			local glowImage = Instance.new("ImageLabel")
			glowImage.BackgroundTransparency = 1
			glowImage.Image = "rbxassetid://13470377227"
			glowImage.ImageColor3 = color
			glowImage.Size = UDim2.new(1, 0, 1, 0)
			glowImage.Parent = glowGui

			local att0 = Instance.new("Attachment", orb)
			att0.Position = Vector3.new(0, CONFIG.OrbBaseSize / 2, 0)
			local att1 = Instance.new("Attachment", orb)
			att1.Position = Vector3.new(0, -CONFIG.OrbBaseSize / 2, 0)

			local trail = Instance.new("Trail")
			trail.Attachment0 = att0
			trail.Attachment1 = att1
			trail.Color = ColorSequence.new(color)
			trail.Lifetime = 0.7
			trail.Transparency = NumberSequence.new(0.3)
			trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
			trail.Parent = orb

			local sparks = Instance.new("ParticleEmitter")
			sparks.Texture = "rbxassetid://5813005513"
			sparks.Size = NumberSequence.new(0.15, 0)
			sparks.Lifetime = NumberRange.new(0.3, 0.6)
			sparks.Rate = 12
			sparks.Speed = NumberRange.new(0.5, 1.5)
			sparks.Transparency = NumberSequence.new(0, 1)
			sparks.Color = ColorSequence.new(color)
			sparks.Parent = orb

			local sparkle = Instance.new("ParticleEmitter")
			sparkle.Texture = "rbxassetid://10849912115"
			sparkle.Size = NumberSequence.new(0.06, 0)
			sparkle.Lifetime = NumberRange.new(0.5, 1.2)
			sparkle.Rate = 8
			sparkle.Speed = NumberRange.new(0.3, 0.8)
			sparkle.Transparency = NumberSequence.new(0.2, 1)
			sparkle.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
			sparkle.LightEmission = 1
			sparkle.LightInfluence = 0
			sparkle.Parent = orb
			table.insert(sparkleEmitters, sparkle)

			return orb, trail, glowImage
		end

		local purpleOrb, purpleTrail, purpleGlow = createCometOrb(CONFIG.ColorPurple)
		local blueOrb, blueTrail, blueGlow = createCometOrb(CONFIG.ColorBlue)

		local springPurple = createVector3Spring(CONFIG.SpringMass, CONFIG.SpringDamping, CONFIG.SpringStiffness)
		local springBlue = createVector3Spring(CONFIG.SpringMass, CONFIG.SpringDamping, CONFIG.SpringStiffness)

		local angle = 0
		local firstFrame = true

		particlesConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			local char = lp.Character
			local rootPart = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
			if not rootPart then return end

			angle = angle + dt * CONFIG.OrbitSpeed
			local rootPos = rootPart.Position
			local breathingSize = CONFIG.OrbBaseSize + math.sin(angle * 3) * 0.12
			purpleOrb.Size = Vector3.new(breathingSize, breathingSize, breathingSize)
			blueOrb.Size = Vector3.new(breathingSize, breathingSize, breathingSize)

			local px = math.cos(angle) * CONFIG.OrbitRadius
			local pz = math.sin(angle) * CONFIG.OrbitRadius
			local py = math.sin(angle * 2) * 0.5

			local bx = math.cos(angle + math.pi) * CONFIG.OrbitRadius
			local bz = math.sin(angle + math.pi) * CONFIG.OrbitRadius
			local by = math.sin((angle + math.pi) * 2) * 0.5

			local targetP1 = rootPos + Vector3.new(px, py, pz)
			local targetP2 = rootPos + Vector3.new(bx, by, bz)

			if firstFrame then
				springPurple.x = targetP1
				springBlue.x = targetP2
				purpleOrb.Position = targetP1
				blueOrb.Position = targetP2
				firstFrame = false
			else
				springPurple.target = targetP1
				springBlue.target = targetP2
				local clampedDt = math.min(dt, 0.1)
				purpleOrb.Position = springPurple:update(clampedDt)
				blueOrb.Position = springBlue:update(clampedDt)
			end
		end)

	elseif mode == "Paradox Engine" then
		local particles = {}
		local particleData = {}
		local PARTICLE_COUNT = 40
		local RADIUS = 6
		local SMOOTHNESS = 0.12

		local function createGravityWell()
			for _, p in pairs(particles) do pcall(function() p:Destroy() end) end
			particles = {}
			particleData = {}
			for i = 1, PARTICLE_COUNT do
				local p = Instance.new("Part")
				p.Size = Vector3.new(0.3 + math.random() * 0.2, 0.3 + math.random() * 0.2, 0.3 + math.random() * 0.2)
				p.Shape = Enum.PartType.Ball
				p.Material = Enum.Material.Neon
				p.Color = Color3.fromRGB(0, 255, 255)
				p.Anchored = true
				p.CanCollide = false
				p.CanTouch = false
				p.CanQuery = false
				p.CastShadow = false
				p.Parent = particlesFolder

				local a0 = Instance.new("Attachment", p)
				a0.Position = Vector3.new(0, 0.2, 0)
				local a1 = Instance.new("Attachment", p)
				a1.Position = Vector3.new(0, -0.2, 0)

				local trail = Instance.new("Trail")
				trail.Attachment0 = a0
				trail.Attachment1 = a1
				trail.Lifetime = 0.4
				trail.Transparency = NumberSequence.new(0.3, 0.9)
				trail.WidthScale = NumberSequence.new(1.2, 0)
				trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(170, 0, 255))
				trail.Parent = p

				table.insert(particles, p)
				particleData[i] = {
					Type = math.random(1, 3),
					Speed = math.random(15, 25) / 10,
					Offset = i * (math.pi * 2 / PARTICLE_COUNT),
					SizeOffset = math.random() * 0.5
				}
			end
		end

		createGravityWell()

		particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
			local char = lp.Character
			local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
			if not root then return end

			if #particles == 0 then createGravityWell() end
			local t = tick()
			for i, p in ipairs(particles) do
				local data = particleData[i]
				local mt = t * data.Speed + data.Offset
				local targetPos
				if data.Type == 1 then
					targetPos = Vector3.new(math.sin(mt) * RADIUS, math.cos(mt * 0.5) * 2 + math.sin(t * 1.5 + i) * 0.3, math.cos(mt) * RADIUS)
				elseif data.Type == 2 then
					targetPos = Vector3.new(math.sin(mt) * 2 + math.cos(t * 0.7 + i) * 0.5, math.sin(mt) * RADIUS, math.cos(mt) * RADIUS)
				else
					targetPos = Vector3.new(math.cos(mt) * RADIUS, math.sin(mt) * (RADIUS / 2) + math.sin(t * 1.2 + i) * 0.3, math.sin(mt) * RADIUS)
				end
				local finalTarget = root.Position + targetPos + Vector3.new(0, 1, 0)
				p.Position = p.Position:Lerp(finalTarget, SMOOTHNESS)
				p.Color = Color3.fromHSV((t * 0.08 + i / PARTICLE_COUNT) % 1, 0.8, 1)
			end
		end)

	elseif mode == "RGB Circle" then
		local parts = {}
		local angleOffset = 0
		local CONFIG = {Radius = 6, NumParts = 24, PartSize = Vector3.new(0.4, 0.4, 0.4), RotationSpeed = 1, ColorSpeed = 0.3, HeightOffset = -1.5, WaveAmp = 1}

		local function createParts()
			for _, p in pairs(parts) do pcall(function() p:Destroy() end) end
			parts = {}
			for i = 1, CONFIG.NumParts do
				local p = Instance.new("Part")
				p.Size = CONFIG.PartSize
				p.Material = Enum.Material.Neon
				p.Anchored = true
				p.CanCollide = false
				p.CanTouch = false
				p.CanQuery = false
				p.CastShadow = false
				p.Parent = particlesFolder

				local gl = Instance.new("PointLight")
				gl.Brightness = 1.5
				gl.Range = 5
				gl.Shadows = false
				gl.Parent = p
				parts[i] = p
			end
		end

		createParts()

		particlesConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			local char = lp.Character
			local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
			if not root then
				for _, p in ipairs(parts) do if p and p.Parent then p.Transparency = 1 end end
				return
			end

			angleOffset = angleOffset + dt * CONFIG.RotationSpeed
			local timeValue = tick() * CONFIG.ColorSpeed
			local centerPosition = root.Position + Vector3.new(0, CONFIG.HeightOffset, 0)
			for i = 1, CONFIG.NumParts do
				local p = parts[i]
				if p and p.Parent then
					p.Transparency = 0
					local angle = (i / CONFIG.NumParts) * math.pi * 2 + angleOffset
					local x = math.cos(angle) * CONFIG.Radius
					local z = math.sin(angle) * CONFIG.Radius
					local y = math.sin(angle * 2 + timeValue * 2) * CONFIG.WaveAmp
					local target = centerPosition + Vector3.new(x, y, z)
					p.Position = p.Position:Lerp(target, 0.35)
					local hue = ((i / CONFIG.NumParts) + timeValue) % 1
					p.Color = Color3.fromHSV(hue, 1, 1)
					local gl = p:FindFirstChildOfClass("PointLight")
					if gl then
						gl.Color = Color3.fromHSV(hue, 0.8, 1)
						gl.Brightness = 1.2 + math.sin(angle * 2 + timeValue * 3) * 0.5
					end
				end
			end
		end)
	end
end

-- Auto-initialize particles system on script load --
task.spawn(function()
	task.wait(0.5)
	pcall(function()
		if ParticlesSettings and ParticlesSettings.Enabled then
			updateParticles(true)
		end
	end)
end)

local function clearTestWeather()
	pcall(function()
		if testWeatherConn then
			testWeatherConn:Disconnect()
			testWeatherConn = nil
		end
	end)
	pcall(function()
		if testWeatherFolder then
			testWeatherFolder:Destroy()
			testWeatherFolder = nil
		end
	end)
	activeWeatherMode = nil
end

local function updateTestWeather(forceRebuild)
	local startTime = os.clock()
	if isUnloaded or (not TestSettings.Enabled and not TestSettings.TestEnabled) then
		clearTestWeather()
		return
	end
	
	local mode = TestSettings.Mode or "Snow"
	local speedVal = TestSettings.Speed or 20
	local glowVal = (TestSettings.Glow or 0) / 100
	local countVal = TestSettings.Count or 150
	local userCol = TestSettings.Color or Color3.fromRGB(255, 255, 255)

	-- Prevent lag freeze on UI open/close: if weather is already running in this mode, do not destroy/recreate 1200 parts!
	if not forceRebuild and testWeatherFolder and testWeatherFolder.Parent and activeWeatherMode == mode then
		return
	end

	clearTestWeather()
	activeWeatherMode = mode
	
	local cam = workspace.CurrentCamera
	if not cam then return end
	
	testWeatherFolder = Instance.new("Folder")
	testWeatherFolder.Name = "TestWeatherFolder"
	testWeatherFolder.Parent = workspace
	
	local part = Instance.new("Part")
	part.Name = "WeatherAnchorPart"
	part.Transparency = 1
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Anchored = true
	part.Size = Vector3.new(180, 2, 180)
	part.CFrame = CFrame.new(cam.CFrame.Position + Vector3.new(0, 18, 0))
	part.Parent = testWeatherFolder
	
	if mode == "Snow" then
		local SnowSettings = {
			Enabled = true,
			Intensity = math.max(80, math.min(450, math.floor(countVal * 1.8))),
			Height = 75,
			Radius = 140,
			FallSpeed = math.max(1.2, 6.0 - (speedVal / 30)),
			Color = userCol,
			Transparency = math.clamp(0.35 - (glowVal * 0.3), 0.02, 0.4),
			WindDirection = Vector3.new(1, 0, 0.5),
			WindStrength = 1.5,
			Accumulation = true,
			MaxAccumulation = 75,
		}

		local SnowPool = {}
		local AccumulatedSnow = {}
		local SnowFolder = Instance.new("Folder")
		SnowFolder.Name = "PortalVisual_Snow"
		SnowFolder.Parent = testWeatherFolder

		local PoolSize = 450
		for i = 1, PoolSize do
			local flake = Instance.new("Part")
			flake.Shape = Enum.PartType.Ball
			flake.Size = Vector3.new(0.25 + math.random() * 0.25, 0.25 + math.random() * 0.25, 0.25 + math.random() * 0.25)
			flake.Material = (glowVal > 0.45) and Enum.Material.Neon or Enum.Material.Snow
			flake.CanCollide = false
			flake.CanTouch = false
			flake.CanQuery = false
			flake.Anchored = true
			flake.CastShadow = false
			flake.Position = Vector3.new(0, -1000, 0)
			flake.Parent = SnowFolder
			table.insert(SnowPool, flake)
		end

		local function GetSnowFlake()
			if #SnowPool > 0 then
				return table.remove(SnowPool)
			end
			return nil
		end

		local function ReturnSnowFlake(flake)
			if flake and flake.Parent then
				flake.Position = Vector3.new(0, -1000, 0)
				flake.Transparency = 1
				if #SnowPool < PoolSize then
					table.insert(SnowPool, flake)
				else
					flake:Destroy()
				end
			end
		end

		local function AddAccumulation(position)
			if not SnowSettings.Accumulation then return end
			if #AccumulatedSnow >= SnowSettings.MaxAccumulation then
				local old = table.remove(AccumulatedSnow, 1)
				if old then old:Destroy() end
			end
			local pile = Instance.new("Part")
			pile.Shape = Enum.PartType.Ball
			pile.Size = Vector3.new(0.35 + math.random() * 0.45, 0.15 + math.random() * 0.15, 0.35 + math.random() * 0.45)
			pile.Position = position + Vector3.new(math.random(-2, 2) / 10, 0, math.random(-2, 2) / 10)
			pile.Color = userCol
			pile.Material = (glowVal > 0.45) and Enum.Material.Neon or Enum.Material.Snow
			pile.CanCollide = false
			pile.CanTouch = false
			pile.CanQuery = false
			pile.Anchored = true
			pile.Transparency = 0.2
			pile.Parent = SnowFolder
			table.insert(AccumulatedSnow, pile)
		end

		local activeFlakes = {}

		local function SpawnFlake()
			local char = game:GetService("Players").LocalPlayer.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
			if not hrp then return end

			local flake = GetSnowFlake()
			if not flake then return end

			local spawnPos = hrp.Position + Vector3.new(0, SnowSettings.Height, 0)
			local randomX = math.random(-SnowSettings.Radius * 10, SnowSettings.Radius * 10) / 10
			local randomZ = math.random(-SnowSettings.Radius * 10, SnowSettings.Radius * 10) / 10
			local startPos = spawnPos + Vector3.new(randomX, 0, randomZ)
			
			flake.Position = startPos
			flake.Color = SnowSettings.Color
			flake.Transparency = SnowSettings.Transparency
			flake.Size = Vector3.new(0.25 + math.random() * 0.25, 0.25 + math.random() * 0.25, 0.25 + math.random() * 0.25)
			flake.Parent = SnowFolder

			table.insert(activeFlakes, {
				part = flake,
				x = startPos.X,
				y = startPos.Y,
				z = startPos.Z,
				speed = (6.0 - (SnowSettings.FallSpeed or 3)) + math.random() * 2,
				sway = math.random() * math.pi * 2,
				groundY = startPos.Y - (SnowSettings.Height + 10)
			})
		end

		local lastSpawn = 0
		local spawnInterval = 0.05

		testWeatherConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			dt = math.min(dt, 0.04)
			lastSpawn = lastSpawn + dt
			if lastSpawn >= spawnInterval then
				lastSpawn = 0
				local count = math.clamp(math.floor(SnowSettings.Intensity / 35), 1, 4)
				for i = 1, count do
					SpawnFlake()
				end
			end

			local char = game:GetService("Players").LocalPlayer.Character
			local hrp = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
			local rootPos = hrp and hrp.Position or Vector3.new(0,0,0)

			for i = #activeFlakes, 1, -1 do
				local f = activeFlakes[i]
				f.y = f.y - f.speed * dt
				f.sway = f.sway + dt * 2
				f.x = f.x + math.sin(f.sway) * 1.2 * dt
				f.z = f.z + math.cos(f.sway) * 0.8 * dt
				f.part.Position = Vector3.new(f.x, f.y, f.z)

				if f.y <= f.groundY or (Vector3.new(f.x, f.y, f.z) - rootPos).Magnitude > 160 then
					if SnowSettings.Accumulation and f.y <= f.groundY then
						AddAccumulation(Vector3.new(f.x, f.groundY, f.z))
					end
					ReturnSnowFlake(f.part)
					table.remove(activeFlakes, i)
				end
			end
		end)
		return
	elseif mode == "Arh" then
		local emitter = Instance.new("ParticleEmitter")
		emitter.Name = "ArhEmitter"
		emitter.Texture = "rbxassetid://258122822"
		emitter.Rate = math.max(60, math.floor(countVal * 2.2))
		emitter.Speed = NumberRange.new(math.max(1, speedVal * 0.2), math.max(6, speedVal * 0.8))
		emitter.Lifetime = NumberRange.new(2, 4)
		emitter.VelocitySpread = 180
		emitter.EmissionDirection = Enum.NormalId.Top
		emitter.Shape = Enum.ParticleEmitterShape.Box
		emitter.ShapeSize = Vector3.new(150, 2, 150)
		emitter.LightEmission = math.clamp(0.4 + glowVal * 0.6, 0.4, 1.0)
		emitter.LightInfluence = math.clamp(1.0 - glowVal, 0.0, 1.0)
		emitter.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.8),
			NumberSequenceKeypoint.new(0.4, 2.0),
			NumberSequenceKeypoint.new(1, 0.0)
		})
		emitter.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1.0),
			NumberSequenceKeypoint.new(0.3, 0.0),
			NumberSequenceKeypoint.new(0.7, 0.0),
			NumberSequenceKeypoint.new(1, 1.0)
		})
		emitter.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, userCol),
			ColorSequenceKeypoint.new(0.5, userCol),
			ColorSequenceKeypoint.new(1, Color3.new(userCol.R * 0.6, userCol.G * 0.6, userCol.B * 0.6))
		})
		emitter.RotSpeed = NumberRange.new(-90, 90)
		emitter.Enabled = true
		emitter.Parent = part

	elseif mode == "Stars" then
		local StarsFolder = Instance.new("Folder")
		StarsFolder.Name = "PortalVisual_Stars"
		StarsFolder.Parent = testWeatherFolder

		local starColor = userCol
		local trailColor = userCol
		local maxActiveStars = math.max(10, math.min(60, math.floor(countVal * 0.25)))
		local fallSpeed = math.max(60, speedVal * 5.0)

		local activeStars = {}
		local frameCounter = 0

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude

		local function updateRayFilter()
			local filter = {testWeatherFolder}
			local lp = game:GetService("Players").LocalPlayer
			if lp and lp.Character then table.insert(filter, lp.Character) end
			rayParams.FilterDescendantsInstances = filter
		end
		updateRayFilter()

		local function createImpactExplosion(pos, normal)
			local ring = Instance.new("Part")
			ring.Shape = Enum.PartType.Cylinder
			ring.Size = Vector3.new(0.05, 0.1, 0.1)
			ring.Material = Enum.Material.Neon
			ring.Color = trailColor
			ring.Transparency = 0.15
			ring.Anchored = true
			ring.CanCollide = false
			ring.CanQuery = false
			ring.CFrame = CFrame.lookAt(pos, pos + normal) * CFrame.Angles(math.rad(90), 0, 0)
			ring.Parent = StarsFolder

			game:GetService("TweenService"):Create(ring, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = Vector3.new(0.05, 10.0, 10.0),
				Transparency = 1
			}):Play()
			game:GetService("Debris"):AddItem(ring, 0.4)

			local flash = Instance.new("Part")
			flash.Shape = Enum.PartType.Ball
			flash.Size = Vector3.new(0.5, 0.5, 0.5)
			flash.Material = Enum.Material.Neon
			flash.Color = Color3.fromRGB(255, 255, 255)
			flash.Transparency = 0.3
			flash.Anchored = true
			flash.CanCollide = false
			flash.CanQuery = false
			flash.Position = pos
			flash.Parent = StarsFolder

			game:GetService("TweenService"):Create(flash, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = Vector3.new(4, 4, 4),
				Transparency = 1
			}):Play()
			game:GetService("Debris"):AddItem(flash, 0.3)

			local sparkPart = Instance.new("Part")
			sparkPart.Size = Vector3.new(0.1, 0.1, 0.1)
			sparkPart.Transparency = 1
			sparkPart.Anchored = true
			sparkPart.CanCollide = false
			sparkPart.Position = pos
			sparkPart.Parent = StarsFolder

			local emitter = Instance.new("ParticleEmitter")
			emitter.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, starColor), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 100))})
			emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(0.3, 0.3), NumberSequenceKeypoint.new(1, 0)})
			emitter.Lifetime = NumberRange.new(0.35, 0.8)
			emitter.Speed = NumberRange.new(15, 35)
			emitter.SpreadAngle = Vector2.new(-180, 180)
			emitter.Acceleration = Vector3.new(0, -25, 0)
			emitter.Drag = 2
			emitter.LightEmission = 1.5
			emitter.Parent = sparkPart
			emitter:Emit(35)
			task.delay(1.0, function() pcall(function() sparkPart:Destroy() end) end)

			local glowBurst = Instance.new("ParticleEmitter")
			glowBurst.Color = ColorSequence.new(Color3.fromRGB(255, 230, 180))
			glowBurst.Size = NumberSequence.new(0.8, 0)
			glowBurst.Lifetime = NumberRange.new(0.15, 0.3)
			glowBurst.Speed = NumberRange.new(2, 5)
			glowBurst.SpreadAngle = Vector2.new(-180, 180)
			glowBurst.LightEmission = 2
			glowBurst.Rate = 0
			glowBurst.Parent = sparkPart
			glowBurst:Emit(18)
		end

		local function createStar()
			local lp = game:GetService("Players").LocalPlayer
			local char = lp and lp.Character
			local hrp = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
			local center = hrp and hrp.Position or (workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position or Vector3.new(0, 0, 0))

			if #activeStars >= maxActiveStars then
				local old = table.remove(activeStars, 1)
				if old and old.Instance and old.Instance.Parent then
					old.Instance:Destroy()
				end
			end

			local angle = math.random() * math.pi * 2
			local distance = math.random(20, 100)
			local targetPos = center + Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
			local dynamicDir = Vector3.new(math.cos(tick() * 0.05) * 0.75, -1, math.sin(tick() * 0.05) * 0.75).Unit
			local spawnPos = targetPos - (dynamicDir * 130)

			local star = Instance.new("Part")
			star.Name = "ShootingStar"
			star.Size = Vector3.new(1.8, 1.8, 1.8)
			star.Shape = Enum.PartType.Ball
			star.Color = starColor
			star.Material = Enum.Material.Neon
			star.Anchored = true
			star.CanCollide = false
			star.CanQuery = false
			star.CanTouch = false
			star.CastShadow = false
			star.Position = spawnPos
			star.Parent = StarsFolder

			local starGlow = Instance.new("PointLight")
			starGlow.Color = starColor
			starGlow.Brightness = math.clamp(2 + glowVal * 3, 2, 6)
			starGlow.Range = 12
			starGlow.Shadows = false
			starGlow.Parent = star

			local att0 = Instance.new("Attachment", star)
			att0.Position = Vector3.new(0, 0.9, 0)
			local att1 = Instance.new("Attachment", star)
			att1.Position = Vector3.new(0, -0.9, 0)

			local trail = Instance.new("Trail")
			trail.Attachment0 = att0
			trail.Attachment1 = att1
			trail.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, trailColor), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
			trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.0), NumberSequenceKeypoint.new(0.5, 0.2), NumberSequenceKeypoint.new(1, 0.9)})
			trail.Lifetime = 0.55
			trail.LightEmission = 1.5
			trail.LightInfluence = 0
			trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.6), NumberSequenceKeypoint.new(1, 0)})
			trail.Parent = star

			local dust = Instance.new("ParticleEmitter")
			dust.Color = ColorSequence.new(starColor)
			dust.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0)})
			dust.Lifetime = NumberRange.new(0.2, 0.45)
			dust.Speed = NumberRange.new(0, 3)
			dust.Rate = 25
			dust.LightEmission = 1.0
			dust.Parent = star

			table.insert(activeStars, {
				Instance = star,
				Position = spawnPos,
				Direction = dynamicDir,
				Speed = fallSpeed * (0.85 + math.random() * 0.3),
				SpawnTime = os.clock(),
				Lifetime = 4.5
			})
		end

		local lastSpawn = 0
		local spawnInterval = 0.12

		testWeatherConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			dt = math.min(dt, 0.05)
			lastSpawn = lastSpawn + dt
			if lastSpawn >= spawnInterval then
				lastSpawn = 0
				createStar()
			end

			frameCounter = frameCounter + 1
			local currentClock = os.clock()
			for i = #activeStars, 1, -1 do
				local sData = activeStars[i]
				local star = sData.Instance
				if not star or not star.Parent then
					table.remove(activeStars, i)
					continue
				end

				if currentClock - sData.SpawnTime >= sData.Lifetime then
					star:Destroy()
					table.remove(activeStars, i)
					continue
				end

				local nextPos = sData.Position + (sData.Direction * sData.Speed * dt)
				sData.Position = nextPos
				star.Position = nextPos

				if frameCounter % 2 == 0 then
					local rayResult = workspace:Raycast(sData.Position, sData.Direction * (sData.Speed * dt * 2.5), rayParams)
					if rayResult then
						createImpactExplosion(rayResult.Position, rayResult.Normal)
						star:Destroy()
						table.remove(activeStars, i)
					end
				end
			end
		end)
		return
		
	elseif mode == "Rain" then
		local rainFolder = Instance.new("Folder")
		rainFolder.Name = "RainEffect"
		rainFolder.Parent = testWeatherFolder

		local rainDrops = {}
		local dropParts = {}
		local splashPool = {}
		local splashIndex = 0
		local activeSplashes = {}
		local frameCount = 0

		local CONFIG = {
			RAIN_COUNT = math.max(180, math.min(450, math.floor(countVal * 2.5))),
			RAIN_RADIUS = 140,
			RAIN_HEIGHT = 70,
			FALL_SPEED = math.max(55, speedVal * 4.2),
			WIND_X = 2.5,
			SPEED_VARIANCE = 18,
			SPLASH_POOL = 90,
		}

		local windAngleCF = CFrame.Angles(math.rad(CONFIG.WIND_X * 3), 0, 0)
		local LERP_SPEED = 25

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude

		local function getGroundY(pos)
			local result = workspace:Raycast(pos, Vector3.new(0, -180, 0), rayParams)
			return result and result.Position.Y or (pos.Y - 180)
		end

		local function playSplash(pos)
			splashIndex = (splashIndex % CONFIG.SPLASH_POOL) + 1
			local s = splashPool[splashIndex]
			if not s then return end
			s.Position = Vector3.new(pos.X, pos.Y + 0.05, pos.Z)
			
			local pe = s:FindFirstChildOfClass("ParticleEmitter")
			if pe then
				local randomScale = 0.75 + math.random() * 0.75
				local randomBlur = 0.15 + math.random() * 0.35
				
				pe.Size = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.25),
					NumberSequenceKeypoint.new(0.5, 1.3 * randomScale),
					NumberSequenceKeypoint.new(1, 2.0 * randomScale)
				})
				pe.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, randomBlur),
					NumberSequenceKeypoint.new(0.5, randomBlur + 0.25),
					NumberSequenceKeypoint.new(1, 1.0)
				})
				pe.Rotation = NumberRange.new(0, 360)
				pe:Emit(math.random(1, 2))
			end
		end

		local character = game:GetService("Players").LocalPlayer.Character
		if character then
			local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
			if rootPart then
				local rootPos = rootPart.Position
				rayParams.FilterDescendantsInstances = { character }

				-- Create Splash Pool (Soft Blurred Circle Emitters, 100% Invisible Parts)
				for i = 1, CONFIG.SPLASH_POOL do
					local s = Instance.new("Part")
					s.Size = Vector3.new(0.1, 0.01, 0.1)
					s.Transparency = 1
					s.Anchored = true
					s.CanCollide = false
					s.CanTouch = false
					s.CanQuery = false
					s.CastShadow = false
					s.Parent = rainFolder

					local pe = Instance.new("ParticleEmitter")
					pe.Name = "SplashRipple"
					pe.Texture = "rbxassetid://13470377227" -- Soft radial blur circle
					pe.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
					pe.EmissionDirection = Enum.NormalId.Top
					pe.Rate = 0
					pe.Speed = NumberRange.new(0.2, 0.8)
					pe.Lifetime = NumberRange.new(0.22, 0.42)
					pe.VelocitySpread = 180
					pe.LightEmission = math.clamp(glowVal * 1.2, 0.1, 0.8)
					pe.LightInfluence = math.clamp(1.0 - glowVal, 0.0, 1.0)
					pe.Color = ColorSequence.new(userCol)
					pe.Parent = s
					splashPool[i] = s
				end

				-- Create Rain Drops
				for i = 1, CONFIG.RAIN_COUNT do
					local angle = math.random() * math.pi * 2
					local radius = math.sqrt(math.random()) * CONFIG.RAIN_RADIUS
					local drop = Instance.new("Part")
					local len = 1.8 + math.random() * 1.2
					drop.Size = Vector3.new(0.04, len, 0.04)
					drop.Material = (glowVal > 0.45) and Enum.Material.Neon or Enum.Material.Glass
					drop.Color = userCol
					drop.Transparency = math.clamp(0.4 - (glowVal * 0.3), 0.05, 0.45)
					drop.CanCollide = false
					drop.Anchored = true
					drop.CastShadow = false
					drop.Parent = rainFolder
					dropParts[i] = drop

					local spawnX = rootPos.X + math.cos(angle) * radius
					local spawnY = rootPos.Y + math.random(5, CONFIG.RAIN_HEIGHT)
					local spawnZ = rootPos.Z + math.sin(angle) * radius

					rainDrops[i] = {
						x = spawnX, y = spawnY, z = spawnZ,
						speed = CONFIG.FALL_SPEED + math.random(-CONFIG.SPEED_VARIANCE, CONFIG.SPEED_VARIANCE),
						groundY = spawnY - 100,
						px = spawnX, py = spawnY, pz = spawnZ, len = len
					}
					drop.CFrame = CFrame.new(spawnX, spawnY, spawnZ) * windAngleCF
				end
			end
		end

		testWeatherConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			dt = math.min(dt, 0.04)
			local char = game:GetService("Players").LocalPlayer.Character
			if not char then return end
			local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
			if not rootPart then return end
			local rootPos = rootPart.Position

			-- Update Rain Drops
			for i = 1, #dropParts do
				local d = rainDrops[i]
				local drop = dropParts[i]
				if not d or not drop then continue end

				if i > CONFIG.RAIN_COUNT then
					drop.Transparency = 1
					continue
				end

				if drop.Transparency == 1 then
					drop.Transparency = 0.3 + math.random() * 0.2
					local angle = math.random() * math.pi * 2
					local radius = math.sqrt(math.random()) * CONFIG.RAIN_RADIUS
					d.x = rootPos.X + math.cos(angle) * radius
					d.y = rootPos.Y + CONFIG.RAIN_HEIGHT
					d.z = rootPos.Z + math.sin(angle) * radius
					d.px = d.x; d.py = d.y; d.pz = d.z
					d.groundY = getGroundY(Vector3.new(d.x, d.y, d.z))
					d.len = 1.8 + math.random() * 1.2
				end

				d.x = d.x + CONFIG.WIND_X * dt
				d.y = d.y - d.speed * dt

				local dx = d.x - rootPos.X
				local dy = d.y - rootPos.Y
				local dz = d.z - rootPos.Z

				if dx * dx + dy * dy + dz * dz > 90000 then
					local angle = math.random() * math.pi * 2
					local radius = math.sqrt(math.random()) * CONFIG.RAIN_RADIUS
					d.x = rootPos.X + math.cos(angle) * radius
					d.y = rootPos.Y + CONFIG.RAIN_HEIGHT
					d.z = rootPos.Z + math.sin(angle) * radius
					d.px = d.x; d.py = d.y; d.pz = d.z
					d.groundY = getGroundY(Vector3.new(d.x, d.y, d.z))
					d.len = 1.8 + math.random() * 1.2
				end

				local alpha = math.min(LERP_SPEED * dt, 1)
				d.px = d.px + (d.x - d.px) * alpha
				d.py = d.py + (d.y - d.py) * alpha
				d.pz = d.pz + (d.z - d.pz) * alpha

				if d.y <= d.groundY + 1.1 then
					playSplash(Vector3.new(d.x, d.groundY, d.z))
					local angle = math.random() * math.pi * 2
					local radius = math.sqrt(math.random()) * CONFIG.RAIN_RADIUS
					d.x = rootPos.X + math.cos(angle) * radius
					d.y = rootPos.Y + CONFIG.RAIN_HEIGHT
					d.z = rootPos.Z + math.sin(angle) * radius
					d.px = d.x; d.py = d.y; d.pz = d.z
					d.groundY = getGroundY(Vector3.new(d.x, d.y, d.z))
					d.len = 1.8 + math.random() * 1.2
				end

				drop.Size = Vector3.new(0.04, d.len, 0.04)
				drop.CFrame = CFrame.new(d.px, d.py, d.pz) * windAngleCF
			end
		end)
		return
	end
	
	testWeatherConn = game:GetService("RunService").RenderStepped:Connect(function()
		if not part or not part.Parent then return end
		local currentCam = workspace.CurrentCamera
		if currentCam then
			part.CFrame = CFrame.new(currentCam.CFrame.Position + Vector3.new(0, 18, 0))
		end
	end)
end

local screenGlowGui = nil

local function updatePixelSurfGlow()
	if screenGlowGui then
		pcall(function() screenGlowGui:Destroy() end)
		screenGlowGui = nil
	end
	
	if isUnloaded or not MovementSettings.PixelSurf then return end
	
	local lp = game:GetService("Players").LocalPlayer
	local parentGui = game:GetService("CoreGui")
	if lp and lp:FindFirstChild("PlayerGui") then parentGui = lp.PlayerGui end
	
	screenGlowGui = Instance.new("ScreenGui")
	screenGlowGui.Name = "PixelSurfScreenGlowGui"
	screenGlowGui.ResetOnSpawn = false
	screenGlowGui.IgnoreGuiInset = true
	screenGlowGui.DisplayOrder = 998
	screenGlowGui.Parent = parentGui
	
	local colorMap = {
		["Purple"] = Color3.fromRGB(160, 32, 240),
		["Cyan"]   = Color3.fromRGB(0, 240, 255),
		["Red"]    = Color3.fromRGB(255, 40, 40),
		["Green"]  = Color3.fromRGB(40, 255, 80),
		["Blue"]   = Color3.fromRGB(40, 100, 255),
		["Yellow"] = Color3.fromRGB(255, 220, 30),
		["Pink"]   = Color3.fromRGB(255, 105, 180),
		["Orange"] = Color3.fromRGB(255, 140, 0),
		["White"]  = Color3.fromRGB(255, 255, 255),
	}
	local selectedColor
	if typeof(MovementSettings.PixelSurfGlowColor) == "Color3" then
		selectedColor = MovementSettings.PixelSurfGlowColor
	elseif type(MovementSettings.PixelSurfGlowColor) == "string" and colorMap[MovementSettings.PixelSurfGlowColor] then
		selectedColor = colorMap[MovementSettings.PixelSurfGlowColor]
	else
		selectedColor = Color3.fromRGB(160, 32, 240)
	end
	local intensity = (MovementSettings.PixelSurfGlowIntensity or 65) / 100
	local frameTrans = math.clamp(1 - intensity, 0.05, 0.95)
	
	local glowFrame = Instance.new("Frame")
	glowFrame.Size = UDim2.new(1, 0, 1, 0)
	glowFrame.BackgroundTransparency = 1
	glowFrame.BorderSizePixel = 0
	glowFrame.Parent = screenGlowGui
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = selectedColor
	stroke.Thickness = 6
	stroke.Transparency = frameTrans
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = glowFrame
end

do
	local bhop = MiscMovement:AddLabel('Bunny Hop')
	bhop:ToolTip("Automatically jumps upon touching ground to maintain speed")
	bhop:AddToggle({
		Default = MovementSettings.Bhop or false,
		Flag = "bhop",
		Callback = function(v)
			MovementSettings.Bhop = v
			saveConfig()
		end
	})

	local strafer = MiscMovement:AddLabel('Air Strafer')
	strafer:AddToggle({
		Default = MovementSettings.AirStrafe or false,
		Flag = "airstrafe",
		Callback = function(v)
			MovementSettings.AirStrafe = v
			saveConfig()
		end
	})

	local stOpt = strafer:AddOption()

	stOpt:AddLabel('Mode'):AddDropdown({
		Default = MovementSettings.AirStrafeMode or 'Beta',
		Values = {'Beta', 'WASD Test'},
		Flag = "airstrafe_mode",
		Callback = function(v)
			MovementSettings.AirStrafeMode = v
			saveConfig()
		end
	})

	stOpt:AddLabel('Air Speed'):AddSlider({
		Min = 100,
		Max = 400,
		Default = MovementSettings.AirStrafeSpeed or 100,
		Size = 140,
		Flag = "airstrafe_speed",
		Callback = function(v)
			MovementSettings.AirStrafeSpeed = math.round(v)
			saveConfig()
		end
	})


	local jbug = MiscMovement:AddLabel('Jump Bug')
	jbug:AddToggle({
		Default = MovementSettings.JumpBug or false,
		Flag = "jumpbug",
		Callback = function(v)
			MovementSettings.JumpBug = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	local pixelsurf = MiscMovement:AddLabel('Pixel Surf')
	pixelsurf:AddToggle({
		Default = MovementSettings.PixelSurf or false,
		Flag = "pixelsurf",
		Callback = function(v)
			MovementSettings.PixelSurf = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			updatePixelSurfGlow()
			saveConfig()
		end
	})

	local psOpt = pixelsurf:AddOption()

	psOpt:AddLabel('Pixel Surf Mode'):AddDropdown({
		Default = MovementSettings.PixelSurfMode or 'Easy',
		Values = {'Easy', 'Normal', 'Realistic'},
		Flag = "pixelsurf_mode",
		Callback = function(v)
			MovementSettings.PixelSurfMode = v
			saveConfig()
		end
	})

	psOpt:AddLabel('Glow Color'):AddColorPicker({
		Default = typeof(MovementSettings.PixelSurfGlowColor) == "Color3" and MovementSettings.PixelSurfGlowColor or Color3.fromRGB(168, 85, 247),
		Flag = "pixelsurf_color",
		Callback = function(col)
			MovementSettings.PixelSurfGlowColor = col
			updatePixelSurfGlow()
			saveConfig()
		end
	})

	psOpt:AddLabel('Intensity'):AddSlider({
		Min = 10,
		Max = 100,
		Default = MovementSettings.PixelSurfGlowIntensity or 65,
		Type = "%",
		Size = 140,
		Flag = "pixelsurf_intensity",
		Callback = function(v)
			MovementSettings.PixelSurfGlowIntensity = v
			updatePixelSurfGlow()
			saveConfig()
		end
	})

	psOpt:AddLabel('Follow Camera'):AddToggle({
		Default = MovementSettings.PixelSurfFollowCamera or false,
		Flag = "pixelsurf_follow_cam",
		Callback = function(v)
			MovementSettings.PixelSurfFollowCamera = v
			saveConfig()
		end
	})

	psOpt:AddLabel('Easy NoClip'):AddToggle({
		Default = MovementSettings.PixelSurfEasyNoClip or false,
		Flag = "pixelsurf_noclip",
		Callback = function(v)
			MovementSettings.PixelSurfEasyNoClip = v
			saveConfig()
		end
	})

	local edgebug = MiscMovement:AddLabel('Edge Bug')
	edgebug:ToolTip("Slides off block edges to negate fall damage")
	edgebug:AddToggle({
		Default = MovementSettings.EdgeBug or false,
		Flag = "edgebug",
		Callback = function(v)
			MovementSettings.EdgeBug = v
			saveConfig()
		end
	})

	local autoalign = MiscMovement:AddLabel('Auto Align')
	autoalign:ToolTip("Automatically aligns character body parallel to nearby block/platform edges before jumping for a clean takeoff angle")
	autoalign:AddToggle({
		Default = MovementSettings.AutoAlign or false,
		Flag = "autoalign",
		Callback = function(v)
			MovementSettings.AutoAlign = v
			saveConfig()
		end
	})

	local autoground = MiscMovement:AddLabel('Auto Ground')
	autoground:ToolTip("Auto-crouches on landing to cancel fall animation, resets fall speed on touch, and applies slide boost for maintaining speed when hitting the ground")
	autoground:AddToggle({
		Default = MovementSettings.AutoGround or false,
		Flag = "autoground",
		Callback = function(v)
			MovementSettings.AutoGround = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	local texturebug = MiscMovement:AddLabel('Texture Bug')
	texturebug:ToolTip("Exploits Roblox block collision quirks at part corners and clip-pads to instantly cancel fall speed or bounce off air geometry")
	texturebug:AddToggle({
		Default = MovementSettings.TextureBug or false,
		Flag = "texturebug",
		Callback = function(v)
			MovementSettings.TextureBug = v
			saveConfig()
		end
	})

	local longjump = MiscMovement:AddLabel('Long Jump')
	longjump:AddToggle({
		Default = MovementSettings.LongJump or false,
		Flag = "longjump",
		Callback = function(v)
			MovementSettings.LongJump = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	local ljOpt = longjump:AddOption()

	ljOpt:AddLabel('Boost'):AddSlider({
		Min = 20,
		Max = 150,
		Default = MovementSettings.LongJumpBoost or 50,
		Size = 140,
		Flag = "longjump_boost",
		Callback = function(v)
			MovementSettings.LongJumpBoost = v
			saveConfig()
		end
	})

	ljOpt:AddLabel('Follow Camera'):AddToggle({
		Default = MovementSettings.LongJumpFollowCamera or false,
		Flag = "longjump_follow_cam",
		Callback = function(v)
			MovementSettings.LongJumpFollowCamera = v
			saveConfig()
		end
	})

	local disablekeys = MiscMovement:AddLabel('Disable Movement Keys')
	disablekeys:ToolTip("Disables manual movement key inputs while automated movement functions are active")
	disablekeys:AddToggle({
		Default = MovementSettings.DisableMovementKeys or false,
		Flag = "disable_keys",
		Callback = function(v)
			MovementSettings.DisableMovementKeys = v
			saveConfig()
		end
	})

	local nulls = MiscMovement:AddLabel('Nulls')
	nulls:ToolTip("Prevents stopping when pressing opposing movement keys simultaneously (A+D / W+S)")
	nulls:AddToggle({
		Default = MovementSettings.Nulls or false,
		Flag = "nulls",
		Callback = function(v)
			MovementSettings.Nulls = v
			saveConfig()
		end
	})
end

local stuckCFrame = nil

do
	local airstuck = MiscOther:AddLabel('Air Stuck')
	airstuck:ToolTip("Freezes character position mid-air when enabled")
	airstuck:AddToggle({
		Default = MovementSettings.AirStuck or false,
		Flag = "airstuck",
		Callback = function(v)
			MovementSettings.AirStuck = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			if v and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character then
				local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if root then
					stuckCFrame = root.CFrame
					-- Save current velocity on enable
					if MovementSettings.AirStuckSaveSpeed then
						MovementSettings.AirStuckSavedVelocity = root.AssemblyLinearVelocity
					end
				end
			else
				stuckCFrame = nil
			end
			saveConfig()
		end
	})

	local asOpt = airstuck:AddOption()

	asOpt:AddLabel('Save Speed'):AddToggle({
		Default = MovementSettings.AirStuckSaveSpeed or false,
		Flag = "airstuck_savespeed",
		Callback = function(v)
			MovementSettings.AirStuckSaveSpeed = v
			saveConfig()
		end
	})

	asOpt:AddLabel('God Mode'):AddToggle({
		Default = MovementSettings.AirStuckGodMode or false,
		Flag = "airstuck_godmode",
		Callback = function(v)
			MovementSettings.AirStuckGodMode = v
			saveConfig()
		end
	})

	local airjump = MiscOther:AddLabel('Air Jump')
	airjump:ToolTip("Allows jumping while in mid-air")
	airjump:AddToggle({
		Default = MovementSettings.AirJump or false,
		Flag = "airjump",
		Callback = function(v)
			MovementSettings.AirJump = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	local infjump = MiscOther:AddLabel('Inf Jump')
	infjump:ToolTip("Allows infinite jumping in mid-air")
	infjump:AddToggle({
		Default = MovementSettings.InfJump or false,
		Flag = "infjump",
		Callback = function(v)
			MovementSettings.InfJump = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	local fly = MiscOther:AddLabel('Fly')
	fly:AddToggle({
		Default = MovementSettings.Fly or false,
		Flag = "fly_enabled",
		Callback = function(v)
			MovementSettings.Fly = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	fly:AddOption():AddLabel('Speed'):AddSlider({
		Min = 10,
		Max = 300,
		Default = MovementSettings.FlySpeed or 50,
		Size = 140,
		Flag = "fly_speed",
		Callback = function(v)
			MovementSettings.FlySpeed = v
			saveConfig()
		end
	})

	local speed = MiscOther:AddLabel('Speed')
	speed:AddToggle({
		Default = MovementSettings.Speed or false,
		Flag = "speed_enabled",
		Callback = function(v)
			MovementSettings.Speed = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	speed:AddOption():AddLabel('Speed'):AddSlider({
		Min = 16,
		Max = 500,
		Default = MovementSettings.SpeedValue or 16,
		Size = 140,
		Flag = "speed_value",
		Callback = function(v)
			MovementSettings.SpeedValue = v
			saveConfig()
		end
	})

	local noclip = MiscOther:AddLabel('No Clip')
	noclip:AddToggle({
		Default = MovementSettings.NoClip or false,
		Flag = "noclip",
		Callback = function(v)
			MovementSettings.NoClip = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	local blink = MiscOther:AddLabel('Blink')
	blink:ToolTip("Freezes your position for the server while you move freely as a ghost. On disable — teleports server character to your ghost position")
	blink:AddToggle({
		Default = MovementSettings.Blink or false,
		Flag = "blink_enabled",
		Callback = function(v)
			MovementSettings.Blink = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})

	blink:AddOption():AddLabel('Speed'):AddSlider({
		Min = 10,
		Max = 150,
		Default = MovementSettings.BlinkSpeed or 30,
		Size = 140,
		Flag = "blink_speed",
		Callback = function(v)
			MovementSettings.BlinkSpeed = v
			saveConfig()
		end
	})

	local autobackslide = MiscOther:AddLabel('Auto Backsliding')
	autobackslide:ToolTip("Prevents ascending/floating up on water & surface boundaries and losing speed, automatically backsliding across it with full momentum")
	autobackslide:AddToggle({
		Default = MovementSettings.AutoBacksliding or false,
		Flag = "autobacksliding",
		Callback = function(v)
			MovementSettings.AutoBacksliding = v
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
			saveConfig()
		end
	})
	local checkpoints = MiscOther:AddLabel('Checkpoints')
	checkpoints:ToolTip("Save position slots and teleport back to them instantly or with smooth lerp")
	checkpoints:AddToggle({
		Default = MovementSettings.CheckpointsEnabled or false,
		Flag = "checkpoints_enabled",
		Callback = function(v)
			MovementSettings.CheckpointsEnabled = v
			saveConfig()
		end
	})

	local cpOpt = checkpoints:AddOption()

	cpOpt:AddButton({
		Name = "Save Checkpoint",
		Callback = function()
			if not MovementSettings.CheckpointsEnabled then return end
			pcall(function()
				local lp = game:GetService("Players").LocalPlayer
				local char = lp and lp.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")
				local cam = workspace.CurrentCamera
				if root then
					local slot = MovementSettings.CheckpointSlot or 1
					MovementSettings.CheckpointSlots[slot] = {
						CFrame = root.CFrame,
						Velocity = root.AssemblyLinearVelocity,
						CameraCFrame = cam and cam.CFrame or root.CFrame
					}
					saveConfig()
					Notification.new({
						Title = "Checkpoint",
						Content = "Saved to Slot " .. slot,
						Duration = 1.5
					})
				end
			end)
		end
	})

	cpOpt:AddButton({
		Name = "Load Checkpoint",
		Callback = function()
			if not MovementSettings.CheckpointsEnabled then return end
			pcall(function()
				local lp = game:GetService("Players").LocalPlayer
				local char = lp and lp.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")
				local cam = workspace.CurrentCamera
				local slot = MovementSettings.CheckpointSlot or 1
				local saved = MovementSettings.CheckpointSlots[slot]
				if root and saved then
					if MovementSettings.CheckpointTeleportMode == "Smooth" then
						MovementSettings.CheckpointSmoothActive = true
						MovementSettings.CheckpointSmoothTarget = saved
					else
						root.CFrame = saved.CFrame
						if MovementSettings.CheckpointKeepVelocity and saved.Velocity then
							root.AssemblyLinearVelocity = saved.Velocity
						else
							root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						end
						if MovementSettings.CheckpointKeepAngles and saved.CameraCFrame and cam then
							cam.CFrame = saved.CameraCFrame
						end
						local humanoid = char:FindFirstChildOfClass("Humanoid")
						if humanoid then
							humanoid:ChangeState(Enum.HumanoidStateType.Landed)
						end
					end
					Notification.new({
						Title = "Checkpoint",
						Content = "Loaded Slot " .. slot,
						Duration = 1.5
					})
				end
			end)
		end
	})

	cpOpt:AddButton({
		Name = "Delete Checkpoint",
		Callback = function()
			if not MovementSettings.CheckpointsEnabled then return end
			local slot = MovementSettings.CheckpointSlot or 1
			MovementSettings.CheckpointSlots[slot] = nil
			saveConfig()
			Notification.new({
				Title = "Checkpoint",
				Content = "Deleted Slot " .. slot,
				Duration = 1.5
			})
		end
	})

	cpOpt:AddLabel('Active Slot'):AddDropdown({
		Default = 'Slot ' .. tostring(MovementSettings.CheckpointSlot or 1),
		Values = {'Slot 1', 'Slot 2', 'Slot 3', 'Slot 4', 'Slot 5'},
		Flag = "cp_slot",
		Callback = function(v)
			local n = tonumber(v:match("%d+")) or 1
			MovementSettings.CheckpointSlot = n
			saveConfig()
		end
	})

	cpOpt:AddLabel('Teleport Mode'):AddDropdown({
		Default = MovementSettings.CheckpointTeleportMode or 'Instant',
		Values = {'Instant', 'Smooth'},
		Flag = "cp_mode",
		Callback = function(v)
			MovementSettings.CheckpointTeleportMode = v
			saveConfig()
		end
	})

	cpOpt:AddLabel('Keep Velocity'):AddToggle({
		Default = MovementSettings.CheckpointKeepVelocity ~= false,
		Flag = "cp_keep_vel",
		Callback = function(v)
			MovementSettings.CheckpointKeepVelocity = v
			saveConfig()
		end
	})

	cpOpt:AddLabel('Keep Camera Angles'):AddToggle({
		Default = MovementSettings.CheckpointKeepAngles ~= false,
		Flag = "cp_keep_angles",
		Callback = function(v)
			MovementSettings.CheckpointKeepAngles = v
			saveConfig()
		end
	})
end

do
	-- ESP Preview GUI Creation --
	local espMainFrame = Instance.new("CanvasGroup")
	espMainFrame.Name = "ESPPreviewMainFrame"
	espMainFrame.Size = UDim2.new(0, 220, 0, 420)
	espMainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	espMainFrame.BorderSizePixel = 0
	espMainFrame.GroupTransparency = 1
	espMainFrame.ZIndex = 0
	espMainFrame.Active = true
	pcall(function()
		espMainFrame.Parent = NeverLose.ScreenGui
	end)

	local espSignal = NeverLose:CreateSignal(false)
	pcall(function()
		NeverLose:CreateBlurModule(espMainFrame, espSignal)
	end)

	local isEnemyEspEnabled = false
	local isVisualsTabActive = false
	local isWindowVisible = true
	local espTweenInfo = TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local TweenService = game:GetService("TweenService")
	local isEspTweening = false

	local function getMainFrame()
		if window then
			local candidate = window.Frame or window.Main or window.Window or window.MainFrame or window.Root
			if candidate and candidate:IsA("GuiObject") then
				return candidate
			end
		end
		if NeverLose and NeverLose.ScreenGui then
			for _, child in ipairs(NeverLose.ScreenGui:GetChildren()) do
				if child:IsA("GuiObject") and child.Name ~= "ESPPreviewMainFrame" and child.Name ~= "PurpleGlowEffect" and child.Name ~= "PixelSurfScreenGlowGui" then
					if child:FindFirstChild("TabContainer") or child:FindFirstChild("Sidebar") or child:FindFirstChild("Tabs") then
						return child
					end
				end
			end
			for _, child in ipairs(NeverLose.ScreenGui:GetChildren()) do
				if (child:IsA("Frame") or child:IsA("CanvasGroup")) and child.Name ~= "ESPPreviewMainFrame" and child.Name ~= "PurpleGlowEffect" then
					if child.Size.X.Offset >= 400 and child.Size.Y.Offset >= 300 then
						return child
					end
				end
			end
		end
		return nil
	end

	local function getEspTargetPosition(offsetYShift)
		offsetYShift = offsetYShift or 0
		local targetMain = getMainFrame()
		if targetMain then
			local mainPos = targetMain.Position
			local mainSize = targetMain.AbsoluteSize
			if mainSize.X == 0 or mainSize.Y == 0 then
				mainSize = Vector2.new(targetMain.Size.X.Offset, targetMain.Size.Y.Offset)
			end
			local width = (mainSize.X > 0) and mainSize.X or 640
			local height = (mainSize.Y > 0) and mainSize.Y or 480

			local anchorX = targetMain.AnchorPoint.X
			local anchorY = targetMain.AnchorPoint.Y

			local rightEdgeOffset = mainPos.X.Offset + (width * (1 - anchorX))
			local topEdgeOffset = mainPos.Y.Offset - (height * anchorY)

			return UDim2.new(
				mainPos.X.Scale,
				rightEdgeOffset + 10,
				mainPos.Y.Scale,
				topEdgeOffset + 30 + offsetYShift
			)
		end
		return UDim2.new(0.5, 330, 0.5, -210 + offsetYShift)
	end

	espMainFrame.Position = getEspTargetPosition(15)

	local function updateEspPreviewVisibility()
		local shouldBeVisible = isEnemyEspEnabled and isVisualsTabActive and isWindowVisible
		espSignal:SetValue(shouldBeVisible)
		if shouldBeVisible then
			isEspTweening = true
			local targetPos = getEspTargetPosition(0)
			local tween = TweenService:Create(espMainFrame, espTweenInfo, {
				GroupTransparency = 0,
				Position = targetPos
			})
			tween:Play()
			tween.Completed:Connect(function()
				isEspTweening = false
			end)
		else
			isEspTweening = true
			local hiddenPos = getEspTargetPosition(15)
			local tween = TweenService:Create(espMainFrame, espTweenInfo, {
				GroupTransparency = 1,
				Position = hiddenPos
			})
			tween:Play()
			tween.Completed:Connect(function()
				isEspTweening = false
			end)
		end
	end

	NeverLose:AddSignal(game:GetService("RunService").RenderStepped:Connect(function()
		local shouldBeVisible = isEnemyEspEnabled and isVisualsTabActive and isWindowVisible
		if shouldBeVisible and not isEspTweening then
			espMainFrame.Position = getEspTargetPosition(0)
		end
	end))

	if Visuals and Visuals.Signal then
		Visuals.Signal:Connect(function(val)
			isVisualsTabActive = val
			updateEspPreviewVisibility()
		end)
	end
	if window and window.Signal then
		window.Signal:Connect(function(val)
			isWindowVisible = val
			updateEspPreviewVisibility()
		end)
	end

	local espCorner = Instance.new("UICorner")
	espCorner.CornerRadius = UDim.new(0, 6)
	espCorner.Parent = espMainFrame

	local espTopGear = Instance.new("ImageLabel")
	espTopGear.Size = UDim2.new(0, 14, 0, 14)
	espTopGear.Position = UDim2.new(0, 12, 0, 12)
	espTopGear.BackgroundTransparency = 1
	espTopGear.Image = "rbxassetid://3926307971"
	espTopGear.ImageRectOffset = Vector2.new(324, 124)
	espTopGear.ImageRectSize = Vector2.new(36, 36)
	espTopGear.Parent = espMainFrame

	local espTitle = Instance.new("TextLabel")
	espTitle.Size = UDim2.new(1, -60, 0, 14)
	espTitle.Position = UDim2.new(0, 30, 0, 12)
	espTitle.BackgroundTransparency = 1
	espTitle.Text = "Interactive ESP Preview"
	espTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
	espTitle.Font = Enum.Font.GothamMedium
	espTitle.TextSize = 12
	espTitle.TextXAlignment = Enum.TextXAlignment.Right
	espTitle.Parent = espMainFrame

	local espQuestion = Instance.new("ImageLabel")
	espQuestion.Size = UDim2.new(0, 14, 0, 14)
	espQuestion.Position = UDim2.new(1, -22, 0, 12)
	espQuestion.BackgroundTransparency = 1
	espQuestion.Image = "rbxassetid://3926305904"
	espQuestion.ImageRectOffset = Vector2.new(524, 44)
	espQuestion.ImageRectSize = Vector2.new(36, 36)
	espQuestion.ImageColor3 = Color3.fromRGB(100, 130, 255)
	espQuestion.Parent = espMainFrame

	local espManageBtn = Instance.new("TextButton")
	espManageBtn.Size = UDim2.new(1, 0, 0, 35)
	espManageBtn.Position = UDim2.new(0, 0, 1, -35)
	espManageBtn.BackgroundTransparency = 1
	espManageBtn.Text = ""
	espManageBtn.Parent = espMainFrame

	local espManageLayout = Instance.new("UIListLayout")
	espManageLayout.FillDirection = Enum.FillDirection.Horizontal
	espManageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	espManageLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	espManageLayout.Padding = UDim.new(0, 6)
	espManageLayout.Parent = espManageBtn

	local espManageIcon = Instance.new("ImageLabel")
	espManageIcon.Size = UDim2.new(0, 14, 0, 14)
	espManageIcon.BackgroundTransparency = 1
	espManageIcon.Image = "rbxassetid://3926307971"
	espManageIcon.ImageRectOffset = Vector2.new(324, 124)
	espManageIcon.ImageRectSize = Vector2.new(36, 36)
	espManageIcon.Parent = espManageBtn

	local espManageText = Instance.new("TextLabel")
	espManageText.Size = UDim2.new(0, 110, 0, 14)
	espManageText.BackgroundTransparency = 1
	espManageText.Text = "Manage Elements"
	espManageText.TextColor3 = Color3.fromRGB(200, 200, 200)
	espManageText.Font = Enum.Font.Gotham
	espManageText.TextSize = 12
	espManageText.Parent = espManageBtn

	----------------------------------------------------------------
	-- 3D Interactive Character Viewport System --
	----------------------------------------------------------------
	local viewportContainer = Instance.new("Frame")
	viewportContainer.Name = "CharacterViewportContainer"
	viewportContainer.Size = UDim2.new(1, 0, 1, -70)
	viewportContainer.Position = UDim2.new(0, 0, 0, 35)
	viewportContainer.BackgroundTransparency = 1
	viewportContainer.BorderSizePixel = 0
	viewportContainer.ClipsDescendants = true
	viewportContainer.Parent = espMainFrame

	create3DCharacterViewport(viewportContainer, { camDistance = 11.5, camYaw = math.pi, targetY = 0.3 })

	-- Visuals ENEMY Section --
	local enemyEnabledItem = VisualsEnemy:AddLabel('Enabled')
	enemyEnabledItem:AddToggle({
		Default = false,
		Flag = "enemy_enabled",
		Callback = function(v)
			isEnemyEspEnabled = v
			updateEspPreviewVisibility()
			saveConfig()
		end
	})
end

-- Visuals LOCAL Section --
local ExecutorFakeVisuals = {
    Settings = { Headless = false, Korblox = false },
    State = { isEnabled = false, Connection = nil }
}

function ExecutorFakeVisuals:UpdateSetting(k, v)
    self.Settings[k] = v
    if (self.Settings.Headless or self.Settings.Korblox) and not self.State.isEnabled then
        self:Enable()
    elseif not self.Settings.Headless and not self.Settings.Korblox and self.State.isEnabled then
        self:Disable()
    end
end

function ExecutorFakeVisuals:SetHeadless(v) self:UpdateSetting("Headless", v) end
function ExecutorFakeVisuals:SetKorblox(v) self:UpdateSetting("Korblox", v) end

function ExecutorFakeVisuals:Enable()
    if self.State.isEnabled then return end
    self.State.isEnabled = true
    self.State.Connection = game:GetService("RunService").RenderStepped:Connect(function()
        local char = game:GetService("Players").LocalPlayer.Character
        if not char then return end
        
        -- Headless
        local head = char:FindFirstChild("Head")
        if head then
            if self.Settings.Headless then
                if head.Transparency ~= 1 then head.Transparency = 1 end
                local face = head:FindFirstChildOfClass("Decal")
                if face and face.Transparency ~= 1 then face.Transparency = 1 end
            else
                if head.Transparency ~= 0 then head.Transparency = 0 end
                local face = head:FindFirstChildOfClass("Decal")
                if face and face.Transparency ~= 0 then face.Transparency = 0 end
            end
        end
        
        -- Korblox (Supports R6 & R15)
        local isR15 = char:FindFirstChild("RightUpperLeg") ~= nil
        local rightLegs = {}
        for _, name in ipairs({"Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
            local p = char:FindFirstChild(name)
            if p then table.insert(rightLegs, p) end
        end
        
        if self.Settings.Korblox then
            local mainLeg = rightLegs[1] or rightLegs[2]
            if mainLeg then
                for _, leg in ipairs(rightLegs) do
                    if leg and leg.Transparency ~= 1 then leg.Transparency = 1 end
                end
                
                local fake = mainLeg:FindFirstChild("FakeKorbloxLeg")
                if not fake then
                    fake = Instance.new("Part")
                    fake.Name = "FakeKorbloxLeg"
                    fake.CanCollide = false
                    fake.Massless = true
                    fake.CastShadow = false
                    fake.Size = Vector3.new(0.001, 0.001, 0.001)
                    fake.Transparency = 1
                    fake.Parent = mainLeg
                    
                    local mesh = Instance.new("SpecialMesh")
                    mesh.MeshType = Enum.MeshType.FileMesh
                    mesh.MeshId = "rbxassetid://14331410389"
                    mesh.TextureId = "rbxassetid://14331410470"
                    mesh.Scale = Vector3.new(1, 1, 1)
                    mesh.Parent = fake
                    
                    local weld = Instance.new("Weld")
                    weld.Part0 = mainLeg
                    weld.Part1 = fake
                    if isR15 then
                        weld.C0 = CFrame.new(0, -0.6, 0) * CFrame.Angles(0, math.pi, 0)
                    else
                        weld.C0 = CFrame.new(0, 0.9, 0) * CFrame.Angles(0, math.pi, 0)
                    end
                    weld.Parent = fake
                end
            end
        else
            for _, leg in ipairs(rightLegs) do
                if leg and leg.Transparency ~= 0 then leg.Transparency = 0 end
                if leg then
                    local fake = leg:FindFirstChild("FakeKorbloxLeg")
                    if fake then fake:Destroy() end
                end
            end
        end
    end)
end

function ExecutorFakeVisuals:Disable()
    self.State.isEnabled = false
    if self.State.Connection then 
        self.State.Connection:Disconnect() 
        self.State.Connection = nil
    end
    local char = game:GetService("Players").LocalPlayer.Character
    if char then
        local head = char:FindFirstChild("Head")
        if head then
            head.Transparency = 0
            local face = head:FindFirstChildOfClass("Decal")
            if face then face.Transparency = 0 end
        end
        local rightLegs = {}
        for _, name in ipairs({"Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
            local p = char:FindFirstChild(name)
            if p then table.insert(rightLegs, p) end
        end
        for _, leg in ipairs(rightLegs) do
            if leg then
                leg.Transparency = 0
                local fake = leg:FindFirstChild("FakeKorbloxLeg")
                if fake then fake:Destroy() end
            end
        end
    end
end


-- Visuals OTHER Section --
local thirdpersonItem = VisualsOther:AddLabel('Thirdperson')
thirdpersonItem:AddToggle({
	Default = false,
	Flag = "thirdperson_enabled",
	Callback = function(v)
		saveConfig()
	end
})

local freecam = VisualsOther:AddLabel('Free Cam')
freecam:ToolTip("Detaches your camera and lets you fly it freely. Your character stays frozen for the server.")
freecam:AddToggle({
	Default = MovementSettings.FreeCam or false,
	Flag = "freecam_enabled",
	Callback = function(v)
		MovementSettings.FreeCam = v
		saveConfig()
	end
})

freecam:AddOption():AddLabel('Speed'):AddSlider({
	Min = 5,
	Max = 300,
	Default = MovementSettings.FreeCamSpeed or 40,
	Size = 140,
	Flag = "freecam_speed",
	Callback = function(v)
		MovementSettings.FreeCamSpeed = v
		saveConfig()
	end
})

-- Ambience System & Controller --
local AmbienceState = {
	Enabled = false,
	World = { Enabled = false, Time = 14, Brightness = 2, Exposure = 0 },
	Shadows = { Enabled = false, Indoor = Color3.fromRGB(128, 128, 128), Outdoor = Color3.fromRGB(128, 128, 128) },
	Fog = { Enabled = false, Color = Color3.fromRGB(192, 192, 192), Start = 0, End = 1000 },
	PostProcess = { Enabled = false, Contrast = 0, Brightness = 0, Saturation = 0, Tint = Color3.fromRGB(255, 255, 255) },
	Atmosphere = { Enabled = false, Density = 0.3, Haze = 0, Color = Color3.fromRGB(199, 199, 199) },
	Bloom = { Enabled = false, Intensity = 1, Size = 24, Threshold = 2 },
	DepthOfField = { Enabled = false, FocusDistance = 10, InFocusRadius = 30, NearIntensity = 0.1, FarIntensity = 0.1 }
}

local originalLightingSettings = nil

local function applyAmbience()
	pcall(function()
		local Lighting = game:GetService("Lighting")
		if not AmbienceState.Enabled then
			if originalLightingSettings then
				pcall(function() Lighting.ClockTime = originalLightingSettings.ClockTime end)
				pcall(function() Lighting.Brightness = originalLightingSettings.Brightness end)
				pcall(function() Lighting.ExposureCompensation = originalLightingSettings.ExposureCompensation end)
				pcall(function() Lighting.Ambient = originalLightingSettings.Ambient end)
				pcall(function() Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient end)
				pcall(function() Lighting.FogColor = originalLightingSettings.FogColor end)
				pcall(function() Lighting.FogStart = originalLightingSettings.FogStart end)
				pcall(function() Lighting.FogEnd = originalLightingSettings.FogEnd end)
			end

			local cc = Lighting:FindFirstChild("NeverloseColorCorrection")
			if cc then cc:Destroy() end
			local at = Lighting:FindFirstChild("NeverloseAtmosphere")
			if at then at:Destroy() end
			local bl = Lighting:FindFirstChild("NeverloseBloom")
			if bl then bl:Destroy() end
			local dof = Lighting:FindFirstChild("NeverloseDepthOfField")
			if dof then dof:Destroy() end
			return
		end

		if not originalLightingSettings then
			originalLightingSettings = {
				ClockTime = Lighting.ClockTime,
				Brightness = Lighting.Brightness,
				ExposureCompensation = Lighting.ExposureCompensation,
				Ambient = Lighting.Ambient,
				OutdoorAmbient = Lighting.OutdoorAmbient,
				FogColor = Lighting.FogColor,
				FogStart = Lighting.FogStart,
				FogEnd = Lighting.FogEnd
			}
		end

		-- 1. World --
		if AmbienceState.World and AmbienceState.World.Enabled then
			pcall(function() Lighting.ClockTime = AmbienceState.World.Time end)
			pcall(function() Lighting.Brightness = AmbienceState.World.Brightness end)
			pcall(function() Lighting.ExposureCompensation = AmbienceState.World.Exposure end)
		else
			if originalLightingSettings then
				pcall(function() Lighting.ClockTime = originalLightingSettings.ClockTime end)
				pcall(function() Lighting.Brightness = originalLightingSettings.Brightness end)
				pcall(function() Lighting.ExposureCompensation = originalLightingSettings.ExposureCompensation end)
			end
		end

		-- 2. Shadows --
		if AmbienceState.Shadows and AmbienceState.Shadows.Enabled then
			pcall(function() Lighting.Ambient = AmbienceState.Shadows.Indoor end)
			pcall(function() Lighting.OutdoorAmbient = AmbienceState.Shadows.Outdoor end)
		else
			if originalLightingSettings then
				pcall(function() Lighting.Ambient = originalLightingSettings.Ambient end)
				pcall(function() Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient end)
			end
		end

		-- 3. Fog --
		if AmbienceState.Fog and AmbienceState.Fog.Enabled then
			pcall(function() Lighting.FogColor = AmbienceState.Fog.Color end)
			pcall(function() Lighting.FogStart = AmbienceState.Fog.Start end)
			pcall(function() Lighting.FogEnd = AmbienceState.Fog.End end)
		else
			if originalLightingSettings then
				pcall(function() Lighting.FogColor = originalLightingSettings.FogColor end)
				pcall(function() Lighting.FogStart = originalLightingSettings.FogStart end)
				pcall(function() Lighting.FogEnd = originalLightingSettings.FogEnd end)
			end
		end

		-- 4. PostProcess (ColorCorrectionEffect) --
		if AmbienceState.PostProcess and AmbienceState.PostProcess.Enabled then
			local cc = Lighting:FindFirstChild("NeverloseColorCorrection")
			if not cc then
				cc = Instance.new("ColorCorrectionEffect")
				cc.Name = "NeverloseColorCorrection"
				cc.Parent = Lighting
			end
			cc.Contrast = AmbienceState.PostProcess.Contrast
			cc.Brightness = AmbienceState.PostProcess.Brightness
			cc.Saturation = AmbienceState.PostProcess.Saturation
			cc.TintColor = AmbienceState.PostProcess.Tint
		else
			local cc = Lighting:FindFirstChild("NeverloseColorCorrection")
			if cc then cc:Destroy() end
		end

		-- 5. Atmosphere --
		if AmbienceState.Atmosphere and AmbienceState.Atmosphere.Enabled then
			local at = Lighting:FindFirstChild("NeverloseAtmosphere")
			if not at then
				at = Instance.new("Atmosphere")
				at.Name = "NeverloseAtmosphere"
				at.Parent = Lighting
			end
			at.Density = AmbienceState.Atmosphere.Density
			at.Haze = AmbienceState.Atmosphere.Haze
			at.Color = AmbienceState.Atmosphere.Color
		else
			local at = Lighting:FindFirstChild("NeverloseAtmosphere")
			if at then at:Destroy() end
		end

		-- 6. Bloom --
		if AmbienceState.Bloom and AmbienceState.Bloom.Enabled then
			local bl = Lighting:FindFirstChild("NeverloseBloom")
			if not bl then
				bl = Instance.new("BloomEffect")
				bl.Name = "NeverloseBloom"
				bl.Parent = Lighting
			end
			bl.Intensity = AmbienceState.Bloom.Intensity
			bl.Size = AmbienceState.Bloom.Size
			bl.Threshold = AmbienceState.Bloom.Threshold
		else
			local bl = Lighting:FindFirstChild("NeverloseBloom")
			if bl then bl:Destroy() end
		end

		-- 7. DepthOfField --
		if AmbienceState.DepthOfField and AmbienceState.DepthOfField.Enabled then
			local dof = Lighting:FindFirstChild("NeverloseDepthOfField")
			if not dof then
				dof = Instance.new("DepthOfFieldEffect")
				dof.Name = "NeverloseDepthOfField"
				dof.Parent = Lighting
			end
			dof.FocusDistance = AmbienceState.DepthOfField.FocusDistance
			dof.InFocusRadius = AmbienceState.DepthOfField.InFocusRadius
			dof.NearIntensity = AmbienceState.DepthOfField.NearIntensity
			dof.FarIntensity = AmbienceState.DepthOfField.FarIntensity
		else
			local dof = Lighting:FindFirstChild("NeverloseDepthOfField")
			if dof then dof:Destroy() end
		end
	end)
end

-- Visuals WORLD Section --
local ambienceItem = VisualsWorld:AddLabel('Ambience')
ambienceItem:AddToggle({
	Default = false,
	Flag = "ambience_enabled",
	Callback = function(v)
		AmbienceState.Enabled = v
		applyAmbience()
		saveConfig()
	end
})

local ambienceOpt = ambienceItem:AddOption()

-- World (Мир)
local worldItem = ambienceOpt:AddLabel('World')
worldItem:AddToggle({
	Default = false,
	Flag = "ambience_world_enabled",
	Callback = function(v)
		AmbienceState.World.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local worldOpt = worldItem:AddOption()

worldOpt:AddLabel('Time'):AddSlider({
	Min = 0,
	Max = 24,
	Default = 14,
	Rounding = 1,
	Type = "h",
	Flag = "ambience_world_time",
	Callback = function(v)
		AmbienceState.World.Time = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
worldOpt:AddLabel('Brightness'):AddSlider({
	Min = 0,
	Max = 10,
	Default = 2,
	Rounding = 1,
	Flag = "ambience_world_brightness",
	Callback = function(v)
		AmbienceState.World.Brightness = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
worldOpt:AddLabel('Exposure'):AddSlider({
	Min = -3,
	Max = 3,
	Default = 0,
	Rounding = 1,
	Flag = "ambience_world_exposure",
	Callback = function(v)
		AmbienceState.World.Exposure = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

-- Shadows (Тени)
local shadowsItem = ambienceOpt:AddLabel('Shadows')
shadowsItem:AddToggle({
	Default = false,
	Flag = "ambience_shadows_enabled",
	Callback = function(v)
		AmbienceState.Shadows.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local shadowsOpt = shadowsItem:AddOption()

shadowsOpt:AddLabel('Indoor'):AddColorPicker({
	Default = Color3.fromRGB(128, 128, 128),
	Flag = "ambience_shadows_indoor",
	Callback = function(v)
		AmbienceState.Shadows.Indoor = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
shadowsOpt:AddLabel('Outdoor'):AddColorPicker({
	Default = Color3.fromRGB(128, 128, 128),
	Flag = "ambience_shadows_outdoor",
	Callback = function(v)
		AmbienceState.Shadows.Outdoor = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

-- Fog (Базовый туман)
local fogItem = ambienceOpt:AddLabel('Fog')
fogItem:AddToggle({
	Default = false,
	Flag = "ambience_fog_enabled",
	Callback = function(v)
		AmbienceState.Fog.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local fogOpt = fogItem:AddOption()

fogOpt:AddLabel('Color'):AddColorPicker({
	Default = Color3.fromRGB(192, 192, 192),
	Flag = "ambience_fog_color",
	Callback = function(v)
		AmbienceState.Fog.Color = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
fogOpt:AddLabel('Start'):AddSlider({
	Min = 0,
	Max = 500,
	Default = 0,
	Rounding = 0,
	Flag = "ambience_fog_start",
	Callback = function(v)
		AmbienceState.Fog.Start = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
fogOpt:AddLabel('End'):AddSlider({
	Min = 0,
	Max = 5000,
	Default = 1000,
	Rounding = 0,
	Flag = "ambience_fog_end",
	Callback = function(v)
		AmbienceState.Fog.End = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

-- PostProcess (Обработка изображения)
local postProcessItem = ambienceOpt:AddLabel('PostProcess')
postProcessItem:AddToggle({
	Default = false,
	Flag = "ambience_postprocess_enabled",
	Callback = function(v)
		AmbienceState.PostProcess.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local postProcessOpt = postProcessItem:AddOption()

postProcessOpt:AddLabel('Contrast'):AddSlider({
	Min = -1,
	Max = 1,
	Default = 0,
	Rounding = 2,
	Flag = "ambience_postprocess_contrast",
	Callback = function(v)
		AmbienceState.PostProcess.Contrast = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
postProcessOpt:AddLabel('Brightness'):AddSlider({
	Min = -1,
	Max = 1,
	Default = 0,
	Rounding = 2,
	Flag = "ambience_postprocess_brightness",
	Callback = function(v)
		AmbienceState.PostProcess.Brightness = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
postProcessOpt:AddLabel('Saturation'):AddSlider({
	Min = -1,
	Max = 1,
	Default = 0,
	Rounding = 2,
	Flag = "ambience_postprocess_saturation",
	Callback = function(v)
		AmbienceState.PostProcess.Saturation = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
postProcessOpt:AddLabel('Tint'):AddColorPicker({
	Default = Color3.fromRGB(255, 255, 255),
	Flag = "ambience_postprocess_tint",
	Callback = function(v)
		AmbienceState.PostProcess.Tint = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

-- Atmosphere (Реалистичный туман)
local atmosphereItem = ambienceOpt:AddLabel('Atmosphere')
atmosphereItem:AddToggle({
	Default = false,
	Flag = "ambience_atmosphere_enabled",
	Callback = function(v)
		AmbienceState.Atmosphere.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local atmosphereOpt = atmosphereItem:AddOption()

atmosphereOpt:AddLabel('Density'):AddSlider({
	Min = 0,
	Max = 1,
	Default = 0.3,
	Rounding = 2,
	Flag = "ambience_atmosphere_density",
	Callback = function(v)
		AmbienceState.Atmosphere.Density = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
atmosphereOpt:AddLabel('Haze'):AddSlider({
	Min = 0,
	Max = 10,
	Default = 0,
	Rounding = 1,
	Flag = "ambience_atmosphere_haze",
	Callback = function(v)
		AmbienceState.Atmosphere.Haze = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
atmosphereOpt:AddLabel('Color'):AddColorPicker({
	Default = Color3.fromRGB(199, 199, 199),
	Flag = "ambience_atmosphere_color",
	Callback = function(v)
		AmbienceState.Atmosphere.Color = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

-- Bloom (Свечение)
local bloomItem = ambienceOpt:AddLabel('Bloom')
bloomItem:AddToggle({
	Default = false,
	Flag = "ambience_bloom_enabled",
	Callback = function(v)
		AmbienceState.Bloom.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local bloomOpt = bloomItem:AddOption()

bloomOpt:AddLabel('Intensity'):AddSlider({
	Min = 0,
	Max = 5,
	Default = 1,
	Rounding = 1,
	Flag = "ambience_bloom_intensity",
	Callback = function(v)
		AmbienceState.Bloom.Intensity = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
bloomOpt:AddLabel('Size'):AddSlider({
	Min = 0,
	Max = 56,
	Default = 24,
	Rounding = 0,
	Flag = "ambience_bloom_size",
	Callback = function(v)
		AmbienceState.Bloom.Size = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
bloomOpt:AddLabel('Threshold'):AddSlider({
	Min = 0,
	Max = 5,
	Default = 2,
	Rounding = 1,
	Flag = "ambience_bloom_threshold",
	Callback = function(v)
		AmbienceState.Bloom.Threshold = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

-- DepthOfField (Глубина резкости)
local dofItem = ambienceOpt:AddLabel('DepthOfField')
dofItem:AddToggle({
	Default = false,
	Flag = "ambience_dof_enabled",
	Callback = function(v)
		AmbienceState.DepthOfField.Enabled = v
		if AmbienceState.Enabled then applyAmbience() end
		saveConfig()
	end
})
local dofOpt = dofItem:AddOption()

dofOpt:AddLabel('Focus Distance'):AddSlider({
	Min = 0,
	Max = 100,
	Default = 10,
	Rounding = 0,
	Flag = "ambience_dof_focus_distance",
	Callback = function(v)
		AmbienceState.DepthOfField.FocusDistance = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
dofOpt:AddLabel('In Focus Radius'):AddSlider({
	Min = 0,
	Max = 100,
	Default = 30,
	Rounding = 0,
	Flag = "ambience_dof_infocus_radius",
	Callback = function(v)
		AmbienceState.DepthOfField.InFocusRadius = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
dofOpt:AddLabel('Near Intensity'):AddSlider({
	Min = 0,
	Max = 1,
	Default = 0.1,
	Rounding = 2,
	Flag = "ambience_dof_near_intensity",
	Callback = function(v)
		AmbienceState.DepthOfField.NearIntensity = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})
dofOpt:AddLabel('Far Intensity'):AddSlider({
	Min = 0,
	Max = 1,
	Default = 0.1,
	Rounding = 2,
	Flag = "ambience_dof_far_intensity",
	Callback = function(v)
		AmbienceState.DepthOfField.FarIntensity = v
		if AmbienceState.Enabled then applyAmbience() end
	end
})

local windowsItem = VisualsWorld:AddLabel('Windows')
windowsItem:AddToggle({
	Default = MovementSettings.WindowsEnabled ~= false,
	Flag = "windows_enabled",
	Callback = function(v)
		MovementSettings.WindowsEnabled = v
		if typeof(updateWatermarkDisplay) == "function" then
			pcall(updateWatermarkDisplay)
		end
		if typeof(updateKeybindsDisplay) == "function" then
			pcall(updateKeybindsDisplay)
		end
		saveConfig()
	end
})

local windowsOpt = windowsItem:AddOption()

windowsOpt:AddLabel('Watermark'):AddToggle({
	Default = MovementSettings.WatermarkEnabled ~= false,
	Flag = "watermark_enabled",
	Callback = function(v)
		MovementSettings.WatermarkEnabled = v
		if typeof(updateWatermarkDisplay) == "function" then
			pcall(updateWatermarkDisplay)
		end
		saveConfig()
	end
})

local keybindsLabel = windowsOpt:AddLabel('KeyBinds')
keybindsLabel:AddToggle({
	Default = MovementSettings.KeybindsEnabled ~= false,
	Flag = "keybind_list_enabled",
	Callback = function(v)
		MovementSettings.KeybindsEnabled = v
		if typeof(updateKeybindsDisplay) == "function" then
			pcall(updateKeybindsDisplay)
		end
		saveConfig()
	end
})

local keybindsOpt = keybindsLabel:AddOption()

local indicatorOptionsMap = {
	["Air Stuck (AS)"] = "airstuck",
	["Jump Bug (JB)"] = "jumpbug",
	["Edge Bug (EB)"] = "edgebug",
	["Auto Align (AA)"] = "autoalign",
	["Auto Ground (AG)"] = "autoground",
	["Texture Bug (TB)"] = "texturebug",
	["No Clip (NC)"] = "noclip",
	["Blink (BL)"] = "blink_enabled",
	["Revive (RV)"] = "self_revive_enabled",
}

local defaultSelectedIndicators = {}
for name, flag in pairs(indicatorOptionsMap) do
	local isAllowed = (MovementSettings.IndicatorVisibility and MovementSettings.IndicatorVisibility[flag] ~= false)
	defaultSelectedIndicators[name] = isAllowed
end

keybindsOpt:AddLabel('Indicators'):AddDropdown({
	Default = defaultSelectedIndicators,
	Multi = true,
	Values = {
		"Air Stuck (AS)",
		"Jump Bug (JB)",
		"Edge Bug (EB)",
		"Auto Align (AA)",
		"Auto Ground (AG)",
		"Texture Bug (TB)",
		"No Clip (NC)",
		"Blink (BL)",
		"Revive (RV)"
	},
	Flag = "keybind_indicators_multiselect",
	Callback = function(selectedDict)
		if not MovementSettings.IndicatorVisibility then
			MovementSettings.IndicatorVisibility = {}
		end
		for name, flag in pairs(indicatorOptionsMap) do
			if typeof(selectedDict) == "table" then
				if selectedDict[name] ~= nil then
					MovementSettings.IndicatorVisibility[flag] = (selectedDict[name] == true)
				end
			end
		end
		if typeof(updateKeybindsDisplay) == "function" then
			pcall(updateKeybindsDisplay)
		end
		saveConfig()
	end
})

keybindsOpt:AddLabel('Mode'):AddDropdown({
	Default = MovementSettings.KeybindsMode or 'Default',
	Values = {'Default', 'Movement', 'Both'},
	Flag = "keybind_list_mode",
	Callback = function(v)
		MovementSettings.KeybindsMode = v
		if typeof(updateKeybindsDisplay) == "function" then
			pcall(updateKeybindsDisplay)
		end
		saveConfig()
	end
})

local particlesItem = VisualsWorld:AddLabel('Particles')
particlesItem:ToolTip("Combined particle visual effects (Trails, Orbit, Aura Pulse, Paradox Engine, RGB Circle)")
particlesItem:AddToggle({
	Default = ParticlesSettings.Enabled or false,
	Flag = "particles_enabled",
	Callback = function(v)
		ParticlesSettings.Enabled = v
		updateParticles(true)
		saveConfig()
	end
})

local particlesOpt = particlesItem:AddOption()

local trailModeLabel = nil
local trailStyle3DLabel = nil
local trailStyle2DLabel = nil
local trailColorLabel = nil

local function updateTrailsUIVisibility()
	local isTrails = (ParticlesSettings.Mode or "Trails") == "Trails"
	local currentTrailMode = ParticlesSettings.TrailMode or "3D"

	local function setVis(lbl, vis)
		if lbl then
			pcall(function()
				if lbl.SetVisible then
					lbl:SetVisible(vis)
				elseif lbl.Root then
					lbl.Root.Visible = vis
				end
			end)
		end
	end

	setVis(trailModeLabel, isTrails)
	setVis(trailStyle3DLabel, isTrails and (currentTrailMode == "3D"))
	setVis(trailStyle2DLabel, isTrails and (currentTrailMode == "2D"))
	setVis(trailColorLabel, isTrails)
end

particlesOpt:AddLabel('Effect'):AddDropdown({
	Default = ParticlesSettings.Mode or 'Trails',
	Values = {'Trails', 'Orbit', 'Aura Pulse', 'Paradox Engine', 'RGB Circle'},
	Flag = "particles_mode",
	Callback = function(v)
		if ParticlesSettings.Mode == v then return end
		ParticlesSettings.Mode = v
		updateTrailsUIVisibility()
		if ParticlesSettings.Enabled then
			updateParticles(true)
		end
		saveConfig()
	end
})

trailModeLabel = particlesOpt:AddLabel('Mode')
trailModeLabel:AddDropdown({
	Default = ParticlesSettings.TrailMode or '3D',
	Values = {'3D', '2D'},
	Flag = "particles_trail_mode",
	Callback = function(v)
		if ParticlesSettings.TrailMode == v then return end
		ParticlesSettings.TrailMode = v
		updateTrailsUIVisibility()
		if ParticlesSettings.Enabled and ParticlesSettings.Mode == "Trails" then
			updateParticles(true)
		end
		saveConfig()
	end
})

trailStyle3DLabel = particlesOpt:AddLabel('Style (3D)')
trailStyle3DLabel:AddDropdown({
	Default = ParticlesSettings.TrailStyle3D or 'Default',
	Values = {'Default', 'Neon', 'Minecraft', 'Test'},
	Flag = "particles_trail_style_3d",
	Callback = function(v)
		if ParticlesSettings.TrailStyle3D == v then return end
		ParticlesSettings.TrailStyle3D = v
		if ParticlesSettings.Enabled and ParticlesSettings.Mode == "Trails" and ParticlesSettings.TrailMode == "3D" then
			updateParticles(true)
		end
		saveConfig()
	end
})

trailStyle2DLabel = particlesOpt:AddLabel('Style (2D)')
trailStyle2DLabel:AddDropdown({
	Default = ParticlesSettings.TrailStyle2D or 'Default',
	Values = {'Default', 'Smoke'},
	Flag = "particles_trail_style_2d",
	Callback = function(v)
		if ParticlesSettings.TrailStyle2D == v then return end
		ParticlesSettings.TrailStyle2D = v
		if ParticlesSettings.Enabled and ParticlesSettings.Mode == "Trails" and ParticlesSettings.TrailMode == "2D" then
			updateParticles(true)
		end
		saveConfig()
	end
})

trailColorLabel = particlesOpt:AddLabel('Color'):AddColorPicker({
	Default = ParticlesSettings.TrailColor or Color3.fromRGB(0, 255, 255),
	Flag = "particles_trail_color",
	Callback = function(col)
		ParticlesSettings.TrailColor = col
		if ParticlesSettings.Enabled and ParticlesSettings.Mode == "Trails" then
			updateParticles(true)
		end
		saveConfig()
	end
})

pcall(updateTrailsUIVisibility)

local worldEffectItem = VisualsWorld:AddLabel('World Effect')
worldEffectItem:ToolTip("Realistic atmospheric snow and weather particle effects with glow, density count and fall speed controls")
worldEffectItem:AddToggle({
	Default = TestSettings.Enabled or TestSettings.TestEnabled or false,
	Flag = "test_enabled",
	Callback = function(v)
		TestSettings.Enabled = v
		TestSettings.TestEnabled = v
		updateTestWeather(true)
		saveConfig()
	end
})

local testOpt = worldEffectItem:AddOption()

testOpt:AddLabel('Effect'):AddDropdown({
	Default = TestSettings.Mode or 'Snow',
	Values = {'Snow', 'Arh', 'Rain', 'Stars'},
	Flag = "test_mode",
	Callback = function(v)
		if TestSettings.Mode == v then return end
		TestSettings.Mode = v
		if TestSettings.Enabled or TestSettings.TestEnabled then
			updateTestWeather(true)
		end
		saveConfig()
	end
})

testOpt:AddLabel('Glow'):AddSlider({
	Min = 0,
	Max = 100,
	Default = TestSettings.Glow or 0,
	Type = "%",
	Size = 140,
	Flag = "snow_glow",
	Callback = function(v)
		if TestSettings.Glow == v then return end
		TestSettings.Glow = v
		if TestSettings.Enabled or TestSettings.TestEnabled then
			updateTestWeather(true)
		end
		saveConfig()
	end
})

testOpt:AddLabel('Count'):AddSlider({
	Min = 20,
	Max = 500,
	Default = TestSettings.Count or 150,
	Size = 140,
	Flag = "snow_count",
	Callback = function(v)
		if TestSettings.Count == v then return end
		TestSettings.Count = v
		if TestSettings.Enabled or TestSettings.TestEnabled then
			updateTestWeather(true)
		end
		saveConfig()
	end
})

testOpt:AddLabel('Speed'):AddSlider({
	Min = 5,
	Max = 100,
	Default = TestSettings.Speed or 20,
	Size = 140,
	Flag = "snow_speed",
	Callback = function(v)
		if TestSettings.Speed == v then return end
		TestSettings.Speed = v
		if TestSettings.Enabled or TestSettings.TestEnabled then
			updateTestWeather(true)
		end
		saveConfig()
	end
})

testOpt:AddLabel('Color'):AddColorPicker({
	Default = TestSettings.Color or Color3.fromRGB(255, 255, 255),
	Flag = "snow_color",
	Callback = function(col)
		TestSettings.Color = col
		if TestSettings.Enabled or TestSettings.TestEnabled then
			updateTestWeather(true)
		end
		saveConfig()
	end
})

---------------------------------------------------------
-- BINDING MODULE SYSTEM (RMB Context Menu & Keybind Manager) --
---------------------------------------------------------
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local ModuleBinds = {}
local RegisteredModules = {}
local FlagToSettingKey = {
	["bhop"] = "Bhop",
	["airstrafe"] = "AirStrafe",
	["speed_enabled"] = "Speed",
	["jumpbug"] = "JumpBug",
	["pixelsurf"] = "PixelSurf",
	["edgebug"] = "EdgeBug",
	["autoalign"] = "AutoAlign",
	["autoground"] = "AutoGround",
	["texturebug"] = "TextureBug",
	["longjump"] = "LongJump",
	["disable_keys"] = "DisableMovementKeys",
	["nulls"] = "Nulls",
	["airstuck"] = "AirStuck",
	["infjump"] = "InfJump",
	["fly_enabled"] = "Fly",
	["freecam_enabled"] = "FreeCam",
	["noclip"] = "NoClip",
	["blink_enabled"] = "Blink",
	["self_revive_enabled"] = "Revive",
	["particles_enabled"] = "ParticlesEnabled",
	["test_enabled"] = "TestEnabled",
}

local bindGui = Instance.new("ScreenGui")
bindGui.Name = "ModuleBindingSystem"
bindGui.ResetOnSpawn = false
bindGui.IgnoreGuiInset = true
bindGui.DisplayOrder = 9999

pcall(function()
	bindGui.Parent = CoreGui
end)
if not bindGui.Parent then
	pcall(function()
		bindGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	end)
end

-- Context Menu Frame --
local bindFrame = Instance.new("Frame")
bindFrame.Name = "BindFrame"
bindFrame.Size = UDim2.new(0, 210, 0, 144)
bindFrame.Position = UDim2.new(0.5, -105, 0.4, -72)
bindFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
bindFrame.BackgroundTransparency = 0.035
bindFrame.BorderSizePixel = 0
bindFrame.Visible = false
bindFrame.ClipsDescendants = true
bindFrame.Parent = bindGui

local bindCorner = Instance.new("UICorner")
bindCorner.CornerRadius = UDim.new(0, 10)
bindCorner.Parent = bindFrame

local bindStroke = Instance.new("UIStroke")
bindStroke.Color = Color3.fromRGB(45, 48, 58)
bindStroke.Transparency = 0.65
bindStroke.Thickness = 1
bindStroke.Parent = bindFrame

-- Row 1: Key --
local keyRow = Instance.new("Frame")
keyRow.Size = UDim2.new(1, -28, 0, 24)
keyRow.Position = UDim2.new(0, 14, 0, 10)
keyRow.BackgroundTransparency = 1
keyRow.Parent = bindFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(0, 90, 1, 0)
keyTitle.Position = UDim2.new(0, 0, 0, 0)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Key"
keyTitle.TextColor3 = Color3.fromRGB(220, 225, 240)
keyTitle.TextSize = 12
keyTitle.Font = Enum.Font.GothamMedium
keyTitle.TextXAlignment = Enum.TextXAlignment.Left
keyTitle.Parent = keyRow

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(0, 80, 0, 22)
keyButton.Position = UDim2.new(1, -80, 0, 1)
keyButton.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
keyButton.BorderSizePixel = 0
keyButton.Text = "N/A"
keyButton.TextColor3 = Color3.fromRGB(240, 245, 255)
keyButton.TextSize = 11
keyButton.Font = Enum.Font.GothamMedium
keyButton.Parent = keyRow

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.CornerRadius = UDim.new(0, 4)
keyBtnCorner.Parent = keyButton

local keyBtnStroke = Instance.new("UIStroke")
keyBtnStroke.Color = Color3.fromRGB(45, 48, 58)
keyBtnStroke.Thickness = 1
keyBtnStroke.Parent = keyButton

-- Row 2: Mode --
local modeRow = Instance.new("Frame")
modeRow.Size = UDim2.new(1, -28, 0, 24)
modeRow.Position = UDim2.new(0, 14, 0, 38)
modeRow.BackgroundTransparency = 1
modeRow.Parent = bindFrame

local modeTitle = Instance.new("TextLabel")
modeTitle.Size = UDim2.new(0, 90, 1, 0)
modeTitle.Position = UDim2.new(0, 0, 0, 0)
modeTitle.BackgroundTransparency = 1
modeTitle.Text = "Mode"
modeTitle.TextColor3 = Color3.fromRGB(220, 225, 240)
modeTitle.TextSize = 12
modeTitle.Font = Enum.Font.GothamMedium
modeTitle.TextXAlignment = Enum.TextXAlignment.Left
modeTitle.Parent = modeRow

local modeDropdownBtn = Instance.new("TextButton")
modeDropdownBtn.Size = UDim2.new(0, 80, 0, 22)
modeDropdownBtn.Position = UDim2.new(1, -80, 0, 1)
modeDropdownBtn.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
modeDropdownBtn.BorderSizePixel = 0
modeDropdownBtn.Text = "Toggle ˅"
modeDropdownBtn.TextColor3 = Color3.fromRGB(200, 205, 220)
modeDropdownBtn.TextSize = 11
modeDropdownBtn.Font = Enum.Font.GothamMedium
modeDropdownBtn.Parent = modeRow

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 4)
modeCorner.Parent = modeDropdownBtn

local modeStroke = Instance.new("UIStroke")
modeStroke.Color = Color3.fromRGB(45, 48, 58)
modeStroke.Thickness = 1
modeStroke.Parent = modeDropdownBtn

modeDropdownBtn.MouseEnter:Connect(function()
	modeStroke.Color = Color3.fromRGB(78, 127, 252)
end)
modeDropdownBtn.MouseLeave:Connect(function()
	modeStroke.Color = Color3.fromRGB(45, 48, 58)
end)

-- Separator 1 --
local sepLine1 = Instance.new("Frame")
sepLine1.Size = UDim2.new(1, -28, 0, 1)
sepLine1.Position = UDim2.new(0, 14, 0, 68)
sepLine1.BackgroundColor3 = Color3.fromRGB(35, 38, 48)
sepLine1.BackgroundTransparency = 0.3
sepLine1.BorderSizePixel = 0
sepLine1.Parent = bindFrame

-- Row 3: Visible --
local visibleRow = Instance.new("Frame")
visibleRow.Size = UDim2.new(1, -28, 0, 24)
visibleRow.Position = UDim2.new(0, 14, 0, 76)
visibleRow.BackgroundTransparency = 1
visibleRow.Parent = bindFrame

local visibleTitle = Instance.new("TextLabel")
visibleTitle.Size = UDim2.new(0, 90, 1, 0)
visibleTitle.Position = UDim2.new(0, 0, 0, 0)
visibleTitle.BackgroundTransparency = 1
visibleTitle.Text = "Visible"
visibleTitle.TextColor3 = Color3.fromRGB(220, 225, 240)
visibleTitle.TextSize = 12
visibleTitle.Font = Enum.Font.GothamMedium
visibleTitle.TextXAlignment = Enum.TextXAlignment.Left
visibleTitle.Parent = visibleRow

local visibleToggleFrame = Instance.new("TextButton")
visibleToggleFrame.Size = UDim2.new(0, 30, 0, 18)
visibleToggleFrame.Position = UDim2.new(1, -30, 0, 3)
visibleToggleFrame.BackgroundColor3 = Color3.fromRGB(78, 127, 252)
visibleToggleFrame.BorderSizePixel = 0
visibleToggleFrame.Text = ""
visibleToggleFrame.Parent = visibleRow

local visCorner = Instance.new("UICorner")
visCorner.CornerRadius = UDim.new(1, 0)
visCorner.Parent = visibleToggleFrame

local visibleKnob = Instance.new("Frame")
visibleKnob.AnchorPoint = Vector2.new(0.5, 0.5)
visibleKnob.Size = UDim2.new(0, 14, 0, 14)
visibleKnob.Position = UDim2.new(0.7, 0, 0.5, 0)
visibleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
visibleKnob.BorderSizePixel = 0
visibleKnob.Parent = visibleToggleFrame

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = visibleKnob

-- Separator 2 --
local sepLine2 = Instance.new("Frame")
sepLine2.Size = UDim2.new(1, -28, 0, 1)
sepLine2.Position = UDim2.new(0, 14, 0, 106)
sepLine2.BackgroundColor3 = Color3.fromRGB(35, 38, 48)
sepLine2.BackgroundTransparency = 0.3
sepLine2.BorderSizePixel = 0
sepLine2.Parent = bindFrame

-- Row 4: Delete Hotkey --
local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(1, -28, 0, 22)
deleteBtn.Position = UDim2.new(0, 14, 0, 114)
deleteBtn.BackgroundTransparency = 1
deleteBtn.Text = "Delete hotkey"
deleteBtn.TextColor3 = Color3.fromRGB(240, 80, 80)
deleteBtn.TextSize = 11
deleteBtn.Font = Enum.Font.GothamSemibold
deleteBtn.TextXAlignment = Enum.TextXAlignment.Left
deleteBtn.Parent = bindFrame

deleteBtn.MouseEnter:Connect(function()
	deleteBtn.TextColor3 = Color3.fromRGB(255, 110, 110)
end)
deleteBtn.MouseLeave:Connect(function()
	deleteBtn.TextColor3 = Color3.fromRGB(240, 80, 80)
end)

-- Bind State & Mouse Hover Management --
local currentBindingFlag = nil
local listeningForKey = false
local ignoreInitialClick = false
local isMouseOverBindFrame = false

bindFrame.MouseEnter:Connect(function()
	isMouseOverBindFrame = true
end)

bindFrame.MouseLeave:Connect(function()
	isMouseOverBindFrame = false
end)

local function updateModeButtons(mode)
	if mode == "HOLD" then
		modeDropdownBtn.Text = "Hold ˅"
	else
		modeDropdownBtn.Text = "Toggle ˅"
	end
end

local function updateVisibleToggle(isVis)
	if isVis then
		visibleToggleFrame.BackgroundColor3 = Color3.fromRGB(78, 127, 252)
		visibleKnob.Position = UDim2.new(0.7, 0, 0.5, 0)
		visibleKnob.BackgroundTransparency = 0
	else
		visibleToggleFrame.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
		visibleKnob.Position = UDim2.new(0.3, 0, 0.5, 0)
		visibleKnob.BackgroundTransparency = 0.5
	end
end

local function formatKeyName(key)
	if not key then return "N/A" end
	local name = (typeof(key) == "EnumItem" and key.Name or tostring(key))
	if name == "MouseButton1" or name == "MouseButton2" then
		return "N/A"
	elseif name == "MouseButton3" then return "MOUSE3"
	end
	return name
end

local function isMouse3Down()
	local UIS = game:GetService("UserInputService")
	local ok, res = pcall(function() return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton3) end)
	if ok and res then return true end
	return false
end

local function isMouse4Down()
	local UIS = game:GetService("UserInputService")
	local ok, res = pcall(function() return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton4) end)
	if ok and res then return true end
	return false
end

local function isMouse5Down()
	local UIS = game:GetService("UserInputService")
	local ok, res = pcall(function() return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton5) end)
	if ok and res then return true end
	return false
end

local function isKeyMatch(input, bindKey)
	if not bindKey or not input then return false end
	local keyName = typeof(bindKey) == "EnumItem" and bindKey.Name or tostring(bindKey)

	if keyName == "M3B" or keyName == "MouseButton3" then
		return isMouse3Down()
	elseif keyName == "MouseButton4" then
		return isMouse4Down()
	elseif keyName == "MouseButton5" then
		return isMouse5Down()
	end
	
	if typeof(bindKey) == "EnumItem" then
		if bindKey.EnumType == Enum.KeyCode and input.KeyCode == bindKey then
			return true
		elseif bindKey.EnumType == Enum.UserInputType and input.UserInputType == bindKey then
			return true
		end
	end
	
	local inputTypeName = pcall(function() return input.UserInputType.Name end) and input.UserInputType.Name or ""
	local keyCodeName = pcall(function() return input.KeyCode.Name end) and input.KeyCode.Name or ""
	
	if keyName == inputTypeName or keyName == keyCodeName then
		return true
	end
	
	return false
end

local function openBindMenu(moduleName, flag, callback)
	currentBindingFlag = flag
	listeningForKey = false
	isMouseOverBindFrame = true
	
	keyButton.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	keyBtnStroke.Color = Color3.fromRGB(45, 48, 58)
	keyButton.TextColor3 = Color3.fromRGB(240, 245, 255)
	
	if not ModuleBinds[flag] then
		ModuleBinds[flag] = { Key = nil, Mode = "TOGGLE", Callback = callback, State = false }
	else
		if callback then ModuleBinds[flag].Callback = callback end
	end
	
	local bindData = ModuleBinds[flag]
	keyButton.Text = formatKeyName(bindData.Key)
	updateModeButtons(bindData.Mode)
	
	local indicatorVis = MovementSettings.IndicatorVisibility or {}
	local isVis = indicatorVis[flag] ~= false
	updateVisibleToggle(isVis)
	
	local mousePos = UserInputService:GetMouseLocation()
	local cam = workspace.CurrentCamera
	local maxX = cam and cam.ViewportSize.X or 1000
	local maxY = cam and cam.ViewportSize.Y or 800
	
	bindFrame.Position = UDim2.new(0, math.min(mousePos.X, maxX - 215), 0, math.min(mousePos.Y, maxY - 150))
	bindFrame.Visible = true
end

local bindSavePath = "NeverLoseConfigs/Binds.json"
local HttpService = game:GetService("HttpService")

local function SaveModuleBinds()
	local toSave = {}
	for flag, data in pairs(ModuleBinds) do
		local keyName = nil
		local keyType = nil
		if data.Key then
			if typeof(data.Key) == "EnumItem" then
				keyName = data.Key.Name
				keyType = tostring(data.Key.EnumType)
			else
				keyName = tostring(data.Key)
				keyType = "String"
			end
		end
		toSave[flag] = {
			Key = keyName,
			KeyType = keyType,
			Mode = data.Mode
		}
	end
	pcall(function()
		if makefolder and isfolder and not isfolder("NeverLoseConfigs") then
			makefolder("NeverLoseConfigs")
		end
		if writefile then
			writefile(bindSavePath, HttpService:JSONEncode(toSave))
		end
	end)
end

local function LoadModuleBinds()
	pcall(function()
		if isfile and readfile and isfile(bindSavePath) then
			local content = readfile(bindSavePath)
			local decoded = HttpService:JSONDecode(content)
			if type(decoded) == "table" then
				for flag, savedData in pairs(decoded) do
					if not ModuleBinds[flag] then
						ModuleBinds[flag] = { Key = nil, Mode = "TOGGLE", Callback = nil, State = false }
					end
					if savedData.Key then
						if savedData.Key == "MouseButton1" or savedData.Key == "MouseButton2" then
							ModuleBinds[flag].Key = nil
						elseif savedData.KeyType == tostring(Enum.KeyCode) then
							pcall(function() ModuleBinds[flag].Key = Enum.KeyCode[savedData.Key] end)
						elseif savedData.KeyType == tostring(Enum.UserInputType) then
							local ok, val = pcall(function() return Enum.UserInputType[savedData.Key] end)
							if ok and val then
								ModuleBinds[flag].Key = val
							else
								ModuleBinds[flag].Key = savedData.Key
							end
						else
							ModuleBinds[flag].Key = savedData.Key
						end
					end
					if savedData.Mode then
						ModuleBinds[flag].Mode = savedData.Mode
					end
				end
			end
		end
	end)
end

local function registerModule(name, flag, toggleCallback)
	RegisteredModules[flag] = { Name = name, Callback = toggleCallback }
	if not ModuleBinds[flag] then
		ModuleBinds[flag] = { Key = nil, Mode = "TOGGLE", Callback = toggleCallback, State = false }
	else
		ModuleBinds[flag].Callback = toggleCallback
	end
end

deleteBtn.MouseButton1Click:Connect(function()
	if currentBindingFlag and ModuleBinds[currentBindingFlag] then
		ModuleBinds[currentBindingFlag].Key = nil
		SaveModuleBinds()
		keyButton.Text = "N/A"
		listeningForKey = false
		keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
		keyButton.TextColor3 = Color3.fromRGB(240, 245, 255)
		bindFrame.Visible = false
	end
end)

keyButton.MouseButton1Click:Connect(function()
	if listeningForKey then
		listeningForKey = false
		keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
		keyButton.TextColor3 = Color3.fromRGB(240, 245, 255)
		local bindData = currentBindingFlag and ModuleBinds[currentBindingFlag]
		keyButton.Text = bindData and bindData.Key and formatKeyName(bindData.Key) or "N/A"
	else
		listeningForKey = true
		keyButton.BackgroundColor3 = Color3.fromRGB(20, 32, 54)
		keyBtnStroke.Color = Color3.fromRGB(78, 127, 252)
		keyButton.TextColor3 = Color3.fromRGB(120, 175, 255)
		keyButton.Text = "..."
		ignoreInitialClick = true
		task.defer(function()
			ignoreInitialClick = false
		end)
	end
end)

modeDropdownBtn.MouseButton1Click:Connect(function()
	if currentBindingFlag and ModuleBinds[currentBindingFlag] then
		local currentMode = ModuleBinds[currentBindingFlag].Mode or "TOGGLE"
		local newMode = (currentMode == "TOGGLE") and "HOLD" or "TOGGLE"
		ModuleBinds[currentBindingFlag].Mode = newMode
		updateModeButtons(newMode)
		SaveModuleBinds()
	end
end)

visibleToggleFrame.MouseButton1Click:Connect(function()
	if currentBindingFlag then
		if not MovementSettings.IndicatorVisibility then
			MovementSettings.IndicatorVisibility = {}
		end
		local currentVis = MovementSettings.IndicatorVisibility[currentBindingFlag] ~= false
		local newVis = not currentVis
		MovementSettings.IndicatorVisibility[currentBindingFlag] = newVis
		updateVisibleToggle(newVis)
		if typeof(updateKeybindsDisplay) == "function" then
			pcall(updateKeybindsDisplay)
		end
		if typeof(saveConfig) == "function" then
			pcall(saveConfig)
		end
	end
end)

-- Register Modules --
setLoadProgress(7)
LoadModuleBinds()
registerModule("Bunny Hop", "bhop", function(v)
	MovementSettings.Bhop = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Air Strafer", "airstrafe", function(v)
	MovementSettings.AirStrafe = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Speed", "speed_enabled", function(v)
	MovementSettings.Speed = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Jump Bug", "jumpbug", function(v)
	MovementSettings.JumpBug = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Pixel Surf", "pixelsurf", function(v)
	MovementSettings.PixelSurf = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
	updatePixelSurfGlow()
end)
registerModule("Edge Bug", "edgebug", function(v)
	MovementSettings.EdgeBug = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Auto Align", "autoalign", function(v)
	MovementSettings.AutoAlign = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Auto Ground", "autoground", function(v)
	MovementSettings.AutoGround = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Texture Bug", "texturebug", function(v)
	MovementSettings.TextureBug = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Long Jump", "longjump", function(v)
	MovementSettings.LongJump = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Disable Movement Keys", "disable_keys", function(v)
	MovementSettings.DisableMovementKeys = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Nulls", "nulls", function(v)
	MovementSettings.Nulls = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Air Stuck", "airstuck", function(v)
	MovementSettings.AirStuck = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
	if v and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character then
		local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if root then
			stuckCFrame = root.CFrame
		end
	else
		stuckCFrame = nil
	end
end)
registerModule("Air Jump", "airjump", function(v)
	MovementSettings.AirJump = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Inf Jump", "infjump", function(v)
	MovementSettings.InfJump = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Fly", "fly_enabled", function(v)
	MovementSettings.Fly = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Free Cam", "freecam_enabled", function(v)
	MovementSettings.FreeCam = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("No Clip", "noclip", function(v)
	MovementSettings.NoClip = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Blink", "blink_enabled", function(v)
	MovementSettings.Blink = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Revive", "self_revive_enabled", function(v)
	MovementSettings.Revive = v
	MovementSettings.SelfRevive = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Auto Backsliding", "autobacksliding", function(v)
	MovementSettings.AutoBacksliding = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Save Checkpoint", "cp_save", function(v) end)
registerModule("Load Checkpoint", "cp_load", function(v) end)
registerModule("Delete Checkpoint", "cp_delete", function(v) end)
registerModule("Particles", "particles_enabled", function(v)
	ParticlesSettings.Enabled = v
	updateParticles(true)
end)

registerModule("Test", "test_enabled", function(v)
	TestSettings.Enabled = v
	TestSettings.TestEnabled = v
	updateTestWeather()
end)

-- Key Listener & Bind Execution --
UserInputService.InputBegan:Connect(function(input, gpe)
	if listeningForKey then
		if ignoreInitialClick then return end
		
		local inputTypeName = pcall(function() return input.UserInputType.Name end) and input.UserInputType.Name or tostring(input.UserInputType)
		local keyCodeName = pcall(function() return input.KeyCode.Name end) and input.KeyCode.Name or tostring(input.KeyCode)
		local rawKeyCodeVal = pcall(function() return input.KeyCode.Value end) and input.KeyCode.Value or "N/A"
		local rawUserTypeVal = pcall(function() return input.UserInputType.Value end) and input.UserInputType.Value or "N/A"
		local fullInputStr = tostring(input.UserInputType) .. " " .. tostring(input.KeyCode)
		
		local selectedKey = nil
		local isKeyboard = pcall(function() return input.UserInputType == Enum.UserInputType.Keyboard end) and input.UserInputType == Enum.UserInputType.Keyboard
		local keyCode = pcall(function() return input.KeyCode end) and input.KeyCode or nil

		if isKeyboard and keyCode == Enum.KeyCode.Escape then
			selectedKey = nil
		elseif inputTypeName == "MouseButton1" or inputTypeName == "MouseButton2" then
			return -- Ignore MOUSE1 and MOUSE2
		elseif inputTypeName == "MouseButton3" then
			selectedKey = Enum.UserInputType.MouseButton3
		elseif inputTypeName == "MouseButton4" or keyCodeName == "MouseButton4" or isMouse4Down() then
			selectedKey = "MouseButton4"
		elseif inputTypeName == "MouseButton5" or keyCodeName == "MouseButton5" or isMouse5Down() then
			selectedKey = "MouseButton5"
		elseif isKeyboard and keyCode and keyCode ~= Enum.KeyCode.Unknown then
			selectedKey = keyCode
		elseif input.UserInputType ~= Enum.UserInputType.None and not isKeyboard then
			selectedKey = input.UserInputType
		end
		
		listeningForKey = false
		keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
		
		if currentBindingFlag and ModuleBinds[currentBindingFlag] then
			ModuleBinds[currentBindingFlag].Key = selectedKey
			SaveModuleBinds()
		end
		
		if selectedKey then
			keyButton.Text = formatKeyName(selectedKey)
		else
			keyButton.Text = "N/A"
		end
		return
	end
	
	-- Open context menu on RMB (MouseButton2) or Scroll Click (MouseButton3) --
	if input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3 then
		local mousePos = UserInputService:GetMouseLocation()
		local guiObjects = {}
		
		-- Fix for Roblox's GetGuiObjectsAtPosition GuiInset bug (36 pixel / 2 function vertical shift)
		local inset = game:GetService("GuiService"):GetGuiInset()
		local searchX = mousePos.X
		local searchY = mousePos.Y - inset.Y
		
		pcall(function()
			local cg = game:GetService("CoreGui")
			for _, obj in ipairs(cg:GetGuiObjectsAtPosition(searchX, searchY)) do
				table.insert(guiObjects, obj)
			end
			-- Fallback: also test raw coordinates just in case CoreGui ignores inset in some edge cases
			for _, obj in ipairs(cg:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)) do
				table.insert(guiObjects, obj)
			end
		end)
		pcall(function()
			local lp = game:GetService("Players").LocalPlayer
			if lp and lp:FindFirstChild("PlayerGui") then
				for _, obj in ipairs(lp.PlayerGui:GetGuiObjectsAtPosition(searchX, searchY)) do
					table.insert(guiObjects, obj)
				end
				for _, obj in ipairs(lp.PlayerGui:GetGuiObjectsAtPosition(mousePos.X, mousePos.Y)) do
					table.insert(guiObjects, obj)
				end
			end
		end)
		
		local candidateElements = {}
		local visited = {}
		
		for _, guiObj in ipairs(guiObjects) do
			-- Inspect individual option row elements only (must be small enough to be a single row)
			-- This prevents accidentally scanning the entire section or window
			if guiObj:IsA("GuiObject") and guiObj.AbsoluteSize.Y <= 65 and guiObj.AbsoluteSize.X <= 450 then
				local function searchForText(o)
					if not o or not o:IsA("GuiObject") or visited[o] then return end
					visited[o] = true
					
					if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
						local txt = o.Text
						if typeof(txt) == "string" and #txt > 0 then
							local cleanTxt = string.gsub(txt, "^%s*(.-)%s*$", "%1"):lower()
							table.insert(candidateElements, cleanTxt)
						end
					end
				end
				
				searchForText(guiObj)
				pcall(function()
					for _, child in ipairs(guiObj:GetChildren()) do
						searchForText(child)
					end
				end)
				
				-- If user clicked the toggle button, we inspect its parent (the row frame)
				if guiObj.Parent and guiObj.Parent:IsA("GuiObject") and guiObj.Parent.AbsoluteSize.Y <= 65 and guiObj.Parent.AbsoluteSize.X <= 450 then
					searchForText(guiObj.Parent)
					pcall(function()
						for _, child in ipairs(guiObj.Parent:GetChildren()) do
							searchForText(child)
						end
					end)
				end
			end
		end

		-- STRICT EXACT MATCH against visible text of registered modules ONLY
		for _, txt in ipairs(candidateElements) do
			for flag, info in pairs(RegisteredModules) do
				if txt == info.Name:lower() then
					openBindMenu(info.Name, flag, info.Callback)
					return
				end
			end
		end
	end
	
	-- Helper to execute module bind (updates UI, setting state, callback & saves config) --
	local function triggerModuleBind(flag, isDown)
		local data = ModuleBinds[flag]
		if not data then return end
		local info = RegisteredModules[flag]
		local settingKey = FlagToSettingKey[flag]

		-- Checkpoint special keybind actions
		if flag == "cp_save" then
			if isDown and MovementSettings.CheckpointsEnabled then
				pcall(function()
					local lp = game:GetService("Players").LocalPlayer
					local char = lp and lp.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")
					local cam = workspace.CurrentCamera
					if root then
						local slot = MovementSettings.CheckpointSlot or 1
						MovementSettings.CheckpointSlots[slot] = {
							CFrame = root.CFrame,
							Velocity = root.AssemblyLinearVelocity,
							CameraCFrame = cam and cam.CFrame or root.CFrame
						}
						Notification.new({
							Title = "Checkpoint",
							Content = "Saved to Slot " .. slot,
							Duration = 1.5
						})
					end
				end)
			end
			return
		elseif flag == "cp_load" then
			if isDown and MovementSettings.CheckpointsEnabled then
				pcall(function()
					local lp = game:GetService("Players").LocalPlayer
					local char = lp and lp.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")
					local cam = workspace.CurrentCamera
					local slot = MovementSettings.CheckpointSlot or 1
					local saved = MovementSettings.CheckpointSlots[slot]
					if root and saved then
						if MovementSettings.CheckpointTeleportMode == "Smooth" then
							MovementSettings.CheckpointSmoothActive = true
							MovementSettings.CheckpointSmoothTarget = saved
						else
							root.CFrame = saved.CFrame
							if MovementSettings.CheckpointKeepVelocity and saved.Velocity then
								root.AssemblyLinearVelocity = saved.Velocity
							else
								root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							end
							if MovementSettings.CheckpointKeepAngles and saved.CameraCFrame and cam then
								cam.CFrame = saved.CameraCFrame
							end
							local humanoid = char:FindFirstChildOfClass("Humanoid")
							if humanoid then
								humanoid:ChangeState(Enum.HumanoidStateType.Landed)
							end
						end
						Notification.new({
							Title = "Checkpoint",
							Content = "Loaded Slot " .. slot,
							Duration = 1.5
						})
					else
						Notification.new({
							Title = "Checkpoint",
							Content = "Slot " .. slot .. " is empty",
							Duration = 1.5
						})
					end
				end)
			end
			return
		elseif flag == "cp_delete" then
			if isDown and MovementSettings.CheckpointsEnabled then
				local slot = MovementSettings.CheckpointSlot or 1
				MovementSettings.CheckpointSlots[slot] = nil
				Notification.new({
					Title = "Checkpoint",
					Content = "Deleted Slot " .. slot,
					Duration = 1.5
				})
			end
			return
		end

		if data.Mode == "TOGGLE" then
			if not isDown then return end
			local currentState = data.State
			if settingKey and MovementSettings[settingKey] ~= nil then
				currentState = MovementSettings[settingKey]
			end
			local newState = not currentState
			data.State = newState

			if NeverLose and NeverLose.Flags and NeverLose.Flags[flag] and NeverLose.Flags[flag].SetValue then
				pcall(function() NeverLose.Flags[flag]:SetValue(newState) end)
			else
				if settingKey and MovementSettings[settingKey] ~= nil then
					MovementSettings[settingKey] = newState
				end
				if data.Callback then pcall(function() data.Callback(newState) end) end
				saveConfig()
			end
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end

			pcall(function()
				Notification.new({
					Title = "Keybind",
					Content = (info and info.Name or flag) .. ": " .. (newState and "ENABLED" or "DISABLED"),
					Duration = 2
				})
			end)

		elseif data.Mode == "HOLD" then
			data.State = isDown
			if NeverLose and NeverLose.Flags and NeverLose.Flags[flag] and NeverLose.Flags[flag].SetValue then
				pcall(function() NeverLose.Flags[flag]:SetValue(isDown) end)
			else
				if settingKey and MovementSettings[settingKey] ~= nil then
					MovementSettings[settingKey] = isDown
				end
				if data.Callback then pcall(function() data.Callback(isDown) end) end
				saveConfig()
			end
			if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
		end
	end

	-- Trigger module keybinds --
	if UserInputService:GetFocusedTextBox() then return end

	for flag, data in pairs(ModuleBinds) do
		if data.Key and isKeyMatch(input, data.Key) then
			triggerModuleBind(flag, true)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	for flag, data in pairs(ModuleBinds) do
		if data.Key and data.Mode == "HOLD" and isKeyMatch(input, data.Key) then
			triggerModuleBind(flag, false)
		end
	end
end)

-- Dismiss menu on left click outside --
UserInputService.InputBegan:Connect(function(input)
	if not bindFrame.Visible then return end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	if listeningForKey then return end

	task.defer(function()
		if not bindFrame.Visible then return end
		if listeningForKey then return end
		if isMouseOverBindFrame then return end

		local GuiService = game:GetService("GuiService")
		local mousePos = UserInputService:GetMouseLocation()
		local guiInset = GuiService:GetGuiInset()
		local mouseX = mousePos.X - guiInset.X
		local mouseY = mousePos.Y - guiInset.Y
		
		local fPos = bindFrame.AbsolutePosition
		local fSize = bindFrame.AbsoluteSize
		
		if mouseX < fPos.X - 5 or mouseX > fPos.X + fSize.X + 5
			or mouseY < fPos.Y - 5 or mouseY > fPos.Y + fSize.Y + 5 then
			bindFrame.Visible = false
		end
	end)
end)

-- Purple Glow Screen Effect --
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local screenGlowGui = Instance.new("ScreenGui")
screenGlowGui.Name = "PurpleGlowEffect"
screenGlowGui.ResetOnSpawn = false
screenGlowGui.IgnoreGuiInset = true

pcall(function()
	screenGlowGui.Parent = CoreGui
end)
if not screenGlowGui.Parent then
	pcall(function()
		screenGlowGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	end)
end

local glowContainer = Instance.new("Frame")
glowContainer.Size = UDim2.new(1, 0, 1, 0)
glowContainer.BackgroundTransparency = 1
glowContainer.Parent = screenGlowGui

local function createGlowEdge(size, pos, rot)
	local f = Instance.new("Frame")
	f.Size = size
	f.Position = pos
	f.BorderSizePixel = 0
	f.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
	f.BackgroundTransparency = 1
	f.Parent = glowContainer
	
	local grad = Instance.new("UIGradient")
	grad.Rotation = rot
	grad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1)
	})
	grad.Parent = f
	return f
end

local edges = {
	createGlowEdge(UDim2.new(0.2, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0),
	createGlowEdge(UDim2.new(0.2, 0, 1, 0), UDim2.new(0.8, 0, 0, 0), 180),
	createGlowEdge(UDim2.new(1, 0, 0.2, 0), UDim2.new(0, 0, 0, 0), 90),
	createGlowEdge(UDim2.new(1, 0, 0.2, 0), UDim2.new(0, 0, 0.8, 0), 270)
}

local glowColorMap = {
	["Purple"] = Color3.fromRGB(168, 85, 247),
	["Cyan"] = Color3.fromRGB(0, 230, 255),
	["Red"] = Color3.fromRGB(255, 50, 50),
	["Green"] = Color3.fromRGB(50, 255, 100),
	["Blue"] = Color3.fromRGB(50, 120, 255),
	["Yellow"] = Color3.fromRGB(255, 220, 50),
	["Pink"] = Color3.fromRGB(255, 105, 180),
	["Orange"] = Color3.fromRGB(255, 140, 0),
	["White"] = Color3.fromRGB(255, 255, 255)
}

local lastGlowTime = 0
local edgeTweens = {}

local function resetGlowEdges()
	for i, edge in ipairs(edges) do
		if edgeTweens[i] then
			edgeTweens[i]:Cancel()
			edgeTweens[i] = nil
		end
		edge.BackgroundTransparency = 1
	end
end

-- Reset glow when bind menu is hidden --
bindFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	if not bindFrame.Visible then
		resetGlowEdges()
	end
end)

-- Register Unload Handler --
getgenv().UnloadNeverLoseScript = function()
	isUnloaded = true
	pcall(function()
		resetGlowEdges()
	end)
	pcall(function()
		if screenGlowGui then
			screenGlowGui:Destroy()
		end
	end)
	pcall(function()
		if bindGui then
			bindGui:Destroy()
		end
	end)
end

local function playPurpleGlow()
	if isUnloaded then return end
	local now = tick()
	if now - lastGlowTime < 0.4 then return end
	lastGlowTime = now
	
	local chosenColor
	if typeof(MovementSettings.PixelSurfGlowColor) == "Color3" then
		chosenColor = MovementSettings.PixelSurfGlowColor
	elseif type(MovementSettings.PixelSurfGlowColor) == "string" and glowColorMap[MovementSettings.PixelSurfGlowColor] then
		chosenColor = glowColorMap[MovementSettings.PixelSurfGlowColor]
	else
		chosenColor = Color3.fromRGB(168, 85, 247)
	end
	local intensity = math.clamp(MovementSettings.PixelSurfGlowIntensity or 65, 10, 100) / 100
	local targetTransparency = 1 - intensity

	for i, edge in ipairs(edges) do
		if edgeTweens[i] then
			edgeTweens[i]:Cancel()
		end
		edge.BackgroundColor3 = chosenColor
		edge.BackgroundTransparency = targetTransparency
		local t = TweenService:Create(edge, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1
		})
		edgeTweens[i] = t
		t:Play()
		t.Completed:Connect(function(state)
			if state == Enum.PlaybackState.Completed then
				edgeTweens[i] = nil
			end
		end)
	end
end

-- Movement Execution Engine --
local cleanupNoClip = function() end

setLoadProgress(8)
task.spawn(function()
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	
	local LocalPlayer = Players.LocalPlayer
	local lastCameraYaw = 0
	local isPixelSurfing = false
	local pixelSurfStartTime = 0
	local pixelGlowTriggered = false
	local pixelSurfLockY = nil
	local function stopPixelSurfing()
		if isPixelSurfing then
			isPixelSurfing = false
			if pixelSurfStartTime > 0 and (tick() - pixelSurfStartTime >= 0.05) then
				playPurpleGlow()
			end
			pixelSurfStartTime = 0
			pixelGlowTriggered = false
			pixelSurfLockY = nil
		end
	end
	local noSlowdownTargetSpeed = nil
	local peakAirSpeed = 0
	local slideMomentum = 0
	local backslideFrictionSet = false
	local wasInAirLastFrame = false
	local lastHorizKey = nil
	local lastVertKey = nil
	local horizKeyStack = {}
	local vertKeyStack = {}

	local function pushKey(stack, key)
		for i = #stack, 1, -1 do
			if stack[i] == key then
				table.remove(stack, i)
			end
		end
		table.insert(stack, key)
	end

	local function popKey(stack, key)
		for i = #stack, 1, -1 do
			if stack[i] == key then
				table.remove(stack, i)
			end
		end
	end

	local function getActiveKey(stack)
		return stack[#stack]
	end

	local blinkActive = false
	local blinkGhostCFrame = nil
	local blinkFrozenCFrame = nil
	local noClipActive = false
	local noClipCharacter = nil
	local noClipStates = {}
	local noClipDescendantAdded = nil
	local noClipLastPosition = nil
	local betaStrafeLastPosition = nil
	
	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
			pushKey(horizKeyStack, input.KeyCode)
			lastHorizKey = input.KeyCode
		elseif input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S then
			pushKey(vertKeyStack, input.KeyCode)
			lastVertKey = input.KeyCode
		end
	end)

	UserInputService.InputEnded:Connect(function(input, gpe)
		if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
			popKey(horizKeyStack, input.KeyCode)
			lastHorizKey = getActiveKey(horizKeyStack)
		elseif input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S then
			popKey(vertKeyStack, input.KeyCode)
			lastVertKey = getActiveKey(vertKeyStack)
		end
	end)
	
	local function disconnectNoClipCharacter()
		if noClipDescendantAdded then
			noClipDescendantAdded:Disconnect()
			noClipDescendantAdded = nil
		end
		noClipCharacter = nil
	end

	local function restoreNoClipParts()
		for part, originalCanCollide in pairs(noClipStates) do
			if part.Parent then
				part.CanCollide = originalCanCollide
			end
		end
		table.clear(noClipStates)
	end

	local function disableNoClip()
		noClipActive = false
		noClipLastPosition = nil
		disconnectNoClipCharacter()
		restoreNoClipParts()
	end

	local function disableCollision(part)
		if not part:IsA("BasePart") then return end
		if noClipStates[part] == nil then
			noClipStates[part] = part.CanCollide
		end
		part.CanCollide = false
	end

	local function attachNoClipCharacter(character)
		if noClipCharacter == character then return end

		disconnectNoClipCharacter()
		restoreNoClipParts()
		noClipCharacter = character
		noClipLastPosition = nil
		if not character then return end

		for _, descendant in ipairs(character:GetDescendants()) do
			disableCollision(descendant)
		end

		noClipDescendantAdded = character.DescendantAdded:Connect(function(descendant)
			if noClipActive then
				disableCollision(descendant)
			end
		end)
	end

	local function processNoClip()
		local pixelSurfNoClip = MovementSettings.PixelSurf
			and MovementSettings.PixelSurfEasyNoClip
			and isPixelSurfing
		local shouldNoClip = not isUnloaded and (MovementSettings.NoClip or pixelSurfNoClip)

		if not shouldNoClip then
			if noClipActive then
				disableNoClip()
			end
			return
		end

		noClipActive = true
		attachNoClipCharacter(LocalPlayer.Character)
		for part in pairs(noClipStates) do
			if part.Parent then
				part.CanCollide = false
			else
				noClipStates[part] = nil
			end
		end
	end

	local function moveNoClipThroughWalls(dt)
		if not noClipActive or not noClipCharacter then return end

		local humanoid = noClipCharacter:FindFirstChildOfClass("Humanoid")
		local rootPart = noClipCharacter:FindFirstChild("HumanoidRootPart")
		if not humanoid or not rootPart or humanoid.Health <= 0 then
			noClipLastPosition = nil
			return
		end

		local moveDirection = humanoid.MoveDirection
		if UserInputService:GetFocusedTextBox() == nil then
			local camera = workspace.CurrentCamera
			if camera then
				local forward = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
				local right = Vector3.new(camera.CFrame.RightVector.X, 0, camera.CFrame.RightVector.Z)
				if forward.Magnitude > 0 then forward = forward.Unit end
				if right.Magnitude > 0 then right = right.Unit end

				local inputDirection = Vector3.zero
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputDirection = inputDirection + forward end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputDirection = inputDirection - forward end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputDirection = inputDirection + right end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputDirection = inputDirection - right end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then inputDirection = inputDirection + Vector3.yAxis end

				if inputDirection.Magnitude > 0 then
					moveDirection = inputDirection.Unit
				end
			end
		end
		local noClipDirection = moveDirection
		local currentPosition = rootPart.Position
		if noClipDirection.Magnitude < 0.05 then
			noClipLastPosition = currentPosition
			return
		end
		noClipDirection = noClipDirection.Unit

		local currentVelocity = rootPart.AssemblyLinearVelocity
		local movementSpeed = math.max(humanoid.WalkSpeed, currentVelocity.Magnitude)
		local expectedDistance = movementSpeed * math.min(dt, 1 / 20)
		local actualDistance = expectedDistance
		if noClipLastPosition then
			actualDistance = math.max(0, (currentPosition - noClipLastPosition):Dot(noClipDirection))
		end

		local missingDistance = math.clamp(expectedDistance - actualDistance, 0, 3)
		if missingDistance > 0.01 then
			rootPart.CFrame = rootPart.CFrame + noClipDirection * missingDistance
		end
		noClipLastPosition = rootPart.Position
	end

	cleanupNoClip = disableNoClip
	RunService.Stepped:Connect(processNoClip)

	RunService.Heartbeat:Connect(function(dt)
		if isUnloaded then return end
		moveNoClipThroughWalls(dt)
		
		local character = LocalPlayer.Character
		if not character then return end
		
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not rootPart or humanoid.Health <= 0 then return end
		
		-- AirStuck Control --
		if MovementSettings.AirStuck then
			if not stuckCFrame then
				stuckCFrame = rootPart.CFrame
				if MovementSettings.AirStuckSaveSpeed then
					MovementSettings.AirStuckSavedVelocity = rootPart.AssemblyLinearVelocity
				end
			end
			rootPart.CFrame = stuckCFrame
			rootPart.AssemblyLinearVelocity = Vector3.zero
			rootPart.AssemblyAngularVelocity = Vector3.zero
			-- God Mode: reset health to max every frame
			if MovementSettings.AirStuckGodMode then
				pcall(function()
					humanoid.Health = humanoid.MaxHealth
				end)
			end
			return
		else
			-- On disable: restore saved velocity
			if MovementSettings.AirStuckSaveSpeed and MovementSettings.AirStuckSavedVelocity then
				pcall(function()
					rootPart.AssemblyLinearVelocity = MovementSettings.AirStuckSavedVelocity
				end)
				MovementSettings.AirStuckSavedVelocity = nil
			end
		end
		
		-- Disable Movement Keys Control --
		if MovementSettings.DisableMovementKeys then
			local inAirNow = (humanoid.FloorMaterial == Enum.Material.Air) or humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping
			local isAutomatedActive = (MovementSettings.AirStrafe and inAirNow) 
				or (MovementSettings.LongJump and inAirNow) 
				or isPixelSurfing 
				or (MovementSettings.Fly and not (UserInputService:GetFocusedTextBox() ~= nil))
			if isAutomatedActive then
				humanoid:Move(Vector3.zero, false)
			end
		end
		
		-- Nulls (Snap Tap / Opposing Keys Override) --
		if MovementSettings.Nulls then
			local isTyping = UserInputService:GetFocusedTextBox() ~= nil
			if not isTyping then
				local aDown = UserInputService:IsKeyDown(Enum.KeyCode.A)
				local dDown = UserInputService:IsKeyDown(Enum.KeyCode.D)
				local wDown = UserInputService:IsKeyDown(Enum.KeyCode.W)
				local sDown = UserInputService:IsKeyDown(Enum.KeyCode.S)
				
				local hasOpposingHoriz = aDown and dDown
				local hasOpposingVert = wDown and sDown
				
				if hasOpposingHoriz or hasOpposingVert then
					local Camera = workspace.CurrentCamera
					if Camera then
						local moveVec = Vector3.zero
						local forward = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
						local right = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z)
						if forward.Magnitude > 0 then forward = forward.Unit end
						if right.Magnitude > 0 then right = right.Unit end
						
						-- Resolve Horizontal (A / D)
						if hasOpposingHoriz then
							local activeH = getActiveKey(horizKeyStack) or lastHorizKey
							if activeH == Enum.KeyCode.A then
								moveVec = moveVec - right
							elseif activeH == Enum.KeyCode.D then
								moveVec = moveVec + right
							end
						else
							if aDown then moveVec = moveVec - right end
							if dDown then moveVec = moveVec + right end
						end
						
						-- Resolve Vertical (W / S)
						if hasOpposingVert then
							local activeV = getActiveKey(vertKeyStack) or lastVertKey
							if activeV == Enum.KeyCode.W then
								moveVec = moveVec + forward
							elseif activeV == Enum.KeyCode.S then
								moveVec = moveVec - forward
							end
						else
							if wDown then moveVec = moveVec + forward end
							if sDown then moveVec = moveVec - forward end
						end
						
						if moveVec.Magnitude > 0 then
							humanoid:Move(moveVec.Unit, false)
						else
							humanoid:Move(Vector3.zero, false)
						end
					end
				end
			end
		end
		
		-- Speed Control --
		if MovementSettings.Speed then
			humanoid.WalkSpeed = MovementSettings.SpeedValue
			local isTyping = UserInputService:GetFocusedTextBox() ~= nil
			local Camera = workspace.CurrentCamera
			if Camera and not isTyping then
				local state = humanoid:GetState()
				local isGroundedState = (state == Enum.HumanoidStateType.Running) 
					or (state == Enum.HumanoidStateType.RunningNoPhysics) 
					or (state == Enum.HumanoidStateType.Landed) 
					or (state == Enum.HumanoidStateType.Seated)
				local inAirNow = (humanoid.FloorMaterial == Enum.Material.Air) and not isGroundedState

				if not (inAirNow and MovementSettings.AirStrafe) then
					local forward = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
					local right = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z)
					if forward.Magnitude > 0 then forward = forward.Unit end
					if right.Magnitude > 0 then right = right.Unit end

					local inputVec = Vector3.zero
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputVec = inputVec + forward end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputVec = inputVec - forward end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputVec = inputVec + right end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputVec = inputVec - right end

					if inputVec.Magnitude == 0 and humanoid.MoveDirection.Magnitude > 0 then
						inputVec = humanoid.MoveDirection
					end

					if inputVec.Magnitude > 0 then
						local moveDir = inputVec.Unit
						local targetSpeed = MovementSettings.SpeedValue or 16
						local currentVel = rootPart.AssemblyLinearVelocity
						local targetVel = moveDir * targetSpeed
						local newVel = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
						rootPart.AssemblyLinearVelocity = newVel
						pcall(function() rootPart.Velocity = newVel end)
					end
				end
			end
		end
		
		-- Fly Control --
		if MovementSettings.Fly then
			local Camera = workspace.CurrentCamera
			local flyVec = Vector3.new(0, 0, 0)
			local isTyping = UserInputService:GetFocusedTextBox() ~= nil
			
			if Camera and not isTyping then
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					flyVec = flyVec + Camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					flyVec = flyVec - Camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					flyVec = flyVec - Camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					flyVec = flyVec + Camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					flyVec = flyVec + Vector3.new(0, 1, 0)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					flyVec = flyVec - Vector3.new(0, 1, 0)
				end
			end
			
			if flyVec.Magnitude > 0 then
				flyVec = flyVec.Unit * MovementSettings.FlySpeed
			end
			
			rootPart.AssemblyLinearVelocity = flyVec
		end
		


		-- Blink --
		if MovementSettings.Blink then
			if not blinkActive then
				-- First frame: freeze character for server, start ghost at current pos
				blinkActive = true
				blinkFrozenCFrame = rootPart.CFrame
				blinkGhostCFrame = rootPart.CFrame
				rootPart.Anchored = true
				rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end

			-- Move ghost with WASD + camera direction
			local cam = workspace.CurrentCamera
			if cam and not (UserInputService:GetFocusedTextBox() ~= nil) then
				local blinkMoveVec = Vector3.new(0, 0, 0)
				local lookFlat = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
				local rightFlat = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
				if lookFlat.Magnitude > 0 then lookFlat = lookFlat.Unit end
				if rightFlat.Magnitude > 0 then rightFlat = rightFlat.Unit end

				if UserInputService:IsKeyDown(Enum.KeyCode.W) then blinkMoveVec = blinkMoveVec + lookFlat end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then blinkMoveVec = blinkMoveVec - lookFlat end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then blinkMoveVec = blinkMoveVec - rightFlat end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then blinkMoveVec = blinkMoveVec + rightFlat end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then blinkMoveVec = blinkMoveVec + Vector3.new(0, 1, 0) end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then blinkMoveVec = blinkMoveVec - Vector3.new(0, 1, 0) end

				if blinkMoveVec.Magnitude > 0 then
					blinkMoveVec = blinkMoveVec.Unit * MovementSettings.BlinkSpeed * 0.016
				end

				blinkGhostCFrame = blinkGhostCFrame + blinkMoveVec
			end

			-- Apply ghost position locally (character anchored — server sees frozen pos)
			rootPart.CFrame = blinkGhostCFrame

		else
			if blinkActive then
				-- Blink released: unanchor and teleport to ghost position
				blinkActive = false
				rootPart.Anchored = false
				rootPart.CFrame = blinkGhostCFrame
				rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				blinkGhostCFrame = nil
				blinkFrozenCFrame = nil
			end
		end



-- Checkpoints: Smooth lerp toward saved position --
		if MovementSettings.CheckpointSmoothActive and MovementSettings.CheckpointSmoothTarget then
			local target = MovementSettings.CheckpointSmoothTarget
			local currentPos = rootPart.Position
			local dist = (target.CFrame.Position - currentPos).Magnitude
			if dist < 0.5 then
				-- Arrived
				MovementSettings.CheckpointSmoothActive = false
				rootPart.CFrame = target.CFrame
				if MovementSettings.CheckpointKeepVelocity and target.Velocity then
					rootPart.AssemblyLinearVelocity = target.Velocity
				else
					rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				end
				if MovementSettings.CheckpointKeepAngles and target.CameraCFrame and Camera then
					Camera.CFrame = target.CameraCFrame
				end
				MovementSettings.CheckpointSmoothTarget = nil
			else
				-- Lerp step (speed: 12 studs per second)
				local step = math.min(12 * 0.016, dist)
				local dir = (target.CFrame.Position - currentPos).Unit
				rootPart.CFrame = rootPart.CFrame + dir * step
				rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end
		end
		
		local inAir = humanoid.FloorMaterial == Enum.Material.Air or humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping
		local isTyping = UserInputService:GetFocusedTextBox() ~= nil
		
		-- Track peak horizontal speed while in air to prevent landing friction 20% speed drop
		local currentVel = rootPart.AssemblyLinearVelocity
		local currentHorizSpeed = Vector3.new(currentVel.X, 0, currentVel.Z).Magnitude

		if inAir then
			peakAirSpeed = math.max(peakAirSpeed or 0, currentHorizSpeed)
			slideMomentum = math.max(slideMomentum or 0, peakAirSpeed)
		else
			if currentHorizSpeed < 2 and humanoid.MoveDirection.Magnitude < 0.1 then
				peakAirSpeed = 0
				slideMomentum = 0
			end
		end

		local justLanded = wasInAirLastFrame and not inAir
		wasInAirLastFrame = inAir
		
		-- 1. Bunny Hop (Triggers only when holding Spacebar like in CS2) --
		if MovementSettings.Bhop and not inAir and not isTyping and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			humanoid.Jump = true
		end
		
		-- 2. Air Strafe (NoClip positional push logic in WASD Beta mode, active ONLY in jump/air) --
		if MovementSettings.AirStrafe and inAir then
			local isTyping = UserInputService:GetFocusedTextBox() ~= nil
			local Camera = workspace.CurrentCamera
			if Camera and not isTyping then
				local mode = MovementSettings.AirStrafeMode or "Beta"
				if mode == "Beta" or mode == "WASD Test" then
					local forward = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
					local right = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z)
					if forward.Magnitude > 0 then forward = forward.Unit end
					if right.Magnitude > 0 then right = right.Unit end

					local inputVec = Vector3.zero
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputVec = inputVec + forward end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputVec = inputVec - forward end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputVec = inputVec + right end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputVec = inputVec - right end

					if inputVec.Magnitude == 0 and humanoid.MoveDirection.Magnitude > 0 then
						inputVec = humanoid.MoveDirection
					end

					if inputVec.Magnitude > 0 then
						local moveDir = inputVec.Unit
						local currentPosition = rootPart.Position
						local currentVel = rootPart.AssemblyLinearVelocity
						local targetSpeed = tonumber(MovementSettings.AirStrafeSpeed) or 40
						local movementSpeed = math.max(targetSpeed, currentVel.Magnitude)
						local expectedDistance = movementSpeed * math.min(dt, 1 / 20)
						local actualDistance = expectedDistance
						if betaStrafeLastPosition then
							actualDistance = math.max(0, (currentPosition - betaStrafeLastPosition):Dot(moveDir))
						end

						local missingDistance = math.clamp(expectedDistance - actualDistance, 0, 3)
						if missingDistance > 0.01 then
							rootPart.CFrame = rootPart.CFrame + moveDir * missingDistance
						end
						betaStrafeLastPosition = rootPart.Position

						local targetVel = moveDir * targetSpeed
						local newVel = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
						rootPart.AssemblyLinearVelocity = newVel
						pcall(function() rootPart.Velocity = newVel end)
					else
						betaStrafeLastPosition = nil
					end
				end
			end
		else
			betaStrafeLastPosition = nil
		end
		-- 4. Pixel Surf --
		if MovementSettings.PixelSurf and inAir then
			local currentVel = rootPart.AssemblyLinearVelocity
			local horizSpeed = Vector3.new(currentVel.X, 0, currentVel.Z).Magnitude
			
			if horizSpeed >= 3.5 then
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {character}
				rayParams.FilterType = Enum.RaycastFilterType.Exclude
				
				local checkDist = 2.8
				local wallNormal = nil
				local wallHitDist = math.huge
				local directions = {
					rootPart.CFrame.LookVector,
					-rootPart.CFrame.LookVector,
					rootPart.CFrame.RightVector,
					-rootPart.CFrame.RightVector,
					(rootPart.CFrame.LookVector + rootPart.CFrame.RightVector).Unit,
					(rootPart.CFrame.LookVector - rootPart.CFrame.RightVector).Unit,
					(-rootPart.CFrame.LookVector + rootPart.CFrame.RightVector).Unit,
					(-rootPart.CFrame.LookVector - rootPart.CFrame.RightVector).Unit,
				}
				
				for _, dir in ipairs(directions) do
					local rayHit = workspace:Raycast(rootPart.Position, dir * checkDist, rayParams)
					if rayHit and rayHit.Instance and rayHit.Instance.CanCollide then
						if rayHit.Distance < wallHitDist then
							wallHitDist = rayHit.Distance
							wallNormal = rayHit.Normal
						end
					end
				end
				
				if wallNormal then
					if not isPixelSurfing then
						isPixelSurfing = true
						pixelSurfStartTime = tick()
						pixelGlowTriggered = false
						pixelSurfLockY = rootPart.Position.Y
					end
					
					local vel = rootPart.AssemblyLinearVelocity
					local verticalVel = 0
					local horizVel = Vector3.new(vel.X, 0, vel.Z)
					local dot = horizVel:Dot(wallNormal)
					if dot < 0 then
						horizVel = horizVel - (wallNormal * dot)
					end
					
					if MovementSettings.PixelSurfFollowCamera then
						local Camera = workspace.CurrentCamera
						if Camera then
							local camLook = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
							if camLook.Magnitude > 0 then
								camLook = camLook.Unit
								local dotCam = camLook:Dot(wallNormal)
								local wallTangent = (camLook - (wallNormal * dotCam))
								if wallTangent.Magnitude > 0.1 then
									wallTangent = wallTangent.Unit
									local speedMag = math.max(horizVel.Magnitude, 16)
									horizVel = wallTangent * speedMag
									rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + wallTangent)
								end
							end
						end
					end
					
					if MovementSettings.PixelSurfEasyNoClip and wallHitDist < 1.8 then
						local pushAmount = (1.8 - wallHitDist) * 12
						horizVel = horizVel + (wallNormal * pushAmount)
					end
					
					local mode = MovementSettings.PixelSurfMode or "Easy"
					if mode == "Easy" then
						verticalVel = 0
						if horizVel.Magnitude > 3.5 and horizVel.Magnitude < 120 then
							horizVel = horizVel * 1.25
						end
					elseif mode == "Normal" then
						verticalVel = -3.5
					elseif mode == "Realistic" then
						verticalVel = 0
						if pixelSurfLockY then
							local diffY = pixelSurfLockY - rootPart.Position.Y
							verticalVel = math.clamp(diffY * 60, -25, 25)
							if math.abs(diffY) > 0.005 then
								pcall(function()
									local currentCF = rootPart.CFrame
									rootPart.CFrame = CFrame.new(currentCF.Position.X, pixelSurfLockY, currentCF.Position.Z) * (currentCF - currentCF.Position)
								end)
							end
						end
					end
					
					rootPart.AssemblyLinearVelocity = Vector3.new(horizVel.X, verticalVel, horizVel.Z)
				else
					stopPixelSurfing()
				end
			else
				stopPixelSurfing()
			end
		else
			stopPixelSurfing()
		end
		
		-- 5. Edge Bug --
		if MovementSettings.EdgeBug and inAir and rootPart.AssemblyLinearVelocity.Y < -3 then
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = {character}
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			
			local rayResult = workspace:Raycast(rootPart.Position, Vector3.new(0, -3.5, 0), rayParams)
			if rayResult then
				playPurpleGlow()
				rootPart.AssemblyLinearVelocity = Vector3.new(
					rootPart.AssemblyLinearVelocity.X,
					0,
					rootPart.AssemblyLinearVelocity.Z
				)
			end
		end

		-- 5b. Auto Align --
		if MovementSettings.AutoAlign and not inAir then
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = {character}
			rayParams.FilterType = Enum.RaycastFilterType.Exclude

			local look = rootPart.CFrame.LookVector
			local right = rootPart.CFrame.RightVector
			local scanDirs = {
				right, -right, look, -look,
				(look + right).Unit, (look - right).Unit,
				(-look + right).Unit, (-look - right).Unit,
			}
			local scanHeights = {
				rootPart.Position,
				rootPart.Position - Vector3.new(0, 1.5, 0),
			}
			local bestNormal = nil
			local bestDist = math.huge

			for _, origin in ipairs(scanHeights) do
				for _, dir in ipairs(scanDirs) do
					local hit = workspace:Raycast(origin, dir * 4.0, rayParams)
					if hit and hit.Instance and hit.Instance.CanCollide then
						local flatNormal = Vector3.new(hit.Normal.X, 0, hit.Normal.Z)
						if flatNormal.Magnitude > 0.1 then
							local dist = (hit.Position - origin).Magnitude
							if dist < bestDist then
								bestDist = dist
								bestNormal = flatNormal.Unit
							end
						end
					end
				end
			end

			if bestNormal and bestDist <= 3.8 then
				-- Align character so its LookVector is parallel to the wall (perpendicular to normal)
				local alignedLook = Vector3.new(-bestNormal.Z, 0, bestNormal.X).Unit
				local dot = alignedLook:Dot(rootPart.CFrame.LookVector)
				if dot < 0 then alignedLook = -alignedLook end

				local targetCFrame = CFrame.new(rootPart.Position, rootPart.Position + alignedLook)
				local currentCFrame = rootPart.CFrame
				local alpha = 0.15
				local newCFrame = currentCFrame:Lerp(targetCFrame, alpha)
				rootPart.CFrame = CFrame.new(newCFrame.Position, newCFrame.Position + newCFrame.LookVector)
			end
		end

		-- 5c. Texture Bug --
		-- Scans for clip-pad geometry: parts that are very thin or at corner intersections.
		-- If a micro-collision surface is detected close to the character while falling,
		-- we exploit the collision quirk: spike the Y velocity upward briefly ("clip bounce"),
		-- or at minimum zero out the downward fall speed.
		if MovementSettings.TextureBug and inAir then
			local vel = rootPart.AssemblyLinearVelocity
			-- Only trigger when actually falling (negative Y velocity)
			if vel.Y < -2 then
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {character}
				rayParams.FilterType = Enum.RaycastFilterType.Exclude

				-- Probe diagonally downward at 8 angles (corners of the character hitbox)
				-- These simulate where clip-pad geometry tends to exist
				local probeOffsets = {
					Vector3.new( 1, 0,  1),
					Vector3.new(-1, 0,  1),
					Vector3.new( 1, 0, -1),
					Vector3.new(-1, 0, -1),
					Vector3.new( 1, 0,  0),
					Vector3.new(-1, 0,  0),
					Vector3.new( 0, 0,  1),
					Vector3.new( 0, 0, -1),
				}

				local triggered = false
				for _, offset in ipairs(probeOffsets) do
					local origin = rootPart.Position + offset.Unit * 1.0
					-- Short downward ray — only catches geometry very close below (clip-pad distance)
					local hit = workspace:Raycast(origin, Vector3.new(0, -1.6, 0), rayParams)
					if hit and hit.Instance and hit.Instance.CanCollide then
						-- Check that the geometry normal is mostly horizontal (wall/corner, not floor)
						-- A true floor hit would have Normal.Y close to 1; clip-pads have mixed normals
						local ny = math.abs(hit.Normal.Y)
						if ny < 0.85 then
							triggered = true
							break
						end
					end
				end

				if triggered then
					playPurpleGlow()
					-- Exploit: bounce off the clip-pad geometry — cancel fall and add small upward push
					local horizVel = Vector3.new(vel.X, 0, vel.Z)
					rootPart.AssemblyLinearVelocity = Vector3.new(
						horizVel.X,
						math.max(8, math.abs(vel.Y) * 0.35),  -- convert fall into small upward pop
						horizVel.Z
					)
				end
			end
		end

		-- 6. Long Jump --
		if MovementSettings.LongJump and inAir then
			local direction = rootPart.CFrame.LookVector
			if MovementSettings.LongJumpFollowCamera then
				local Camera = workspace.CurrentCamera
				if Camera then
					direction = Camera.CFrame.LookVector
				end
			end

			local forwardDir = Vector3.new(direction.X, 0, direction.Z)
			if forwardDir.Magnitude > 0 then
				forwardDir = forwardDir.Unit
				
				if MovementSettings.LongJumpFollowCamera then
					rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + forwardDir)
				end
				
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {character}
				rayParams.FilterType = Enum.RaycastFilterType.Exclude

				local boost = MovementSettings.LongJumpBoost or 50
				local checkDist = math.max(3.5, (boost * 0.05) + 2.0)
				
				local origins = {
					rootPart.Position,
					rootPart.Position + Vector3.new(0, 1.5, 0),
					rootPart.Position - Vector3.new(0, 1.2, 0)
				}
				
				local wallHit = nil
				local closestHitDist = math.huge
				
				for _, orig in ipairs(origins) do
					local hit = workspace:Raycast(orig, forwardDir * checkDist, rayParams)
					if hit and hit.Instance and hit.Instance.CanCollide then
						if hit.Distance < closestHitDist then
							closestHitDist = hit.Distance
							wallHit = hit
						end
					end
				end
				
				local currentVel = rootPart.AssemblyLinearVelocity
				
				if wallHit then
					local wallNormal = wallHit.Normal
					local dot = forwardDir:Dot(wallNormal)
					
					if dot < -0.1 then
						if closestHitDist <= 2.5 then
							local projForward = forwardDir - (wallNormal * dot)
							if projForward.Magnitude > 0.1 then
								local targetVel = projForward.Unit * (boost * 0.5)
								rootPart.AssemblyLinearVelocity = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
							else
								rootPart.AssemblyLinearVelocity = Vector3.new(0, currentVel.Y, 0)
							end
						else
							local scale = math.clamp((closestHitDist - 2.0) / (checkDist - 2.0), 0.1, 1.0)
							local targetVel = forwardDir * (boost * scale)
							rootPart.AssemblyLinearVelocity = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
						end
					else
						local targetVel = forwardDir * boost
						rootPart.AssemblyLinearVelocity = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
					end
				else
					local targetVel = forwardDir * boost
					rootPart.AssemblyLinearVelocity = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
				end
			end
		end

		-- 7b. Advanced Multi-Point Stair & Incline Backsliding Engine --
		if MovementSettings.AutoBacksliding then
			if not isTyping then
				local currentVel = rootPart.AssemblyLinearVelocity
				local moveDir = humanoid.MoveDirection
				local isMoving = moveDir.Magnitude > 0.1
				
				local cPressed = UserInputService:IsKeyDown(Enum.KeyCode.C) 
					or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) 
					or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
				local sPressed = UserInputService:IsKeyDown(Enum.KeyCode.S)
				local wPressed = UserInputService:IsKeyDown(Enum.KeyCode.W)
				local aPressed = UserInputService:IsKeyDown(Enum.KeyCode.A)
				local dPressed = UserInputService:IsKeyDown(Enum.KeyCode.D)
				local state = humanoid:GetState()
				local inWaterState = (state == Enum.HumanoidStateType.Swimming) or (humanoid.FloorMaterial == Enum.Material.Water)
				
				-- Setup Raycast Filter
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {character}
				rayParams.FilterType = Enum.RaycastFilterType.Exclude

				local rootPos = rootPart.Position

				-- Determine raw movement / camera look direction
				local Camera = workspace.CurrentCamera
				local rawDir = Vector3.zero
				if Camera then
					local look = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
					if look.Magnitude > 0 then look = look.Unit end
					local right = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z)
					if right.Magnitude > 0 then right = right.Unit end

					if sPressed then rawDir = rawDir - look end
					if wPressed then rawDir = rawDir + look end
					if aPressed then rawDir = rawDir - right end
					if dPressed then rawDir = rawDir + right end

					if rawDir.Magnitude < 0.01 then
						if isMoving then
							rawDir = Vector3.new(moveDir.X, 0, moveDir.Z)
						else
							rawDir = -look -- Default backslide direction when sliding without directional keys
						end
					end
				end

				if rawDir.Magnitude > 0.01 then
					rawDir = rawDir.Unit
				end

				-- Calculate current horizontal speed
				local configuredSpeed = (MovementSettings.Speed and MovementSettings.SpeedValue) or 16
				local currentHoriz = Vector3.new(currentVel.X, 0, currentVel.Z).Magnitude
				
				-- Preserve peak horizontal momentum, capped safely
				slideMomentum = math.max(currentHoriz, slideMomentum or 0, peakAirSpeed or 0, configuredSpeed)
				if slideMomentum > 350 then slideMomentum = 350 end -- Hard safety ceiling

				-- Ground & surface detection (raycast-based, not humanoid inAir)
				-- Probe 0: straight down
				local groundRay = workspace:Raycast(rootPos, Vector3.new(0, -4.5, 0), rayParams)
				-- Probe diagonal: forward-down at 45 degrees to catch steep surfs
				local diagRay = workspace:Raycast(rootPos, (rawDir * 3 + Vector3.new(0, -3, 0)), rayParams)
				local nearGround = groundRay ~= nil

				local isStairsOrSlope = false
				local stairSlopeY = 0
				local surfNormal = Vector3.new(0, 1, 0)
				local detectedSurf = nil -- the raycast hit we use for surface info

				if groundRay then
					detectedSurf = groundRay
					surfNormal = groundRay.Normal
				end

				-- Detect steep surfs (45+ degrees) via diagonal ray
				if diagRay and diagRay.Instance and diagRay.Instance.CanCollide then
					if diagRay.Normal.Y > 0.05 and diagRay.Normal.Y < 0.98 then
						-- It's an angled surface, not a pure wall or flat floor
						isStairsOrSlope = true
						if not detectedSurf or diagRay.Normal.Y < surfNormal.Y then
							-- Use the steeper surface for projection
							detectedSurf = diagRay
							surfNormal = diagRay.Normal
						end
						stairSlopeY = (rawDir - rawDir:Dot(diagRay.Normal) * diagRay.Normal).Y
						nearGround = true -- we're touching a surface, even if not "ground"
					end
				end

				if nearGround and detectedSurf then
					-- Probe ahead for height difference (stair detection)
					local hit1 = workspace:Raycast(rootPos + rawDir * 2.5, Vector3.new(0, -5.0, 0), rayParams)
					-- Wall probe: horizontal check at knee height
					local wallHit = workspace:Raycast(rootPos - Vector3.new(0, 1.2, 0), rawDir * 3.0, rayParams)

					if detectedSurf.Normal.Y < 0.98 and not isStairsOrSlope then
						isStairsOrSlope = true
						stairSlopeY = (rawDir - rawDir:Dot(detectedSurf.Normal) * detectedSurf.Normal).Y
					end

					if detectedSurf and hit1 then
						local dy1 = (hit1.Position.Y - detectedSurf.Position.Y) / 2.5
						if math.abs(dy1) > 0.05 then
							isStairsOrSlope = true
							if stairSlopeY == 0 then stairSlopeY = dy1 end
						end
					end

					-- Detect vertical step faces AND steep surfs (threshold 0.95 covers 45+ degrees)
					if wallHit and wallHit.Instance and wallHit.Instance.CanCollide then
						if math.abs(wallHit.Normal.Y) < 0.95 then
							isStairsOrSlope = true
							if stairSlopeY == 0 then stairSlopeY = 0.5 end
							-- Use wall normal for projection if it's angled (surf ramp)
							if wallHit.Normal.Y > 0.05 then
								surfNormal = wallHit.Normal
							end
						end
					end
				end

				-- Should slide activate?
				local shouldSlide = cPressed or sPressed or isStairsOrSlope or inWaterState

				if shouldSlide then
					-- Set minimal density for collisions, zero friction for sliding
					if not backslideFrictionSet then
						backslideFrictionSet = true
						pcall(function()
							rootPart.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
						end)
					end

					-- Determine slide direction vector
					local slideVec = rawDir
					if isStairsOrSlope and nearGround then
						-- Project rawDir onto surface normal for smooth ramp/stair gliding
						local proj = rawDir - (rawDir:Dot(surfNormal)) * surfNormal
						if proj.Magnitude > 0.01 then
							slideVec = proj.Unit
						elseif math.abs(stairSlopeY) > 0.04 then
							slideVec = Vector3.new(rawDir.X, math.clamp(stairSlopeY, -1.2, 1.2), rawDir.Z).Unit
						end
					end

					-- If high speed (> 50), preserve physical horizontal velocity direction
					if currentHoriz > 50 and not (cPressed or sPressed) then
						local horizVel = Vector3.new(currentVel.X, 0, currentVel.Z)
						if horizVel.Magnitude > 0.1 then
							slideVec = Vector3.new(horizVel.Unit.X, slideVec.Y, horizVel.Unit.Z).Unit
						end
					end

					-- Y-velocity calculation
					local targetY = currentVel.Y
					if isStairsOrSlope and nearGround and math.abs(slideVec.Y) > 0.02 then
						targetY = slideVec.Y * slideMomentum
						-- Cap upward Y to prevent trampoline/ramp launches into the sky
						if targetY > 60 then
							targetY = 60
						end
					elseif inWaterState then
						targetY = math.clamp(currentVel.Y, -1, 0)
					elseif inAir and not nearGround then
						-- Truly airborne (no ground within range) — don't touch Y at all
						targetY = currentVel.Y
					end

					-- Apply calculated velocity
					rootPart.AssemblyLinearVelocity = Vector3.new(
						slideVec.X * slideMomentum,
						targetY,
						slideVec.Z * slideMomentum
					)
				else
					-- Slide ended: keep low friction while still moving fast for smooth exit
					if currentHoriz > configuredSpeed * 1.2 then
						-- Still fast — keep friction off, let speed decay naturally
						if not backslideFrictionSet then
							backslideFrictionSet = true
							pcall(function()
								rootPart.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							end)
						end
					else
						-- Speed dropped to walkspeed range — restore normal friction
						if backslideFrictionSet then
							backslideFrictionSet = false
							pcall(function()
								rootPart.CustomPhysicalProperties = nil
							end)
						end
						if currentHoriz < 2 then
							slideMomentum = 0
							peakAirSpeed = 0
						end
					end
				end
			else
				if backslideFrictionSet then
					backslideFrictionSet = false
					pcall(function()
						rootPart.CustomPhysicalProperties = nil
					end)
				end
			end
		else
			if backslideFrictionSet then
				backslideFrictionSet = false
				pcall(function()
					rootPart.CustomPhysicalProperties = nil
				end)
			end
		end
		-- 8. Air Jump (Re-jumps in mid-air when holding Spacebar as soon as descending slightly) --
		if MovementSettings.AirJump and inAir then
			local isTyping = UserInputService:GetFocusedTextBox() ~= nil
			if not isTyping and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				if rootPart.AssemblyLinearVelocity.Y < -0.5 then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					humanoid.Jump = true
					
					local jumpVel = 50
					pcall(function()
						if humanoid.UseJumpPower then
							jumpVel = humanoid.JumpPower > 0 and humanoid.JumpPower or 50
						else
							jumpVel = math.sqrt(2 * workspace.Gravity * (humanoid.JumpHeight > 0 and humanoid.JumpHeight or 7.2))
						end
					end)
					rootPart.AssemblyLinearVelocity = Vector3.new(
						rootPart.AssemblyLinearVelocity.X,
						jumpVel,
						rootPart.AssemblyLinearVelocity.Z
					)
				end
			end
		end
	end)
	
	-- 4. Infinite Jump --
	local function doInfJump()
		if not MovementSettings.InfJump or isUnloaded then return end
		if UserInputService:GetFocusedTextBox() ~= nil then return end
		
		local character = LocalPlayer.Character
		if not character then return end
		
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if humanoid and rootPart and humanoid.Health > 0 then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			humanoid.Jump = true
			
			local jumpVel = 50
			pcall(function()
				if humanoid.UseJumpPower then
					jumpVel = humanoid.JumpPower > 0 and humanoid.JumpPower or 50
				else
					jumpVel = math.sqrt(2 * workspace.Gravity * (humanoid.JumpHeight > 0 and humanoid.JumpHeight or 7.2))
				end
			end)
			rootPart.AssemblyLinearVelocity = Vector3.new(rootPart.AssemblyLinearVelocity.X, jumpVel, rootPart.AssemblyLinearVelocity.Z)
		end
	end
	
	UserInputService.JumpRequest:Connect(doInfJump)
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
			doInfJump()
		end
	end)
end)

local Raging = Rage:AddSection({
	Name = "MAIN"
})

local Selection = Rage:AddSection({
	Name = "SELECTION",
	Position = 'left'
})

local Other = Rage:AddSection({
	
	Name = "OTHER",
	Position = 'right'
})

local AntiAim = Rage:AddSection({
	Name = "ANTI-AIM",
	Position = 'right'
})


-- Something like paragraph: <STRING : TEXT, BOOLEAN : WARP> --
local EnabledRage = Raging:AddLabel('Enabled')
local SlientAim = Raging:AddLabel('Silent Aim')

-- Creating ToolTip
EnabledRage:ToolTip("Dynamically adjusts grenade throw angles to counteract\nmovement velocity, allowing precise straight-line throws\neven while strafing")
EnabledRage:AddToggle({
	Default = false,
	Callback = print;
	Flag = "Ragebot",
})

EnabledRage:AddOption():AddLabel("Force Shoot"):AddToggle({
	Default = false,
	Callback = print,
	Flag = "FS"
})

SlientAim:AddToggle({
	Default = false,
	Callback = print,
	Flag = "SLIENTAIM",
})

local opt = SlientAim:AddOption();
opt:AddLabel('Perfect Silent-Aim'):AddToggle({
	Default = false,
	Callback = print,
	Flag = "HideShot",
})

opt:AddLabel('Perfect Silent-Aim'):AddToggle({
	Default = false,
	Callback = print,
	Flag = "HideShot2",
})

Raging:AddLabel('Automatic Fire'):AddToggle({
	Default = false,
	Flag = "AutoFire",
})

Raging:AddLabel('Aim Through Walls'):AddToggle({
	Default = false,
	Flag = "AWALLS",
})

Raging:AddLabel('Field of View'):AddSlider({
	Min = 0,
	Max = 2600,
	Rounding = 1,
	Default = 100,
	Type = "Lv",
	Size = 100,
	Callback = print,
	Flag = "fov",
})

Selection:AddLabel("Target"):AddDropdown({
	Default = 'Hightest Damage',
	Values = {
		'Hightest Damage',
		'Automatic',
		'Lowest Damage'
	},
	Callback = print,
	Flag = "target_box",
})

Selection:AddLabel('Hitboxes'):AddDropdown({
	Default = {'Head'},
	Multi = true,
	Values = {
		'Head',
		'Body',
		'Arms',
		'Legs'
	},
	Flag = "hitboxes",
	Callback = print
})

local Multipoint = Selection:AddLabel('Multipoint')

Multipoint:AddOption():AddLabel('Multipoint'):AddSlider({
	Min = 0,
	Max = 100,
	Default = 75,
	Flag = "multipoint",
	Callback = print
})

Multipoint:AddDropdown({
	Default = {'Head'},
	Multi = true,
	Values = {
		'Head',
		'Body',
		'Arms',
		'Legs'
	},
	Flag = "hitboxmuklti",
	Callback = print
})

local hc = Selection:AddLabel('Hit Chance')

hc:AddSlider({
	Min = 0,
	Max = 100,
	Type = "%",
	Nums = {
		[0] = 'Auto',
	},
	Flag = "hc",
	Size = 95,
	Default = 50,
})

hc:AddOption():AddLabel('Something'):AddToggle({
	Default = false
})

local md = Selection:AddLabel('Min Damage')

md:AddSlider({
	Min = 0,
	Max = 100,
	Nums = {
		[0] = 'Auto',
	},
	Flag = "md",
	Size = 95,
	Default = 15,
})

md:AddOption():AddLabel('Something'):AddToggle({
	Default = false
})

local qs = Selection:AddLabel('Quick Stop')

qs:AddToggle({
	Default = false,
	Flag = "astop",
	Callback = print
})

qs:AddOption():AddLabel('Auto Stop'):AddDropdown({
	Default = {'Early'},
	Multi = true,
	Flag = "astop_module",
	Values = {'Early','In Air','Between Shot' , 'Force Accurate'},
	Callback = print
})

Selection:AddLabel('Quick Scope'):AddToggle({
	Default = false,
	Flag = "ascope",
	Callback = print
})

Other:AddLabel('History'):AddDropdown({
	Default = 'High',
	Values = {'Minimum','Low','High','Maximum'},
	Flag = "backtrack",
	Callback = print
})

Other:AddLabel('Delay Shot'):AddToggle({
	Default = false,
	Flag = "delayshoot",
	Callback = print
})

Other:AddLabel('Remove Recoil'):AddToggle({
	Default = false,
	Flag = "removerecoil",
	Callback = print
})


Other:AddLabel('Remove Spread'):AddToggle({
	Default = false,
	Flag = "removespread",
	Callback = print
})


Other:AddLabel('Duck Peek Assist'):AddToggle({
	Default = false,
	Callback = print
})


local qpa = Other:AddLabel('Quick Peek Assist');
qpa:AddToggle({
	Default = false,
	Flag = "qpa",
	Callback = print
})

qpa:AddOption():AddLabel('Something tung tung')

Other:AddLabel('Double Tap'):AddToggle({
	Default = false,
	Callback = print,
	Flag = "dt",
})

local aa_enable = AntiAim:AddLabel('Enabled');
aa_enable:AddToggle({
	Default = false,
	Flag = "aa",
	Callback = print
})

aa_enable:AddOption():AddLabel('Resolvers tung tung'):AddToggle({
	Default = false,
	Callback = print
})

AntiAim:AddLabel('Pitch'):AddDropdown({
	Default = 'Down',
	Flag = "pitch",
	Values = {'Down','Center','Up','Fake Up','Fake Down'}
})

AntiAim:AddLabel('Yaw'):AddDropdown({
	Default = 'Backwards',
	Flag = "yaw",
	Values = {'Backwards','Left','Right','Forwards'}
})

AntiAim:AddLabel('Freestanding'):AddToggle({
	Default = false,
	Flag = "freestand",
	Callback = print
})

AntiAim:AddLabel('Mouse Override'):AddToggle({
	Default = false,
	Flag = "mouse_override",
	Callback = print
})

---------- Menu Configuration ------------
window.UserSettings:AddLabel("Menu Keybind"):AddKeybind({
	Default = 'Insert',
	Callback = function(v)
		window.Keybind = v;
		Logging.new("ps4-touchpad",'Changed ui keybind to '..tostring(v),5)
	end,
})
pcall(function()
	window:SetSize(NeverLose.Scales.Default)
end)


-- Optimize ZIndex layering without performance overhead --
task.spawn(function()
	task.wait(0.2)
	pcall(function()
		if NeverLose and NeverLose.ScreenGui then
			NeverLose.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		end
	end)
end)

-- In-Game Debug Log Console Engine --
local debugGui = nil
local debugLogContainer = nil
local debugLogConnection = nil

local function clearDebugConsole()
	if debugLogConnection then
		pcall(function() debugLogConnection:Disconnect() end)
		debugLogConnection = nil
	end
	if debugGui then
		pcall(function() debugGui:Destroy() end)
		debugGui = nil
	end
end

local function addDebugLogEntry(msg, msgType)
	if not debugLogContainer or not debugLogContainer.Parent then return end
	
	local timeStr = os.date("%H:%M:%S")
	local entryText = "[" .. timeStr .. "] " .. tostring(msg)
	
	local textColor = Color3.fromRGB(220, 220, 220)
	if msgType == Enum.MessageType.MessageError then
		textColor = Color3.fromRGB(255, 75, 75)
	elseif msgType == Enum.MessageType.MessageWarning then
		textColor = Color3.fromRGB(255, 200, 50)
	elseif msgType == Enum.MessageType.MessageInfo then
		textColor = Color3.fromRGB(100, 200, 255)
	end
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 0, 16)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Code
	label.TextSize = 12
	label.TextColor3 = textColor
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.TextWrapped = true
	label.Text = entryText
	label.Parent = debugLogContainer
	
	local children = debugLogContainer:GetChildren()
	if #children > 60 then
		for i = 1, #children - 60 do
			if children[i]:IsA("TextLabel") then
				children[i]:Destroy()
			end
		end
	end
	
	debugLogContainer.CanvasPosition = Vector3.new(0, 99999, 0)
end

local function updateDebugConsole()
	clearDebugConsole()
	if isUnloaded or not DebugSettings.Enabled then return end
	
	local lp = game:GetService("Players").LocalPlayer
	local parentGui = game:GetService("CoreGui")
	if lp and lp:FindFirstChild("PlayerGui") then
		parentGui = lp.PlayerGui
	end
	
	debugGui = Instance.new("ScreenGui")
	debugGui.Name = "NeverloseDebugConsoleGui"
	debugGui.ResetOnSpawn = false
	debugGui.DisplayOrder = 999
	debugGui.Parent = parentGui
	
	local frame = Instance.new("Frame")
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 340, 0, 210)
	frame.Position = UDim2.new(0, 15, 0, 15)
	frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	frame.BackgroundTransparency = 0.15
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true
	frame.Parent = debugGui
	
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = frame
	
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = Color3.fromRGB(45, 45, 60)
	uiStroke.Thickness = 1
	uiStroke.Parent = frame
	
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 26)
	header.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
	header.BorderSizePixel = 0
	header.Parent = frame
	
	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 8)
	headerCorner.Parent = header
	
	local headerTitle = Instance.new("TextLabel")
	headerTitle.Size = UDim2.new(1, -10, 1, 0)
	headerTitle.Position = UDim2.new(0, 10, 0, 0)
	headerTitle.BackgroundTransparency = 1
	headerTitle.Font = Enum.Font.GothamBold
	headerTitle.TextSize = 11
	headerTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	headerTitle.TextXAlignment = Enum.TextXAlignment.Left
	headerTitle.Text = "NEVERLOSE // DEBUG CONSOLE"
	headerTitle.Parent = header
	
	local scroll = Instance.new("ScrollingFrame")
	scroll.Name = "LogContainer"
	scroll.Size = UDim2.new(1, -10, 1, -34)
	scroll.Position = UDim2.new(0, 5, 0, 30)
	scroll.BackgroundTransparency = 1
	scroll.BorderSizePixel = 0
	scroll.ScrollBarThickness = 4
	scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
	scroll.Parent = frame
	
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 2)
	layout.Parent = scroll
	
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 5)
		scroll.CanvasPosition = Vector3.new(0, 99999, 0)
	end)
	
	debugLogContainer = scroll
	
	addDebugLogEntry("Debug console initialized", Enum.MessageType.MessageInfo)
	
	debugLogConnection = game:GetService("LogService").MessageOut:Connect(function(msg, msgType)
		local msgStr = tostring(msg)
		if not msgStr:find("ReplicatedStorage%.Objects") 
		   and not msgStr:find("ReplicatedStorage%.Services")
		   and not msgStr:find("ReplicatedStorage%.Packages") then
			addDebugLogEntry(msg, msgType)
		end
	end)
end



-- Revive & Fast Revive Background System --
task.spawn(function()
	local Players = game:GetService("Players")
	local lp = Players.LocalPlayer
	while task.wait(0.2) do
		if isUnloaded or not MovementSettings.Revive then continue end
		pcall(function()
			local mode = MovementSettings.ReviveMode or "Both"
			local delayVal = MovementSettings.ReviveDelay or 0

			-- Fast Revive for Friends / Teammates
			if mode == "Friend" or mode == "Both" then
				local gameFolder = workspace:FindFirstChild("Game")
				local settingsObj = gameFolder and gameFolder:FindFirstChild("Settings")
				if settingsObj then
					settingsObj:SetAttribute("ReviveTime", delayVal)
				end
			end

			-- Self Revive
			if mode == "Self" or mode == "Both" then
				local char = lp and lp.Character
				if char and char:GetAttribute("Downed") == true then
					if not _G.LastSelfReviveTime or tick() - _G.LastSelfReviveTime >= (delayVal + 1.5) then
						_G.LastSelfReviveTime = tick()
						task.spawn(function()
							if delayVal > 0 then task.wait(delayVal) end
							local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
							if events then
								local reviveEv = events:FindFirstChild("Revive")
								if reviveEv and reviveEv:IsA("RemoteEvent") then
									reviveEv:FireServer(lp)
								end
							end
						end)
					end
				end
			end
		end)
	end
end)

-- Jump Bug Engine (StateChanged, boosts on first jump) --
task.spawn(function()
	local lp2 = game:GetService("Players").LocalPlayer

	local function hookCharacter(char2)
		if not char2 then return end
		local root2 = char2:WaitForChild("HumanoidRootPart", 5)
		local hum2 = char2:WaitForChild("Humanoid", 5)
		if not root2 or not hum2 then return end

		hum2.StateChanged:Connect(function(old, new)
			if isUnloaded then return end
			if not MovementSettings.JumpBug then return end
			if new ~= Enum.HumanoidStateType.Jumping then return end
			-- Apply boost the moment Roblox sets Jumping state
			local vel = root2.AssemblyLinearVelocity
			local boosted = Vector3.new(vel.X, math.max(vel.Y, 25), vel.Z)
			root2.AssemblyLinearVelocity = boosted
			pcall(function() root2.Velocity = boosted end)
		end)
	end

	if lp2.Character then hookCharacter(lp2.Character) end
	lp2.CharacterAdded:Connect(hookCharacter)
end)

-- FreeCam Engine --
task.spawn(function()
	local RunService = game:GetService("RunService")
	local UIS = game:GetService("UserInputService")
	local Players = game:GetService("Players")
	local lp = Players.LocalPlayer

	local freeCamActive = false
	local savedCamType = nil
	local savedMouseBehavior = nil
	local freeCamPos = Vector3.new(0, 0, 0)
	local freeCamYaw = 0
	local freeCamPitch = 0
	local freeCamConn = nil

	local function enableFreeCam()
		local cam = workspace.CurrentCamera
		if not cam then return end

		local char = lp.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		-- Freeze character on server
		if root then
			root.Anchored = true
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end

		-- Save original camera & mouse state
		savedCamType = cam.CameraType
		savedMouseBehavior = UIS.MouseBehavior

		cam.CameraType = Enum.CameraType.Scriptable

		-- Init camera position and angles from current cam
		freeCamPos = cam.CFrame.Position
		local rx, ry = cam.CFrame:ToEulerAnglesYXZ()
		freeCamPitch = rx
		freeCamYaw = ry

		UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

		freeCamConn = RunService.RenderStepped:Connect(function(dt)
			if isUnloaded or not MovementSettings.FreeCam then return end

			local cam2 = workspace.CurrentCamera
			if not cam2 then return end

			-- Keep mouse locked every frame (some Roblox scripts reset it)
			UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

			-- Mouse look
			local delta = UIS:GetMouseDelta()
			freeCamYaw   = freeCamYaw   - delta.X * 0.003
			freeCamPitch = math.clamp(freeCamPitch - delta.Y * 0.003, -math.rad(89), math.rad(89))

			-- Build rotation
			local rot = CFrame.fromEulerAnglesYXZ(freeCamPitch, freeCamYaw, 0)

			-- Movement
			local move = Vector3.zero
			local spd = MovementSettings.FreeCamSpeed * dt
			if not UIS:GetFocusedTextBox() then
				if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + rot.LookVector end
				if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - rot.LookVector end
				if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - rot.RightVector end
				if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + rot.RightVector end
				if UIS:IsKeyDown(Enum.KeyCode.E) or UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
				if UIS:IsKeyDown(Enum.KeyCode.Q) or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
				if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then spd = spd * 3 end
			end

			if move.Magnitude > 0 then
				freeCamPos = freeCamPos + move.Unit * spd
			end

			cam2.CFrame = CFrame.new(freeCamPos) * rot
		end)
	end

	local function disableFreeCam()
		if freeCamConn then freeCamConn:Disconnect(); freeCamConn = nil end

		-- Unfreeze character
		local char = lp.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if root then
			root.Anchored = false
		end

		-- Release mouse behavior
		UIS.MouseBehavior = Enum.MouseBehavior.Default

		-- Restore camera subject & camera type immediately
		local cam = workspace.CurrentCamera
		if cam then
			cam.CameraType = Enum.CameraType.Custom
			if hum then
				cam.CameraSubject = hum
			elseif root then
				cam.CameraSubject = root
			end
		end

		task.defer(function()
			local cam2 = workspace.CurrentCamera
			if cam2 then
				cam2.CameraType = Enum.CameraType.Custom
				local char2 = lp.Character
				local hum2 = char2 and char2:FindFirstChildOfClass("Humanoid")
				if hum2 then
					cam2.CameraSubject = hum2
				end
			end
			UIS.MouseBehavior = Enum.MouseBehavior.Default

			pcall(function()
				local PlayerModule = require(lp.PlayerScripts:WaitForChild("PlayerModule", 0.5))
				if PlayerModule then
					local cameras = PlayerModule:GetCameras()
					if cameras and cameras.Update then
						cameras:Update(0)
					end
				end
			end)
		end)
	end

	-- Watch toggle
	RunService.Heartbeat:Connect(function()
		if isUnloaded then return end

		if MovementSettings.FreeCam and not freeCamActive then
			freeCamActive = true
			enableFreeCam()
		elseif not MovementSettings.FreeCam and freeCamActive then
			freeCamActive = false
			disableFreeCam()
		end
	end)
end)

-- First-Person Menu Lock (Freezes Camera Rotation & Unlocks Cursor, while allowing WASD / Shift / Ctrl Movement) --
task.spawn(function()
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local savedCamRotation = nil
	local wasMenuOpen = false

	RunService.RenderStepped:Connect(function()
		if isUnloaded then return end

		local isMenuOpen = false
		pcall(function()
			if window and window.Signal then
				isMenuOpen = window.Signal:GetValue()
			end
		end)

		if isMenuOpen then
			-- Unlock mouse cursor for clicking menu
			UserInputService.MouseIconEnabled = true
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default

			-- Freeze camera ROTATION only (allow camera POSITION to follow WASD/Shift/Ctrl movement)
			if not MovementSettings.FreeCam then
				local Camera = workspace.CurrentCamera
				if Camera then
					if not wasMenuOpen then
						wasMenuOpen = true
						savedCamRotation = Camera.CFrame - Camera.CFrame.Position
					end
					if savedCamRotation then
						local currentPos = Camera.CFrame.Position
						Camera.CFrame = CFrame.new(currentPos) * savedCamRotation
					end
				end
			end
		else
			if wasMenuOpen then
				wasMenuOpen = false
				savedCamRotation = nil
				pcall(function()
					UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				end)
				task.defer(function()
					pcall(function()
						UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
					end)
				end)
			end
		end
	end)
end)

-- Unload Functionality --
local UserInputService = game:GetService("UserInputService")

local function UnloadScript()
	if isUnloaded then return end
	cleanupNoClip()
	isUnloaded = true
	clearParticles()
	clearTestWeather()
	clearDebugConsole()
	getgenv().UnloadNeverLoseScript = nil

	-- Reset Local Player Visuals (Chams, Overlay, Glow) --
	pcall(function()
		if LocalVisualsState then
			LocalVisualsState.Chams = false
			LocalVisualsState.Overlay = false
			LocalVisualsState.Glow = false
			if typeof(updateLocalPlayerVisuals) == "function" then
				updateLocalPlayerVisuals()
			end
		end
		local lp = game:GetService("Players").LocalPlayer
		local char = lp and lp.Character
		if char then
			local chams = char:FindFirstChild("LocalChamsHighlight")
			if chams then chams:Destroy() end
			local glow = char:FindFirstChild("LocalGlowHighlight")
			if glow then glow:Destroy() end
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					local orig = part:FindFirstChild("OriginalMaterial")
					if orig then
						pcall(function() part.Material = Enum.Material[orig.Value] end)
						orig:Destroy()
					end
				end
			end
		end
	end)
	
	-- 1. Direct UI & Library Cleanup --
	pcall(function()
		if NeverLose and NeverLose.Unload then
			NeverLose:Unload()
		end
	end)
	pcall(function()
		if window and window.Destroy then
			window:Destroy()
		end
	end)
	pcall(function() if bindGui then bindGui:Destroy() end end)
	pcall(function() if screenGlowGui then screenGlowGui:Destroy() end end)
	pcall(function() if NeverLose and NeverLose.ScreenGui then NeverLose.ScreenGui:Destroy() end end)
	pcall(function() if window and window.ScreenGui then window.ScreenGui:Destroy() end end)
	
	-- 2. Remove Blur and Lighting Effects --
	pcall(function()
		local Lighting = game:GetService("Lighting")
		for _, effect in ipairs(Lighting:GetChildren()) do
			if effect:IsA("BlurEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("PostEffect") then
				pcall(function() effect:Destroy() end)
			end
		end
	end)

	-- 3. Remove Camera Post Effects & Attached Parts --
	pcall(function()
		local Camera = workspace.CurrentCamera
		if Camera then
			for _, child in ipairs(Camera:GetChildren()) do
				if child:IsA("PostEffect") or child:IsA("BlurEffect") or child:IsA("DepthOfFieldEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("BasePart") or child:IsA("Model") or child:IsA("Folder") then
					pcall(function() child:Destroy() end)
				end
			end
		end
	end)

	-- 4. Remove Workspace 3D UI parts --
	pcall(function()
		for _, child in ipairs(workspace:GetChildren()) do
			local name = child.Name:lower()
			if name:find("neverlose") or name:find("3dmenu") or name:find("uiparts") or name:find("blur") then
				pcall(function() child:Destroy() end)
			end
		end
	end)
	
	-- 5. Comprehensive GUI Cleanup --
	local function cleanupContainer(parent)
		if not parent then return end
		for _, child in ipairs(parent:GetChildren()) do
			local name = child.Name:lower()
			local isMatch = name:find("neverlose") or name:find("modulebinding") or name:find("purpleglow") 
				or name:find("indicator") or name:find("watermark") or name:find("notification") 
				or name:find("blur") or name:find("glow") or name:find("effect")
			
			if isMatch or child == (NeverLose and NeverLose.ScreenGui) or child == (window and window.ScreenGui) then
				pcall(function() child:Destroy() end)
			elseif child:IsA("ScreenGui") or child:IsA("Folder") or child:IsA("SurfaceGui") or child:IsA("BillboardGui") then
				if child:FindFirstChild("PurpleGlowEffect") or child:FindFirstChild("Neverlose") then
					pcall(function() child:Destroy() end)
				end
			end
		end
	end
	
	pcall(function() cleanupContainer(game:GetService("CoreGui")) end)
	pcall(function()
		local lp = game:GetService("Players").LocalPlayer
		if lp then cleanupContainer(lp:FindFirstChild("PlayerGui")) end
	end)
	pcall(function()
		if gethui then cleanupContainer(gethui()) end
	end)
end

getgenv().UnloadNeverLoseScript = UnloadScript

-- Keybind listener for Delete (Del) key --
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Delete then
		UnloadScript()
	end
end)

window.UserSettings:AddButton({
	Icon = 'trash-can',
	Name = 'Unload',
	Callback = function()
		UnloadScript()
	end,
})

Notification.new({
	Title = "Scorp",
	Content = "Initialization complete",
	Duration = 5,
})

Logging.new("crosshairs",'Loaded Movement Script',5)

-- Initial state for Watermark and Keybind Indicators --
if typeof(updateWatermarkDisplay) == "function" then
	pcall(updateWatermarkDisplay)
end
if typeof(updateKeybindsDisplay) == "function" then
	pcall(updateKeybindsDisplay)
end

-- Bottom Center Movement HUD (px / ag / lj + speedometer) --
task.spawn(function()
	local CoreGui = game:GetService("CoreGui")
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local lp = Players.LocalPlayer

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MovementHUD"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	pcall(function() screenGui.Parent = CoreGui end)

	_G.SetMovementHUDVisible = function(vis)
		if screenGui then
			screenGui.Enabled = vis
		end
	end

	-- Container: centered horizontally, 75% down the screen
	local container = Instance.new("Frame")
	container.Name = "HUDContainer"
	container.BackgroundTransparency = 1
	container.AnchorPoint = Vector2.new(0.5, 0.5)
	container.Position = UDim2.new(0.5, 0, 0.80, 0)
	container.Size = UDim2.new(0, 400, 0, 70)
	container.Parent = screenGui

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 5)
	layout.Parent = container

	-- Keybind row (horizontal, auto-centering via UIListLayout)
	local keybindRow = Instance.new("Frame")
	keybindRow.BackgroundTransparency = 1
	keybindRow.AutomaticSize = Enum.AutomaticSize.X
	keybindRow.Size = UDim2.new(0, 0, 0, 30)
	keybindRow.Parent = container

	local keybindLayout = Instance.new("UIListLayout")
	keybindLayout.FillDirection = Enum.FillDirection.Horizontal
	keybindLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	keybindLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	keybindLayout.Padding = UDim.new(0, 14)
	keybindLayout.Parent = keybindRow

	local LABEL_SIZE = 35

	local function makeLabel(text)
		local lbl = Instance.new("TextLabel")
		lbl.BackgroundTransparency = 1
		lbl.AutomaticSize = Enum.AutomaticSize.X
		lbl.Size = UDim2.new(0, 0, 1, 0)
		lbl.Text = text
		lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
		lbl.TextSize = LABEL_SIZE
		lbl.Font = Enum.Font.GothamBold
		lbl.TextTransparency = 0
		lbl.Visible = false  -- hidden by default
		lbl.Parent = keybindRow

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(78, 127, 252)
		stroke.Thickness = 1.5
		stroke.Transparency = 0.25
		stroke.Parent = lbl

		return lbl
	end

	local lblBS = makeLabel("bs")
	local lblPX = makeLabel("ps")
	local lblAG = makeLabel("ag")
	local lblLJ = makeLabel("lj")

	-- Speedometer: independent position, below the keybind row
	local speedLabel = Instance.new("TextLabel")
	speedLabel.BackgroundTransparency = 1
	speedLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	speedLabel.Position = UDim2.new(0.5, 0, 0.845, 0)
	speedLabel.Size = UDim2.new(0, 300, 0, 50)
	speedLabel.Text = "0"
	speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedLabel.TextSize = 41
	speedLabel.Font = Enum.Font.GothamBold
	speedLabel.TextTransparency = 0
	speedLabel.TextXAlignment = Enum.TextXAlignment.Center
	speedLabel.ZIndex = 5
	speedLabel.Parent = screenGui

	-- Blue stroke (menu accent color)
	local speedStroke = Instance.new("UIStroke")
	speedStroke.Color = Color3.fromRGB(78, 127, 252)
	speedStroke.Thickness = 1.5
	speedStroke.Transparency = 0.25
	speedStroke.Parent = speedLabel

	local TweenService = game:GetService("TweenService")
	local peakSpeed = 0
	local lastSpeed = 0

	local function showPeak(spd)
		if spd <= 10 then return end
		pcall(function()
			local ghost = Instance.new("TextLabel")
			ghost.BackgroundTransparency = 1
			ghost.AnchorPoint = Vector2.new(0.5, 0.5)
			ghost.Position = UDim2.new(0.5, 0, 0.845, -15)
			ghost.Size = UDim2.new(0, 300, 0, 40)
			ghost.Text = tostring(spd)
			ghost.TextColor3 = Color3.fromRGB(255, 255, 255)
			ghost.TextSize = 34
			ghost.Font = Enum.Font.GothamBold
			ghost.TextTransparency = 0.1
			ghost.TextXAlignment = Enum.TextXAlignment.Center
			ghost.ZIndex = 4
			ghost.Parent = screenGui

			local ghostStroke = Instance.new("UIStroke")
			ghostStroke.Color = Color3.fromRGB(78, 127, 252)
			ghostStroke.Thickness = 1.5
			ghostStroke.Transparency = 0.25
			ghostStroke.Parent = ghost

			local tweenInfo = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local t1 = TweenService:Create(ghost, tweenInfo, {
				TextTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.845, -45),
			})
			local t2 = TweenService:Create(ghostStroke, tweenInfo, {
				Transparency = 1,
			})
			t1:Play()
			t2:Play()

			t1.Completed:Connect(function()
				pcall(function() ghost:Destroy() end)
			end)
			task.delay(0.7, function()
				pcall(function() ghost:Destroy() end)
			end)
		end)
	end

	RunService.RenderStepped:Connect(function()
		if isUnloaded then
			pcall(function() screenGui:Destroy() end)
			return
		end

		local enabled = MovementSettings.KeybindsEnabled ~= false
		local mode = MovementSettings.KeybindsMode or "Default"
		local showMovement = enabled and (mode == "Movement" or mode == "Both")

		screenGui.Enabled = showMovement

		if not showMovement then return end

		-- Show/hide labels based on toggle state — only visible ones stay in layout (auto-center)
		lblBS.Visible = MovementSettings.AutoBacksliding or false
		lblPX.Visible = MovementSettings.PixelSurf  or false
		lblAG.Visible = MovementSettings.AutoGround or false
		lblLJ.Visible = MovementSettings.LongJump   or false

		-- Speedometer
		local char = lp and lp.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then
			local vel = root.AssemblyLinearVelocity
			local rawSpeed = Vector3.new(vel.X, 0, vel.Z).Magnitude
			local horizSpeed = math.floor(rawSpeed * 10)
			speedLabel.Text = tostring(horizSpeed)

			-- Peak tracking: update peak if going faster
			if horizSpeed > peakSpeed then
				peakSpeed = horizSpeed
			end

			-- Show peak ghost when speed drops 25+ below peak (2.5+ real speed drop)
			if peakSpeed > 50 and (peakSpeed - horizSpeed) >= 25 and horizSpeed < lastSpeed then
				showPeak(peakSpeed)
				peakSpeed = horizSpeed -- reset peak to current so it can build up again
			end

			if horizSpeed < 20 then
				peakSpeed = 0
			end

			lastSpeed = horizSpeed
		else
			speedLabel.Text = "0"
			peakSpeed = 0
			lastSpeed = 0
		end
	end)
end)

-- Auto Ground Engine --
task.spawn(function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local lp = Players.LocalPlayer
	local wasInAir = false
	local landCooldown = false

	RunService.Heartbeat:Connect(function()
		if isUnloaded then return end
		if not MovementSettings.AutoGround then return end
		local char = lp and lp.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not root or not hum then return end

		local inAir = hum.FloorMaterial == Enum.Material.Air
			or hum:GetState() == Enum.HumanoidStateType.Freefall
			or hum:GetState() == Enum.HumanoidStateType.Jumping

		-- Detect pre-landing proximity while falling
		if inAir and not landCooldown then
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = {char}
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			local hit = workspace:Raycast(root.Position, Vector3.new(0, -3.2, 0), rayParams)
			if hit and root.AssemblyLinearVelocity.Y < -3 then
				landCooldown = true
				local vel = root.AssemblyLinearVelocity
				root.AssemblyLinearVelocity = Vector3.new(vel.X, 0, vel.Z)
				pcall(function() root.Velocity = Vector3.new(vel.X, 0, vel.Z) end)
				hum:ChangeState(Enum.HumanoidStateType.Running)
				
				task.delay(0.1, function()
					landCooldown = false
				end)
			end
		end

		-- Detect exact landing frame
		if wasInAir and not inAir and not landCooldown then
			landCooldown = true
			local vel = root.AssemblyLinearVelocity
			if vel.Y < -1 then
				root.AssemblyLinearVelocity = Vector3.new(vel.X, 0, vel.Z)
				pcall(function() root.Velocity = Vector3.new(vel.X, 0, vel.Z) end)
				hum:ChangeState(Enum.HumanoidStateType.Running)
			end
			-- Slide boost: preserve and boost horizontal momentum on touch
			local horizMag = Vector3.new(vel.X, 0, vel.Z).Magnitude
			if horizMag > 3 then
				local newHoriz = Vector3.new(vel.X, 0, vel.Z).Unit * (horizMag * 1.08)
				root.AssemblyLinearVelocity = Vector3.new(newHoriz.X, vel.Y, newHoriz.Z)
			end
			task.delay(0.08, function()
				landCooldown = false
			end)
		end

		wasInAir = inAir
	end)
end)

setLoadProgress(10)
task.delay(0.25, function()
	pcall(function()
		if loaderNotify and loaderNotify.UpdateText then
			loaderNotify:UpdateText("Scorp", "Initialization complete")
		end
	end)
end)

