---@diagnostic disable-next-line: unused-local
local ws = require(script.WebhookService)

local HttpService = game:GetService("HttpService")

local SHAPES = {
	CUBE = 1000,
	SPHERE = 1001,
	CYLINDER = 1002,
}

local MATERIALS = {
	DEFAULT = 0,
	GRABBABLE = 1,
	ICE = 2,
	LAVA = 3,
	WOOD = 4,
	DEFAULT_COLORED = 8,
	BOUNCING = 9,
}

local HEADSCALE = 0.3

local shape_map = {
	[Enum.PartType.Ball] = SHAPES.SPHERE,
	[Enum.PartType.Cylinder] = SHAPES.CYLINDER,
}

local material_map = {
	[Enum.Material.Ice] = MATERIALS.ICE,
	[Enum.Material.Brick] = MATERIALS.DEFAULT,
	[Enum.Material.Wood] = MATERIALS.WOOD,
	[Enum.Material.WoodPlanks] = MATERIALS.WOOD,
	[Enum.Material.ForceField] = MATERIALS.LAVA,
	[Enum.Material.Slate] = MATERIALS.GRABBABLE,
	[Enum.Material.Pebble] = MATERIALS.GRABBABLE,
	[Enum.Material.Foil] = MATERIALS.BOUNCING,
}

local function export_to_server(message)
	local url = "http://127.0.0.1:5000"

	local response = HttpService:RequestAsync({
		Url = url,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
		},
		Body = HttpService:JSONEncode({ message = message }),
	})

	print(response.Body)
end

-- 3x3 rotation matrix to quaternion
local function cframe_to_quaternion(cf)
	local _, _, _, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:GetComponents()

	local trace = r00 + r11 + r22
	local qw, qx, qy, qz

	if trace > 0 then
		local s = math.sqrt(trace + 1.0) * 2
		qw = 0.25 * s
		qx = (r21 - r12) / s
		qy = (r02 - r20) / s
		qz = (r10 - r01) / s
	elseif r00 > r11 and r00 > r22 then
		local s = math.sqrt(1.0 + r00 - r11 - r22) * 2
		qw = (r21 - r12) / s
		qx = 0.25 * s
		qy = (r01 + r10) / s
		qz = (r02 + r20) / s
	elseif r11 > r22 then
		local s = math.sqrt(1.0 + r11 - r00 - r22) * 2
		qw = (r02 - r20) / s
		qx = (r01 + r10) / s
		qy = 0.25 * s
		qz = (r12 + r21) / s
	else
		local s = math.sqrt(1.0 + r22 - r00 - r11) * 2
		qw = (r10 - r01) / s
		qx = (r02 + r20) / s
		qy = (r12 + r21) / s
		qz = 0.25 * s
	end

	return { w = qw, x = qx, y = qy, z = qz }
end

local function build_level(nodes)
	return {
		formatVersion = 18,
		title = "Roblox Map",
		creators = "",
		description = "This map was created using Person, .index, and vestria's Roblox2Grab script!",
		levelNodes = nodes,
		maxCheckpointCount = 10,
		ambienceSettings = {
			skyZenithColor = { r = 0.2800000011920929, g = 0.47600001096725464, b = 0.7300000190734863, a = 1 },
			skyHorizonColor = { r = 0.9160000085830688, g = 0.9574000239372253, b = 0.9574000239372253, a = 1 },
			sunAltitude = 45,
			sunAzimuth = 315,
			sunSize = 1,
			fogDensity = 0,
		},
	}
end

local function part_to_node(child)
	local is_part = child:IsA("Part")

	local shape = is_part and shape_map[child.Shape] or SHAPES.CUBE
	local material = is_part and material_map[child.Material] or MATERIALS.DEFAULT_COLORED

	local position = {
		x = child.Position.X * HEADSCALE,
		y = child.Position.Y * HEADSCALE,
		z = child.Position.Z * HEADSCALE,
	}

	local scale = {
		x = child.Size.X * HEADSCALE,
		y = child.Size.Y * HEADSCALE,
		z = child.Size.Z * HEADSCALE,
	}

	local rotation = cframe_to_quaternion(child.CFrame)

	local transparent = is_part and child.Transparency > 0 or nil

	local color = is_part and material == MATERIALS.DEFAULT_COLORED and {
		r = child.Color.R,
		g = child.Color.G,
		b = child.Color.B,
		a = 1,
	} or nil

	local node = {
		levelNodeStatic = {
			shape = shape,
			material = material,
			position = position,
			scale = scale,
			rotation = rotation,
			color1 = color,
			isTransparent = transparent,
		},
	}

	return node
end

local function roblox_to_grab()
	local folder = workspace:FindFirstChild("GrabMap")
	if not folder then
		error("GrabMap folder not found in workspace!")
		return
	end

	local children = folder:GetDescendants()
	if #children == 0 then
		error("GrabMap has no descendants!")
		return
	end

	print("Found", #children, "descendants in GrabMap")

	local nodes = {}

	for i = 1, #children do
		local child = children[i]

		local is_part = child:IsA("Part")
		local is_truss = child:IsA("TrussPart")

		if is_part or is_truss then
			local node = part_to_node(child)
			table.insert(nodes, node)
		end
	end

	local level = build_level(nodes)

	export_to_server(level)
end

roblox_to_grab()
