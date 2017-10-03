//
//  HNUserPageHeader.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 9/07/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit
import HeaderedTabScrollView
import PageMenu



class HNUserPageController: HeaderedCAPSPageMenuViewController, CAPSPageMenuDelegate {
    let tabsTexts = ["Submissions", "Comments", "Favorites"]
    //var tabs: [HNTabTitleView] = []
    
    var contentViews: [UIView] = []
    var defaultPageIndex = 0
    override func viewDidLoad() {
        self.headerHeight = 230
        super.viewDidLoad()
        let head = HNUserPageHeader()
        head.about = "He’s probably passionate about something and works as a [long, senseless, job title]. He has two dogs and a turtle. And two kids.\n\n And this is just to test the majestic scrolling feature :)"
        head.backgroundColor = .red
        head.karma = 280
        head.created = "Since 27th september 2015"
        
        self.headerView = head
        
        var controllers: [UIViewController] = []
        for i in 0 ..< tabsTexts.count {
            let vc = PlaceholderViewController()
            vc.placeholderContent = MockupData.subpagesContent[i]
            vc.contentText.backgroundColor = #colorLiteral(red: 0.07159858197, green: 0.09406698495, blue: 0.1027848646, alpha: 1)
            vc.contentText.textColor = .white
            vc.scrollDelegateFunc = self.pleaseScroll
            
            vc.title = tabsTexts[i]
            controllers.append(vc)
        }
        
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(#colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1019607843, alpha: 0.5)),
            .viewBackgroundColor(#colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1019607843, alpha: 0.5)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(#colorLiteral(red: 0.8404174447, green: 0.396413058, blue: 0, alpha: 1)),
            .menuMargin(0.0),
            .menuHeight(40.0),
            .selectedMenuItemLabelColor(.white),
            .unselectedMenuItemLabelColor(.white),
            .useMenuLikeSegmentedControl(true),
            .selectionIndicatorHeight(2.0),
            .menuItemFont(UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)),
            .menuItemWidthBasedOnTitleTextWidth(false)
        ]
        
        self.addPageMenu(menu: CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: 0, width: pageMenuContainer.frame.width, height: pageMenuContainer.frame.height), pageMenuOptions: parameters))
        self.pageMenuController!.delegate = self
        
        self.headerBackgroundColor = #colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1019607843, alpha: 1)
        self.navBarTransparancy = 0
        self.navBarItemsColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBarTitle(title: "Curtis' profile")
        if let navController = self.navigationController {
            let navBar = navController.navigationBar
            navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)]
        }
        
        self.navBarColor = #colorLiteral(red: 0.07159858197, green: 0.09406698495, blue: 0.1027848646, alpha: 1)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    override func headerDidScroll(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        updateNavBarAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
        updateHeaderPositionAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
        updateHeaderAlphaAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: currentY)
    }
    
    public override func updateNavBarAccordingToScrollPosition(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        let alphaOffset: CGFloat = (minY-maxY)*0.3 // alpha start changing at 1/3 of the way up
        var alpha = (currentY + alphaOffset - minY)/(maxY+alphaOffset-minY)
        if currentY > minY - alphaOffset {
            alpha = 0
        }
        
        self.navBarTransparancy = alpha
    }
}



