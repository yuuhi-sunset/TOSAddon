_G["ADDONS"] = _G["ADDONS"] or {}
_G["ADDONS"]["YUUHI"] = _G["ADDONS"]["YUUHI"] or {}
_G["ADDONS"]["YUUHI"]["LYCANFIX"] = _G["ADDONS"]["YUUHI"]["LYCANFIX"] or {}
local g = _G["ADDONS"]["YUUHI"]["LYCANFIX"]

g.buffIDTable = g.buffIDTable or {}
g.buffIDTable[40908] = 2162 -- Lycanthropy_Half_Buff

function _G.LYCANFIX_ON_INIT(addon, frame)
  g.addon = g.addon or addon
  g.frame = g.addon or frame

  if g.oldHook == nil then
    g.oldHook = _G.QUICKSLOTNEXPBAR_SLOT_USE
    _G.QUICKSLOTNEXPBAR_SLOT_USE = function (...) g.hook(...) end
  end
end

function g.hook(frame, slot, ...)
  if _G.GetCraftState() == 1 then
    g.oldHook(frame, slot, ...)
    return
  end

  _G.tolua.cast(slot, 'ui::CSlot')
  local icon = slot:GetIcon()
  if icon == nil then
    g.oldHook(frame, slot, ...)
    return
  end

  local iconInfo = icon:GetInfo()
  if iconInfo:GetCategory() == 'Skill' then
    local skillInfo = _G.session.GetSkill(iconInfo.type)
    if skillInfo then
      local skl = _G.GetIES(skillInfo:GetObject())
      if skillInfo:GetCurrentCoolDownTime() == 0 then
        local buffID = g.buffIDTable[skl.ClassID]
        if buffID ~= nil and g.hasBuff(buffID) then
          _G.packet.ReqRemoveBuff(buffID)
          return
        end
      end
    end
  end

  g.oldHook(frame, slot, ...)
end

function g.hasBuff(buffID)
  if buffID ~= nil then
    local handle = _G.session.GetMyHandle()
    for i = 0, _G.info.GetBuffCount(handle) - 1 do
      if buffID == _G.info.GetBuffIndexed(handle, i).buffID then
        return true
      end
    end
  end

  return false
end
