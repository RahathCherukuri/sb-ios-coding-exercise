//
//  Ratings.swift
//  Ratings
//
//  Created by Rahath cherukuri on 4/28/20.
//  Copyright © 2020 Serial Box. All rights reserved.
//

import Foundation

struct Ratings: Codable {
    let titles: [Recommendation]
    let skipped: [String]
    let titlesOwned: [String]
    enum CodingKeys: String, CodingKey {
        case titles
        case skipped
        case titlesOwned = "titles_owned"
    }
}

// Business rules
extension Ratings {
    var recommendedTitles: [Recommendation] {
        let xs: [String] = skipped + titlesOwned
        let excludingSet: Set<String> = Set(xs.map{$0})

        return Array(
            titles
                .sorted(by: {$0.getRatingFloat > $1.getRatingFloat})
                .filter {$0.isReleased}
                .filter {!excludingSet.contains($0.getTitle)}
                .prefix(10)
        )
    }
}
