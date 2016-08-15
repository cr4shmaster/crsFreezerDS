PrefabFiles = {
    "freezer",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/ui_freezer_3x4.xml"),
    Asset("ATLAS", "images/inventoryimages/freezer.xml"),
    Asset("IMAGE", "minimap/freezer.tex"),
    Asset("ATLAS", "minimap/freezer.xml"),
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
Vector3 = GLOBAL.Vector3
IsDLCEnabled = GLOBAL.IsDLCEnabled
getConfig = GetModConfigData
RoG = GLOBAL.REIGN_OF_GIANTS
SW = GLOBAL.CAPY_DLC

-- local noDLC = not IsDLCEnabled(RoG) and not GLOBAL.IsDLCEnabled(SW)
-- local anyDLC = IsDLCEnabled(RoG) or IsDLCEnabled(SW)
-- local rogDLC = IsDLCEnabled(RoG)
local swDLC = IsDLCEnabled(SW)

-- MAP ICONS --

AddMinimapAtlas("minimap/freezer.xml")

-- STRINGS --

STRINGS.NAMES.FREEZER = "Freezer"
STRINGS.RECIPE_DESC.FREEZER = "Nice!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FREEZER = "Should Do Nicely"

-- RECIPES --

if swDLC then
    local freezer = Recipe("darkpylon", {
        Ingredient("cutstone", 10),
        Ingredient("gears", 3),
        Ingredient("bluegem", 3),
    }, RECIPETABS.FARM, TECH.NONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "freezer_placer")
    freezer.atlas = "images/inventoryimages/freezer.xml"
else
    local freezer = Recipe("darkpylon", {
        Ingredient("cutstone", 10),
        Ingredient("gears", 3),
        Ingredient("bluegem", 3),
    }, RECIPETABS.FARM, TECH.NONE, "freezer_placer")
    freezer.atlas = "images/inventoryimages/freezer.xml"
end

-- TINT --

local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
    if container.widgetbgimagetint then
        self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    end
end
AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- CONTAINER --

local crsWidgetPosition = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0) -- background image position

AddPrefabPostInit("freezer", function(inst)
    local slotpos = {}
    for y = 3, 0, -1 do
        for x = 0, 2 do
            table.insert(slotpos, Vector3(80 * x - 80 * 2 + 90, 80 * y - 80 * 2 + 40, 0))
        end
    end
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetbgimage = "ui_freezer_3x4.tex"
    inst.components.container.widgetbgatlas = "images/inventoryimages/ui_freezer_3x4.xml"
    inst.components.container.widgetpos = crsWidgetPosition
	inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}
    inst.components.container.side_align_tip = 160
end)

-- ITEM TEST --

local function freezerItemTest(inst, item, slot)
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
local function freezerItemTestUpdate(inst)
    inst.components.container.itemtestfn = freezerItemTest
end
AddPrefabPostInit("freezer", freezerItemTestUpdate)

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

AddPrefabPostInit("freezer", function(inst)
    inst.components.container.onopenfn = crsOnOpen
    inst.components.container.onclosefn = crsOnClose
end)
