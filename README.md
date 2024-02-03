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

## Credit
- @person615 (Discord) Created the first version / proof of concept.
- @the1geo (Discord) Helped fix the rotation issue.
- [@Slin](https://github.com/Slin) Created Grab and the level format.