//
//  HNUserPageHeaderView.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 30/09/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit

class TestHNUserPageHeaderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let head = HNUserPageHeader()
        head.about = "He’s probably passionate about something and works as a [long, senseless, job title]. He has two dogs and a turtle. And two kids.\n\n And this is just to test the majestic scrolling feature :)"
        head.backgroundColor = .red
        head.karma = 280
        head.created = "Since 27th september 2015"
        self.view.addSubview(head)
        head.translatesAutoresizingMaskIntoConstraints = false
        head.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        head.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        head.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        if head.about != "" {
            head.heightAnchor.constraint(equalToConstant: 210).isActive = true
            
        } else {
            head.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
        }
        
    }
}
class HNUserPageHeader: UIView {
    var created: String! = "Caterday" {
        didSet {
            self.createdLabel.text = created
        }
    }
    var karma: Int! = 0 {
        didSet {
            self.karmaNumberLabel.text = "\(karma!)"
        }
    }
    var about: String? {
        didSet {
            self.aboutLabel.text = about // TODO: Attributed Text
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(karmaNumberLabel)
        karmaNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        karmaNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 85).isActive = true
        karmaNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        karmaNumberLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(karmaLabel)
        karmaLabel.translatesAutoresizingMaskIntoConstraints = false
        karmaLabel.topAnchor.constraint(equalTo: karmaNumberLabel.bottomAnchor, constant: -2).isActive = true
        karmaLabel.trailingAnchor.constraint(equalTo: karmaNumberLabel.trailingAnchor).isActive = true
        
        self.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.centerYAnchor.constraint(equalTo: karmaNumberLabel.centerYAnchor).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: karmaNumberLabel.trailingAnchor, constant: 5).isActive = true
        
        self.addSubview(aboutLabel)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.topAnchor.constraint(equalTo: karmaLabel.bottomAnchor, constant: 5).isActive = true
        aboutLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        aboutLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        aboutLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        aboutLabelHeightConstraint = aboutLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
        aboutLabelHeightConstraint!.isActive = true
        
        
    }
    
    var aboutLabelHeightConstraint: NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let karmaNumberLabel: UILabel =  {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
        
    }()
    let createdLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    let karmaLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.text = "Karma"
        return lbl
    }()
    let aboutLabel: UITextView = {
        let lbl = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        lbl.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        lbl.textColor = .white
        lbl.isScrollEnabled = true
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear
        lbl.isEditable = false
        lbl.isSelectable = false
        return lbl
    }()
    
    let background: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "profileHeaderDark")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let css: String = "" // TODO
    
}
