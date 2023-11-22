local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local crossedLine = false
local playerCooldowns = {}

function crossProduct(a, b)
    return vector3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
end

function magnitude(v)
    return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
end

function IsEntityWithinSegment(coords, lineStart, lineEnd)
    local dot = (lineEnd.x - lineStart.x) * (coords.x - lineStart.x) + (lineEnd.y - lineStart.y) *
                    (coords.y - lineStart.y) + (lineEnd.z - lineStart.z) * (coords.z - lineStart.z)
    local len_sq = (lineEnd.x - lineStart.x) ^ 2 + (lineEnd.y - lineStart.y) ^ 2 + (lineEnd.z - lineStart.z) ^ 2
    local param = dot / len_sq

    if param < 0 or param > 1 then
        return false
    else
        local nearest = vector3(lineStart.x + param * (lineEnd.x - lineStart.x),
            lineStart.y + param * (lineEnd.y - lineStart.y), lineStart.z + param * (lineEnd.z - lineStart.z))
        local dist = #(coords - nearest)
        return dist < 1.0
    end
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local idJogador = GetPlayerServerId(PlayerId())
        local coords = GetEntityCoords(ped)

        if vehicle ~= 0 and playerCooldowns[idJogador] == nil then
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                TriggerServerEvent('Client:EnviarConfigLines', config.lines)
                local speedVector = GetEntitySpeedVector(vehicle, true)
                local velocidade = math.sqrt(speedVector.x ^ 2 + speedVector.y ^ 2 + speedVector.z ^ 2) * 3.6

                if velocidade > 0 then
                    for _, linha in ipairs(config.lines) do
                        local lineStart = linha.start
                        local lineEnd = linha.endline

                        if IsEntityWithinSegment(coords, lineStart, lineEnd) then
                            if not crossedLine then
                                crossedLine = true
                                local plate = GetVehicleNumberPlateText(vehicle)
                                TriggerServerEvent('Server:VeiculoCruzouLinha', velocidade, linha.id, plate)
                                playerCooldowns[idJogador] = GetGameTimer() + 10000
                            end
                        else
                            crossedLine = false
                        end
                    end
                end
            end
        end

        for id, cooldown in pairs(playerCooldowns) do
            if GetGameTimer() > cooldown then
                playerCooldowns[id] = nil
            end
        end

        Wait(50)
    end
end)

Citizen.CreateThread(function()
    while true do
        if config.debug == "true" then
            for _, linha in ipairs(config.lines) do
                local lineStart = linha.start
                local lineEnd = linha.endline
                DrawLine(lineStart.x, lineStart.y, lineStart.z, lineEnd.x, lineEnd.y, lineEnd.z, 255, 0, 0, 255)
            end
        end
        Citizen.Wait(0)
    end
end)

function printtodiscord(webhook)
    exports['screenshot-basic']:requestScreenshotUpload(webhook, 'files[]', function(data)
        local response = json.decode(data)
        if response and response.attachments and #response.attachments > 0 then
        end
    end)
end

RegisterNetEvent('Client:printtodiscord')
AddEventHandler('Client:printtodiscord', function(webhook)
    printtodiscord(webhook)
end)
