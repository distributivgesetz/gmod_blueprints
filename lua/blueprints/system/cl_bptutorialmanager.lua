if SERVER then AddCSLuaFile() return end

module( "bptutorialmanager", package.seeall )

local BPAVAILABLE_TUTORIALS = BPAVAILABLE_TUTORIALS or {}

local next = next

function GetAvailableTutorials()

	for _,v in ipairs( BPAVAILABLE_TUTORIALS ) do
		if not IsValid( v ) then
			-- forcefully clear table if any panel turns out to be null
			table.Empty( BPAVAILABLE_TUTORIALS ) 
		end
	end

	if next( BPAVAILABLE_TUTORIALS ) == nil then
		PopulateTutorialTable()
	end

	return BPAVAILABLE_TUTORIALS

end

function PopulateTutorialTable()

	local tutorial1 = bptutorial.New( "tutorial 1" )
	local tutorial2 = bptutorial.New( "tutorial 2" )
	table.insert( BPAVAILABLE_TUTORIALS, tutorial1 )
	table.insert( BPAVAILABLE_TUTORIALS, tutorial2 )

end