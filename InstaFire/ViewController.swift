//
//  ViewController.swift
//  InstaFire
//
//  Created by LIFX Laptop on 30/4/17.
//  Copyright © 2017 LIFX Laptop. All rights reserved.
//

import UIKit
import Firebase

enum FirebaseError: Error {
	case userCreationError(reason: String)
}

class ViewController: UIViewController, UITextFieldDelegate {
	
	var addPhotoButton: UIButton = {
		let button: UIButton = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
		return button
	}()
	
	var emailTextField: UITextField = {
		let emtf = UITextField()
		emtf.placeholder = "Email"
		emtf.backgroundColor = UIColor(white: 0, alpha: 0.03)
		emtf.borderStyle = .roundedRect
		emtf.font = UIFont.systemFont(ofSize: 14)
		emtf.translatesAutoresizingMaskIntoConstraints = false
		emtf.addTarget(self, action: #selector(validateForm), for: .editingChanged)
		return emtf
	}()
	
	var usernameTextField: UITextField = {
		let usernametf = UITextField()
		usernametf.placeholder = "Username"
		usernametf.backgroundColor = UIColor(white: 0, alpha: 0.03)
		usernametf.borderStyle = .roundedRect
		usernametf.font = UIFont.systemFont(ofSize: 14)
		usernametf.translatesAutoresizingMaskIntoConstraints = false
		usernametf.addTarget(self, action: #selector(validateForm), for: .editingChanged)
		return usernametf
	}()
	
	var passwordTextField: UITextField = {
		let pwtf = UITextField()
		pwtf.placeholder = "Password"
		pwtf.backgroundColor = UIColor(white: 0, alpha: 0.03)
		pwtf.borderStyle = .roundedRect
		pwtf.font = UIFont.systemFont(ofSize: 14)
		pwtf.isSecureTextEntry = true
		pwtf.translatesAutoresizingMaskIntoConstraints = false
		pwtf.addTarget(self, action: #selector(validateForm), for: .editingChanged)
		return pwtf
	}()
	
	var signUpButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor.rgb(red: 109, green: 204, blue: 244)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.setTitleColor(.white, for: .normal)
		button.setTitle("Sign Up", for: .normal)
		button.layer.cornerRadius = 5
		button.isEnabled = false
		button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(addPhotoButton)
		addPhotoButton.customConstraints(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
		addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		setupViews()
	}
	
	private func setupViews() {
		passwordTextField.delegate = self
		usernameTextField.delegate = self
		emailTextField.delegate = self
		
		let stackView: UIStackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
		stackView.distribution = .fillEqually
		stackView.axis = .vertical
		stackView.spacing = 5.0
		
		view.addSubview(stackView)
		
		stackView.customConstraints(top: addPhotoButton.bottomAnchor,
		                            left: view.leftAnchor,
		                            bottom: nil,
		                            right: view.rightAnchor,
		                            paddingTop: 20,
		                            paddingLeft: 40,
		                            paddingBottom: 0,
		                            paddingRight: -40,
		                            width: 0,
		                            height: 0)
	}
	
	@objc func validateForm() {
		let formValid = emailTextField.text?.characters.count ?? 0 > 0 && usernameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
		if formValid {
			signUpButton.isEnabled = true
			signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
		} else {
			signUpButton.isEnabled = false
			signUpButton.backgroundColor = UIColor.rgb(red: 109, green: 204, blue: 244)
		}
	}
	
	@objc private func handleSignUp() {
		guard let email = emailTextField.text, !email.isEmpty else { return }
		guard let userName = usernameTextField.text, !userName.isEmpty else { return }
		guard let password = passwordTextField.text, !password.isEmpty else { return }
		
		FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
			if error != nil {
				print(error.debugDescription)
				return
			}
			guard let user = user else { return }
			print(user.email ?? "")
			print(user.displayName ?? "")
		})
	}
}

extension UIView {
	func customConstraints(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}
		if let left = left {
			leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
		}
		if let right = right {
			rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
		}
		if width > 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		if height > 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
}
