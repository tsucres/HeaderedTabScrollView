//
//  HeaderedACTabScrollViewController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 2/10/17.
//

import UIKit
import ACTabScrollView

/**
 Basically an ACTabScrollView with an header on top of it with some cool scrolling effects.
 */
open class HeaderedACTabScrollViewController: AbstractHeaderedTabScrollViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // tabScrollView
        self.view.addSubview(tabScrollView)
        tabScrollView.translatesAutoresizingMaskIntoConstraints = false
        tabScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabTopConstraint = tabScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: headerHeight)
        tabTopConstraint!.isActive = true
        tabScrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height - navBarOffset()).isActive = true
        
    }
    /// Get and set the datasource of the tabScrollView
    public var dataSource: ACTabScrollViewDataSource? {
        get {
            return tabScrollView.dataSource
        } set (value) {
            tabScrollView.dataSource = value
        }
    }
    /// Get and set the delegate of the tabScrollView
    public var delegate: ACTabScrollViewDelegate? {
        get {
            return tabScrollView.delegate
        } set (value) {
            tabScrollView.delegate = value
        }
    }
    
    public let tabScrollView: ACTabScrollView = {
        let sv = ACTabScrollView()
        sv.defaultPage = 3
        sv.arrowIndicator = true
        sv.tabSectionHeight = 35
        //sv.tabSectionBackgroundColor = ProjectConstants.lightBackgroundColor
        //sv.contentSectionBackgroundColor = ProjectConstants.backgroundColor
        sv.tabGradient = true
        sv.pagingEnabled = true
        sv.cachedPageLimit = 3
        return sv
    }()
}
