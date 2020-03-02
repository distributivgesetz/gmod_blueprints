if SERVER then AddCSLuaFile() return end

module( "bpuitutorialeditor", package.seeall )

local PANEL = {}

function PANEL:PaintOver(w, h)
	
	self:UpdateScroll()

	local x, y = self:LocalToScreen(0,0)
	self.renderer:Draw(x,y,w,h)

	if self.interface ~= nil then self.interface:DrawOverlay(self:GetSize()) end

	if self:GetIsLocked() then 

		draw.RoundedBox(0, 0, 0, w, h, Color(20,20,20,150))

	end

end


function PANEL:GetEditor()

	return self.editor

end

derma.DefineControl( "BPTutorialGraph", "Blueprint graph renderer with tutorial extension", PANEL, "BPGraph" )

local PANEL = {}

function PANEL:SetTutorial( tut )

	if self.module then
		self.module:RemoveListener(self.callback)
	end

	self.module = tut
	self:Clear()

	if tut == nil then return end
	self.VarList:SetList( self.module.variables )
	self.GraphList:SetList( self.module.graphs )
	self.StructList:SetList( self.module.structs )
	self.EventList:SetList( self.module.events )
	self.module:AddListener(self.callback, bpmodule.CB_ALL)

	for id, graph in self.module.graphs:Items() do
		self:GraphAdded( id )
		graph:SetName( "Tutorial" )
	end

	hook.Add("BPPinClassRefresh", "pinrefresh_" .. self.module:GetUID(), function(class)
		print("PIN CLASS UPDATED, INVALIDATE: " .. class)
		for _, graph in self.module:Graphs() do
			for _, node in graph:Nodes() do
				node:UpdatePins()
			end
		end
		for _, ed in pairs( self.vgraphs ) do
			ed:GetEditor():InvalidateAllNodes( true )
		end
	end)

	self.Content:SetLeftWidth(150)

end


function PANEL:GraphAdded( id )

	--print("GRAPH ADDED: " .. id)
	local graph = self.module:GetGraph(id)
	local vgraph = vgui.Create("BPTutorialGraph", self.Content)

	vgraph:SetGraph( graph )
	vgraph:SetVisible(false)
	vgraph:CenterToOrigin()
	self.vgraphs[id] = vgraph

end

derma.DefineControl( "BPTutorialInterface", "Blueprint interactive Tutorial interface", PANEL, "BPModuleEditor" )

--[[ function OpenFromTutorial(...)
	local pnl = vgui.Create( "BPTutorialInterface" )
	pnl:SetTutorial()
	pnl:SetVisible( false )
	return pnl
end ]]