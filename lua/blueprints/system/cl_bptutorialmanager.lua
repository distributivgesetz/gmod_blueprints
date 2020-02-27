if SERVER then AddCSLuaFile() return end

module( "bptutorialmanager", package.seeall )

G_BPAVAILABLE_TUTORIALS = G_BPAVAILABLE_TUTORIALS or {}

local next = next

function GetAvailableTutorials()

    for _,v in ipairs( G_BPAVAILABLE_TUTORIALS ) do
        if not IsValid( v ) then
            -- forcefully clear table if any panel turns out to be null
            table.Empty( G_BPAVAILABLE_TUTORIALS ) 
        end
    end

    if next( G_BPAVAILABLE_TUTORIALS ) == nil then
        PopulateTutorialTable()
    end

    return G_BPAVAILABLE_TUTORIALS

end

function PopulateTutorialTable()

    -- buttons for testing
    local test = vgui.Create( "DButton" )
    local test2 = vgui.Create( "DButton" )
    table.insert( G_BPAVAILABLE_TUTORIALS, test )
    table.insert( G_BPAVAILABLE_TUTORIALS, test2 )

end