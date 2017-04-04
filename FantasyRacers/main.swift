//
//  main.swift
//  FantasyRacers
//
//  Created by Chris Home on 11/06/2016.
//  Copyright © 2016 Christoher Fonseka. All rights reserved.
//

import Foundation


assert(CommandLine.arguments.count >= 4, "Incorrect number of command line arguments")

let budget = 75


let data = AppData(commandLineArguments: CommandLine.arguments)

let teams   = data.getTeamData();
let drivers = data.getDriverData()
let races   = data.getRaceData()


print ("Generating Team Lineups")
let teamLineups   = teams.uniquePermutations(withPredicate: { $0.count == 3 })
print ("... found \(teamLineups.count) combinations")

print ("Generating Driver Lineups")
let driverLineups = drivers.uniquePermutations(withPredicate: { $0.count == 3 })
print ("... found \(driverLineups.count) combinations")

func getAllCombinations(ofTeams teams: [[Team]], andDrivers drivers: [[Driver]]) -> [FantasyEntry]
{
    var output = [FantasyEntry]()
    for team in teams
    {
        for driver in drivers
        {
            let entry = FantasyEntry(drivers: driver, teams: team)
            if (entry.price <= budget)
            {
                output.append(entry)
            }
        }
    }
    return output
}

print ("Generating Entries")
let entries = getAllCombinations(ofTeams: teamLineups, andDrivers: driverLineups)
print ("... found \(entries.count) combinations")

