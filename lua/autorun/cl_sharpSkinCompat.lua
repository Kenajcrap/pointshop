AddCSLuaFile( )

if SERVER then return end

hook.Add( "SharpSkinAddCategory", "Addcompatshar", function( category )
	if category.EnableSubcategories then
		return vgui.Create( "DPointshopSubcategorizedCategory" ) --yep, that simple.
	end
end )