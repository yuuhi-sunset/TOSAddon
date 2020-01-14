_G["ADDONS"] = _G["ADDONS"] or {}
_G["ADDONS"]["YUUHI"] = _G["ADDONS"]["YUUHI"] or {}
_G["ADDONS"]["YUUHI"]["POKEMON"] = _G["ADDONS"]["YUUHI"]["POKEMON"] or {}
local g = _G["ADDONS"]["YUUHI"]["POKEMON"]

function _G.POKEMON_ON_INIT(addon, frame)
  g.addon = g.addon or addon
  g.frame = g.addon or frame

  _G.ANCIENT_MON_SACRIFICE = function()
    _G.CHAT_SYSTEM("[pokemon] 合成を無効化しました。")
  end
end