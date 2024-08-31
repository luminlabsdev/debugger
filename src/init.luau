-- Variables

local RunService = game:GetService("RunService")
local WebLinksAllowed = RunService:IsStudio()

local OutputSpace = string.rep("\t", 4)
local LogList = nil
local Metadata = {
	InfoURL = "",
	PackageName = "Package",
}

-- Functions

local function SetMetadata(metadata: { [string]: any })
	for key, value in metadata do
		if key == "InfoURL" and not WebLinksAllowed then
			continue
		end
		Metadata[key] = value
	end
end

local function SetLogs(logList: { [string]: string })
	LogList = logList
end

local function Log(logId: string, type: "warn" | "err", ...: any)
	local Traceback = debug.traceback(nil, 3)
	local Message = `[{Metadata.PackageName}] {LogList[logId] or "unknown"}{if Metadata.InfoURL ~= ""
		then `\n{OutputSpace}Help: {Metadata.InfoURL}`
		else ""}\n{OutputSpace}Trace: {Traceback}`
	if type == "err" then
		error(Message, 0)
	else
		warn(Message)
	end
end

-- Module

return {
	SetMetadata = SetMetadata,
	SetLogs = SetLogs,
	Log = Log,
}
