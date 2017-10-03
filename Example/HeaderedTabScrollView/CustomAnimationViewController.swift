//
//  CustomAnimationViewController.swift
//  HeaderedTabScrollView_Example
//
//  Created by Stéphane Sercu on 3/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import HeaderedTabScrollView
import PageMenu

class CustomAnimationViewController: HeaderedCAPSPageMenuViewController, CAPSPageMenuDelegate {
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
            vc.scrollDelegateFunc = self.pleaseScroll
        }
        
        let parameters: [CAPSPageMenuOption] = [
            //...
        ]
        self.addPageMenu(menu: CAPSPageMenu(viewControllers: subPageControllers, frame: CGRect(x: 0, y: 0, width: pageMenuContainer.frame.width, height: pageMenuContainer.frame.height), pageMenuOptions: parameters))
        self.pageMenuController!.delegate = self
        
        self.navBarTitleColor = UIColor.black
        self.navBarItemsColor = .black
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func headerDidScroll(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        self.updateNavBarTitleColor(minY: minY, maxY: maxY, currentY: currentY)
        updateHeaderPositionAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
        updateHeaderAlphaAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
    }
    
    /// Custom animation that progrssivelly changes the navBar content color from black to white
    func updateNavBarTitleColor(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        let percent = (currentY - minY)/(maxY-minY)
        let color = UIColor(white: percent, alpha: 1)
        self.navBarItemsColor = color
        self.navBarTitleColor = color
        if percent > 0.5 {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
            
        }
        
    }
    
    
}
