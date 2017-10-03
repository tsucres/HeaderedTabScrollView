//
//  WithNavBarExample.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 9/09/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit
import ACTabScrollView
import HeaderedTabScrollView

class WithoutNavBarExampleController: HeaderedACTabScrollViewController, ACTabScrollViewDataSource {
    var contentViews: [UIView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView = headerExample
        self.dataSource = self
        
        self.headerBackgroundColor = .white
        UIApplication.shared.statusBarStyle = .default
        
        for i in 0 ..< MockupData.subpagesContent.count {
            let vc = PlaceholderViewController()
            vc.placeholderContent = MockupData.subpagesContent[i]
            self.addSubPage(vc: vc)
            vc.scrollDelegateFunc = self.pleaseScroll
        }
        
    }
    
    /**
     Add the specified controller to the tabScrollView
     */
    func addSubPage(vc: UIViewController) {
        addChildViewController(vc)
        contentViews.append(vc.view)
    }
    
    //-MARK: ACTabScrollViewDataSource
    
    func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
        return 3
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "Hello"
        return lbl
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return contentViews[index]
    }

    
    let headerExample: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "header")
        return img
    }()
}

