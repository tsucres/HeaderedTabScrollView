//
//  BasicHeaderedCAPSPageMenuViewController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 30/09/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit
import HeaderedTabScrollView
import PageMenu

/**
 Shows the basic usage of HeaderedCAPSPageMenuViewController.
 
 It initializes the CAPSPageMenu with the basic configuration,
 as shown [here](https://github.com/PageMenu/PageMenu);
 
 Configures the HeaderedTabScrollViewController with a minimalist header;
 Adds the built in animations.
 */
class BasicHeaderedCAPSPageMenuViewController: HeaderedCAPSPageMenuViewController, CAPSPageMenuDelegate {
    var subPageControllers: [UIViewController] = []
    var subPageTitles = ["One", "Two", "Three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) Set the header
        self.headerView = UIImageView(image: #imageLiteral(resourceName: "header"))
        
        // 2) Set the subpages
        
        for _ in 0 ..< subPageTitles.count {
            let vc = PlaceholderViewController()
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            vc.view.backgroundColor = .red
            vc.contentText.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
            
            addChildViewController(vc)
            subPageControllers.append(vc)
            vc.scrollDelegateFunc = { [weak self] in self?.pleaseScroll($0) }
        }
        
        let parameters: [CAPSPageMenuOption] = [
            //...
        ]
        self.addPageMenu(menu: CAPSPageMenu(viewControllers: subPageControllers, frame: CGRect(x: 0, y: 0, width: pageMenuContainer.frame.width, height: pageMenuContainer.frame.height), pageMenuOptions: parameters))
        self.pageMenuController!.delegate = self
        
        self.navBarTitleColor = UIColor.white.withAlphaComponent(0)
        self.navBarItemsColor = .white
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print("Will move to page \(index)")
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moved to page \(index)")
    }
}
