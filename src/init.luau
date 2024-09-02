-- Variables

local RunService = game:GetService("RunService")
local WebLinksAllowed = RunService:IsStudio()

local LogList = nil
local Metadata = {
	InfoURL = "",
	PackageName = "Package",
}

-- Functions

--[=[
	Sets specific metadata for formatting; such as a custom web link or package name

	[Learn More](https://google.com)
]=]
local function SetMetadata(metadata: { [string]: any })
	for key, value in metadata do
		if key == "InfoURL" and not WebLinksAllowed then
			continue
		end
		Metadata[key] = value
	end
end

--[=[
	Sets a list of logs to be referenced within formatters

	[Learn More](https://google.com)
]=]
local function SetLogs(logList: { [string]: string })
	LogList = logList
end

--[=[
	Base formatter for all debug functions, returns a formatted string with extra info

	[Learn More](https://google.com)
]=]
local function Format(logId: string, ...: any): string
	assert(LogList[logId], "Invalid log ID")
	local Traceback = debug.traceback(nil, 3)
	return string.gsub(
		`[{Metadata.PackageName}] {LogList[logId] or "unknown"}{if Metadata.InfoURL ~= ""
			then `\nLearn: {Metadata.InfoURL}`
			else ""}\nTrace: {Traceback}`,
		"\n",
		"\n\t\t\t\t"
	)
end

--[=[
	Formats a fatal error of a log ID with provided parameters

	[Learn More](https://google.com)
]=]
local function Fatal(logId: string, ...: any): never
	error(Format(logId, ...), 0)
end

--[=[
	Formats a warning of a log ID with provided parameters

	[Learn More](https://google.com)
]=]
local function Warn(logId: string, ...: any)
	warn(Format(logId, ...))
end

--[=[
	Returns the condition if it was truthy; behaves opposite of assert

	[Learn More](https://google.com)
]=]
local function Expect<T>(condition: T, logId: string, ...: any): T
	if condition then
		return condition
	end
	return Fatal(logId, ...)
end

-- Module

return table.freeze({
	SetMetadata = SetMetadata,
	SetLogs = SetLogs,
	Format = Format,
	Fatal = Fatal,
	Warn = Warn,
	Expect = Expect,
})
