AddCSLuaFile()

if SERVER then return end

local SKIN = {}
SKIN.Name = "CleanPointshop"

local function loadSkin( )

SKIN.Colours = table.Copy( derma.GetDefaultSkin( ).Colours )
SKIN.Colours.Label = {}
SKIN.Colours.Label.Default = color_white
SKIN.Colours.Label.Bright = SKIN.ItemDescPanelBorder

SKIN.IconSize = { 136, 136 }

function SKIN:PaintVerticalPropertySheetBar( panel, w, h )
	surface.SetDrawColor( 0, 0, 0, 100 )
	surface.DrawRect( 0, 0, w, h )
end

function SKIN:PaintVScrollBar( panel, w, h )

end

function SKIN:PaintScrollBarGrip( pnl, w, h )
	if pnl.Hovered then 
		surface.SetDrawColor( 40, 40, 40, 150 )
	else 
		surface.SetDrawColor( 20, 20, 20, 150 ) 
	end
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )
end

function SKIN:PaintButtonDown( pnl, w, h )
	if pnl.Hovered then surface.SetDrawColor( 40, 40, 40, 150 )
	else surface.SetDrawColor( 20, 20, 20, 150 ) end
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )
end

function SKIN:PaintButtonUp( pnl, w, h )
	if pnl.Hovered then surface.SetDrawColor( 40, 40, 40, 150 )
	else surface.SetDrawColor( 20, 20, 20, 150 ) end
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )
end

function SKIN:PaintSubcategoryPanel( panel, w, h )
	--nah
end

function SKIN:PaintItemIcon( panel, w, h )
	local s = panel 
	
	draw.RoundedBox( 0, 0, 0, w, h, Color(57, 61, 72))
	draw.RoundedBox( 0, 1, 1, w-2, h-2, Color(255, 255, 255, 10))
	draw.RoundedBox( 0, 2, 2, w-4, h-4, Color(57, 61, 72))
	
	s.BarColor = Color(0,0,0,0)
	s.DoStripes = false
	
	if not s.Data then return end
	local points = PS.Config.CalculateBuyPrice(LocalPlayer(), s.Data)
	
	if not LocalPlayer():PS_HasPoints(points) then
		s.BarColor = Color(214, 139, 139, 5)
		s.DoStripes = true
	end

	if LocalPlayer():PS_HasItem(s.Data.ID) then
		s.BarColor = Color(139, 214, 143, 5)
		s.DoStripes = true
	end

	if s.DoStripes and not inv then
		for _ = 0, 6 do
			surface.SetMaterial(Material("vgui/white"))
			surface.SetDrawColor(s.BarColor)
			surface.DrawTexturedRectRotated(_*20, _*20, 200, 15, 45)
		end
	end 
end

function SKIN:LayoutItemIcon( panel )
	panel:SetSize( 90, 90 )
end

function SKIN:LayoutSubcategoryPanel( panel )
	panel.titleLabel:SetFont( "PS_Heading3" )
	panel.titleLabel:SetColor( color_black )
	panel.titleLabel:SetTall( 12 )
	panel.descLabel:SetFont( "PS_CatName" )
	panel.descLabel:SetColor( color_black )
	panel.descLabel:SetTall( 10 )
	panel.descLabel:SizeToContents( )
end

derma.DefineSkin( SKIN.Name, "PointshopSkin", SKIN )

end --function loadSkin

if GAMEMODE then
	loadSkin( )
end

hook.Add( "Initialize", SKIN.Name .. "init", loadSkin, 100 )
hook.Add( "OnReloaded", SKIN.Name .. "reload", loadSkin, 100 )