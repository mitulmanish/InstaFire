//
//  UserProfileHeaderView.swift
//  InstaFire
//
//  Created by LIFX Laptop on 15/10/17.
//  Copyright © 2017 LIFX Laptop. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeaderView: UICollectionViewCell {
	var user: User? {
		didSet {
			downloadProfileImage()
			userNameLabel.text = user?.userName
		}
	}
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	let gridButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
		return button
	}()
	
	let listButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let userNameLabel: UILabel = {
		let label = UILabel()
		label.text = "user name"
		label.font = UIFont.boldSystemFont(ofSize: 14)
		return label
	}()
	
	let postsLabel: UILabel = {
		let label = UILabel()
		let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
		attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]))
		label.attributedText = attributedText
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	let followersLabel: UILabel = {
		let label = UILabel()
		let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
		attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]))
		label.attributedText = attributedText
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	let followingLabel: UILabel = {
		let label = UILabel()
		let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
		attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]))
		label.attributedText = attributedText
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	let editProfileButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Edit Profile", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.layer.borderColor = UIColor.lightGray.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 3
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		user = nil
		setupViews()
		setupBottomToolBar()
		setupLabel()
		setupUserStatsView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViews() {
		addSubview(profileImageView)
		profileImageView.customConstraints(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
		profileImageView.layer.cornerRadius = 80 / 2
		profileImageView.clipsToBounds = true
	}
	
	func setupBottomToolBar() {
		
		let toolBarStackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
		toolBarStackView.distribution = .fillEqually
		toolBarStackView.alignment = .center
		addSubview(toolBarStackView)
		
		toolBarStackView.customConstraints(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
		
		let topDividerView = UIView()
		topDividerView.backgroundColor = UIColor.lightGray
		addSubview(topDividerView)
		
		topDividerView.customConstraints(top: toolBarStackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
		
		let bottomDividerView = UIView()
		bottomDividerView.backgroundColor = UIColor.lightGray
		addSubview(bottomDividerView)
		
		bottomDividerView.customConstraints(top: toolBarStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
		
	}
	
	func setupLabel() {
		addSubview(userNameLabel)
		userNameLabel.translatesAutoresizingMaskIntoConstraints = false
		userNameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
		userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 3).isActive = true
		
	}
	
	func setupUserStatsView() {
		let userStatsStackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
		userStatsStackView.distribution = .fillEqually
		addSubview(userStatsStackView)
		
		userStatsStackView.customConstraints(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
		
		addSubview(editProfileButton)
		
		editProfileButton.customConstraints(top: postsLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: -8, width: 0, height: 34)
	}
	
	private func downloadProfileImage() {
		guard let profileImageUrl = URL(string: self.user?.profileImageDownloadUrlString ?? "") else { return }
		URLSession.shared.dataTask(with: profileImageUrl, completionHandler: { (data, response, err) in
			guard err == nil, let imageData = data, let image = UIImage(data: imageData) else { return }
			DispatchQueue.main.async {
				self.profileImageView.image = image
			}
		}).resume()
	}
}
