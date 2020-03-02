if SERVER then AddCSLuaFile() return end

module( "bptutorial", package.seeall )

local meta = bpcommon.MetaTable( "bptutorial" )

function meta:Init( name )

	self.name = name
	return self

end

function meta:StartTutorial( editor )

	self.mod = bpmodule.New()
	self.mod:CreateDefaults()

	local existing = editor.openModules[self.mod:GetUID()]
	if existing then
		editor.Tabs:SetActiveTab( existing.Tab )
		return existing
	end

	self.interface = vgui.Create( "BPTutorialInterface" )

	local title = self.name
	local sheet = editor.Tabs:AddSheet( title, self.interface, title, "icon16/application.png", true )
	self.interface.editor = editor
	self.interface.tab = sheet.Tab
	self.interface:SetTutorial( self.mod )

	sheet.Tab.Close = function()
		editor:CloseModule( self.mod )
	end

	editor.openModules[self.mod:GetUID()] = sheet

	editor.Tabs:SetActiveTab( sheet.Tab )

end

function meta:GetName() return self.name end

function New(...) return bpcommon.MakeInstance(meta,...) end