-- name: [CS] Template
-- description: Write mod description here!\n\nMade by: You!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local TEXT_MOD_NAME = get_active_mod().name

-- Stops mod from loading if Character Select isn't on, Does not need to be touched
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

--- Load Models ---
local E_MODEL_REPLACE = smlua_model_util_get_id("replace_geo")      -- Located in "actors"

--- Load Textures ---
local TEX_REPLACE_LIFE_ICON = get_texture_info("repalce_icon") -- Located in "textures"

-- All sound files are located in "sound" folder
local VOICETABLE_REPLACE = {
    [CHAR_SOUND_OKEY_DOKEY] =        'ReplaceStartGame.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] =         'ReplaceStartLevel.ogg', -- Starting level
	[CHAR_SOUND_GAME_OVER] =         'ReplaceGameOver.ogg', -- Game Overed
	[CHAR_SOUND_PUNCH_YAH] =         'ReplacePunch1.ogg', -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] =         'ReplacePunch2.ogg', -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] =         'ReplacePunch3.ogg', -- Punch 3
	[CHAR_SOUND_YAH_WAH_HOO] =       {'ReplaceJump1.ogg', 'ReplaceJump2.ogg', 'ReplaceJump3.ogg'}, -- First Jump Sounds
	[CHAR_SOUND_HOOHOO] =            'ReplaceDoubleJump.ogg', -- Second jump sound
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'ReplaceTripleJump1.ogg', 'ReplaceTripleJump2.ogg'}, -- Triple jump sounds
	[CHAR_SOUND_UH] =                'ReplaceBonk.ogg', -- Soft wall bonk
	[CHAR_SOUND_UH2] =               'ReplaceLedgeGetUp.ogg', -- Quick ledge get up
	[CHAR_SOUND_UH2_2] =             'ReplaceLongJumpLand.ogg', -- Landing after long jump
	[CHAR_SOUND_DOH] =               'ReplaceBonk.ogg', -- Hard wall bonk
	[CHAR_SOUND_OOOF] =              'ReplaceBonk.ogg', -- Attacked in air
	[CHAR_SOUND_OOOF2] =             'ReplaceBonk.ogg', -- Land from hard bonk
	[CHAR_SOUND_HAHA] =              'ReplaceTripleJumpLand.ogg', -- Landing triple jump
	[CHAR_SOUND_HAHA_2] =            'ReplaceWaterLanding.ogg', -- Landing in water from big fall
	[CHAR_SOUND_YAHOO] =             'ReplaceLongJump.ogg', -- Long jump
	[CHAR_SOUND_WHOA] =              'ReplaceGrabLedge.ogg', -- Grabbing ledge
	[CHAR_SOUND_EEUH] =              'ReplaceClimbLedge.ogg', -- Climbing over ledge
	[CHAR_SOUND_WAAAOOOW] =          'ReplaceFalling.ogg', -- Falling a long distance
	[CHAR_SOUND_TWIRL_BOUNCE] =      'ReplaceFlowerBounce.ogg', -- Bouncing off of a flower spring
	[CHAR_SOUND_GROUND_POUND_WAH] =  'ReplaceGroundPound.ogg', -- Ground Pound after startup
	[CHAR_SOUND_WAH2] =              'ReplaceThrow.ogg', -- Throwing something
	[CHAR_SOUND_HRMM] =              'ReplaceLift.ogg', -- Lifting something
	[CHAR_SOUND_HERE_WE_GO] =        'ReplaceGetStar.ogg', -- Star get
	[CHAR_SOUND_SO_LONGA_BOWSER] =   'ReplaceThrowBowser.ogg', -- Throwing Bowser
--DAMAGE
	[CHAR_SOUND_ATTACKED] =          'ReplaceDamaged.ogg', -- Damaged
	[CHAR_SOUND_PANTING] =           'ReplacePanting.ogg', -- Low health
	[CHAR_SOUND_PANTING_COLD] =      'ReplacePanting.ogg', -- Getting cold
	[CHAR_SOUND_ON_FIRE] =           'ReplaceBurned.ogg', -- Burned
--SLEEP SOUNDS
	[CHAR_SOUND_IMA_TIRED] =         'ReplaceTired.ogg', -- Mario feeling tired
	[CHAR_SOUND_YAWNING] =           'ReplaceYawn.ogg', -- Mario yawning before he sits down to sleep
	[CHAR_SOUND_SNORING1] =          'ReplaceSnore.ogg', -- Snore Inhale
	[CHAR_SOUND_SNORING2] =          'ReplaceExhale.ogg', -- Exhale
	[CHAR_SOUND_SNORING3] =          'ReplaceSleepTalk.ogg', -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
	[CHAR_SOUND_COUGHING1] =         'ReplaceCough1.ogg', -- Cough take 1
	[CHAR_SOUND_COUGHING2] =         'ReplaceCough2.ogg', -- Cough take 2
	[CHAR_SOUND_COUGHING3] =         'ReplaceCough3.ogg', -- Cough take 3
--DEATH
	[CHAR_SOUND_DYING] =             'ReplaceDying.ogg', -- Dying from damage
	[CHAR_SOUND_DROWNING] =          'ReplaceDrowning.ogg', -- Running out of air underwater
	[CHAR_SOUND_MAMA_MIA] =          'ReplaceLeaveLevel.ogg' -- Booted out of level
}

local CAPTABLE_REPLACE = {
    normal = smlua_model_util_get_id("replace_cap_geo"),
    wing = smlua_model_util_get_id("replace_wcap_geo"),
    metal = smlua_model_util_get_id("replace_mcap_geo"),
}

local PALETTE_REPLACE = {
    [PANTS]  = "ffffff",
    [SHIRT]  = "ffffff",
    [GLOVES] = "ffffff",
    [SHOES]  = "ffffff",
    [HAIR]   = "ffffff",
    [SKIN]   = "ffffff",
    [CAP]    = "ffffff",
	[EMBLEM] = "ffffff"
}

local HEALTH_METER_REPLACE = {
    label = {
        left = get_texture_info("replace_hl"),
        right = get_texture_info("replace_hr"),
    },
    pie = {
        [1] = get_texture_info("replace_h1"),
        [2] = get_texture_info("replace_h2"),
        [3] = get_texture_info("replace_h3"),
        [4] = get_texture_info("replace_h4"),
        [5] = get_texture_info("replace_h5"),
        [6] = get_texture_info("replace_h6"),
        [7] = get_texture_info("replace_h7"),
        [8] = get_texture_info("replace_h8"),
    }
}

local function on_character_select_load()
    CT_REPLACE = charSelect.character_add(
        "Custom Character", -- Character Name
        "Description/Info", -- Description
        "denpakei32", -- Credits
        "00ff00",           -- Menu Color
        E_MODEL_REPLACE,       -- Character Model
        CT_MARIO,           -- Override Character
        TEX_REPLACE_LIFE_ICON, -- Life Icon
        1                   -- Camera Scale
    )

 	charSelect.character_add_caps(E_MODEL_REPLACE, CAPTABLE_REPLACE)
    charSelect.character_add_voice(E_MODEL_REPLACE, VOICETABLE_REPLACE)
    charSelect.character_add_celebration_star(E_MODEL_REPLACE, E_MODEL_REPLACE_STAR, TEX_REPLACE_STAR_ICON)
	charSelect.character_add_palette_preset(E_MODEL_REPLACE, PALETTE_REPLACE)
	charSelect.character_add_health_meter(CT_REPLACE, HEALTH_METER_REPLACE)
	charSelect.character_set_category(CT_REPLACE, TEXT_MOD_NAME)
	charSelect.character_add_animations(E_MODEL_REPLACE, ANIMTABLE_REPLACE, EYETABLE_REPLACE, HANDTABLE_REPLACE)

	charSelect.credit_add(TEXT_MOD_NAME, "denpakei32", "Pack")
end

-- Waits until the API is fully loaded before adding chars, just to be safe
hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
