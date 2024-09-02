local Debugger = require(game.ReplicatedStorage.Packages.debugger)
local TestModule = require(script.Parent.testmodule)

Debugger.SetMetadata({
    PackageURL = "https://lumin-dev.github.io/LuminFramework/",
    PackageName = "Lumin Framework",
    TraceLevel = 2,
})

Debugger.SetLogs({
    Good = "hi can you please say hi",
    Bad = "OH NO - %s",
})

Debugger.Warn("Good")

local result, message = xpcall(function()
    TestModule()
end, Debugger.Parse)

if not result then
    local error_message = message :: Debugger.ParsedError
    Debugger.Warn("Bad", error_message.Message)
end
