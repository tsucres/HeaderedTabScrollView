//
//  BasicHeaderedACTabScrollViewController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 30/09/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit
import HeaderedTabScrollView
import ACTabScrollView

/**
     Shows the basic usage of HeaderedACTabScrollViewController.
 
	 It initializes the ACTabScrollView with the basic configuration,
     as shown [here](https://github.com/azurechen/ACTabScrollView);
 
	 Configures the HeaderedTabScrollViewController with a minimalist header;
	 Adds the built in animations.
 */
class BasicHeaderedACTabScrollViewController: HeaderedACTabScrollViewController, ACTabScrollViewDelegate,  ACTabScrollViewDataSource {
    
    var subPageViews: [UIView] = []
    var subPageTitles = ["One", "Two", "Three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) Header init
        self.headerView = UIImageView(image: #imageLiteral(resourceName: "header"))
        
        
        // 2) Minimal ACTabScrollView initialisation
        
        self.tabScrollView.dataSource = self
        self.tabScrollView.delegate = self
        
        for _ in 0 ..< subPageTitles.count {
            let vc = PlaceholderViewController()
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            vc.contentText.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
            
            addChildViewController(vc)
            subPageViews.append(vc.view)
            vc.scrollDelegateFunc = { [weak self] in self?.pleaseScroll($0) }
        }
        
        self.navBarColor = .green
        self.navBarItemsColor = UIColor.black
        self.navBarTitleColor = UIColor.black.withAlphaComponent(0) // At first, the navbar's title is transparent (update according to scroll prosition)
        self.setNavBarTitle(title: "Title")
    }
    
    
    // ACTabScrollViewDelegate & ACTabScrollViewDataSource
    // ----------------------------------------------------
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        print("didChangePageTo \(index)")
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
        print("didScrollPageTo \(index)")
    }
    
    func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
        return subPageTitles.count
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        // create a label
        let label = UILabel()
        label.text = subPageTitles[index]
        label.textAlignment = .center
        
        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(
            width: label.frame.size.width + 28,
            height: label.frame.size.height + 36) // add some paddings
        
        return label
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return subPageViews[index]
    }
    
    
}
