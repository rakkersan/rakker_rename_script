local QBCore = exports['qb-core']:GetCoreObject()



RegisterNetEvent('rakker_namechange:client:openNUI', function (firstname, lastname)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'ui',
        servername = Config.options.servername,
        firstName = firstname,
        lastName = lastname
    })
end)

RegisterNuiCallback('closeUI', function (data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNuiCallback('changeName', function (data, cb)
    TriggerServerEvent('rakker_namechange:server:changeName', data.firstname, data.lastname)
    cb('ok')
end)

RegisterNetEvent('rakker_namechange:client:notify', function (title, msg, type)
    local cfg = Config.options.notify
    if cfg == 'okok'then
        exports['okokNotify']:Alert(title, msg, 3000, type, true)
    elseif cfg == 'qb' then
        QBCore.Functions.Notify(title, type, 3000)
    elseif cfg == 'ox' then
        lib.notify({
            title = title,
            description = msg,
            type = type
        })
    end
end)

CreateThread(function ()
    local model = Config.npc.model
    QBCore.Functions.LoadModel(model)
    RequestModel(model)
    

    local coords = Config.npc.coords
    local npc = CreatePed(0, model, coords.x, coords.y, coords.z -1, coords.w, false, false)
    TaskStartScenarioInPlace(npc, Config.npc.scenario, 0, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    if Config.options.target == 'ox' then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 2.0,
            options = {
                {
                    name = 'menutarget',
                    label = Config.npc.label,
                    onSelect = function()
                        TriggerServerEvent('rakker_namechange:server:getName')
                    end
                }
            }
        })
    elseif Config.options.target == 'qb' then
        exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
            num = 1,
            type = "client",
            icon = "fas fa-credit-card",
            label = Config.npc.label,
            targeticon = "fas fa-dollar-sign",
            action = function(entity)
                TriggerServerEvent('rakker_namechange:server:getName')
            end,
            }
        },
        distance = 1.5
        })
    end


end)

