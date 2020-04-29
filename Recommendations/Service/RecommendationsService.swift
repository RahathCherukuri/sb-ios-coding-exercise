//
//  RecommendationsService.swift
//  Recommendations
//
//  Created by Rahath cherukuri on 4/28/20.
//  Copyright © 2020 Serial Box. All rights reserved.
//

import Foundation

enum ErrorModel: Error {
    case invalidData
    case unabletoParseData
}

class RecommendationService {
    /// Gets Recommendations from the service
    ///
    /// - Parameter completionHandler: Result<Ratings, Error>
    func getRecommendations(_ completionHandler: @escaping (Result<Ratings, Error>) -> Void) {
        guard let url = URL(string: Stub.stubbedURL_doNotChange) else { fatalError() }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            // Error case
            if let error = error {
                completionHandler(Result.failure(error))
                return
            }

            guard let receivedData = data else {
                completionHandler(Result.failure(ErrorModel.invalidData))
                return
            }

            guard let ratings = try? JSONDecoder().decode(Ratings.self, from: receivedData) else {
                completionHandler(Result.failure(ErrorModel.invalidData))
                return
            }
            completionHandler(.success(ratings))
        });

        task.resume()
    }
}


