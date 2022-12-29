//
//  FeedController.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2022/12/28.
//

import UIKit

class FeedController: UIViewController{
    // MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
