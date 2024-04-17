// Add Item to Player
// There is a memory leak as a player is created but isn't freed in memory.
//  * param1: recipient, the name of the player.
//  * param2: itemId, unique ID of the item to grant to the player
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId) {
    
    // Define the Player
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false; // if the player was created dynamically, flag it here.

    // If the player doesn't exist, attempt to make a new player.
    if (!player) {
        // Create player and tag as dynamically created
        player = new Player(nullptr);
        playerCreated = true;
        // Determine valid player
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;
            return;
        }
    }

    // Create the Item
    // If the item is invalid, delete the player if made dynamically.
    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerCreated) {
            delete player;
        }
        return;
    }

    // Add item to the player
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
    // Save if the player is offline
    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    // Delete the player if made dynamically
    if (playerCreated) {
        delete player;
    }
}