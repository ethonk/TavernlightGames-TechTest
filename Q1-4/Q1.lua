-- Constants
--  * To improve maintainability in code,
--  * these values can be changed without altering the code.
local STORAGE_KEY = 1000
local STORAGE_RELEASE_DELAY_MS = 1000 -- in milliseconds

-- Release Storage
--  * param1, player: The player's storage to release
local function releaseStorage(player)
  -- Ensure the player exists
  if not player then
    print("Invalid Player.")
    return
  end
  -- Set storage value to -1
  player:setStorageValue(STORAGE_KEY, -1)
end

-- On Log Out
--  * param1, player: The player that is logging out
function onLogout(player)
  -- Player exists, and storage exists. Release Storage.
  if player and player:getStorageValue(STORAGE_KEY) == 1 then
    addEvent(releaseStorage, STORAGE_RELEASE_DELAY_MS, player)
  end
  return true
end