# Roblox2Grab

> [Rbx2Grab plugin by GeoFennec](https://create.roblox.com/store/asset/16359944935/Rbx2Grab) also exists and may be easier to use

### Requirements

- Install [Python]([Python](https://python.org))
- Install [Roblox Studio](https://create.roblox.com)

### Setup Scripts

- Create a folder named "GrabMap" in the Roblox Studio Workspace
- Place all the maps and objects you want to export into the "GrabMap" folder
- Create a script in ServerScriptService named "Script"
- In the "Script" script, create a module named "WebhookService"
- Copy and paste the content of `WebhookServiceScript.lua` into the "WebhookService" module script
- Copy and paste the content of `MainScript.lua` into the "Script" script

### Configure permissions

- In Game Settings find `Security > Allow HTTP Requests` and set it to ON

### Setup Server

- Open a terminal / command prompt and navigate to this folder
- Run `python3 -m venv .` to initialize a python environment
- Run `bin/pip install flask` to install flask
- Run `bin/python server.py` to start the server on `https://127.0.0.1:5000`

### Usage

- Run the game
- Press F9 to start the script
- When finished a .json file will have been created in this folder

You can convert the JSON file to a level file with any json to level tool such as any of the following tools:
- [JSON editor](https://grab-tools.live/editor)
> View > Performance > Toggle editor
> 
> File > Open > JSON File
- [Level JSON Tool](https://grab-tools.live/tools?tab=JSONButton)
- [Slin/GRAB-Level-Format](https://github.com/Slin/GRAB-Level-Format/tree/main) (main/tools)

## Credit
- @person615 (Discord) Created the first version / proof of concept.
- @the1geo (Discord) Helped fix the rotation issue.
- [@Slin](https://github.com/Slin) Created Grab and the level format.