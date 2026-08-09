--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- #### U CAN USE TS IN UR ROBLOX GAME #### ---

-- Clean up previous script instances if re-executed --
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
if readfile then
	pcall(function()
		if isfile and isfile("source.luau") then
			sourceCode = readfile("source.luau")
		end
	end)
end
if not sourceCode or type(sourceCode) ~= "string" or #sourceCode < 100 then
	pcall(function()
		sourceCode = game:HttpGet("https://raw.githubusercontent.com/desc13374/neverloseui/refs/heads/main/source.luau")
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
			-- Filter out internal game script errors (e.g. Evade's internal Carry / CharacterService scripts)
			if not msgStr:find("ReplicatedStorage%.Objects") 
			   and not msgStr:find("ReplicatedStorage%.Services")
			   and not msgStr:find("ReplicatedStorage%.Packages") then
				logDebug("gear", "[Lua Error]: " .. msgStr, 5)
			end
		end
	end)
end)

-- Creating Indicator --
local Indicator = NeverLose:CreateIndicator();

-- Creating Window --
local window = NeverLose:CreateWindow({
	Logo = NeverLose.GlobalLogo,
	Name = "Neverlose",
	Content = "Movement Verison",
	Size = NeverLose.Scales.Default,
	ConfigFolder = "NeverLoseConfigs",
	Enable3DRenderer = false,
	Keybind = "Insert"
});



-- Creating Watermark --
local Watermark = window:Watermark();


-- Indicators (No-Clip, Air-Stuck, Inf-Jump, Blink, Pixel-Surf)--
local NC = Indicator.new({
	Name = "NC",
	Icon = 'crosshairs',
	Color = 'White',
})

local AS = Indicator.new({
	Name = "AS",
	Icon = 'crosshairs',
	Color = 'White',
})

local IJ = Indicator.new({
	Name = "IJ",
	Icon = 'crosshairs',
	Color = 'White',
})

local BL = Indicator.new({
	Name = "BL",
	Icon = 'crosshairs',
	Color = 'White',
})

local PS = Indicator.new({
	Name = "PX",
	Icon = 'crosshairs',
	Color = 'White',
})

local JB = Indicator.new({
	Name = "JB",
	Icon = 'crosshairs',
	Color = 'White',
})

local LJ = Indicator.new({
	Name = "LJ",
	Icon = 'crosshairs',
	Color = 'White',
})

local AG_Indicator = Indicator.new({
	Name = "AG",
	Icon = 'crosshairs',
	Color = 'White',
})



-- Add Tab Label --
window:AddTabLabel('AIMBOT')

local ping = Watermark:AddBlock("chart-four-vertical-bars" , "0MS");
local UITogg = Watermark:AddBlock("cube-vertexes" , "Neverlose");

UITogg:Input(function()
	window:ToggleInterface();
end);

task.spawn(function()
	while task.wait(1) do
		local ok = pcall(function()
			local rawPing = game:GetService('Players').LocalPlayer:GetNetworkPing() or 0
			local ms = math.floor(rawPing * 1000 + 0.5)
			ping:SetText(tostring(ms)..'MS')
		end)
		if not ok then break end
	end
end)

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
	Name = "Inventory"
})

local Miscellaneous = window:AddTab({
	Icon = 'three-stacked-squares-tilted',
	Name = "Miscellaneous"
})

local VisualsEnemy = Visuals:AddSection({
	Name = "ENEMY",
	Position = 'left'
})

local VisualsLocal = Visuals:AddSection({
	Name = "LOCAL",
	Position = 'left'
})

local VisualsOther = Visuals:AddSection({
	Name = "OTHER",
	Position = 'right'
})

local VisualsWorld = Visuals:AddSection({
	Name = "WORLD",
	Position = 'right'
})

local InvMain = Inventory:AddSection({
	Name = "SKIN CHANGER",
	Position = 'left'
})

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

-- Movement Settings State --
local MovementSettings = {
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
	PixelSurfGlowColor = "Purple",
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
	InfJump = false,
	Fly = false,
	FlySpeed = 50,
	FreeCam = false,
	FreeCamSpeed = 40,
	NoClip = false,
	Blink = false,
	BlinkSpeed = 30,
	SelfRevive = false,
	SelfReviveDelay = 0,
	FastRevive = false,
	FastReviveDelay = 0.2,
	CheckpointsEnabled = false,
	CheckpointSlot = 1,
	CheckpointKeepVelocity = true,
	CheckpointKeepAngles = true,
	CheckpointTeleportMode = "Instant",
	CheckpointSlots = {nil, nil, nil, nil, nil},
	CheckpointSmoothActive = false,
	CheckpointSmoothTarget = nil
}

-- Particles Settings State --
local ParticlesSettings = {
	Enabled = true,
	Mode = "Trails",
	TrailType = "2D Green Smoke"
}

-- Weather / Test Settings State --
local TestSettings = {
	Enabled = false,
	TestEnabled = false,
	Mode = "Snow",
	Glow = 50,
	Count = 150,
	Speed = 20
}

-- Debug Settings State --
local DebugSettings = {
	Enabled = false
}

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
ParticlesSettings.TrailType = "2D Green Smoke"

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
		local lastPositions = {}
		local bufferIndex = 1
		local maxTrailLength = 20
		local updateRate = 0.05
		local lastUpdate = 0
		local trailStyle = ParticlesSettings.TrailType or "Neon"

		local function createNeonTrailPart(pos, color)
			local part = Instance.new("Part")
			local sz = 0.5 + math.random() * 0.4
			part.Name = "NeonTrail"
			part.Size = Vector3.new(sz, sz, sz)
			part.Shape = Enum.PartType.Ball
			part.CFrame = CFrame.new(pos)
			part.Anchored = true
			part.CanCollide = false
			part.Material = Enum.Material.Neon
			part.Color = color
			part.Transparency = 0.15
			part.Parent = particlesFolder

			local sparkle = Instance.new("ParticleEmitter")
			sparkle.Texture = "rbxassetid://10849912115"
			sparkle.Size = NumberSequence.new(0.04, 0)
			sparkle.Lifetime = NumberRange.new(0.3, 0.6)
			sparkle.Rate = 5
			sparkle.Speed = NumberRange.new(0.2, 0.5)
			sparkle.Transparency = NumberSequence.new(0.3, 1)
			sparkle.Color = ColorSequence.new(color)
			sparkle.LightEmission = 1
			sparkle.LightInfluence = 0
			sparkle.Parent = part

			local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(1.8), {Transparency = 1, Size = Vector3.new(0, 0, 0)})
			tween:Play()
			tween.Completed:Connect(function() pcall(function() part:Destroy() end) end)
		end

		local function create2DSmokeTrailPart(pos)
			local part = Instance.new("Part")
			part.Name = "2DSmokePart"
			part.Size = Vector3.new(0.1, 0.1, 0.1)
			part.CFrame = CFrame.new(pos + Vector3.new(0, -0.2, 0))
			part.Anchored = true
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.CastShadow = false
			part.Transparency = 1
			part.Parent = particlesFolder

			-- Distinct Glowing Green Smoke/Flame Chunk Emitter
			local smoke = Instance.new("ParticleEmitter")
			smoke.Name = "GreenSmokeChunk"
			smoke.Texture = "rbxassetid://13470377227" -- Soft 2D glowing smoke/flame orb
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
				ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 255, 60)),
				ColorSequenceKeypoint.new(0.4, Color3.fromRGB(30, 230, 50)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 130, 25))
			})
			smoke.LightEmission = 0.65
			smoke.LightInfluence = 0
			smoke.Orientation = Enum.ParticleOrientation.FacingCamera
			smoke.Parent = part

			-- Floating Green Embers / Leaves
			local embers = Instance.new("ParticleEmitter")
			embers.Name = "GreenEmbers"
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
			embers.Color = ColorSequence.new(Color3.fromRGB(140, 255, 80))
			embers.LightEmission = 0.9
			embers.LightInfluence = 0
			embers.Orientation = Enum.ParticleOrientation.FacingCamera
			embers.Parent = part

			smoke:Emit(3)
			embers:Emit(2)

			game:GetService("Debris"):AddItem(part, 1.2)
		end

		local lastSpawnPos = nil
		local minChunkDistance = 0.6 -- Distance (in studs) between each distinct smoke chunk!

		particlesConn = game:GetService("RunService").Heartbeat:Connect(function()
			local char = lp.Character
			if not char then return end
			local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
			if not root then return end

			local currentPos = root.Position

			-- Distance check: ONLY spawn a new chunk when moved at least minChunkDistance studs --
			if lastSpawnPos then
				local dist = (currentPos - lastSpawnPos).Magnitude
				if dist < minChunkDistance then return end
			end
			lastSpawnPos = currentPos

			local currentStyle = ParticlesSettings.TrailType or "2D Green Smoke"
			if currentStyle == "Neon" then
				local now = tick()
				createNeonTrailPart(currentPos, Color3.fromHSV((now % 3) / 3, 1, 1))
			else
				create2DSmokeTrailPart(currentPos)
			end
		end)

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
			Color = Color3.fromRGB(math.floor(215 + 40 * glowVal), math.floor(235 + 20 * glowVal), 255),
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
			pile.Color = Color3.fromRGB(235 + math.random(0, 20), 245 + math.random(0, 10), 255)
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
			ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 220, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 255))
		})
		emitter.RotSpeed = NumberRange.new(-90, 90)
		emitter.Enabled = true
		emitter.Parent = part

	elseif mode == "Stars" then
		local StarsFolder = Instance.new("Folder")
		StarsFolder.Name = "PortalVisual_Stars"
		StarsFolder.Parent = testWeatherFolder

		local starColor = Color3.fromRGB(math.floor(215 + 40 * glowVal), math.floor(210 + 45 * glowVal), 150)
		local trailColor = Color3.fromRGB(255, math.floor(160 + 65 * glowVal), 80)
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
					pe.Color = ColorSequence.new(Color3.fromRGB(210, 235, 255))
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
					drop.Color = Color3.fromRGB(math.floor(180 + 75 * glowVal), math.floor(210 + 45 * glowVal), 255)
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
	Min = 33.3,
	Max = 55.5,
	Default = MovementSettings.AirStrafeSpeed or 40,
	Size = 140,
	Flag = "airstrafe_speed",
	Callback = function(v)
		MovementSettings.AirStrafeSpeed = v
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
		if JB then JB:SetRender(v) end
		saveConfig()
	end
})

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
	local selectedColor = colorMap[MovementSettings.PixelSurfGlowColor or "Purple"] or Color3.fromRGB(160, 32, 240)
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

local pixelsurf = MiscMovement:AddLabel('Pixel Surf')
pixelsurf:AddToggle({
	Default = MovementSettings.PixelSurf or false,
	Flag = "pixelsurf",
	Callback = function(v)
		MovementSettings.PixelSurf = v
		if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
		if PS then PS:SetRender(v) end
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

psOpt:AddLabel('Glow Color'):AddDropdown({
	Default = MovementSettings.PixelSurfGlowColor or 'Purple',
	Values = {'Purple', 'Cyan', 'Red', 'Green', 'Blue', 'Yellow', 'Pink', 'Orange', 'White'},
	Flag = "pixelsurf_color",
	Callback = function(v)
		MovementSettings.PixelSurfGlowColor = v
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
		if AG_Indicator then AG_Indicator:SetRender(v) end
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
		if LJ then LJ:SetRender(v) end
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

local stuckCFrame = nil

local airstuck = MiscOther:AddLabel('Air Stuck')
airstuck:ToolTip("Freezes character position mid-air when enabled")
airstuck:AddToggle({
	Default = MovementSettings.AirStuck or false,
	Flag = "airstuck",
	Callback = function(v)
		MovementSettings.AirStuck = v
		if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
		if AS then AS:SetRender(v) end
		if v and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character then
			local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if root then
				stuckCFrame = root.CFrame
			end
		else
			stuckCFrame = nil
		end
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
		if IJ then IJ:SetRender(v) end
		saveConfig()
	end
})

local fly = MiscOther:AddLabel('Fly')
fly:AddToggle({
	Default = MovementSettings.Fly or false,
	Flag = "fly_enabled",
	Callback = function(v)
		MovementSettings.Fly = v
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

local freecam = MiscOther:AddLabel('Free Cam')
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

local speed = MiscOther:AddLabel('Speed')
speed:AddToggle({
	Default = MovementSettings.Speed or false,
	Flag = "speed_enabled",
	Callback = function(v)
		MovementSettings.Speed = v
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

local debugConsole = MiscOther:AddLabel('Debug')
debugConsole:ToolTip("Displays an in-game live error and log window in the top-left corner of the screen")
debugConsole:AddToggle({
	Default = DebugSettings.Enabled or false,
	Flag = "debug_console_enabled",
	Callback = function(v)
		DebugSettings.Enabled = v
		if typeof(updateDebugConsole) == "function" then
			pcall(updateDebugConsole)
		end
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
		if NC then NC:SetRender(v) end
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
		if BL then BL:SetRender(v) end
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

local revive = MiscOther:AddLabel('Revive')
revive:ToolTip("Auto-revives you when downed or fast-revives teammates")
revive:AddToggle({
	Default = MovementSettings.Revive or false,
	Flag = "revive_enabled",
	Callback = function(v)
		MovementSettings.Revive = v
		saveConfig()
	end
})

local reviveOpt = revive:AddOption()
reviveOpt:AddLabel('Target Mode'):AddDropdown({
	Default = MovementSettings.ReviveMode or 'Both',
	Values = {'Self', 'Friend', 'Both'},
	Flag = "revive_mode",
	Callback = function(v)
		MovementSettings.ReviveMode = v
		saveConfig()
	end
})

reviveOpt:AddLabel('Delay'):AddSlider({
	Min = 0,
	Max = 10,
	Default = MovementSettings.ReviveDelay or 0,
	Size = 140,
	Flag = "revive_delay",
	Callback = function(v)
		MovementSettings.ReviveDelay = v
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

local function getBindText(flag)
	if ModuleBinds and ModuleBinds[flag] and ModuleBinds[flag].Key then
		local k = ModuleBinds[flag].Key
		if typeof(k) == "EnumItem" then return "[" .. k.Name .. "]" end
		return "[" .. tostring(k) .. "]"
	end
	return "[?]"
end

local saveCpBtn = cpOpt:AddButton({
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

local loadCpBtn = cpOpt:AddButton({
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

local delCpBtn = cpOpt:AddButton({
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
-- ESP Preview GUI Creation --
local espMainFrame = Instance.new("CanvasGroup")
espMainFrame.Name = "ESPPreviewMainFrame"
espMainFrame.Size = UDim2.new(0, 220, 0, 420)
espMainFrame.Position = UDim2.new(0.5, 330, 0.5, -240)
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

local function updateEspPreviewVisibility()
	local shouldBeVisible = isEnemyEspEnabled and isVisualsTabActive and isWindowVisible
	espSignal:SetValue(shouldBeVisible)
	if shouldBeVisible then
		TweenService:Create(espMainFrame, espTweenInfo, {
			GroupTransparency = 0,
			Position = UDim2.new(0.5, 330, 0.5, -240)
		}):Play()
	else
		TweenService:Create(espMainFrame, espTweenInfo, {
			GroupTransparency = 1,
			Position = UDim2.new(0.5, 330, 0.5, -225)
		}):Play()
	end
end

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

local localModelItem = VisualsLocal:AddLabel('Model')
local modelOpt = localModelItem:AddOption()

modelOpt:AddLabel('Headless'):AddToggle({
	Default = false,
	Flag = "local_model_headless",
	Callback = function(v)
		if ExecutorFakeVisuals then
			ExecutorFakeVisuals:SetHeadless(v)
		end
		saveConfig()
	end
})

modelOpt:AddLabel('Korblox'):AddToggle({
	Default = false,
	Flag = "local_model_korblox",
	Callback = function(v)
		if ExecutorFakeVisuals then
			ExecutorFakeVisuals:SetKorblox(v)
		end
		saveConfig()
	end
})

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

-- Visuals WORLD Section --
local ambienceItem = VisualsWorld:AddLabel('Ambience')
ambienceItem:AddToggle({
	Default = false,
	Flag = "ambience_enabled",
	Callback = function(v)
		saveConfig()
	end
})

local windowsItem = VisualsWorld:AddLabel('Windows')
local windowsOpt = windowsItem:AddOption()

windowsOpt:AddLabel('Watermark'):AddToggle({
	Default = MovementSettings.WatermarkEnabled ~= false,
	Flag = "watermark_enabled",
	Callback = function(v)
		MovementSettings.WatermarkEnabled = v
		if Watermark then Watermark:SetRender(v) end
		saveConfig()
	end
})

windowsOpt:AddLabel('KeyBinds'):AddToggle({
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

windowsOpt:AddLabel('KeyBinds Mode'):AddDropdown({
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

local trailStyleLabel = nil

particlesOpt:AddLabel('Effect'):AddDropdown({
	Default = ParticlesSettings.Mode or 'Trails',
	Values = {'Trails', 'Orbit', 'Aura Pulse', 'Paradox Engine', 'RGB Circle'},
	Flag = "particles_mode",
	Callback = function(v)
		if ParticlesSettings.Mode == v then return end
		ParticlesSettings.Mode = v
		if trailStyleLabel then
			pcall(function()
				if trailStyleLabel.SetVisible then
					trailStyleLabel:SetVisible(v == "Trails")
				elseif trailStyleLabel.Root then
					trailStyleLabel.Root.Visible = (v == "Trails")
				end
			end)
		end
		if ParticlesSettings.Enabled then
			updateParticles(true)
		end
		saveConfig()
	end
})

trailStyleLabel = particlesOpt:AddLabel('Trail Style')
trailStyleLabel:AddDropdown({
	Default = ParticlesSettings.TrailType or 'Neon',
	Values = {'Neon', '2D Green Smoke'},
	Flag = "particles_trail_style",
	Callback = function(v)
		if ParticlesSettings.TrailType == v then return end
		ParticlesSettings.TrailType = v
		if ParticlesSettings.Enabled and ParticlesSettings.Mode == "Trails" then
			updateParticles(true)
		end
		saveConfig()
	end
})

pcall(function()
	if trailStyleLabel then
		local showTrailsOpt = (ParticlesSettings.Mode or 'Trails') == "Trails"
		if trailStyleLabel.SetVisible then
			trailStyleLabel:SetVisible(showTrailsOpt)
		elseif trailStyleLabel.Root then
			trailStyleLabel.Root.Visible = showTrailsOpt
		end
	end
end)

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
bindFrame.Size = UDim2.new(0, 205, 0, 115)
bindFrame.Position = UDim2.new(0.5, -102, 0.4, -57)
bindFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
bindFrame.BorderSizePixel = 0
bindFrame.Visible = false
bindFrame.ClipsDescendants = true
bindFrame.Parent = bindGui

local bindCorner = Instance.new("UICorner")
bindCorner.CornerRadius = UDim.new(0, 8)
bindCorner.Parent = bindFrame

local bindStroke = Instance.new("UIStroke")
bindStroke.Color = Color3.fromRGB(38, 43, 58)
bindStroke.Thickness = 1.2
bindStroke.Parent = bindFrame

-- Header Title --
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 24)
titleLabel.Position = UDim2.new(0, 12, 0, 6)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Binding module"
titleLabel.TextColor3 = Color3.fromRGB(240, 244, 255)
titleLabel.TextSize = 12
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = bindFrame

-- Trash / Delete Button --
local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(0, 20, 0, 20)
deleteBtn.Position = UDim2.new(1, -28, 0, 7)
deleteBtn.BackgroundTransparency = 1
deleteBtn.Text = "🗑"
deleteBtn.TextColor3 = Color3.fromRGB(220, 65, 65)
deleteBtn.TextSize = 12
deleteBtn.Font = Enum.Font.GothamBold
deleteBtn.Parent = bindFrame

deleteBtn.MouseEnter:Connect(function()
	deleteBtn.TextColor3 = Color3.fromRGB(255, 95, 95)
end)
deleteBtn.MouseLeave:Connect(function()
	deleteBtn.TextColor3 = Color3.fromRGB(220, 65, 65)
end)

-- Header Divider Line --
local headerDivider = Instance.new("Frame")
headerDivider.Size = UDim2.new(1, 0, 0, 1)
headerDivider.Position = UDim2.new(0, 0, 0, 32)
headerDivider.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
headerDivider.BorderSizePixel = 0
headerDivider.Parent = bindFrame

-- Key Row --
local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(0, 60, 0, 26)
keyTitle.Position = UDim2.new(0, 12, 0, 42)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Key"
keyTitle.TextColor3 = Color3.fromRGB(160, 166, 185)
keyTitle.TextSize = 11
keyTitle.Font = Enum.Font.GothamSemibold
keyTitle.TextXAlignment = Enum.TextXAlignment.Left
keyTitle.Parent = bindFrame

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(0, 75, 0, 26)
keyButton.Position = UDim2.new(1, -87, 0, 42)
keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
keyButton.BorderSizePixel = 0
keyButton.Text = "N/A"
keyButton.TextColor3 = Color3.fromRGB(220, 226, 240)
keyButton.TextSize = 11
keyButton.Font = Enum.Font.GothamBold
keyButton.Parent = bindFrame

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.CornerRadius = UDim.new(0, 6)
keyBtnCorner.Parent = keyButton

local keyBtnStroke = Instance.new("UIStroke")
keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
keyBtnStroke.Thickness = 1
keyBtnStroke.Parent = keyButton

-- Mode Row --
local modeTitle = Instance.new("TextLabel")
modeTitle.Size = UDim2.new(0, 70, 0, 26)
modeTitle.Position = UDim2.new(0, 12, 0, 76)
modeTitle.BackgroundTransparency = 1
modeTitle.Text = "Bind mode"
modeTitle.TextColor3 = Color3.fromRGB(160, 166, 185)
modeTitle.TextSize = 11
modeTitle.Font = Enum.Font.GothamSemibold
modeTitle.TextXAlignment = Enum.TextXAlignment.Left
modeTitle.Parent = bindFrame

local holdBtn = Instance.new("TextButton")
holdBtn.Size = UDim2.new(0, 52, 0, 26)
holdBtn.Position = UDim2.new(1, -118, 0, 76)
holdBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
holdBtn.BorderSizePixel = 0
holdBtn.Text = "HOLD"
holdBtn.TextColor3 = Color3.fromRGB(130, 136, 155)
holdBtn.TextSize = 10
holdBtn.Font = Enum.Font.GothamSemibold
holdBtn.Parent = bindFrame

local holdCorner = Instance.new("UICorner")
holdCorner.CornerRadius = UDim.new(0, 6)
holdCorner.Parent = holdBtn

local holdStroke = Instance.new("UIStroke")
holdStroke.Color = Color3.fromRGB(38, 43, 58)
holdStroke.Thickness = 1
holdStroke.Parent = holdBtn

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 56, 0, 26)
toggleBtn.Position = UDim2.new(1, -61, 0, 76)
toggleBtn.BackgroundColor3 = Color3.fromRGB(225, 45, 55)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "TOGGLE"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 10
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = bindFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(255, 80, 85)
toggleStroke.Thickness = 1
toggleStroke.Parent = toggleBtn

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
		holdBtn.BackgroundColor3 = Color3.fromRGB(225, 45, 55)
		holdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		holdBtn.Font = Enum.Font.GothamBold
		holdStroke.Color = Color3.fromRGB(255, 80, 85)
		
		toggleBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		toggleBtn.TextColor3 = Color3.fromRGB(130, 136, 155)
		toggleBtn.Font = Enum.Font.GothamSemibold
		toggleStroke.Color = Color3.fromRGB(38, 43, 58)
	else
		toggleBtn.BackgroundColor3 = Color3.fromRGB(225, 45, 55)
		toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggleBtn.Font = Enum.Font.GothamBold
		toggleStroke.Color = Color3.fromRGB(255, 80, 85)
		
		holdBtn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		holdBtn.TextColor3 = Color3.fromRGB(130, 136, 155)
		holdBtn.Font = Enum.Font.GothamSemibold
		holdStroke.Color = Color3.fromRGB(38, 43, 58)
	end
end

local function formatKeyName(key)
	if not key then return "N/A" end
	local name = (typeof(key) == "EnumItem" and key.Name or tostring(key))
	if name == "MouseButton1" or name == "MouseButton2" then
		return "N/A"
	elseif name == "MouseButton3" then return "MOUSE3"
	elseif name == "MouseButton4" then return "MOUSE4"
	elseif name == "MouseButton5" then return "MOUSE5"
	end
	return name
end

local function getGlobalFn(name)
	if type(_G[name]) == "function" then return _G[name] end
	if getgenv and type(getgenv()[name]) == "function" then return getgenv()[name] end
	if getrenv and type(getrenv()[name]) == "function" then return getrenv()[name] end
	return nil
end

local function checkSideMouse(vk, names)
	local iskeydownFn = getGlobalFn("iskeydown") or getGlobalFn("iskeypressed") or getGlobalFn("GetAsyncKeyState") or getGlobalFn("isbuttonpressed")
	if iskeydownFn then
		local ok, res = pcall(function() return iskeydownFn(vk) end)
		if ok and res then
			return true
		end
		for _, name in ipairs(names) do
			local ok2, res2 = pcall(function() return iskeydownFn(name) end)
			if ok2 and res2 then
				return true
			end
		end
	end
	return false
end

local function isMouse4Down()
	return checkSideMouse(5, {"MouseButton4", "XButton1", "SideButton1", "ThumbButton1", "Button4", "Mouse4", "XBUTTON1"})
end

local function isMouse5Down()
	return checkSideMouse(6, {"MouseButton5", "XButton2", "SideButton2", "ThumbButton2", "Button5", "Mouse5", "XBUTTON2"})
end

local function isMouse3Down()
	local UIS = game:GetService("UserInputService")
	local ok, res = pcall(function() return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton3) end)
	if ok and res then return true end
	return checkSideMouse(4, {"MouseButton3", "MiddleButton", "Mouse3", "Button3"})
end

local function isVKDown(vk)
	return checkSideMouse(vk, {})
end

local function isKeyMatch(input, bindKey)
	if not bindKey or not input then return false end
	local keyName = typeof(bindKey) == "EnumItem" and bindKey.Name or tostring(bindKey)

	if keyName == "M3B" or keyName == "MouseButton3" then
		return isMouse3Down()
	elseif keyName == "M4B" or keyName == "MouseButton4" then
		return isMouse4Down()
	elseif keyName == "M5B" or keyName == "MouseButton5" then
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
	local fullStr = tostring(input.UserInputType) .. " " .. tostring(input.KeyCode)
	
	if keyName == inputTypeName or keyName == keyCodeName then
		return true
	end
	if (keyName == "MouseButton4" or keyName == "MouseButton5") and string.find(fullStr, keyName) then
		return true
	end
	
	return false
end

local function openBindMenu(moduleName, flag, callback)
	currentBindingFlag = flag
	titleLabel.Text = moduleName
	listeningForKey = false
	isMouseOverBindFrame = true
	
	keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
	keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
	
	if not ModuleBinds[flag] then
		ModuleBinds[flag] = { Key = nil, Mode = "TOGGLE", Callback = callback, State = false }
	else
		if callback then ModuleBinds[flag].Callback = callback end
	end
	
	local bindData = ModuleBinds[flag]
	keyButton.Text = formatKeyName(bindData.Key)
	updateModeButtons(bindData.Mode)
	
	local mousePos = UserInputService:GetMouseLocation()
	local cam = workspace.CurrentCamera
	local maxX = cam and cam.ViewportSize.X or 1000
	local maxY = cam and cam.ViewportSize.Y or 800
	
	bindFrame.Position = UDim2.new(0, math.min(mousePos.X, maxX - 215), 0, math.min(mousePos.Y, maxY - 125))
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
	end
end)

keyButton.MouseButton1Click:Connect(function()
	if listeningForKey then
		listeningForKey = false
		keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
		local bindData = currentBindingFlag and ModuleBinds[currentBindingFlag]
		keyButton.Text = bindData and bindData.Key and formatKeyName(bindData.Key) or "N/A"
	else
		listeningForKey = true
		keyButton.BackgroundColor3 = Color3.fromRGB(225, 45, 55)
		keyBtnStroke.Color = Color3.fromRGB(255, 90, 95)
		keyButton.Text = "..."
		ignoreInitialClick = true
		task.defer(function()
			ignoreInitialClick = false
		end)
		
		task.spawn(function()
			local startTime = tick()
			while listeningForKey and (tick() - startTime < 10) do
				task.wait(0.01)
				if not listeningForKey then break end
				if ignoreInitialClick then continue end
				
				local sideKey = nil
				if isMouse4Down() then
					sideKey = "MouseButton4"
				elseif isMouse5Down() then
					sideKey = "MouseButton5"
				end
				
				if sideKey then
					listeningForKey = false
					keyButton.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
					keyBtnStroke.Color = Color3.fromRGB(42, 48, 65)
					
					if currentBindingFlag and ModuleBinds[currentBindingFlag] then
						ModuleBinds[currentBindingFlag].Key = sideKey
						SaveModuleBinds()
					end
					keyButton.Text = formatKeyName(sideKey)
					break
				end
			end
		end)
	end
end)

holdBtn.MouseButton1Click:Connect(function()
	if currentBindingFlag and ModuleBinds[currentBindingFlag] then
		ModuleBinds[currentBindingFlag].Mode = "HOLD"
		updateModeButtons("HOLD")
		SaveModuleBinds()
	end
end)

toggleBtn.MouseButton1Click:Connect(function()
	if currentBindingFlag and ModuleBinds[currentBindingFlag] then
		ModuleBinds[currentBindingFlag].Mode = "TOGGLE"
		updateModeButtons("TOGGLE")
		SaveModuleBinds()
	end
end)

-- Register Modules --
LoadModuleBinds()
registerModule("Bunny Hop", "bhop", function(v) MovementSettings.Bhop = v end)
registerModule("Air Strafer", "airstrafe", function(v) MovementSettings.AirStrafe = v end)
registerModule("Speed", "speed_enabled", function(v) MovementSettings.Speed = v end)
registerModule("Jump Bug", "jumpbug", function(v)
	MovementSettings.JumpBug = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Pixel Surf", "pixelsurf", function(v)
	MovementSettings.PixelSurf = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
	updatePixelSurfGlow()
end)
registerModule("Edge Bug", "edgebug", function(v) MovementSettings.EdgeBug = v end)
registerModule("Auto Align", "autoalign", function(v) MovementSettings.AutoAlign = v end)
registerModule("Auto Ground", "autoground", function(v)
	MovementSettings.AutoGround = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Texture Bug", "texturebug", function(v) MovementSettings.TextureBug = v end)
registerModule("Long Jump", "longjump", function(v)
	MovementSettings.LongJump = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Disable Movement Keys", "disable_keys", function(v) MovementSettings.DisableMovementKeys = v end)
registerModule("Nulls", "nulls", function(v) MovementSettings.Nulls = v end)
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
registerModule("Inf Jump", "infjump", function(v)
	MovementSettings.InfJump = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Fly", "fly_enabled", function(v) MovementSettings.Fly = v end)
registerModule("Free Cam", "freecam_enabled", function(v) MovementSettings.FreeCam = v end)
registerModule("No Clip", "noclip", function(v)
	MovementSettings.NoClip = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Blink", "blink_enabled", function(v)
	MovementSettings.Blink = v
	if typeof(updateKeybindsDisplay) == "function" then pcall(updateKeybindsDisplay) end
end)
registerModule("Revive", "self_revive_enabled", function(v)
	MovementSettings.SelfRevive = v
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
		if input.KeyCode == Enum.KeyCode.Escape then
			selectedKey = nil
		elseif inputTypeName == "MouseButton1" or inputTypeName == "MouseButton2" then
			return -- Ignore MOUSE1 and MOUSE2
		elseif inputTypeName == "MouseButton3" then
			selectedKey = Enum.UserInputType.MouseButton3
		elseif isMouse4Down() or inputTypeName == "MouseButton4" or keyCodeName == "MouseButton4" then
			selectedKey = "MouseButton4"
		elseif isMouse5Down() or inputTypeName == "MouseButton5" or keyCodeName == "MouseButton5" then
			selectedKey = "MouseButton5"
		elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.Unknown then
			selectedKey = input.KeyCode
		elseif input.UserInputType ~= Enum.UserInputType.None and input.UserInputType ~= Enum.UserInputType.Keyboard then
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

-- Dedicated polling loop for side mouse buttons (MOUSE4 & MOUSE5) --
local lastM4State = false
local lastM5State = false

game:GetService("RunService").RenderStepped:Connect(function()
	if UserInputService:GetFocusedTextBox() then return end
	if listeningForKey then return end
	
	local currentM4 = isMouse4Down()
	local currentM5 = isMouse5Down()
	
	if currentM4 ~= lastM4State then
		lastM4State = currentM4
		for flag, data in pairs(ModuleBinds) do
			local keyName = typeof(data.Key) == "EnumItem" and data.Key.Name or tostring(data.Key)
			if keyName == "MouseButton4" then
				triggerModuleBind(flag, currentM4)
			end
		end
	end
	
	if currentM5 ~= lastM5State then
		lastM5State = currentM5
		for flag, data in pairs(ModuleBinds) do
			local keyName = typeof(data.Key) == "EnumItem" and data.Key.Name or tostring(data.Key)
			if keyName == "MouseButton5" then
				triggerModuleBind(flag, currentM5)
			end
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
	
	local chosenColor = glowColorMap[MovementSettings.PixelSurfGlowColor] or Color3.fromRGB(168, 85, 247)
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
	local lastHorizKey = nil
	local lastVertKey = nil
	local blinkActive = false
	local blinkGhostCFrame = nil
	local blinkFrozenCFrame = nil
	local noClipActive = false
	local noClipCharacter = nil
	local noClipStates = {}
	local noClipDescendantAdded = nil
	local noClipLastPosition = nil
	
	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
			lastHorizKey = input.KeyCode
		elseif input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S then
			lastVertKey = input.KeyCode
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
		processNoClip()
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
			end
			rootPart.CFrame = stuckCFrame
			rootPart.AssemblyLinearVelocity = Vector3.zero
			rootPart.AssemblyAngularVelocity = Vector3.zero
			return
		end
		
		-- Disable Movement Keys Control --
		if MovementSettings.DisableMovementKeys then
			local isAutomatedActive = MovementSettings.AirStrafe or MovementSettings.LongJump or MovementSettings.PixelSurf or MovementSettings.Fly or MovementSettings.Speed
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
				
				local Camera = workspace.CurrentCamera
				if Camera then
					local moveVec = Vector3.zero
					if aDown and dDown then
						if lastHorizKey == Enum.KeyCode.A then
							moveVec = moveVec - Camera.CFrame.RightVector
						elseif lastHorizKey == Enum.KeyCode.D then
							moveVec = moveVec + Camera.CFrame.RightVector
						end
					end
					if wDown and sDown then
						local lookDir = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z).Unit
						if lastVertKey == Enum.KeyCode.W then
							moveVec = moveVec + lookDir
						elseif lastVertKey == Enum.KeyCode.S then
							moveVec = moveVec - lookDir
						end
					end
					if moveVec.Magnitude > 0 then
						humanoid:Move(moveVec, false)
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
				if gameFolder and gameFolder:FindFirstChild("Settings") then
					gameFolder.Settings:SetAttribute("ReviveTime", delayVal)
				end
			end

			-- Self Revive
			if mode == "Self" or mode == "Both" then
				local char = lp and lp.Character
				if char and char:getAttribute("Downed") == true then
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
		
		-- 1. Bunny Hop (Triggers only when holding Spacebar like in CS2) --
		if MovementSettings.Bhop and not inAir and not isTyping and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			humanoid.Jump = true
		end
		
		-- 2. Air Strafe (Removed old conflicting AirStrafe, using RenderStepped advanced AirStrafe instead) --
		
		
		
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
					
					if not pixelGlowTriggered and (tick() - pixelSurfStartTime >= 0.2) then
						pixelGlowTriggered = true
						playPurpleGlow()
					end
					
					local vel = rootPart.AssemblyLinearVelocity
					local verticalVel = 0
					local horizVel = Vector3.new(vel.X, 0, vel.Z)
					local dot = horizVel:Dot(wallNormal)
					if dot < 0 then
						horizVel = horizVel - (wallNormal * dot)
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
					if isPixelSurfing then
						isPixelSurfing = false
						pixelGlowTriggered = false
						pixelSurfLockY = nil
					end
				end
			else
				if isPixelSurfing then
					isPixelSurfing = false
					pixelGlowTriggered = false
					pixelSurfLockY = nil
				end
			end
		else
			if isPixelSurfing then
				isPixelSurfing = false
				pixelGlowTriggered = false
				pixelSurfLockY = nil
			end
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

			-- Scan sideways for nearby block edges
			local scanDirs = {
				rootPart.CFrame.RightVector,
				-rootPart.CFrame.RightVector,
				rootPart.CFrame.LookVector,
				-rootPart.CFrame.LookVector,
			}
			local bestNormal = nil
			local bestDist = math.huge

			for _, dir in ipairs(scanDirs) do
				local hit = workspace:Raycast(rootPart.Position, dir * 3.5, rayParams)
				if hit and hit.Instance and hit.Instance.CanCollide then
					local flatNormal = Vector3.new(hit.Normal.X, 0, hit.Normal.Z)
					if flatNormal.Magnitude > 0.1 then
						local dist = (hit.Position - rootPart.Position).Magnitude
						if dist < bestDist then
							bestDist = dist
							bestNormal = flatNormal.Unit
						end
					end
				end
			end

			if bestNormal then
				-- Align character so its LookVector is parallel to the wall (perpendicular to normal)
				local alignedLook = Vector3.new(-bestNormal.Z, 0, bestNormal.X).Unit
				local dot = alignedLook:Dot(rootPart.CFrame.LookVector)
				if dot < 0 then alignedLook = -alignedLook end

				local targetCFrame = CFrame.new(rootPart.Position, rootPart.Position + alignedLook)
				local currentCFrame = rootPart.CFrame
				-- Smooth slerp toward aligned angle (10% per frame)
				local alpha = 0.10
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
		addDebugLogEntry(msg, msgType)
	end)
end

-- CS-Style Air Strafer Engine (Auto-Strafe & WASD Air Rebound) --
task.spawn(function()
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local Players = game:GetService("Players")
	local lp = Players.LocalPlayer

	local lastYaw = nil

	local function getCameraYaw()
		local cam = workspace.CurrentCamera
		if not cam then return 0 end
		local _, yaw, _ = cam.CFrame:ToOrientation()
		return yaw
	end

	RunService.RenderStepped:Connect(function()
		if isUnloaded or not MovementSettings.AirStrafe then 
			return 
		end

		local char = lp.Character
		if not char then return end

		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("HRP") or char.PrimaryPart
		local cam = workspace.CurrentCamera
		if not hum or not hrp or not cam or hum.Health <= 0 then return end

		-- Ground Check --
		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {char}
		rayParams.FilterType = Enum.RaycastFilterType.Exclude

		local groundRay = workspace:Raycast(hrp.Position, Vector3.new(0, -2.0, 0), rayParams)
		local state = hum:GetState()
		local inAir = (hum.FloorMaterial == Enum.Material.Air) 
			or (state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Physics) 
			or (math.abs(hrp.AssemblyLinearVelocity.Y) > 0.05)
			or (groundRay == nil)

		if inAir then
			local isTyping = UserInputService:GetFocusedTextBox() ~= nil
			if not isTyping then
				local forward = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
				local right = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
				if forward.Magnitude > 0 then forward = forward.Unit end
				if right.Magnitude > 0 then right = right.Unit end

				local inputVec = Vector3.zero
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then inputVec = inputVec + forward end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then inputVec = inputVec - forward end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then inputVec = inputVec + right end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then inputVec = inputVec - right end

				if inputVec.Magnitude == 0 and hum.MoveDirection.Magnitude > 0 then
					inputVec = hum.MoveDirection
				end

				if inputVec.Magnitude > 0 then
					local moveDir = inputVec.Unit
					local targetSpeed = MovementSettings.AirStrafeSpeed or 40.0
					local currentVel = hrp.AssemblyLinearVelocity
					local targetVel = moveDir * targetSpeed
					local newVel = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
					hrp.AssemblyLinearVelocity = newVel
					pcall(function() hrp.Velocity = newVel end)
				end
			end
		end
	end)
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
	Title = "Neverlose",
	Content = "Initialization complete",
	Duration = 5,
})

Logging.new("crosshairs",'Loaded Movement Script',5)

-- Initial state for Watermark and Keybind Indicators --
Watermark:SetRender(true);
local function updateKeybindsDisplay()
	local enabled = MovementSettings.KeybindsEnabled ~= false
	local mode = MovementSettings.KeybindsMode or "Default"

	local showLeft = enabled and (mode == "Default" or mode == "Both")
	local showMovement = enabled and (mode == "Movement" or mode == "Both")

	if NC then NC:SetRender(showLeft and (MovementSettings.NoClip or false) or false) end
	if AS then AS:SetRender(showLeft and (MovementSettings.AirStuck or false) or false) end
	if IJ then IJ:SetRender(showLeft and (MovementSettings.InfJump or false) or false) end
	if BL then BL:SetRender(showLeft and (MovementSettings.Blink or false) or false) end
	if PS then PS:SetRender(showLeft and (MovementSettings.PixelSurf or false) or false) end
	if JB then JB:SetRender(showLeft and (MovementSettings.JumpBug or false) or false) end
	if LJ then LJ:SetRender(showLeft and (MovementSettings.LongJump or false) or false) end
	if AG_Indicator then AG_Indicator:SetRender(showLeft and (MovementSettings.AutoGround or false) or false) end

	if _G.SetMovementHUDVisible then
		_G.SetMovementHUDVisible(showMovement)
	end
end

updateKeybindsDisplay()

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

	local lblPX = makeLabel("px")
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

	-- Peak speed ghost label (appears behind speedLabel, floats up slightly and fades)
	local peakLabel = Instance.new("TextLabel")
	peakLabel.BackgroundTransparency = 1
	peakLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	peakLabel.Position = UDim2.new(0.5, 0, 0.845, -10)
	peakLabel.Size = UDim2.new(0, 300, 0, 40)
	peakLabel.Text = ""
	peakLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	peakLabel.TextSize = 34
	peakLabel.Font = Enum.Font.GothamBold
	peakLabel.TextTransparency = 1
	peakLabel.TextXAlignment = Enum.TextXAlignment.Center
	peakLabel.ZIndex = 4
	peakLabel.Parent = screenGui

	-- Blue stroke for peak label (matching menu accent color)
	local peakStroke = Instance.new("UIStroke")
	peakStroke.Color = Color3.fromRGB(78, 127, 252)
	peakStroke.Thickness = 1.5
	peakStroke.Transparency = 1
	peakStroke.Parent = peakLabel

	local TweenService = game:GetService("TweenService")
	local peakSpeed = 0
	local lastSpeed = 0
	local peakFadeTween = nil
	local peakStrokeTween = nil

	local function showPeak(spd)
		if peakFadeTween then pcall(function() peakFadeTween:Cancel() end) end
		if peakStrokeTween then pcall(function() peakStrokeTween:Cancel() end) end

		peakLabel.Text = tostring(spd)
		peakLabel.TextTransparency = 0.1
		peakStroke.Transparency = 0.25
		peakLabel.Position = UDim2.new(0.5, 0, 0.845, -10)

		-- Fade out over 0.75 seconds while floating up slightly behind speedLabel (-10px to -14px)
		local tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		peakFadeTween = TweenService:Create(peakLabel, tweenInfo, {
			TextTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.845, -14),
		})
		peakStrokeTween = TweenService:Create(peakStroke, tweenInfo, {
			Transparency = 1,
		})
		peakFadeTween:Play()
		peakStrokeTween:Play()
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
		lblPX.Visible = MovementSettings.PixelSurf  or false
		lblAG.Visible = MovementSettings.AutoGround or false
		lblLJ.Visible = MovementSettings.LongJump   or false

		-- Speedometer
		local char = lp and lp.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then
			local vel = root.AssemblyLinearVelocity
			local rawSpeed = Vector3.new(vel.X, 0, vel.Z).Magnitude
			if rawSpeed > 0.1 and rawSpeed < 100 then
				rawSpeed = rawSpeed * 10
			end
			local horizSpeed = math.floor(rawSpeed)
			speedLabel.Text = tostring(horizSpeed)

			-- Peak tracking: update peak if going faster
			if horizSpeed > peakSpeed then
				peakSpeed = horizSpeed
			end

			-- Show peak ghost when speed drops 3+ below peak
			if peakSpeed > 5 and (peakSpeed - horizSpeed) >= 3 and horizSpeed < lastSpeed then
				if peakLabel.TextTransparency > 0.5 then
					showPeak(peakSpeed)
				end
				peakSpeed = horizSpeed -- reset peak to current so it can build up again
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

		-- Detect landing moment
		if wasInAir and not inAir and not landCooldown then
			landCooldown = true
			-- Fall speed reset: micro-jump to cancel landing animation lag
			local vel = root.AssemblyLinearVelocity
			if vel.Y < -10 then
				-- Reset vertical velocity to prevent stumble/landing lag
				root.AssemblyLinearVelocity = Vector3.new(vel.X, 0, vel.Z)
				pcall(function() root.Velocity = Vector3.new(vel.X, 0, vel.Z) end)
				hum:ChangeState(Enum.HumanoidStateType.Running)
			end
			-- Slide boost: preserve horizontal momentum
			task.delay(0.05, function()
				if isUnloaded then return end
				if not root or not root.Parent then return end
				local v2 = root.AssemblyLinearVelocity
				if v2.Y >= -2 then
					root.AssemblyLinearVelocity = Vector3.new(v2.X * 1.05, v2.Y, v2.Z * 1.05)
				end
				landCooldown = false
			end)
		end

		wasInAir = inAir
	end)
end)

