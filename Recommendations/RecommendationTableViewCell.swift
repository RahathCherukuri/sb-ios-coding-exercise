//
//  RecommendationTableViewCell.swift
//  Recommendations
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    @IBOutlet weak var recommendationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    /// Configures the view display
    ///
    /// - Parameter recommendation: Recommendation
    func configureView(_ recommendation: Recommendation) {
        titleLabel.text = recommendation.getTitle
        taglineLabel.text = recommendation.getTagLine
        ratingLabel.text = recommendation.getRating

        DispatchQueue.global(qos: .background).async {
            guard let imageData = recommendation.getImageData,
                let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                self.recommendationImageView?.image = image
            }
        }
    }
}
