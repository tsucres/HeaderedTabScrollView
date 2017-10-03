//
//  HeaderedCAPSPageMenuViewController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 2/10/17.
//

import UIKit
import PageMenu

/**
 Basically an PagingMenu with an header on top of it with some cool scrolling effects.
 */
open class HeaderedCAPSPageMenuViewController: AbstractHeaderedTabScrollViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // PageMenu
        self.view.addSubview(pageMenuContainer)
        pageMenuContainer.frame = CGRect(x: 0, y: headerHeight, width: self.view.frame.width, height: self.view.frame.height - navBarOffset())
        pageMenuContainer.translatesAutoresizingMaskIntoConstraints = false
        pageMenuContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pageMenuContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        tabTopConstraint = pageMenuContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: headerHeight)
        tabTopConstraint!.isActive = true
        pageMenuContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height - navBarOffset()).isActive = true
        
        
    }
    public func addPageMenu(menu: CAPSPageMenu) {
        pageMenuController = menu
        
        pageMenuContainer.addSubview(pageMenuController!.view)
        
        
    }
    
    public var pageMenuController: CAPSPageMenu?
    public let pageMenuContainer = UIView()
    
    
}
