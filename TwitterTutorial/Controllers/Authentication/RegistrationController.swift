//
//  File.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2022/12/28.
//

import UIKit
import Firebase

class RegistrationController: UIViewController{
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"),textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"),textField: passwordTextField)
        
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: UIImage(named: "ic_person_outline_white_2x")!, textField: fullNameTextField)
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage:  UIImage(named: "ic_person_outline_white_2x")!,textField: userNameTextField)
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        tf.keyboardType = .emailAddress
        
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder:"Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder:"Fullname")
        
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder:"Username")
        return tf
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", "  Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for:.normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self,
                         action: #selector(handleRegistration),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addHideKeyboardGesture()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegistration(){
        guard let profileImage = profileImage else {
            print("DEBUG: Please Select Profile Image..")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = userNameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials, completion: {
            (error, ref) in
            print("DEBUG: 회원가입 성공")
            guard let window  = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else{
                return
            }
            
            guard let tab = UIApplication.shared.keyWindow?.rootViewController as? MainTabController else {
                return
            }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true,completion: nil)
        })
            
        }
        
        
        

    
    @objc func handleAddProfilePhoto(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view,
                                topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 20)
        plusPhotoButton.setDimensions(width: 130,
                                      height: 130)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   userNameContainerView,
                                                   registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top:plusPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 25,
                     paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor,
                                        paddingLeft: 40,
                                        paddingBottom: 20,
                                        paddingRight: 40)
        
    }
}

// MARK: - UIImagePickerControllerDeletage

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 130/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true,completion: nil)
        
    }
}


