local PANEL = {}

function PANEL:Init()
	self:SetTitle("Modificações")
end

local group = {}
local sskin = 0
function PANEL:Start(item ,  modifications)

	self:SetSize(540,525)	
	self:SetBackgroundBlur(true)
	self:MakePopup(true)
	self:Center()

	local mdl = vgui.Create( "DModelPanel" , self)
	mdl:Dock( FILL )
	mdl:SetFOV( 36 )
	mdl:SetCamPos( Vector( 0, 0, 0 ) )
	mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 160, 80, 255 ) )
	mdl:SetDirectionalLight( BOX_LEFT, Color( 80, 160, 255, 255 ) )
	mdl:SetAmbientLight( Vector( -64, -64, -64 ) )
	mdl:SetAnimated( true )
	mdl.Angles = Angle( 0, 0, 0 )
	mdl:SetLookAt( Vector( -100, 0, -22 ) )

	local model = item.Model
	local modelname = item.Model
	util.PrecacheModel( modelname )
	mdl:SetModel( modelname )
	mdl.Entity:SetPos( Vector( -100, 0, -61 ) )
	function mdl:DragMousePress()
		self.PressX, self.PressY = gui.MousePos()
		self.Pressed = true
	end

	function mdl:DragMouseRelease() self.Pressed = false end

	function mdl:LayoutEntity( Entity )
		if ( self.bAnimated ) then self:RunAnimation() end

		if ( self.Pressed ) then
			local mx, my = gui.MousePos()
			self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )

			self.PressX, self.PressY = gui.MousePos()
		end

		Entity:SetAngles( self.Angles )
	end

	dx,dy = 185, 30

	local nskins = mdl.Entity:SkinCount() - 1

	local bdcontrols = vgui.Create("DPanel", self)
	bdcontrols:Dock( RIGHT )
	bdcontrols:SetSize( 200, 0 )
	bdcontrols:DockPadding( 8, 8, 8, 8 )

	local bdcontrolspanel = vgui.Create("DScrollPanel",bdcontrols)
	bdcontrolspanel:Dock( FILL )

	local nskins = mdl.Entity:SkinCount() - 1
	if ( nskins > 0 ) then
		local skins = vgui.Create( "DNumSlider" ,bdcontrolspanel)
		skins:Dock( TOP )
		skins:SetText( "Skin" )
		skins:SetDark( true )
		skins:SetTall( 50 )
		skins:SetDecimals( 0 )
		skins:SetMax( nskins )
		skins:SetValue(modifications.skin)
		skins.type = "skin"
		mdl.Entity:SetSkin(modifications.skin or 0)
		function skins.OnValueChanged()
			mdl.Entity:SetSkin(math.Round( skins:GetValue() ) )
			sskin = math.Round( skins:GetValue() )
		end
		bdcontrolspanel:AddItem( skins )
	end

	for k = 0, mdl.Entity:GetNumBodyGroups() - 1 do
		if ( mdl.Entity:GetBodygroupCount( k ) <= 1 ) then continue end

		local bgroup = vgui.Create( "DNumSlider" ,bdcontrolspanel)
		bgroup:Dock( TOP )
		bgroup:SetText( mdl.Entity:GetBodygroupName( k )  )
		bgroup:SetDark( true )
		bgroup:SetTall( 50 )
		bgroup:SetDecimals( 0 )
		bgroup.type = "bgroup"
		bgroup.typenum = k
		bgroup:SetValue((modifications.group ~= nil) and modifications.group[k] or 0)
		bgroup:SetMax( mdl.Entity:GetBodygroupCount( k ) - 1 )
		mdl.Entity:SetBodygroup( k, (modifications.group ~= nil) and modifications.group[k] or 0 )
		function bgroup.OnValueChanged()
			mdl.Entity:SetBodygroup( k, math.Round( bgroup:GetValue() ) )
			group[k] = math.Round( bgroup:GetValue() )
		end
		bdcontrolspanel:AddItem( bgroup )

	end

	apply = vgui.Create("DButton")
	apply:SetParent(bdcontrolspanel)
	apply:SetText("Aplicar")
	apply:Dock(TOP)
	apply:SetSize(40,20)
	apply.DoClick = function()
		self.OnChoose(group, sskin)
		self:Close()
	end
	bdcontrolspanel:AddItem( apply )

	local dCredits = vgui.Create("DLabel")
	dCredits:SetParent(self)
	dCredits:SetText("by Kenajcrap")
	dCredits:SetPos(dx-10, dy+10)
	dCredits:SetFont("HudHintTextSmall")
	dCredits:SetMouseInputEnabled(true)
	dCredits:SetColor(Color (150,150,150))
	function dCredits:DoClick()
		gui.OpenURL("https://steamcommunity.com/id/Kenajcrap")
	end
end

function PANEL:OnChoose(groupies, sskinies)
	--nothing
end

vgui.Register('DPointShopBodygroupChooser', PANEL, 'DFrame')
