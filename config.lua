Config = {}
Config.EnableDebug = false -- Enables debug for the polyzone
Config.Radius = 25 -- Radius of the polyzone, if player enters the PED will spawn
Config.Target = "ox_target" -- ox/ox_target or qb/qb-target
Config.NearestVehicleRadius = 8.0 -- Radius where the vehicle will be searched

Config.MoneyItem = "money" -- Name of the money item
Config.RepairCost = 2500 -- Money that will the repair cost
Config.Repairtime = 25 -- In seconds
Config.MechanicPED = "mp_m_waremech_01" -- https://docs.fivem.net/docs/game-references/ped-models/

Config.Blips = true
Config.BlipSprite = 544 -- https://docs.fivem.net/docs/game-references/blips/
Config.BlipScale = 0.8
Config.BlipColour = 39 -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
Config.BlipText = "Mechanic" -- Text on the blip

Config.TargetLabel = "Repair Vehicle"
Config.TargetDistance = 2.5
Config.TargetIcon = "fa-solid fa-wrench" -- https://fontawesome.com/search?o=r&m=free

Config.EnableWebhook = true
Config.Webhook = "" -- Webhook for logging

Config.Mechanics = {
    { coords = vector4(-355.5555, -121.1529, 38.6963, 97.4974) },
    { coords = vector4(718.9512, -1074.6748, 22.2386, 49.4747) },
    { coords = vector4(944.1611, -986.4917, 39.0172, 201.1259) },
    { coords = vector4(-555.0020, -914.6996, 23.8788, 232.2232) },
    { coords = vector4(-436.8976, -2170.5779, 10.3207, 15.4584) },
    { coords = vector4(-1140.6545, -1994.8971, 13.1659, 282.9494) },
    { coords = vector4(1132.5303, -776.7636, 57.6054, 357.2809) },
    { coords = vector4(1898.2710, 3709.1096, 32.7639, 142.9991) },
    { coords = vector4(117.6821, 6624.3203, 31.8618, 213.0245) },
}

Notify = function(description, icon, iconcolor, duration) -- EDIT TO YOUR OWN NOTIFICATIONS IF YOU DONT USE LIB NOTIFICATIONS!
    lib.notify({
        id = "mechanic",
        title = "Mechanic",
        description = description,
        icon = icon,
        iconColor = iconcolor,
        duration = duration,
    })
end