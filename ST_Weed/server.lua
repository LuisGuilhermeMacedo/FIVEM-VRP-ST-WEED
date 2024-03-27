local Proxy = module('vrp', 'lib/Proxy')
local vRP = Proxy.getInterface('vRP')



RegisterCommand('plantar',function(source)
    local user_id = vRP.getUserId(source)
    print(1)
    if user_id then
        print(2)
        if vRP.tryGetInventoryItem(user_id,"weedSeed",1) then 
            print(3)
            TriggerClientEvent('ST_WEED:PLACE', source)
        end
    end
    
end)

RegisterNetEvent('ST_WEED:GIVEWEED', function()
    local user_id = vRP.getUserId(source)
    vRP.giveInventoryItem(user_id,'weed',10)
end)

