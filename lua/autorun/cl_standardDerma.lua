AddCSLuaFile()

if SERVER then return end

local SKIN = {}
SKIN.Name = "StandardPS"

local function loadSkin( )

SKIN.Colours = table.Copy( derma.GetDefaultSkin( ).Colours )
SKIN.Colours.Label = {}
SKIN.Colours.Label.Default = color_white
SKIN.Colours.Label.Bright = SKIN.ItemDescPanelBorder

SKIN.IconSize = { 136, 136 }

function SKIN:PaintSubcategoryPanel( panel, w, h )
	surface.SetDrawColor( Color( 240, 240, 240 ) )
	surface.DrawRect( 0, 0, w, h )
end


function SKIN:LayoutItemIcon( panel )
	panel:SetSize( 200, 200 )
end

function SKIN:LayoutSubcategoryPanel( panel )
	panel.titleLabel:SetFont( "PS_Heading2" )
	panel.titleLabel:SetColor( color_black )
	panel.titleLabel:SetTall( 12 )
	panel.titleLabel:SizeToContents( )
	panel.descLabel:SetFont( "PS_Heading3" )
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