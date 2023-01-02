//
//  ExploreController.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2022/12/28.
//


import UIKit

class ExploreController: UIViewController{
    // MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}
