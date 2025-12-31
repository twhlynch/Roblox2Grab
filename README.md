# Roblox2Grab

### Requirements

- [Roblox Studio](https://create.roblox.com)  
- HTTP Requests enabled in your game (`Game Settings > Security > Allow HTTP Requests`)

---

### Setup Scripts

1. Create a folder named `GrabMap` in the Roblox Studio **Workspace**.  
2. Place all maps and objects you want to export into the `GrabMap` folder.  
3. Create a Script in **ServerScriptService** named `MainScript`.  
4. Create a ModuleScript named `WebhookService`.  
5. Copy the content of `WebhookServiceScript.lua` into the `WebhookService` module.  
6. Copy the content of the new server script (`MainScript.lua`) into `MainScript`.

---

### Workflow

- Players must join the Discord server to see their exported map: https://discord.gg/4ajRee58Xs
- The server script waits for the first player to know their Roblox username.  
- The script exports the map from the `GrabMap` folder as JSON.  
- The JSON file is sent into a public channel of the Discord server.  

---

## Credit
- @person615 (Discord) Created the first version / proof of concept.
- @.index (Discord / [GitHub](https://github.com/twhlynch)
- @vestriaa (Discord) [GitHub](https://github.com/vestriaa)
- @the1geo (Discord) Helped fix the rotation issue.
- @slindev (Discord) / [GitHub](https://github.com/Slin) Created Grab and the level format.
