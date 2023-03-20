// This is a template for making an objective-system for a new map
// Don't touch anything up here, this is simply for functionality's sake

	local ActiveObjective = ""
	local SubObjective = ""
	local CurObjMarker = 0
	local RemoveDelay = math.huge

hook.Add("HUDPaint", "CustomNameObj", function(ply)

// Obviously replace CustomNameObj with whatever you want, just make sure it doesn't conflict with others

if GetConVar("ResetObjectives"):GetInt() == 1 then
	ActiveObjective = ""
	CurObjMarker = 0
	SubObjective = ""
	SubObjSpot = nil
	RemoveDelay = math.huge
	RunConsoleCommand("ResetObjectives", "0")
end

	local MarkerDistance = GetConVar("ObjSysMarkerDistance"):GetInt()

	if game.GetMap() == "MapNameHere" and GetConVar("ObjSysEnabled"):GetInt() == 1 then

// Replace MapNameHere with the map name (Duh.) Note that this is not the name displayed on the menu
// But rather the name of the map file instead
// E.g: Construct = gm_construct

	local Alpha = Color( GetConVar("ObjFontColorR"):GetInt(), GetConVar("ObjFontColorG"):GetInt(), GetConVar("ObjFontColorB"):GetInt(), GetConVar("ObjFontColorA"):GetInt() )

	local Width = GetConVar("ObjSysTextXPos"):GetFloat()
	local Height = GetConVar("ObjSysTextYPos"):GetFloat()

	local ply = LocalPlayer()

	local XPos = math.Round(tostring(ply:GetPos().x), 0)
	local YPos = math.Round(tostring(ply:GetPos().y), 0)
	local ZPos = math.Round(tostring(ply:GetPos().z), 0) + 3

// More functionality stuff

// if ActiveObjective != "" then
	draw.DrawText( "Current Objectives:", "ObjSysBig", ScrW() * Width, ScrH() * Height, Alpha, 0 )
	draw.DrawText( "__________________", "ObjSysBig", ScrW() * Width, ScrH() * (Height + 0.01), Alpha, 0 )
// end
// Only use this if there is ever a point where the objectives are blank
// I.e. there is no active objective

if GetConVar("ObjSysResetOnDeath"):GetInt() == 1 and ply:Alive() then
if CurObjective == DeathObjective then
	RunConsoleCommand("ResetObjectives", "0")
end
end
if !ply:Alive() then
	CurObjective = DeathObjective
else
	CurObjective = ActiveObjective
end

// Here we start the objective itself

if CurObjMarker == 0 then

	ActiveObjective = "- This is the current objective"
// ActiveObjective is what defines the Current Objectives text
// This will be applied at the beginning of the map

	DeathObjective = "- This is the current objective - Objective Failed"
// DeathObjective is what the player sees when they die
// This should be the same as ActiveObjective, but with the Objective Failed suffix

	CurObjMarker = 1
end
	if CurObjMarker == 10 then
	ActiveObjective = "- Proceed to the next level"
end
// Here, we define the last CurObjMarker on the map as the level change text
// Basically it tells the player a mapchange is coming

if SubObjective != "" then
	draw.DrawText( "Side Objectives:", "ObjSysBig", ScrW() * Width, ScrH() * (Height + 0.15), Alpha, 0 )
	draw.DrawText( "__________________", "ObjSysBig", ScrW() * Width, ScrH() * (Height + 0.16), Alpha, 0 )
end
// This starts the Side Objectives text, but only if SubObjective is not blank

	draw.DrawText( CurObjective, "ObjSysSmall", ScrW() * Width, ScrH() * (Height + 0.04), Alpha, 0 )
	draw.DrawText( SubObjective, "ObjSysSmall", ScrW() * Width, ScrH() * (Height + 0.17), Alpha, 0 )
// Write the text n stuff

// The Markers
local Marker = Material("ping.png")
// This is the "Go here" orange marker

local CuriosityMarker = Material("locationping.png")
// This is the "Cool stuff here" green marker

// Here, we start the objective system itself
// CurObjMarker refers to the numerical value of each position
// To put it simply: The player starts at 1, going up in value 1 > 2 > 3 > 4 > 5 etc.
// See the 'Objective System explained.txt' for a more simplified explanation

if CurObjMarker == 1 then
	CurObjSpot = Vector(640, -7432, -100)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 598, 669) and YPos == math.Clamp(YPos, -7453, -7387))
end
// These are ordinary objective markers, with nothing fancy

if CurObjMarker == 2 then
	CurObjSpot = Vector(-314, -7360, -100)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, -360, -280) and YPos == math.Clamp(YPos, -7396, -7329))
end
if CurObjMarker == 3 then
	CurObjTriggerSpot = nil
	SubObjSpot = Vector(280, -6800, 520)
	SubObjective = "\n- Do a Side Thing"
	CurObjMarker = CurObjMarker + 1
end
// Here, we create a green marker for a unique location

if CurObjMarker == 4 then
	CurObjSpot = Vector(395, -7010, 532)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 388, 448) and YPos == math.Clamp(YPos, -7115, -6950))
	SubObjTriggerSpot = (XPos == math.Clamp(XPos, 260, 380) and YPos == math.Clamp(YPos, -7000, -6600))
end
// Add the triggerspot for the green marker

if CurObjMarker == 5 then
	CurObjTriggerSpot = nil
	SubObjSpot = nil
	SubObjective = string.gsub(SubObjective, "%\n%- Do a Side Thing", "%\n%- Do a Side Thing - Objective Failed")
	RemoveDelay = CurTime() + 5
	CurObjMarker = CurObjMarker + 1
end
// Remove the green marker, because the player advanced too many Objective Markers
// And then apply the Objective Failed suffix
// Only do this if the SubObj is too far, or unreachable
// If the SubObj should not be removed yet, then SubObjTriggerSpot must be applied to the next CurObjMarker aswell

if CurObjMarker == 6 then
	CurObjSpot = Vector(607, -5167, 532)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 583, 628) and YPos == math.Clamp(YPos, -5180, -5128))
//	SubObjTriggerSpot = (XPos == math.Clamp(XPos, 260, 380) and YPos == math.Clamp(YPos, -7000, -6600))
// Like this
end

if CurObjMarker == 7 then
	ActiveObjective = "- A New Objective is added"
	DeathObjective = "- A New Objective is added - Objective Failed"
	CurObjSpot = Vector(699, -3455, 404)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 657, 735) and YPos == math.Clamp(YPos, -3497, -3422))
end
// Update the objective text

if CurObjMarker == 8 then
	CurObjTriggerSpot = nil
	ActiveObjective = "- A New Objective is added - Objective Complete"
	DeathObjective = "- A second Objective is added - Objective Failed"
	RemoveDelay = CurTime() + 5
	CurObjMarker = CurObjMarker + 1
end
// Update it again, but because we complete it
// We skip to the next CurObjMarker, because otherwise the delay will not update the objective text

if CurObjMarker == 9 then
	CurObjSpot = Vector(488, 2613, -67)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 448, 530) and YPos == math.Clamp(YPos, 2563, 2659))
end
if CurObjMarker == 10 then
	CurObjSpot = nil
	CurObjTriggerSpot = nil
end
// This is the last Objective Marker
// If the player reaches the last marker on the map (in this case 9)
// Then this marker will automatically disable the marker and trigger spot
// And the - Proceed to the next level text will trigger

if CurObjTriggerSpot then
	CurObjMarker = CurObjMarker + 1
end

if SubObjTriggerSpot and SubObjSpot != nil then
	SubObjective = string.gsub(SubObjective, "Side Thing", "Side Thing - Objective Complete")
	SubObjSpot = nil
end
// This is what disables the green marker
// We can also use it to update the SubObjective text

if RemoveDelay < CurTime() then
	ActiveObjective = string.gsub(ActiveObjective, "%- A New Objective is added %- Objective Complete", "- A second Objective is added")
	SubObjective = string.gsub(SubObjective, "%\n%- Do a Side Thing %- Objective Complete", "")
	SubObjective = string.gsub(SubObjective, "%\n%- Do a Side Thing %- Objective Failed", "")
end
// This is where we remove objective text, and either replace it or remove it
// Note that the whole line has to be accounted for
// In this case, Objective Failed/Complete triggers
// Otherwise the text will remain and ruin the appearance

cam.Start3D()
if CurObjSpot != nil then
	RoundedDistance = math.Round( ply:GetPos():Distance( CurObjSpot ) / 39.37, 0 )
if RoundedDistance < MarkerDistance then
	render.SetMaterial(Marker)
	render.DrawSprite( CurObjSpot, 14, 60, color_white )
end
end
if SubObjSpot != nil then
	RoundedDistance = math.Round( ply:GetPos():Distance( SubObjSpot ) / 39.37, 0 )
if RoundedDistance < MarkerDistance then
	render.SetMaterial(CuriosityMarker)
	render.DrawSprite( SubObjSpot, 14, 20, color_white )
end
end
cam.End3D()

end // GetMap end
end)
