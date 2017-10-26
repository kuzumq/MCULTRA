local MCULTRA = LibStub("AceAddon-3.0"):NewAddon("MCULTRA", "AceEvent-3.0")

_G.MCULTRA = MCULTRA

local _Options = { 

    handler = MCULTRA,
    type = 'group',
	
    args = {
	
        enable = {
            name = 'Loot filter',
			desc = 'Hide gray/white/green/blue loot from chat, except your.',
			type = 'toggle',
            get = 'Get_LootFilter',
            set = 'Set_LootFilter',
        },
		
        enable1 = {
            name = 'EWT Filter',
			desc = "Hide EWT message's from chat.",
			type = 'toggle',
            get = 'Get_EWTFilter',
            set = 'Set_EWTFilter',
        },
      
    },
}

local DBD = {

	profile = {
	
		settings = {
		
			LootFilter = false,
			EWTFilter = true,
			
		},
		
	}
	
}

function MCULTRA:OnInitialize()

	MCULTRA.db = LibStub("AceDB-3.0"):New("MCULTRA_DB", DBD)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("MCULTRA_OPTIONS", _Options)
	MCULTRA.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MCULTRA_OPTIONS", "MCULTRA")

end

function MCULTRA:OnEnable()

	if MCULTRA.db.profile.options then
	
		MCULTRA.db.profile.playerName = UnitName("player")
		
	end
	
	ChatFrame_AddMessageEventFilter('CHAT_MSG_LOOT', self.lootFilter)
	ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', self.hackFilter)

end

local colors = {

	'cff1eff00',
	'cffffffff', --white
	'cff1eff00',
	'cff0070dd',
	'cff9d9d9d', --gray

}

function MCULTRA:lootFilter(_, message, ...)
	
	if not MCULTRA.db.profile.settings.LootFilter then return false end
	
	if message:match('Ваша') then
		
		return false
		
	else
	
		for _, v in pairs(colors) do

			if message:match(v) then
		
				return true
			
			end
		
		end
		
	end
	
end

function MCULTRA:hackFilter(_, message, ...)

	if not MCULTRA.db.profile.settings.EWTFilter then return false end

	if message:match('EWT') then
		
		return true
		
	end
	
end

function MCULTRA:Get_LootFilter(_)

    return MCULTRA.db.profile.settings.LootFilter
	
end

function MCULTRA:Set_LootFilter(_,v)

    MCULTRA.db.profile.settings.LootFilter = v
	
end

function MCULTRA:Get_EWTFilter(_)

    return MCULTRA.db.profile.settings.EWTFilter
	
end

function MCULTRA:Set_EWTFilter(_,v)

    MCULTRA.db.profile.settings.EWTFilter = v
	
end
