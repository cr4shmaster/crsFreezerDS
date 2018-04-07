PrefabFiles = {
    "newicebox",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/ui_newicebox_3x4.xml"),
    Asset("ATLAS", "images/inventoryimages/newicebox.xml"),
    Asset("IMAGE", "minimap/newicebox.tex"),
    Asset("ATLAS", "minimap/newicebox.xml"),
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

AddMinimapAtlas("minimap/newicebox.xml")

-- STRINGS --

STRINGS.NAMES.NEWICEBOX = "New Icebox"
STRINGS.RECIPE_DESC.NEWICEBOX = "Kewl!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEWICEBOX = "A better Icebox."

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

local newicebox = swDLC and Recipe("newicebox", ingredients, recipeTab, recipeTech, GLOBAL.RECIPE_GAME_TYPE.COMMON, "newicebox_placer")
                or Recipe("newicebox", ingredients, recipeTab, recipeTech, "newicebox_placer")
newicebox.atlas = (oldAnim and "images/inventoryimages/old/newicebox.xml" or "images/inventoryimages/newicebox.xml")

-- TINT --

local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
    if container.widgetbgimagetint then
        self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    end
end
AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- CONTAINER --

local crsWidgetPosition = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0) -- background image position

AddPrefabPostInit("newicebox", function(inst)
    local slotpos = {}
    for y = 3, 0, -1 do
        for x = 0, 2 do
            table.insert(slotpos, Vector3(80 * x - 80 * 2 + 90, 80 * y - 80 * 2 + 40, 0))
        end
    end
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetbgimage = "ui_newicebox_3x4.tex"
    inst.components.container.widgetbgatlas = "images/inventoryimages/ui_newicebox_3x4.xml"
    inst.components.container.widgetpos = crsWidgetPosition
	inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}
    inst.components.container.side_align_tip = 160
end)

-- ITEM TEST --

local function newiceboxItemTest(inst, item, slot)
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
local function newiceboxItemTestUpdate(inst)
    inst.components.container.itemtestfn = newiceboxItemTest
end
AddPrefabPostInit("newicebox", newiceboxItemTestUpdate)

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

AddPrefabPostInit("newicebox", function(inst)
    inst.components.container.onopenfn = crsOnOpen
    inst.components.container.onclosefn = crsOnClose
end)
