local ox_target = exports.ox_target
local qbtarget = exports['qb-target']

for k, v in ipairs(Config.Mechanics) do
    lib.zones.sphere({
        coords = v.coords,
        radius = Config.Radius,
        debug = Config.EnableDebug,
        model = Config.MechanicPED,
        onEnter = function(self)
            lib.requestModel(self.model)
            local ped = CreatePed(4, GetHashKey(self.model), v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
            SetPedFleeAttributes(ped, 0, false)
            SetPedDiesWhenInjured(ped, false)
            SetPedKeepTask(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            SetModelAsNoLongerNeeded(GetHashKey(self.model))
            self.modelEntity = ped
            if Config.Target == "ox_target" or Config.Target == "ox" then
                self.targetID = ox_target:addLocalEntity(ped, {
                    type = "client",
                    icon = Config.TargetIcon,
                    label = Config.TargetLabel,
                    distance = Config.TargetDistance,
                    onSelect = function()
                        if lib.callback.await('ox_inventory:getItemCount', false, Config.MoneyItem) >= Config.RepairCost then
                        local vehicle = lib.getClosestVehicle(vec3(v.coords.x, v.coords.y, v.coords.z), Config.NearestVehicleRadius, false)
                        local isDamaged = IsVehicleDamaged(vehicle)
                        if vehicle then
                            if not isDamaged then
                                Notify("Vehicle you want to repair is not damaged!", "fa-solid fa-wrench", "#747173", 2500)
                                return
                            end
                            lib.requestAnimDict("mini@repair")
                            TaskPlayAnim(ped, "mini@repair", "fixing_a_ped", 8.0, 0.0, -1, 1, 0, false, false, false)
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                            if lib.progressBar({
                                duration = Config.Repairtime * 1000,
                                label = "🔧 Mechanic is reparing your vehicle",
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    car = true,
                                },
                            })
                            then
                                SetVehicleFixed(vehicle)
                                SetVehicleDeformationFixed(vehicle)
                                SetVehicleBodyHealth(vehicle, 1000.0)
                                SetVehicleEngineHealth(vehicle, 1000.0)
                                Notify("Vehicle has been fixed!", "fa-solid fa-wrench", "#747173", 2500)
                                TriggerServerEvent("lion_mechanic:pay", Config.RepairCost)
                                SetVehicleDoorShut(vehicle, 4, false)
                                ClearPedTasksImmediately(ped)
                                if Config.EnableWebhook then
                                    TriggerServerEvent("lion_mechanic:log", GetPlayerName(PlayerId()), GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                                end
                            else
                                ClearPedTasksImmediately(ped)
                                SetVehicleDoorShut(vehicle, 4, false)
                            end
                        else
                            Notify("No vehicle nearby!", "fa-solid fa-wrench", "#747173", 2500)
                        end
                    else
                        Notify(("You don't have enough money! You need $%s"):format(Config.RepairCost), "fa-solid fa-wrench", "#747173", 2500)
                    end
            end
        })
        elseif Config.Target == "qb-target" or Config.Target == "qb" then
            qbtarget:AddBoxZone('Mechanic' .. k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.5, 1.6, {
                name = 'Mechanic'..k,
                heading = v.coords.w,
                debugPoly = Config.EnableDebug,
            }, {
                options = {
                    {
                        icon = Config.TargetIcon,
                        label = Config.TargetLabel,
                        action = function()
                        end
                    }
                },
                distance = Config.TargetDistance
            })
        end
end,
        onExit = function(self)
            DeleteEntity(self.modelEntity)
        if Config.Target == "ox_target" or Config.Target == "ox" then
            ox_target:removeLocalEntity(self.modelEntity)
        elseif Config.Target == "qb-target" or Config.Target == "qb" then
            qbtarget:RemoveZone("Mechanic"..k)
            SetEntityAsNoLongerNeeded(self.modelEntity)
            self.modelEntity = nil
        end
        end
    })
end

Citizen.CreateThread(function()
    if Config.Blips then
    for k, v in ipairs(Config.Mechanics) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blip, Config.BlipSprite)
        SetBlipScale(blip, Config.BlipScale)
        SetBlipColour(blip, Config.BlipColour)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.BlipText)
        EndTextCommandSetBlipName(blip)
    end
    end
end)