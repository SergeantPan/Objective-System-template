	local ActiveObjective = ""
	local SubObjective = ""
	local CurObjMarker = 0
	local RemoveDelay = math.huge

hook.Add("HUDPaint", "CustomNameObj", function(ply)

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

	local Alpha = Color( GetConVar("ObjFontColorR"):GetInt(), GetConVar("ObjFontColorG"):GetInt(), GetConVar("ObjFontColorB"):GetInt(), GetConVar("ObjFontColorA"):GetInt() )

	local Width = GetConVar("ObjSysTextXPos"):GetFloat()
	local Height = GetConVar("ObjSysTextYPos"):GetFloat()

	local ply = LocalPlayer()

	local XPos = math.Round(tostring(ply:GetPos().x), 0)
	local YPos = math.Round(tostring(ply:GetPos().y), 0)
	local ZPos = math.Round(tostring(ply:GetPos().z), 0) + 3

	draw.DrawText( "Current Objectives:", "ObjSysBig", ScrW() * Width, ScrH() * Height, Alpha, 0 )
	draw.DrawText( "__________________", "ObjSysBig", ScrW() * Width, ScrH() * (Height + 0.01), Alpha, 0 )

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

if CurObjMarker == 0 then

	ActiveObjective = "- This is the current objective"
	DeathObjective = "- This is the current objective - Objective Failed"
	CurObjMarker = 1
end
	if CurObjMarker == 10 then
	ActiveObjective = "- Proceed to the next level"
end

if SubObjective != "" then
	draw.DrawText( "Side Objectives:", "ObjSysBig", ScrW() * Width, ScrH() * (Height + 0.15), Alpha, 0 )
	draw.DrawText( "__________________", "ObjSysBig", ScrW() * Width, ScrH() * (Height + 0.16), Alpha, 0 )
end

	draw.DrawText( CurObjective, "ObjSysSmall", ScrW() * Width, ScrH() * (Height + 0.04), Alpha, 0 )
	draw.DrawText( SubObjective, "ObjSysSmall", ScrW() * Width, ScrH() * (Height + 0.17), Alpha, 0 )

local Marker = Material("ping.png")
local CuriosityMarker = Material("locationping.png")

if CurObjMarker == 1 then
	CurObjSpot = Vector(640, -7432, -100)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 598, 669) and YPos == math.Clamp(YPos, -7453, -7387))
end
if CurObjMarker == 2 then
	CurObjSpot = Vector(-314, -7360, -100)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, -360, -280) and YPos == math.Clamp(YPos, -7396, -7329))
end
if CurObjMarker == 3 then
	CurObjTriggerSpot = nil
	SubObjSpot = Vector(280, -6800, 520)
	CurObjMarker = CurObjMarker + 1
end
if CurObjMarker == 4 then
	CurObjSpot = Vector(395, -7010, 532)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 388, 448) and YPos == math.Clamp(YPos, -7115, -6950))
	SubObjTriggerSpot = (XPos == math.Clamp(XPos, 260, 380) and YPos == math.Clamp(YPos, -7000, -6600))
end
if CurObjMarker == 5 then
	CurObjTriggerSpot = nil
	SubObjSpot = nil
	SubObjective = string.gsub(SubObjective, "%\n%- Do a Side Thing", "%\n%- Do a Side Thing - Objective Failed")
	RemoveDelay = CurTime() + 5
	CurObjMarker = CurObjMarker + 1
end
if CurObjMarker == 6 then
	CurObjSpot = Vector(607, -5167, 532)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 583, 628) and YPos == math.Clamp(YPos, -5180, -5128))
end
if CurObjMarker == 7 then
	ActiveObjective = "- A New Objective is added"
	DeathObjective = "- A New Objective is added - Objective Failed"
	CurObjSpot = Vector(699, -3455, 404)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 657, 735) and YPos == math.Clamp(YPos, -3497, -3422))
end
if CurObjMarker == 8 then
	CurObjTriggerSpot = nil
	ActiveObjective = "- A New Objective is added - Objective Complete"
	DeathObjective = "- A second Objective is added - Objective Failed"
	RemoveDelay = CurTime() + 5
	CurObjMarker = CurObjMarker + 1
end
if CurObjMarker == 9 then
	CurObjSpot = Vector(488, 2613, -67)
	CurObjTriggerSpot = (XPos == math.Clamp(XPos, 448, 530) and YPos == math.Clamp(YPos, 2563, 2659))
end
if CurObjMarker == 10 then
	CurObjSpot = nil
	CurObjTriggerSpot = nil
end

if CurObjTriggerSpot then
	CurObjMarker = CurObjMarker + 1
end
if SubObjTriggerSpot and SubObjSpot != nil then
	SubObjective = string.gsub(SubObjective, "Side Thing", "Side Thing - Objective Complete")
	SubObjSpot = nil
end

if RemoveDelay < CurTime() then
	ActiveObjective = string.gsub(ActiveObjective, "%- A New Objective is added %- Objective Complete", "- A second Objective is added")
	SubObjective = string.gsub(SubObjective, "%\n%- Do a Side Thing %- Objective Complete", "")
	SubObjective = string.gsub(SubObjective, "%\n%- Do a Side Thing %- Objective Failed", "")
end

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

end
end)