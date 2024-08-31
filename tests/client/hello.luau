local Debugger = require(game.ReplicatedStorage.Packages.Debugger)

Debugger.SetMetadata({
    InfoURL = "https://lumin-dev.github.io/LuminFramework/",
    PackageName = "LuminFramework"
})

Debugger.SetLogs({
    sigma = "hi can you please say hi"
})

return function()
    Debugger.Log("sigma", "err")
end