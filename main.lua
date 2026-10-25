-- name: [CS] Template
-- description: Write mod description here!\n\nMade by: You!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local TEXT_MOD_NAME = get_active_mod().name

-- Stops mod from loading if Character Select isn't on, Does not need to be touched
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

--- Load Models ---
local E_MODEL_REPLACE = smlua_model_util_get_id("custom_model_geo")      -- Located in "actors"

--- Load Textures ---
local TEX_REPLACE_LIFE_ICON = get_texture_info("exclamation-icon") -- Located in "textures"

-- All sound files are located in "sound" folder
local VOICETABLE_REPLACE = {
    [CHAR_SOUND_OKEY_DOKEY] =        'CharStartGame.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] =         'CharStartLevel.ogg', -- Starting level
	[CHAR_SOUND_GAME_OVER] =         'CharGameOver.ogg', -- Game Overed
	[CHAR_SOUND_PUNCH_YAH] =         'CharPunch1.ogg', -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] =         'CharPunch2.ogg', -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] =         'CharPunch3.ogg', -- Punch 3
	[CHAR_SOUND_YAH_WAH_HOO] =       {'CharJump1.ogg', 'CharJump2.ogg', 'CharJump3.ogg'}, -- First Jump Sounds
	[CHAR_SOUND_HOOHOO] =            'CharDoubleJump.ogg', -- Second jump sound
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'CharTripleJump1.ogg', 'CharTripleJump2.ogg'}, -- Triple jump sounds
	[CHAR_SOUND_UH] =                'CharBonk.ogg', -- Soft wall bonk
	[CHAR_SOUND_UH2] =               'CharLedgeGetUp.ogg', -- Quick ledge get up
	[CHAR_SOUND_UH2_2] =             'CharLongJumpLand.ogg', -- Landing after long jump
	[CHAR_SOUND_DOH] =               'CharBonk.ogg', -- Hard wall bonk
	[CHAR_SOUND_OOOF] =              'CharBonk.ogg', -- Attacked in air
	[CHAR_SOUND_OOOF2] =             'CharBonk.ogg', -- Land from hard bonk
	[CHAR_SOUND_HAHA] =              'CharTripleJumpLand.ogg', -- Landing triple jump
	[CHAR_SOUND_HAHA_2] =            'CharWaterLanding.ogg', -- Landing in water from big fall
	[CHAR_SOUND_YAHOO] =             'CharLongJump.ogg', -- Long jump
	[CHAR_SOUND_WHOA] =              'CharGrabLedge.ogg', -- Grabbing ledge
	[CHAR_SOUND_EEUH] =              'CharClimbLedge.ogg', -- Climbing over ledge
	[CHAR_SOUND_WAAAOOOW] =          'CharFalling.ogg', -- Falling a long distance
	[CHAR_SOUND_TWIRL_BOUNCE] =      'CharFlowerBounce.ogg', -- Bouncing off of a flower spring
	[CHAR_SOUND_GROUND_POUND_WAH] =  'CharGroundPound.ogg', -- Ground Pound after startup
	[CHAR_SOUND_WAH2] =              'CharThrow.ogg', -- Throwing something
	[CHAR_SOUND_HRMM] =              'CharLift.ogg', -- Lifting something
	[CHAR_SOUND_HERE_WE_GO] =        'CharGetStar.ogg', -- Star get
	[CHAR_SOUND_SO_LONGA_BOWSER] =   'CharThrowBowser.ogg', -- Throwing Bowser
--DAMAGE
	[CHAR_SOUND_ATTACKED] =          'CharDamaged.ogg', -- Damaged
	[CHAR_SOUND_PANTING] =           'CharPanting.ogg', -- Low health
	[CHAR_SOUND_PANTING_COLD] =      'CharPanting.ogg', -- Getting cold
	[CHAR_SOUND_ON_FIRE] =           'CharBurned.ogg', -- Burned
--SLEEP SOUNDS
	[CHAR_SOUND_IMA_TIRED] =         'CharTired.ogg', -- Mario feeling tired
	[CHAR_SOUND_YAWNING] =           'CharYawn.ogg', -- Mario yawning before he sits down to sleep
	[CHAR_SOUND_SNORING1] =          'CharSnore.ogg', -- Snore Inhale
	[CHAR_SOUND_SNORING2] =          'CharExhale.ogg', -- Exhale
	[CHAR_SOUND_SNORING3] =          'CharSleepTalk.ogg', -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
	[CHAR_SOUND_COUGHING1] =         'CharCough1.ogg', -- Cough take 1
	[CHAR_SOUND_COUGHING2] =         'CharCough2.ogg', -- Cough take 2
	[CHAR_SOUND_COUGHING3] =         'CharCough3.ogg', -- Cough take 3
--DEATH
	[CHAR_SOUND_DYING] =             'CharDying.ogg', -- Dying from damage
	[CHAR_SOUND_DROWNING] =          'CharDrowning.ogg', -- Running out of air underwater
	[CHAR_SOUND_MAMA_MIA] =          'CharLeaveLevel.ogg' -- Booted out of level
}

local CAPTABLE_REPLACE = {
    normal = smlua_model_util_get_id("FILENAME_geo"),
    wing = smlua_model_util_get_id("FILENAME_geo"),
    metal = smlua_model_util_get_id("FILENAME_geo"),
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
        left = get_texture_info("healthleft"),
        right = get_texture_info("healthright"),
    },
    pie = {
        [1] = get_texture_info("Pie1"),
        [2] = get_texture_info("Pie2"),
        [3] = get_texture_info("Pie3"),
        [4] = get_texture_info("Pie4"),
        [5] = get_texture_info("Pie5"),
        [6] = get_texture_info("Pie6"),
        [7] = get_texture_info("Pie7"),
        [8] = get_texture_info("Pie8"),
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
