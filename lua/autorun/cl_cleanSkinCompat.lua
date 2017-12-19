AddCSLuaFile( )

if SERVER then return end

hook.Add( "InitPostEntity", "dsfa", function() 
	PS.Config.Currency = " Pts"
end )

hook.Add( "CleanSkinAddCategory", "addCustoms", function( s, inv )
	local cat = PS.Categories[s.CurrentCat]
	if cat and cat.EnableSubcategories and not inv then
		s.Scroll = vgui.Create('DPointshopSubcategorizedCategory', s)
		s.Scroll:SetSkin( "CleanPointshop" )
		s.Scroll:LoadItems( cat )
		--Sorry, wasn't my idea to hardcode these
		s.Scroll:SetPos( 255, 105 )
		s.Scroll:SetSize( s:GetWide()-460, s:GetTall()-110 )
		return true
	end
end )