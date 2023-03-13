if CLIENT then
// CONFIG //
// Where is this placed on the screen?
local NLRPlaceX = ScrW()*0.9
local NLRPlaceY = ScrH()*0.15
local NLRLengthX = ScrW()*0.1
local NLRLengthY = ScrH()*0.06
// When should it disappear?
local DissapearAt = 300 // After 5 minutes the timer will disappear
/////////////////////////////////////////////////

local NLRColor = Color(0,0,0,64)
local NLRTextColor = Color(255,255,0,64)
local LastDeath = 0
local ShowOn = true

net.Receive( "UpdateNLRTime", function( len )
    ShowOn = true
    LastDeath = net.ReadUInt(32) // Fun fact: Due to the limits of a unsigned 32 bit integer, this will stop working in 2106.
end)

surface.CreateFont( "NLRTimerFont", {
	font = "Consolas",
	size = 16,
} )
surface.CreateFont( "NLRTimerFontBold", {
	font = "Cambria",
	size = 48,
} )

hook.Add("HUDPaint", "NLRClient", function()
    if ShowOn && (LastDeath > os.time() - DissapearAt) then
        surface.SetDrawColor(NLRColor)
        draw.RoundedBoxEx(20, NLRPlaceX, NLRPlaceY, NLRLengthX, NLRLengthY, NLRColor, true, false, true, false)
        draw.SimpleText("Time since last death", "NLRTimerFont", NLRPlaceX+(NLRLengthX*0.5), NLRPlaceY+(NLRLengthY*0.15), NLRTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        local TimeTable = string.FormattedTime(os.difftime(os.time(), LastDeath))
        local TimeTableEnd = ""
        if TimeTable.h > 0 then
            if TimeTable.h > 9 then
                TimeTableEnd = TimeTableEnd..TimeTable.h..":"
            else
                TimeTableEnd = TimeTableEnd.."0"..TimeTable.h..":"
            end
        end
        if TimeTable.m > 9 then
            TimeTableEnd = TimeTableEnd..TimeTable.m..":"
        else
            TimeTableEnd = TimeTableEnd.."0"..TimeTable.m..":"
        end
        if TimeTable.s > 9 then
            TimeTableEnd = TimeTableEnd..TimeTable.s
        else
            TimeTableEnd = TimeTableEnd.."0"..TimeTable.s
        end
        draw.SimpleText(TimeTableEnd, "NLRTimerFontBold", NLRPlaceX+(NLRLengthX*0.5), NLRPlaceY+(NLRLengthY*0.55), NLRTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

end)
end