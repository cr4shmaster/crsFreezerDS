PrefabFiles = {
    "icebox_v2",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/ui_icebox_v2_3x4.xml"),
    Asset("ATLAS", "images/inventoryimages/icebox_v2.xml"),
    Asset("IMAGE", "minimap/icebox_v2.tex"),
    Asset("ATLAS", "minimap/icebox_v2.xml"),
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
Vector3 = GLOBAL.Vector3
IsDLCEnabled = GLOBAL.IsDLCEnabled
RoG = GLOBAL.REIGN_OF_GIANTS
SW = GLOBAL.CAPY_DLC
getConfig = GetModConfigData

-- local noDLC = not IsDLCEnabled(RoG) and not IsDLCEnabled(SW)
-- local anyDLC = IsDLCEnabled(RoG) or IsDLCEnabled(SW)
-- local rogDLC = IsDLCEnabled(RoG)
local swDLC = IsDLCEnabled(SW)

-- MAP ICONS --

AddMinimapAtlas("minimap/icebox_v2.xml")

-- STRINGS --

STRINGS.NAMES.ICEBOX_V2 = "Icebox"
STRINGS.RECIPE_DESC.ICEBOX_V2 = "Kewl!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ICEBOX_V2 = "A better Icebox."

-- RECIPES --

local crsRecipeTabs = {
    RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
    RECIPETABS.ANCIENT,
}
local recipeTab = crsRecipeTabs[getConfig("cfgRecipeTab")]

local crsRecipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
    TECH.OBSIDIAN_TWO, -- Obsidian Workbench
}
local recipeTech = crsRecipeTechs[getConfig("cfgRecipeTech")]

local ingredients = {
    Ingredient("cutstone", getConfig("cfgFStones")),
    Ingredient("gears", getConfig("cfgFGears")),
    Ingredient("bluegem", getConfig("cfgFGems")),
}

local icebox_v2 = swDLC and Recipe("icebox_v2", ingredients, recipeTab, recipeTech, GLOBAL.RECIPE_GAME_TYPE.COMMON, "icebox_v2_placer")
                or Recipe("icebox_v2", ingredients, recipeTab, recipeTech, "icebox_v2_placer")
icebox_v2.atlas = (oldAnim and "images/inventoryimages/old/icebox_v2.xml" or "images/inventoryimages/icebox_v2.xml")

-- TINT --

local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
    if container.widgetbgimagetint then
        self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    end
end
AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- CONTAINER --

local crsWidgetPosition = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0) -- background image position

AddPrefabPostInit("icebox_v2", function(inst)
    local slotpos = {}
    for y = 3, 0, -1 do
        for x = 0, 2 do
            table.insert(slotpos, Vector3(80 * x - 80 * 2 + 90, 80 * y - 80 * 2 + 40, 0))
        end
    end
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetbgimage = "ui_icebox_v2_3x4.tex"
    inst.components.container.widgetbgatlas = "images/inventoryimages/ui_icebox_v2_3x4.xml"
    inst.components.container.widgetpos = crsWidgetPosition
	inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}
    inst.components.container.side_align_tip = 160
end)

-- ITEM TEST --

local function icebox_v2ItemTest(inst, item, slot)
	return (item.components.edible and item.components.perishable) or 
	item.prefab == "spoiled_food" or 
	item.prefab == "heatrock" or 
	item.prefab == "rottenegg" or
	item.prefab == "hawaiianshirt" or
	item.prefab == "hambat" or	
	item.prefab == "watermelonhat" or	
	item.prefab == "flowerhat" or
	item:HasTag("icebox_valid")or
	item:HasTag("frozen") or
	item:HasTag("foodclothing")
end
local function icebox_v2ItemTestUpdate(inst)
    inst.components.container.itemtestfn = icebox_v2ItemTest
end
AddPrefabPostInit("icebox_v2", icebox_v2ItemTestUpdate)

-- ON OPEN/CLOSED --

local function crsOnOpen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")		
    inst.AnimState:PlayAnimation("open")
    inst.Light:Enable(true)
end

local function crsOnClose(inst)
    inst.AnimState:PlayAnimation("closed")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")		
    inst.Light:Enable(false)
end

AddPrefabPostInit("icebox_v2", function(inst)
    inst.components.container.onopenfn = crsOnOpen
    inst.components.container.onclosefn = crsOnClose
end)
