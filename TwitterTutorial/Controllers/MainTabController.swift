//
//  MainTabController.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2022/12/27.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet{
            print("유저 정보 세팅 완료")
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
         super.viewDidLoad()
        authenticateUserAndConfigureUI()

     }

    
    // MARK: - API
    
    func fetchUser(){
        UserService.shared.fetchUser{
            user in
            self.user = user
        }
    }
    
    
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil{
            print("DEBUG: User 로그아웃 상태")
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }else{
            print("DEBUG: User 로그인 상태")
            addHideKeyboardGesture()
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut(){
        do{
            try Auth.auth().signOut()
        } catch let error{
            print("DEBUG: 유저 로그아웃 실패")
        }
    }
    
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped(){
        let nav = UINavigationController(rootViewController: UploadTweetController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    

    
    // MARK: - Helpers
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 64,
            paddingRight: 16,
            width: 56,
            height: 56)
        
        actionButton.layer.cornerRadius = 56/2
    }
    
    func configureViewControllers(){
        let feed = FeedController()
        let nav1 = templateNavigationController(
            image: UIImage(named:"home_unselected"),
            rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(
            image: UIImage(named: "search_unselected"),
            rootViewController: explore)
        
        let notificaitons = NotificationController()
        let nav3 = templateNavigationController(
            image: UIImage(named: "like_unselected"),
            rootViewController: notificaitons)
        
        let conversations = ConversationController()
        let nav4 = templateNavigationController(
            image: UIImage(named: "ic_mail_outline_white_2x-1"),
            rootViewController: conversations)
        
//        viewControllers = [nav1, nav2, nav3, nav4]
        
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)

    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.barTintColor = .white
        nav.tabBarItem.image = image ?? UIImage()
         
        return nav
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
