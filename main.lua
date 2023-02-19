TableHelper = require 'tableHelper'

---@class HebiDB
local HebiDB = {}

HebiDB.config = require('custom.hebiDB.config') 

function HebiDB:loadTable()
    self.Table = jsonInterface.load(HebiDB.config.path)
end

function HebiDB:writeTable()
    jsonInterface.quicksave(HebiDB.config.path, self.Table)
end

---@param key string
---@param table table
function HebiDB:insertToTable(key, table)
    TableHelper.insertValues(self.Table[key], table, false)
end

---@return boolean|string|number|table|unknown playerTable READ-ONLY
function HebiDB:getTable()
    return self.Table
end

customEventHooks.registerHandler("OnServerInit", function()
    HebiDB:loadTable()
end)

customEventHooks.registerHandler("OnServerExit", function()
    HebiDB:writeTable()
end)

return HebiDB