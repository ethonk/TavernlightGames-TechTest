-- Remove Player from Party
--  * Removes a player with a direct reference to the player.
--  * Can called with other functions like "removePlayerFromPartyWithPlayerId" to avoid redundancy.
function removePlayerFromParty(party, player)

    -- Create player reference
    --  * done this way as it is called twice in the iterator
    --  * we can also prevent entering the loop if this player is invalid
    if not player then
        print("Player does not exist.")
        return false
    end

    -- Iterate through every player
    --  * Changed from k, v to more readable parameters.
    for index, partyMember in pairs(party:getMembers()) do
        -- Check if the party member matches and remove
        if partyMember == player then
            party:removeMember(player)
            return  -- important, when the player is removed we can ignore the rest of the loop
        end
    end

    -- Return unsuccessful when no player result.
    return false
end

-- Remove Player from Party with Name
--  * Removes a player from the party given their name.
--  * Changed membername parameter to be camel case to remain cohesive with coding standard.
function removePlayerFromPartyWithName(playerId, memberName)
    -- Get and validate player
    local player = Player(playerId)
    if not player then
        print("Invalid Player ID.")
        return
    end
    -- Get and validate party
    local party = player:getParty()
    if not party then
        print("Player is not in a party.")
        return
    end

    -- Remove the player and print if succeeded
    if removePlayerFromParty(party, Player(memberName)) then
        print("Successfully removed player from party.")
    else
        print("Failed to remove player from party - Could not find player with name: " + memberName)
    end
end