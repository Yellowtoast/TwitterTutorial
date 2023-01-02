
//
//  FeedController.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2022/12/28.
//

import UIKit

class UploadTweetController: UIViewController{
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    // MARK: - Selectors
    
    @objc func handleCancle(){
        dismiss(animated: true)
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancle))
    }

}
