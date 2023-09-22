![image](https://media.discordapp.net/attachments/985134187600297986/1154892454550585374/trusted-banner.png?width=1440&height=465)
<p align="center">
    <a href="https://discord.overextended.dev">
        <img src="https://img.shields.io/discord/1068573047172374634?style=for-the-badge&logo=discord&labelColor=7289da&logoColor=white&color=2c2f33&label=Discord"/>
    </a>
</p>

---

# FiveM Job Garage Script

A simple Lua script for FiveM that enables players to gat a garage for a job and park/unpark their vehicles.

![image](https://media.discordapp.net/attachments/1115378133424668682/1115378133806354613/Screenshot_918.png?width=1246&height=701)

## Config Documentation 

> `Config.Framework`: Sets the Framework your server is using. Currently supporting "ESX", "Standalone" & "QBCore"

- Framework: `string` 

*Example:*
```lua
Config.Framework = "ESX"
```

---

> `Config.Garages`: Contains all data for the job garages. Note that an infinite amount of garages can be added to this table. 

- Key (Garage): `table`
    - Label: `string`
    - Job?: `string`
    - Coords: `vec3`
    - SpawnCoords?: `vec4`
    - Blip?: `table`
        - id: `number`
        - scale: `number`
        - colour: `number`
    - Vehicles: `table`
        - Key (vehicle spawn name): `table` or `string` (vehicle label)
            -  label: `string`
            - grade: `number`
            - defaultExtras: `table`
                - Key (Number): `boolean`

*Example:*
```lua
    ["police"] = {
        Label = "Police Garage",
        Job = 'police', 
        Coords = vec3(0, 0, 0),
        SpawnCoords = vec4(0, 0, 0, 0), 
        Blip = {
            id = 1, 
            scale = 0.8, 
            colour = -1,
        },
        Vehicles = {
            ['police'] = {
                label = 'Police Interceptor',
                grade = 2, 
                defaultExtras = {
                    [1] = true, 
                    [4] = true, 
                    [12] = true
                }
            },
        }
    },

    -- or without all the fancy stuff: 

    ["mechanic"] = {
        Label = "Mechanic Garage",
        Coords = vec3(0, 0, 0),
        Vehicles = {
            ['towtruck'] = 'Tow Truck'
        }
    }
```

---

> `Config.Text`: Local like config. Change the display text to what you want it to be.

- Text: `table`
    - Key (do not change!): `string`
