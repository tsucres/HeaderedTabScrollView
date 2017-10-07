//
//  PlaceholderScrollableViewController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 30/09/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit
import HeaderedTabScrollView

/// ViewController for a scrollable view intented to be used a as subpage of a HeaderedTabScrollView
class PlaceholderViewController: UIViewController, UITextViewDelegate {
    var placeholderContent: String = "" {
        didSet {
            self.contentText.text = placeholderContent
            contentText.sizeToFit()
            // Scroll to top
            contentText.setContentOffset(CGPoint(x: 0, y: -contentText.contentInset.top), animated: false)
        }
    }
    let contentText = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentText.delegate = self
        self.view.addSubview(contentText)
        
        contentText.translatesAutoresizingMaskIntoConstraints = false
        contentText.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentText.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentText.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentText.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentText.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        contentText.isScrollEnabled = true
        contentText.alwaysBounceVertical = true
        
    }
    var scrollDelegateFunc: ((UIScrollView)->Void)?
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollDelegateFunc != nil {
            self.scrollDelegateFunc!(scrollView)
        }
    }
    
    
}
