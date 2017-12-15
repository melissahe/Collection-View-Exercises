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
    
    var review: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.criticTableView.dataSource = self
        self.criticTableView.delegate = self
        loadCritics()
    }
    
    func loadCritics() {
        CriticAPIClient.manager.getCritics(completionHandler: { (onlineCritics) in
            
            self.critics = onlineCritics.sorted {$0.name < $1.name}
            self.criticTableView.reloadData()
            
        }, errorHandler: {print($0)})
    }
    
    func loadReviews(for critic: String) {
        
    }

}

//Table View Delegate
extension ReviewerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //to do
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

