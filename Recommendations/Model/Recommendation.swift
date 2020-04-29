//
//  Recommendation.swift
//  Recommendations
//
//  Created by Rahath cherukuri on 4/29/20.
//  Copyright © 2020 Serial Box. All rights reserved.
//

import Foundation

struct Recommendation: Codable {
    static let userDefaultsKey: String = "recommendation"
    let imageURL: String?
    let title: String?
    let tagline: String?
    let rating: Float?
    let isReleased: Bool
    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case title
        case tagline
        case rating
        case isReleased = "is_released"
    }
    
    var getRatingFloat: Float {
        guard let rating = rating else {return 0.0}
        return rating
    }
}

// Display Rules
extension Recommendation {
    var getRating: String {
        return "Rating: " + "\(getRatingFloat)"
    }
    var getTitle: String {
        guard let title = title else {return "N/A"}
        return "\(title)"
    }
    var getTagLine: String {
        guard let tagLine = tagline else {return "N/A"}
        return "\(tagLine)"
    }
    var getImageData: Data? {
        guard let url = URL(string: imageURL ?? "") else {return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
