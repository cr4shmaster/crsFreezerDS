-- More information here: https://sites.google.com/view/cr4shmaster/new-icebox-ds-dst

name = "New Icebox v2.0.8.4"
description = "Nice!"
author = "cr4shmaster"
version = "2.0.8.4.2"
forumthread = ""
api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"

local crsCount = {
    {description = "-5", data = -5},
    {description = "-4", data = -4},
    {description = "-3", data = -3},
    {description = "-2", data = -2},
    {description = "-1", data = -1},
    {description = "0", data = 0},
    {description = "1", data = 1},
    {description = "2", data = 2},
    {description = "3", data = 3},
    {description = "4", data = 4},
    {description = "5", data = 5},
}
local crsIngredient = {
    {description = "1", data = 1},
    {description = "2", data = 2},
    {description = "3", data = 3},
    {description = "5", data = 5},
    {description = "10", data = 10},
    {description = "15", data = 15},
    {description = "20", data = 20},
}
local crsPosition = {
    {description = "500", data = 500},
    {description = "475", data = 475},
    {description = "450", data = 450},
    {description = "425", data = 425},
    {description = "400", data = 400},
    {description = "375", data = 375},
    {description = "350", data = 350},
    {description = "325", data = 325},
    {description = "300", data = 300},
    {description = "275", data = 275},
    {description = "250", data = 250},
    {description = "225", data = 225},
    {description = "200", data = 200},
    {description = "175", data = 175},
    {description = "150", data = 150},
    {description = "125", data = 125},
    {description = "100", data = 100},
    {description = "75", data = 75},
    {description = "50", data = 50},
    {description = "25", data = 25},
    {description = "0", data = 0},
    {description = "-25", data = -25},
    {description = "-50", data = -50},
    {description = "-75", data = -75},
    {description = "-100", data = -100},
    {description = "-125", data = -125},
    {description = "-150", data = -150},
    {description = "-175", data = -175},
    {description = "-200", data = -200},
    {description = "-225", data = -225},
    {description = "-250", data = -250},
    {description = "-275", data = -275},
    {description = "-300", data = -300},
    {description = "-325", data = -325},
    {description = "-350", data = -350},
    {description = "-375", data = -375},
    {description = "-400", data = -400},
    {description = "-425", data = -425},
    {description = "-450", data = -450},
    {description = "-475", data = -475},
    {description = "-500", data = -500},
}

configuration_options = {
    {
        name = "cfgRecipeTab",
        label = "Recipe Tab",
        options = {
            {description = "Tools", data = 1},
            {description = "Survival", data = 2},
            {description = "Farm", data = 3},
            {description = "Science", data = 4},
            {description = "Structures", data = 5},
            {description = "Refine", data = 6},
            {description = "Magic", data = 7},
            {description = "Ancient", data = 8},
        },
        default = 1,
    },
    {
        name = "cfgRecipeTech",
        label = "Recipe Tech",
        options = {
            {description = "None", data = 1},
            {description = "Science Machine", data = 2},
            {description = "Alchemy Engine", data = 3},
            {description = "Prestihatitator", data = 4},
            {description = "Shadow Manip.", data = 5},
            {description = "Broken APS", data = 6},
            {description = "Repaired APS", data = 7},
            {description = "Obs. Workbench", data = 8},
        },
        default = 5,
    },
    {
        name = "cfgFStones",
        label = "Cut Stones",
        options = crsIngredient,
        default = 5,
    },
    {
        name = "cfgFGears",
        label = "Gears",
        options = crsIngredient,
        default = 2,
    },
    {
        name = "cfgFGems",
        label = "Blue Gems",
        options = crsIngredient,
        default = 2,
    },
	{
		name = "cfgPerishMult",
		label = "Perish Time",
		options = {
            {description = "Default", data = .5},
            {description = "25% longer", data = .37},
            {description = "50% longer", data = .25},
            {description = "75% longer", data = .12},
            {description = "Forever", data = 0},
        },
		default = .25,
	},
    {
        name = "cfgIcePerDay",
        label = "Ice Per Day",
        options = {
            {description = "Once", data = 16},
            {description = "Twice", data = 8},
            {description = "3 times", data = 5.33},
            {description = "4 times", data = 4},
            {description = "5 times", data = 3.33},
        },
        default = 16,
    },
    {
        name = "cfgTempDuration",
        label = "Cooling Rate",
        options = crsCount,
        default = -1,
    },
    {
        name = "cfgXPos",
        label = "UI x Position",
        options = crsPosition,
        default = -300,
    },
    {
        name = "cfgYPos",
        label = "UI y Position",
        options = crsPosition,
        default = -100,
    },
    {
        name = "cfgTestCheck",
        label = "Installed",
        options = {
            {description = "Yes", data = true},
        },
        default = true,
    },
}