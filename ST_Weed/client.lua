local Proxy = module('vrp', 'lib/Proxy')
local Tunnel = module("vrp", "lib/Tunnel")
local vRP = Proxy.getInterface('vRP')

function notify(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true,true)
end

weedSepling = GetHashKey('bkr_prop_weed_01_small_01a')
weedSmall = GetHashKey('bkr_prop_weed_01_small_01b')
weedMedium = GetHashKey('bkr_prop_weed_med_01a')
weedPlant = GetHashKey('bkr_prop_weed_lrg_01a')
weedBud = GetHashKey('bkr_prop_weed_drying_01a')

RegisterNetEvent('ST_WEED:PLACE', function(source)
    local ped = PlayerPedId()
    local playerPedCoords = GetEntityCoords(ped)
    
    CreateThread(function()

        RequestModel(weedSepling)
        while not HasModelLoaded(weedSepling) do
            Wait(100)   
        end 
    end)

    weedSeplingEnt = CreateObject(weedSepling, playerPedCoords, false , true, true )
    SetEntityAlpha(weedSeplingEnt, 160, false )
    AttachEntityToEntity(weedSeplingEnt, ped, GetPedBoneIndex(ped, 0x0), 0.0, 1.3, -1.0,0.0, 0.0, 0.0, nil , false, true, false, true, true) 
end)

CreateThread(function()
    while true do  
        Wait(0) 
        if IsControlJustPressed(0, 38) then 
            for k, object in ipairs(GetGamePool('CObject')) do 
                if GetEntityModel(weedSeplingEnt) == GetHashKey('bkr_prop_weed_01_small_01a') then
                    local ped = PlayerPedId()
                    local playerPedCoords = GetEntityCoords(ped)
                    weedTesteSepling = GetHashKey('bkr_prop_weed_01_small_01c')
                    local weedSepelingCds = GetEntityCoords(weedSeplingEnt)
                    local animDictonary = 'amb@world_human_gardener_plant@female@base'
                    RequestAnimDict(animDictonary)
                    while not HasAnimDictLoaded(animDictonary) do
                        Wait(100)
                    end
                    SetEntityAsMissionEntity(weedSeplingEnt, true, true)
                    DeleteObject(weedSeplingEnt)
                    TaskPlayAnim(ped, 'amb@world_human_gardener_plant@female@base','base_female', 8.0, 8.0, 5000, 1, 0.0, false, false, false)
                    Wait(1000)
                    ClearPedTasks(ped)

                    RequestModel(weedTesteSepling)
                    while not HasModelLoaded(weedTesteSepling) do
                        Wait(100)   
                    end 
                    
                    weed2SeplingEnt = CreateObject(weedTesteSepling, weedSepelingCds[1], weedSepelingCds[2], (weedSepelingCds[3]),  false , true, true )
                    FreezeEntityPosition(weed2SeplingEnt, true)
                    notify('~g~Maconha plantada!')
                    Wait(1000)

                    RequestModel(weedSmall)
                    while not HasModelLoaded(weedSmall) do
                        Wait(100)   
                    end 
                    SetEntityAsMissionEntity(weed2SeplingEnt, true, true)
                    DeleteObject(weed2SeplingEnt)
                    weedSmallEnt = CreateObject(weedSmall, weedSepelingCds[1], weedSepelingCds[2], (weedSepelingCds[3]),  false , true, true )
                    Wait(1000)


                    RequestModel(weedMedium)
                    while not HasModelLoaded(weedMedium) do
                        Wait(100)   
                    end 
                    SetEntityAsMissionEntity(weedSmallEnt, true, true)
                    DeleteObject(weedSmallEnt)
                    weedMediumEnt = CreateObject(weedMedium, weedSepelingCds[1], weedSepelingCds[2], (weedSepelingCds[3] - 2.65),  false , true, true )
                    Wait(1000)


                    RequestModel(weedPlant)
                    while not HasModelLoaded(weedPlant) do
                        Wait(100)   
                    end  
                    SetEntityAsMissionEntity(weedMediumEnt, true, true)
                    DeleteObject(weedMediumEnt)
                    weedFinalEnt = CreateObject(weedPlant, weedSepelingCds[1], weedSepelingCds[2], (weedSepelingCds[3] - 2.65),  false , true, true )


                end 
            end
        end  
    end
end)


RegisterCommand('colher', function(source)
    for k, object in ipairs(GetGamePool('CObject')) do 
        if GetEntityModel(weedFinalEnt) == GetHashKey('bkr_prop_weed_lrg_01a') then
            local ped = PlayerPedId()
            local playerPedCoords = GetEntityCoords(ped)
            local colheitaCoords = GetEntityCoords(weedFinalEnt) 
            local distance = #(playerPedCoords - colheitaCoords)

            CreateThread(function()
                local animDictonary = 'amb@prop_human_parking_meter@female@idle_a'
                RequestAnimDict(animDictonary)
                while not HasAnimDictLoaded(animDictonary) do
                    Wait(100)
                end
            
            end)

            if distance < 1.5 then 
                TaskPlayAnim(ped, 'amb@prop_human_parking_meter@female@idle_a','idle_a_female', 8.0, 8.0, 5000, 1, 0.0, false, false, false)
                Wait(5000)
                SetEntityAsMissionEntity(weedFinalEnt, true, true)
                DeleteObject(weedFinalEnt)
                budEnt = CreateObject(weedBud, playerPedCoords, false , true, true )
                AttachEntityToEntity(budEnt, ped, GetPedBoneIndex(ped, 0x0), 0.15, -0.2, 0.3,0.0, 0.0, 0.0, nil , false, true, false, true, true)
                TriggerServerEvent('ST_WEED:GIVEWEED')
                notify('~g~Maconha Colhida!')
            end
        end 
    end
end)






            