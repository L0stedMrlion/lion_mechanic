local ox_inventory = exports.ox_inventory

RegisterServerEvent('lion_mechanic:pay',function(price)
    ox_inventory:RemoveItem(source, Config.MoneyItem, price)
end)

RegisterServerEvent('lion_mechanic:log',function(player, plate, model)
    local steam = "Unavailable"
    local license = "Unavailable"
    local discord = "Unavailable"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    local embed = {
        {
            ["color"] = 7631219,
            ["title"] = '🔧  Mechanic repaired vehicle',
            ["description"] = 'Player **'..player..'** with ID **'..source..'** repaired his car **'..model..'** with license plate **'..plate..'**\n\n**Steam ID:** '..steam..'\n**License:** '..license..'\n**Discord:** '..discord,
            ["footer"] = {
                ["text"] = "🦁 Made by Mrlion | 🔧 lion_mechanic"
            }
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, "POST",json.encode({username = "🦁 Lion Mechanic Logs",embeds = embed,avatar_url = "https://cdn.discordapp.com/attachments/1178330264263462943/1229136630045081691/lionsproject_logo.png?ex=66c04370&is=66bef1f0&hm=1070217ee6bf5fd59ab5591d3ab8e931b42272fece5156dcbfcef53c2f8b6b7b&"}),{["Content-Type"] = "application/json"})
end)