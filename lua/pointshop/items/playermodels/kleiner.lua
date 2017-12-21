ITEM.Name = 'Kleiner'
ITEM.Price = 250
ITEM.Model = 'models/player/kleiner.mdl'

function ITEM:OnEquip(ply, modifications)
	PrintTable(modifications)
	if not ply._OldModel then
		ply._OldModel = ply:GetModel()
	end
	timer.Simple(1, function() 
		ply:SetModel(self.Model) 
		ply:SetupHands()
		ply:SetSkin(modifications.skin)
		for k, v in pairs (modifications.group) do
			ply:SetBodygroup(k , modifications.group[k])
		end
	end)
end

function ITEM:OnHolster(ply)
	if ply._OldModel then
		ply:SetModel(ply._OldModel)
		ply:SetupHands()
	end
end

function ITEM:Modify(modifications)

	PS:ShowBodygroupChooser(self, modifications)
end


function ITEM:OnModify(ply, modifications)
   self:OnHolster(ply)
   self:OnEquip(ply, modifications)
end

function ITEM:PlayerSetModel(ply)
	ply:SetModel(self.Model)
 	ply:SetupHands()
end

function PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ITEM.Model )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end
