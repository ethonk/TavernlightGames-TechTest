-- Print Small Guild Names
-- Prints the names of all guilds that have less than "memberCount" max members.
function printSmallGuildNames(memberCount)
  -- Create SQL Query
  local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"

  -- Execute the query
  local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
  -- Validate the query, if unsuccessful print error
  if resultId == nil then
    print("Error executing Guild Query.")
    return
  end

  -- With a successful query, iterate over the results and print the guild names
  repeat
    local guildName = result.getString("name")
    print(guildName)
  until not resultId.next(resultId) -- until the end
  -- Free the data after printing
  resultId.free(resultId)
end