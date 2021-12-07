--Setting up slash commands
SLASH_InviteMacro1 = "/invitemacro"
SLASH_InviteMacro2 = "/invmacro"
SlashCmdList["InviteMacro"] = function()   
local numglobal, numperchar = GetNumMacros()
local members = GetNumGroupMembers()
local affectingCombat = UnitAffectingCombat("player")
--check if in a party and no more than 5 players are present 
if(members == 0) then 
    print("You aren't in a party")
elseif(members > 5) then
    print("You are in a raid")
--check if player is in combat since CreateMacro is protected and can only be used out of combat
elseif(affectingCombat) then 
    print("Macro can only be created out of combat.")
else
--check if macros are capped  
if(numglobal>119) then
    print("You can't have any more macros!")
else
    local macrotxt
    local PartyNames = {}
    for i=1, members-1 do
        PartyNames[i] = "/inv " .. GetUnitName("party"..(i), true) .. "\n"
    end
    macrotxt = table.concat(PartyNames)
    --check if there already is a macro named INV Macro and edit it if 
    if(GetMacroIndexByName("INV Macro") == 0) then 
        CreateMacro("INV Macro", 136101, macrotxt)  
        print("Macro generated.")
    else 
    --if not create one
        EditMacro("INV Macro", "INV Macro", 136101, macrotxt, 1, 1) 
        print("Macro updated.")
    end  
    --check if the macro frame is open and update it if
    if (MacroFrame ~= nil) then   
        if (MacroFrame:IsVisible()) then
            MacroFrame_Update()
        end
    end
end
end
end
