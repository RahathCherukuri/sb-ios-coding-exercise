//
//  ViewController.swift
//  Recommendations
//

import UIKit
import OHHTTPStubs

class RecommendationsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    // MARK: StoredProperties
    private let service: RecommendationService = RecommendationService()
    fileprivate var recommendations = [Recommendation]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialRecommendations()
        stubAPICall()
        setUpTableView()
        fetchRecommendations()
    }
    // MARK: Private functions
    /// Sets initial recommendations from database
    private func setInitialRecommendations() {
        recommendations = getRecommendations()
    }
    /// Stubs the api call response
    private func stubAPICall() {
        // ---------------------------------------------------
        // -------- <DO NOT MODIFY INSIDE THIS BLOCK> --------
        // stub the network response with our local ratings.json file
        let stub = Stub()
        stub.registerStub()
        // -------- </DO NOT MODIFY INSIDE THIS BLOCK> -------
        // ---------------------------------------------------
    }
    /// Sets up tableView cells, datasource and delegate
    private func setUpTableView() {
        tableView.register(UINib(nibName: "RecommendationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    /// fetches recommendations from the service
    private func fetchRecommendations() {
        service.getRecommendations() { [weak self] res in
            switch res {
            case let .success(movieRatings):
                self?.recommendations = movieRatings.recommendedTitles
                _ = self?.setRecommendations(movieRatings.recommendedTitles)
            case let .failure(error):
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
// MARK: Conforming to UITableViewDataSource and UITableViewDelegate
extension RecommendationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecommendationTableViewCell
        let recommendation = recommendations[indexPath.row]
        cell.configureView(recommendation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Setting the tableView height to automaticDimension allows the tableView to grow as per intrinsic size
        return UITableView.automaticDimension
    }
}
// MARK: Conforming to SaveAndRetrieveRecommendations
extension RecommendationsViewController: SaveAndRetrieveRecommendations {}
