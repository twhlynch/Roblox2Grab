# Roblox2Grab

### Setup Scripts

- Add a "GrabMap" folder to the Roblox Studio Workspace
- Put the maps and objects you want to export in "GrabMap"
- Add a "Script" script in ServerScriptService
- Create a module script in "Script" named "WebhookService"
- Paste `WebhookServiceScript.lua` into the "WebhookService" module script
- Paste `MainScript.lua` into the "Script" script
- Set `Game Settings > Security > Allow HTTP Requests` to ON

### Setup Server

- Run `pip install flask` to install flask
- Run `python server.py` to start the server on `https://127.0.0.1:5000`

### Usage

- Run the game
- Press F9 to start the script
- When finished a .json file will be created in the folder with `server.py`
- To convert it to a .level file see [Slin/GRAB-Level-Format](https://github.com/Slin/GRAB-Level-Format) (`tools/ConvertToLevel.py`) or [grab-tools.live](https://grab-tools.live/editor).

### Debugging

Due to weirdness with different roblox maps, each one you convert will be rotated wrong in its own ✨special✨ way.
This means you will need to manually swap different rotation and scale values to see what works for a specific map.

> or you could manually rotate them in grab if you give up

Lines 79 - 87:
```
table.insert(collection, children[i].Size.Y*headscale) -- ScaleX
table.insert(collection, children[i].Size.X*headscale) -- ScaleY
table.insert(collection, children[i].Size.Z*headscale) -- ScaleZ

local rot = eulerToQuaternion(math.rad(math.rad(children[i].Rotation.Y),children[i].Rotation.X),math.rad(children[i].Rotation.Z+90))
table.insert(collection, rot[1]) -- RotationX
table.insert(collection, rot[2]) -- RotationY
table.insert(collection, rot[3]) -- RotationZ
table.insert(collection, rot[4]) -- RotationW
```

These are the lines you will have to mess with. basically just change the order of the values being inserted, or mess with `local rot = ...` swapping which one has +90, the order, or something else.

## Credit
- @person615 (Discord) Created the first version / proof of concept.
- [@Slin](https://github.com/Slin) Created Grab and the level format.