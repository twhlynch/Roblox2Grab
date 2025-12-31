ws = require(script.WebhookService)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local function exp(player, message)
	local url = "https://roblox.vestria.workers.dev/"

	local response = HttpService:RequestAsync({
		Url = url,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json"
		},
		Body = HttpService:JSONEncode({
			message = message,
			username = player.Name
		})
	})

	print(response.StatusCode, response.Body)
end

local function cframeToQuaternion(cf)
	local _, _, _,
	r00, r01, r02,
	r10, r11, r12,
	r20, r21, r22 = cf:GetComponents()

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

	return qx, qy, qz, qw
end

local matList = {
	Enum.Material.Ice,
	Enum.Material.Brick,
	Enum.Material.Wood,
	Enum.Material.WoodPlanks,
	Enum.Material.ForceField,
	Enum.Material.Slate,
	Enum.Material.Pebble,
	Enum.Material.Foil
}

local matListCoor = { 2, 0, 4, 4, 3, 1, 1, 9 }
local headscale = 0.3

local folder = workspace:FindFirstChild("GrabMap")
if not folder then
	error("GrabMap folder not found in workspace!")
end

local children = folder:GetDescendants()
if #children == 0 then
	warn("GrabMap has no descendants!")
else
	print("Found", #children, "descendants in GrabMap")
end

local nodeList = {}

for i = 1, #children do
	local child = children[i]

	if child:IsA("Part") or child:IsA("TrussPart") then

		local shape = 1000
		if child:IsA("Part") then
			if child.Shape == Enum.PartType.Ball then
				shape = 1001
			elseif child.Shape == Enum.PartType.Cylinder then
				shape = 1002
			end
		end

		local material = 8
		if child:IsA("Part") then
			for m = 1, #matList do
				if child.Material == matList[m] then
					material = matListCoor[m]
					break
				end
			end
		end

		local px = child.Position.X * headscale
		local py = child.Position.Y * headscale
		local pz = child.Position.Z * headscale

		local sx = child.Size.X * headscale
		local sy = child.Size.Y * headscale
		local sz = child.Size.Z * headscale

		local qx, qy, qz, qw = cframeToQuaternion(child.CFrame)

		local isTransparent = false
		local alpha = 1
		if child:IsA("Part") and child.Transparency > 0 then
			isTransparent = true
			alpha = 1 - child.Transparency
		end

		local node = {
			levelNodeStatic = {
				shape = shape,
				material = material,
				position = { x = px, y = py, z = pz },
				scale = { x = sx, y = sy, z = sz },
				rotation = { w = qw, x = qx, y = qy, z = qz }
			}
		}

		if child:IsA("Part") then
			if material == 8 or isTransparent then
				node.levelNodeStatic.color1 = {
					r = child.Color.R,
					g = child.Color.G,
					b = child.Color.B,
					a = alpha
				}
			end

			if isTransparent then
				node.levelNodeStatic.isTransparent = true
			end
		end

		table.insert(nodeList, node)
	end
end

local mapTable = {
	formatVersion = 18,
	title = "Roblox Map",
	creators = "",
	description = "This map was created using Person and .index's Roblox2Grab script!",
	levelNodes = nodeList,
	maxCheckpointCount = 10,
	ambienceSettings = {
		skyZenithColor = { r = 0.2800000011920929, g = 0.47600001096725464, b = 0.7300000190734863, a = 1 },
		skyHorizonColor = { r = 0.9160000085830688, g = 0.9574000239372253, b = 0.9574000239372253, a = 1 },
		sunAltitude = 45,
		sunAzimuth = 315,
		sunSize = 1,
		fogDensity = 0
	}
}

local finalJSON = HttpService:JSONEncode(mapTable)

local player = Players.PlayerAdded:Wait()

exp(player, finalJSON)
