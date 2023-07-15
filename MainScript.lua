ws = require(script.WebhookService)

function exp(message)
    local HttpService = game:GetService("HttpService")

    local url = "https://127.0.0.1:5000"

    local response = HttpService:RequestAsync({
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ message = message })
    })

    print(response.Body)
    print("Sent data!")
end

function eulerToQuaternion(roll,pitch,yaw) -- Converts euler rotations to a quaternion.
	local qx = math.sin(roll/2) * math.cos(pitch/2) * math.cos(yaw/2) - math.cos(roll/2) * math.sin(pitch/2) * math.sin(yaw/2)
	local qy = math.cos(roll/2) * math.sin(pitch/2) * math.cos(yaw/2) + math.sin(roll/2) * math.cos(pitch/2) * math.sin(yaw/2)
	local qz = math.cos(roll/2) * math.cos(pitch/2) * math.sin(yaw/2) - math.sin(roll/2) * math.sin(pitch/2) * math.cos(yaw/2)
	local qw = math.cos(roll/2) * math.cos(pitch/2) * math.cos(yaw/2) + math.sin(roll/2) * math.sin(pitch/2) * math.sin(yaw/2)
	return {qx, qy, qz, qw}
end
-- Setup
matList = {Enum.Material.Ice,Enum.Material.Brick,Enum.Material.Wood,Enum.Material.WoodPlanks,Enum.Material.ForceField,Enum.Material.Slate,Enum.Material.Pebble,Enum.Material.Foil}
matListCoor = {2,0,4,4,3,1,1,9}

headscale = 0.3

children = workspace.GrabMap:GetDescendants()
childrenTemp = {}
for i=1,#children do
	if children[i]:IsA("Part") then
		table.insert(childrenTemp, children[i])
	end
    wait()
end
children = childrenTemp

-- Get data from parts and put it into a table
map = {}

for i=1,#children do
	if children[i]:IsA("Part") and children[i] then

		local collection = {}

        local shape = 1000
		if children[i].Shape == Enum.PartType.Block then
			shape = 1000
		end
		if children[i].Shape == Enum.PartType.Ball then
			shape = 1001
		end
		if children[i].Shape == Enum.PartType.Cylinder then
            shape = 1002
		end
        table.insert(collection, shape) -- Shape

		local curmat = 8
		for e=1,#matList do
			if children[i].Material == matList[e] then
				curmat = matListCoor[e]
			end
            wait()
		end
		table.insert(collection, curmat) -- Material

		table.insert(collection, children[i].Position.X*headscale) -- PositionX
		table.insert(collection, children[i].Position.Y*headscale) -- PositionY
		table.insert(collection, children[i].Position.Z*headscale) -- PositionZ
		
		if children[i].Shape == Enum.PartType.Cylinder then
			table.insert(collection, children[i].Size.Y*headscale) -- ScaleX
			table.insert(collection, children[i].Size.X*headscale) -- ScaleY
		else
			table.insert(collection, children[i].Size.X*headscale) -- ScaleX
			table.insert(collection, children[i].Size.Y*headscale) -- ScaleY
		end
        table.insert(collection, children[i].Size.Z*headscale) -- ScaleZ
		
        local extra = 90
		if children[i].Shape ~= Enum.PartType.Cylinder then
			extra = 0
		end
        local rot = eulerToQuaternion(math.rad(children[i].Rotation.X),math.rad(children[i].Rotation.Y),math.rad(children[i].Rotation.Z+extra))
        table.insert(collection, rot[1]) -- RotationX
        table.insert(collection, rot[2]) -- RotationY
        table.insert(collection, rot[3]) -- RotationZ
        table.insert(collection, rot[4]) -- RotationW

		table.insert(collection, children[i].Color.R) -- ColorR
		table.insert(collection, children[i].Color.G) -- ColorG
		table.insert(collection, children[i].Color.B) -- ColorB

		table.insert(map, collection) -- Adds the node to the map's index.
		print("prepared node " .. i .. " / " .. #children)
	end
	wait()
end

-- Create the JSON string for the map
levelNodes = [[]]

for i=1,#map do

	curNode = map[i]

    -- Comma or not
    commaString = [[,]]
    if #map == i then
        commaString = [[]]
    end

    -- Color or not
    colorString = [[]]
    if curNode[2] == 8 then
        colorString = [[,
        "color": {
            "r":]] .. curNode[13] .. [[,
            "g":]] .. curNode[14] .. [[,
            "b":]] .. curNode[15] .. [[,
            "a":1
        }
        ]]
    end

    -- Node string
    nodeString = [[
        { 
            "levelNodeStatic": {
                "shape":]] .. curNode[1] .. [[,
                "material":]] .. curNode[2] .. [[,
                "position": {
                    "x":]] .. curNode[3] .. [[,
                    "y":]] .. curNode[4] .. [[,
                    "z":]] .. curNode[5] .. [[
                },
                "scale": {
                    "x":]] .. curNode[6] .. [[,
                    "y":]] .. curNode[7] .. [[,
                    "z":]] .. curNode[8] .. [[
                },
                "rotation": {
                    "w":]] .. curNode[12] .. [[,
                    "x":]] .. curNode[9] .. [[,
                    "y":]] .. curNode[10] .. [[,
                    "z":]] .. curNode[11] .. [[ 
                }]] .. colorString .. [[
            }
        }]] .. commaString
    
    -- Add to export string
    levelNodes = levelNodes .. nodeString

	print("created node " .. i .. " / " .. #children)
	
    wait()
end

map = [[{
    "formatVersion": 6,
    "title": "Roblox Map",
    "creators": "",
    "description": "This map was created using Person and .index's Roblox2Grab script!",
    "levelNodes": [
        ]] .. levelNodes .. [[
    ],
    "maxCheckpointCount": 10,
    "ambienceSettings": {
        "skyZenithColor": {
            "r": 0.2800000011920929,
            "g": 0.47600001096725464,
            "b": 0.7300000190734863,
            "a": 1
        },
        "skyHorizonColor": {
            "r": 0.9160000085830688,
            "g": 0.9574000239372253,
            "b": 0.9574000239372253,
            "a": 1
        },
        "sunAltitude": 45,
        "sunAzimuth": 315,
        "sunSize": 1,
        "fogDDensity": 0
    }
}
]]

exp(map)