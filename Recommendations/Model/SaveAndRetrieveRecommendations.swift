//
//  SaveAndRetrieveRecommendations.swift
//  Recommendations
//
//  Created by Rahath cherukuri on 4/29/20.
//  Copyright © 2020 Serial Box. All rights reserved.
//

import Foundation

protocol SaveAndRetrieveRecommendations {
    func getRecommendations() -> [Recommendation]
    func setRecommendations(_ reco: [Recommendation]) -> Bool
}

extension SaveAndRetrieveRecommendations {
    /// Gets the Recommendations saved in Userdefaults
    ///
    /// - Returns: [Recommendation]
    func getRecommendations() -> [Recommendation] {
        guard let data = UserDefaults.standard.data(forKey: Recommendation.userDefaultsKey) else {return []}
        guard let recommendations = try? JSONDecoder().decode([Recommendation].self, from: data) else {return []}
        return recommendations
    }

    /// Sets the Recommendations in Userdefaults
    ///
    /// - Returns: to determine if the object is saved or not
    func setRecommendations(_ reco: [Recommendation]) -> Bool {
        guard let data = try? JSONEncoder().encode(reco) else {return false}
        UserDefaults.standard.set(data, forKey: Recommendation.userDefaultsKey)
        return true
    }
}
