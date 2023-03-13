if SERVER then
util.AddNetworkString("UpdateNLRTime")
hook.Add("PostPlayerDeath", "NLRTimerUpdate", function( ply )
    net.Start("UpdateNLRTime")
    net.WriteUInt(os.time(), 32) // This spends 4 bytes of bandwidth to ensure that the time-of-death the client receives is accurate.
    net.Send(ply)
end)
end