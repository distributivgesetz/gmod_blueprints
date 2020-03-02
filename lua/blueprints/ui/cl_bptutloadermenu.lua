if SERVER then AddCSLuaFile() return end

module("bpuitutorialloader", package.seeall )

local PANEL = {}

function PANEL:Init()

	self.contentholder = vgui.Create("DPanel", self)
	self.contentholder:Dock( FILL )
	self.contentholder:SetBackgroundColor( Color(50,50,50) )

	self.contentdiv = vgui.Create("DHorizontalDivider", self.contentholder)
	self.contentdiv:Dock( FILL )

	self.tutoriallist = vgui.Create("DPanelList")
	self.tutoriallist:SetSpacing(2)
	self.tutoriallist:EnableVerticalScrollbar()

	self.tutorialsplash = vgui.Create("DPanel")
	self.tutorialsplash:SetBackgroundColor( Color(30,30,30) )

	self.contentdiv:SetLeft(self.tutoriallist)
	self.contentdiv:SetRight(self.tutorialsplash)

	self.contentdiv:SetLeftWidth( 300 )

	self:UpdateTutorials()

end

function PANEL:UpdateTutorials()

	for _, v in ipairs( bptutorialmanager.GetAvailableTutorials() ) do

		local vbutton = vgui.Create( "DButton", self.tutoriallist )
		vbutton:SetText( v:GetName() )
		vbutton.DoClick = function()
			v:StartTutorial( self.editor )
		end
		self.tutoriallist:AddItem( vbutton )

	end

end

derma.DefineControl( "BPTutorialMenu", "Blueprint interactive tutorial loader", PANEL, "DPanel" )