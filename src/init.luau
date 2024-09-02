-- Variables

local RunService = game:GetService("RunService")
local PackageLinksAllowed = RunService:IsStudio()

local LogList = nil
local Metadata = {
	PackageURL = "",
	PackageName = "Package",
}

-- Functions

--[=[
	Sets specific metadata for formatting; such as a custom web link or package name.

	[Learn More](https://google.com)
]=]
local function SetMetadata(metadata: { [string]: any })
	for key, value in metadata do
		if key == "PackageURL" and not PackageLinksAllowed then
			continue
		end
		Metadata[key] = value
	end
end

--[=[
	Sets a list of logs to be referenced within formatters.

	[Learn More](https://google.com)
]=]
local function SetLogs(logList: { [string]: string })
	LogList = logList
end

--[=[
	Base formatter for all debug functions, returns a formatted string with extra info.

	[Learn More](https://google.com)
]=]
local function Format(logId: string, ...: any): string
	assert(LogList[logId], "Invalid log ID")
	local Traceback = debug.traceback(nil, 3)
	return string.gsub(
		`[{Metadata.PackageName}] {LogList[logId] or "Package"}{if Metadata.PackageURL ~= ""
			then `\nLearn: {Metadata.PackageURL}`
			else ""}\nTrace: {Traceback}`,
		"\n",
		"\n\t\t\t\t"
	)
end

--[=[
	Formats a fatal error of a log ID with provided parameters.

	[Learn More](https://google.com)
]=]
local function Fatal(logId: string, ...: any): never
	error(Format(logId, ...), 0)
end

--[=[
	Formats a warning of a log ID with provided parameters.

	[Learn More](https://google.com)
]=]
local function Warn(logId: string, ...: any)
	warn(Format(logId, ...))
end

--[=[
	Returns the provided condition if it is false, behaves as the regular assert.

	[Learn More](https://google.com)
]=]
local function Assert<T>(condition: T, logId: string, ...: any): T
	if not condition then
		return condition :: any
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
	Assert = Assert,
})
