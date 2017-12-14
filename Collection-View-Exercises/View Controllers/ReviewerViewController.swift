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
    @IBOutlet weak var reviewerTableView: UITableView!
    
    var critics: [Critic] = []
    
    //Collection View
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    var review: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

