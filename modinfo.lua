-- The Freezer keeps your food fresh or frozen and produces ice.

-- Original author:
-- Afro1967: http://steamcommunity.com/profiles/76561197989646930
-- New version author:
-- cr4shmaster: http://steamcommunity.com/id/cr4shmaster

name = "Freezer 2.0"
description = "Nice!"
author = "cr4shmaster"
version = "2.0.1"
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

configuration_options =
{
	{
		name = "cfgPerishMult",
		label = "Perish Time",
		options = {
            {description = "Default", data = .5},
            {description = "25% longer", data = .37},
            {description = "50% longer", data = .25},
            {description = "75% longer", data = .12},
            {description = "None", data = 0},
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
        label = "Temp Duration",
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