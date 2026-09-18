local QBCore = exports['qb-core']:GetCoreObject()

local function kuuhaku(value)
    if type(value) ~= 'string' then
        return true
    end
    return value:gsub('%s', ''):gsub('　', '') == ''
end

RegisterNetEvent('rakker_namechange:server:getName', function ()
    
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local PlayerData = Player.PlayerData

    local firstname = PlayerData.charinfo.firstname
    local lastname = PlayerData.charinfo.lastname
    
    TriggerClientEvent('rakker_namechange:client:openNUI', src, firstname, lastname)
end)

RegisterNetEvent('rakker_namechange:server:changeName', function (firstname, lastname)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local PlayerData = Player.PlayerData

    if kuuhaku(firstname) or kuuhaku(lastname) then
        QBCore.Functions.Notify(src, '名前を正しく入力してください', 'error', 5000)
        return
    end

    PlayerData.charinfo.firstname = firstname
    PlayerData.charinfo.lastname = lastname

    Player.Functions.SetPlayerData('charinfo', Player.PlayerData.charinfo)
    Player.Functions.Save()
    Player.Functions.UpdatePlayerData()

    print('PlayerName changed')
    if Config.options.notify == 'qb' then
        QBCore.Functions.Notify(src, '名前を変更しました！', 'success', 5000)
    else
        TriggerClientEvent('rakker_namechange:client:notify', src, '名前を変更しました！', 'success')
    end
end)
