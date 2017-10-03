//
//  AbstractHeaderedTabScrollViewController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 7/07/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit

/**
 Base view controller
 */
open class AbstractHeaderedTabScrollViewController: UIViewController {
    
    // MARK: - Private members
    // ====================================
    
    /// Parent view of the header
    private let headerContainer = UIView()
    /// Constraint on the height of the header
    private var headerHeightConstraint: NSLayoutConstraint?
    ///constraint on the top of the header
    var headerTopConstraint: NSLayoutConstraint?
    
    /// Constraint on the top of the tabScrollView
    var tabTopConstraint: NSLayoutConstraint?
    /// Remembers the last position (since last viewDidScroll event) of the tabScrollView (relatively to the top of the view)
    private var lastTabScrollViewOffset: CGPoint = .zero
    
    /// Handle the tranparency of the navBar
    private var navBarOverlay: UIView?
    
    
    
    // MARK: - Public attributes
    // ====================================
    
    
    /// The view pinned on top of the tabScrollview
    public var headerView: UIView? {
        didSet {
            if headerView != nil {
                headerContainer.subviews.forEach({ $0.removeFromSuperview() })
                headerContainer.addSubview(headerView!)
                headerView!.translatesAutoresizingMaskIntoConstraints = false
                headerView!.topAnchor.constraint(equalTo: headerContainer.topAnchor).isActive = true
                headerView!.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor).isActive = true
                headerView!.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor).isActive = true
                headerView!.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor).isActive = true
            }
            
        }
    }
    
    /// Height of the header
    public var headerHeight: CGFloat = 210 {
        didSet {
            if let constraint = headerHeightConstraint {
                constraint.constant = headerHeight
            }
        }
    }
    
    
    /// get & set the alpha of the navigation bar.
    public var navBarTransparancy: CGFloat {
        get {
            if navBarOverlay != nil {
                return navBarOverlay!.backgroundColor!.cgColor.alpha
            } else {
                return 0
            }
            
        } set (value) {
            if navBarOverlay != nil {
                navBarOverlay!.backgroundColor = navBarColor.withAlphaComponent(value)
            }
        }
    }
    
    /**
     The background color of the navigation bar (if any)
     */
    public var navBarColor: UIColor = .black {
        didSet {
            if navBarOverlay != nil {
                navBarOverlay!.backgroundColor = navBarColor.withAlphaComponent(navBarTransparancy)
            }
        }
    }
    /**
     *  This correspond to the color the header will progressivelly get
     *  as it's scrolled up (if you enable the alpha animation). It's
     *  also the color that the status bar will get when the header is
     *  totally scrolled up if there's no navigation  bar.
     */
    public var headerBackgroundColor: UIColor? {
        get {
            return self.view.backgroundColor
        }
        set(value) {
            self.view.backgroundColor = value
        }
    }
    
    
    /**
     The color of the items in the navigation bar (if any)
     */
    public var navBarItemsColor: UIColor = .white {
        didSet {
            if let navCtrl = self.navigationController {
                navCtrl.navigationBar.tintColor = navBarItemsColor
            }
        }
    }
    
    public var navBarTitleColor: UIColor = .white {
        didSet {
            if let navCtrl = self.navigationController {
                navCtrl.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:navBarTitleColor]
            }
        }
    }
    
    
    
    
    // MARK: - Initialisation
    // ===================================
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Header
        self.view.addSubview(headerContainer)
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        headerTopConstraint = headerContainer.topAnchor.constraint(equalTo: self.view.topAnchor)
        headerTopConstraint!.isActive = true
        headerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerHeightConstraint = headerContainer.heightAnchor.constraint(equalToConstant: self.headerHeight)
        headerHeightConstraint!.isActive = true
        lastTabScrollViewOffset = CGPoint(x: CGFloat(0), y: navBarOffset())
        
        
        
        setupNavBar()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navBarOverlay?.isHidden = false
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navBarOverlay?.isHidden = true
        if let navCtrl = self.navigationController {
            navCtrl.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:self.navBarItemsColor.withAlphaComponent(1)]
        }
    }
    private func setupNavBar() {
        if let navCtrl = self.navigationController {
            let navBar = navCtrl.navigationBar
            // Make the navBar transparent
            navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navBar.shadowImage = UIImage()
            navBarOverlay = UIView.init(frame: CGRect.init(x: 0, y: 0, width: navBar.bounds.width, height: self.navBarOffset()))
            
            navBarOverlay!.autoresizingMask = UIViewAutoresizing.flexibleWidth
            navBar.subviews.first?.insertSubview(navBarOverlay!, at: 0)
            navBarOverlay!.backgroundColor = navBarColor.withAlphaComponent(0.0)
        }
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Navigation bar helpers
    public func setNavBarRightItems(items: [UIBarButtonItem]) {
        self.navigationItem.rightBarButtonItems = items
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    public func setNavBarTitle(title: String) {
        self.title = title
    }
    public func setNavbarTitleTransparency(alpha: CGFloat) {
        if let navCtrl = self.navigationController {
            let navBar = navCtrl.navigationBar
            navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(alpha)]
        }
    }
    public func setNavBarLeftItems(items: [UIBarButtonItem]) {
        self.navigationItem.leftBarButtonItems = items
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    
    // MARK: - Scroll management
    // ====================================
    
    
    /**
     Handles all the effects hapening on a scroll event. You have
     to bind this method to the viewDidScroll action of the subpages' scrollView.
     */
    public func pleaseScroll(_ scrollView: UIScrollView) {
        var delta =  scrollView.contentOffset.y - lastTabScrollViewOffset.y
        
        // Vertical bounds
        let maxY: CGFloat = navBarOffset()
        let minY: CGFloat = self.headerHeight
        
        if tabTopConstraint == nil { return }
        //we compress the top view
        if delta > 0 && tabTopConstraint!.constant > maxY && scrollView.contentOffset.y > 0 {
            if tabTopConstraint!.constant - delta < maxY {
                delta = tabTopConstraint!.constant - maxY
            }
            tabTopConstraint!.constant -= delta
            scrollView.contentOffset.y -= delta
        }
        
        //we expand the top view
        if delta < 0 {
            
            if tabTopConstraint!.constant < minY && scrollView.contentOffset.y < 0 {
                if tabTopConstraint!.constant - delta > minY {
                    delta = tabTopConstraint!.constant - minY
                }
                tabTopConstraint!.constant -= delta
                scrollView.contentOffset.y -= delta
            }
        }
        
        lastTabScrollViewOffset = scrollView.contentOffset
        headerDidScroll(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant)
    }
    
    /**
     Called whenever the tabScrollView is moved up/down
     - parameters:
     - minY: The y coordinate of the lowest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - maxY: The y coordinate of the highest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - currentY: The y coordinate of the current position of the top of the tabScrollView (relatively to the top of the parentView)
     */
    open func headerDidScroll(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        // Change de opacity of the navBar
        updateNavBarAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant)
        updateHeaderPositionAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant)
        updateHeaderAlphaAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant)
        
    }
    
    
    func navBarOffset() -> CGFloat {
        return (self.navigationController?.navigationBar.bounds.height ?? 0) + UIApplication.shared.statusBarFrame.height
    }
    
    
    /**
     Updates the transparency of the navigation bar according to the current position of the tabScrollview
     - parameters:
     - minY: The y coordinate of the lowest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - maxY: The y coordinate of the highest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - currentY: The y coordinate of the current position of the top of the tabScrollView (relatively to the top of the parentView)
     */
    open func updateNavBarAccordingToScrollPosition(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        let alphaOffset: CGFloat = (minY-maxY)*0.3 // alpha start changing at 1/3 of the way up
        var alpha = (currentY + alphaOffset - minY)/(maxY+alphaOffset-minY)
        if currentY > minY - alphaOffset {
            alpha = 0
        }
        
        if (navBarOverlay != nil) {
            navBarOverlay!.backgroundColor = navBarColor.withAlphaComponent(alpha)
        }
        // Only the title's color is updated here
        navBarTitleColor = navBarTitleColor.withAlphaComponent(alpha)
        // do the following to update items too:
        // navBarItemsColor = navBarItemsColor.withAlphaComponent(alpha)
        
    }
    
    /**
     Updates the position of the header according to the current position of the tabScrollview to create a parallax effect.
     - parameters:
     - minY: The y coordinate of the lowest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - maxY: The y coordinate of the highest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - currentY: The y coordinate of the current position of the top of the tabScrollView (relatively to the top of the parentView)
     */
    open func updateHeaderPositionAccordingToScrollPosition(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        if let constraint = headerTopConstraint {
            let paralaxCoef: CGFloat = 0.3 // i.e. if the tabScrollView goas up by 1, the header goes up by this coefficient
            let tabScrollViewTravelPercent = -(currentY-minY)/(minY-maxY)
            let headerTravelPercent = tabScrollViewTravelPercent*paralaxCoef
            let headerTargetY = headerTravelPercent*(minY-maxY)
            constraint.constant = -headerTargetY
        }
    }
    
    /**
     Updates the transparency of the header according to the current position of the tabScrollview
     - parameters:
     - minY: The y coordinate of the lowest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - maxY: The y coordinate of the highest possible position of the top of the tabScrollView (relatively to the top of the parentView)
     - currentY: The y coordinate of the current position of the top of the tabScrollView (relatively to the top of the parentView)
     */
    open func updateHeaderAlphaAccordingToScrollPosition(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
        let alphaOffset: CGFloat = (minY-maxY)*0.3 // alpha start changing at 1/3 of the way up
        var alpha = 1 - (currentY + alphaOffset - minY)/(maxY+alphaOffset-minY)
        if currentY > minY - alphaOffset {
            alpha = 1
        }
        
        headerContainer.alpha = alpha
    }
    
    
    
}
