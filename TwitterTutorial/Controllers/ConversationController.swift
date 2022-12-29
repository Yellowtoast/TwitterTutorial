//
//  ConversationController.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2022/12/28.
//


import UIKit

class ConversationController: UIViewController{
    // MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
