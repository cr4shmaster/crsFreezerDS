require "prefabutil"

getConfig = GetModConfigData
local crsNewIceboxDS = getConfig("cfgTestCheck", "workshop-744033689") and "workshop-744033689" or "crsNewIceboxDS"

local assets = {
    Asset("ANIM", "anim/newicebox.zip"),
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.components.container:DropEverything()
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
    inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.components.container:DropEverything()
	inst.AnimState:PushAnimation("closed", false)
	inst.components.container:Close()	
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", false)	
end

local function fn(Sim)
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    
	inst.entity:AddAnimState()
    
	inst.entity:AddSoundEmitter()
    
	--inst:AddTag("fridge")
	inst:AddTag("newicebox")
    
    inst:AddTag("crsCustomPerishMult")
    inst.crsCustomPerishMult = getConfig("cfgPerishMult", crsNewIceboxDS)
    inst:AddTag("crsCustomTempDuration")
    inst.crsCustomTempDuration = getConfig("cfgTempDuration", crsNewIceboxDS)
    
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("newicebox.tex")
	
    inst.AnimState:SetBank("freezer")
    inst.AnimState:SetBuild("freezer")
    inst.AnimState:PlayAnimation("closed")

    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(6.5)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(0/0,0/0,255/255)    


    inst:AddComponent("container")
    inst.components.container.widgetanimbank = nil
    inst.components.container.widgetanimbuild = nil
    inst.components.container.side_align_tip = 160 

    if (IsDLCEnabled(REIGN_OF_GIANTS)) then
        inst:AddComponent("harvestable")
        inst.components.harvestable:SetUp("ice", 1, 30 * getConfig("cfgIcePerDay", crsNewIceboxDS))
    end
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
    if inst.components.harvestable and inst.components.harvestable:CanBeHarvested() then
        return "READY"
    end
    end

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 
	
    return inst
end

return Prefab( "common/newicebox", fn, assets),
       MakePlacer("common/newicebox_placer", "freezer", "freezer", "closed")
