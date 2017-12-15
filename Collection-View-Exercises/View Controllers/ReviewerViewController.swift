//
//  ViewController.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ReviewerViewController: UIViewController {
    
    //Table View
    @IBOutlet weak var criticTableView: UITableView!
    
    var critics: [Critic] = []
    
    //Collection View
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    var reviews: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.criticTableView.dataSource = self
        self.criticTableView.delegate = self
        self.reviewCollectionView.delegate = self
        self.reviewCollectionView.dataSource = self
        loadCritics()
    }
    
    func loadCritics() {
        CriticAPIClient.manager.getCritics(completionHandler: { (onlineCritics) in
            
            self.critics = onlineCritics.sorted {$0.name < $1.name}
            self.criticTableView.reloadData()
            
        }, errorHandler: {print($0)})
    }
    
    func loadReviews(for critic: String) {
        guard let formattedCritic = critic.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Can't add url host characters")
            
            return
        }
        
        ReviewAPIClient.manager.getReviews(for: formattedCritic, completionHandler: { (onlineReviews) in
            self.reviews = onlineReviews
            self.reviewCollectionView.reloadData()
            
        }, errorHandler: {print($0)})
    }

}

//Table View Delegate
extension ReviewerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCritic = critics[indexPath.row]
        
        loadReviews(for: selectedCritic.name)
    }
    
}

//Table View Data Source
extension ReviewerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return critics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "criticCell", for: indexPath)
        let currentCritic = critics[indexPath.row]
        
        cell.textLabel?.text = currentCritic.name
        
        return cell
    }
    
}

//Collection View Delegate
extension ReviewerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height / CGFloat(1.1)
        let width = collectionView.bounds.width / CGFloat(2)
        
        return CGSize(width: width, height: height)
    }
}

//Collection View Data Source
extension ReviewerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath)
        let currentReview = reviews[indexPath.row]
        
        if let reviewCell = cell as? ReviewCollectionViewCell {
            
            reviewCell.reviewTitleLabel.text = currentReview.title
            
            //setting image
            if let imageURL = currentReview.multimedia?.link {
                ImageAPIClient.manager.getImage(from: imageURL, completionHandler: { (onlineImage) in
                    
                    reviewCell.reviewImageView.image = nil
                    reviewCell.reviewImageView.image = onlineImage
                    reviewCell.setNeedsLayout()
                    
                }, errorHandler: {print($0)})
            
            } else {
                reviewCell.reviewImageView.image = #imageLiteral(resourceName: "placeholder")
            }
            
            return reviewCell
        }
        
        return cell
    }
    
}

