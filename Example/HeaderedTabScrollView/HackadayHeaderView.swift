//
//  HackadayHeaderView.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 7/07/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit

/**
 Base header for an hackaday page (such aas a project, user, contest, other?)
 What's common to all the pages is
 - a title
 - a summary
 - some other controls under the summeray (username, follow button, etc)
 - 4 statViews
 - background image
 */
class HackadayHeaderView: UIView {
    /// The title of the presented page
    var pageTitle: String! = "Title" {
        didSet {
            pageTitleLabel.text = pageTitle
        }
        
    }
    /// The summary of the presented page
    var pageSummary: String? = "Description" {
        didSet {
            pageSummaryLabel.text = pageSummary
        }
    }
    
    var controlView: UIView? {
        didSet {
            controlContainer.subviews.forEach({ $0.removeFromSuperview() })
            controlContainer.addSubview(controlView!)
            controlView!.topAnchor.constraint(equalTo: controlContainer.topAnchor).isActive = true
            controlView!.leadingAnchor.constraint(equalTo: controlContainer.leadingAnchor).isActive = true
            controlView!.trailingAnchor.constraint(equalTo: controlContainer.trailingAnchor).isActive = true
            controlView!.bottomAnchor.constraint(equalTo: controlContainer.bottomAnchor).isActive = true
        }
    }
    /*
    /// The image on the background of the header of the project page
    var headerImageURL: String? {
        didSet {
            if (headerImageURL != nil) {
                headerImageView.loadmageFromUrl(urlString: headerImageURL!)
            } else {
                headerImageView.image = #imageLiteral(resourceName: "headerExample")
            }
        }
        
    }
    */
    var statValues: [Int] = [] {
        didSet {
            if statValues.count != 4 {
                statValues = []
                return
            }
            for i in 0 ..< 4 {
                self.stats[i].statValue = statValues[i]
            }
        }
    }
    var statNames: [String] = [] {
        didSet {
            if statValues.count != 4 {
                statValues = []
                return
            }
            for i in 0 ..< 4 {
                self.stats[i].statName = statNames[i]
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup of the header: Title-Description-Owner-background-stats
    private func setupHeader() {
        self.backgroundColor = .black
        
        // Background image
        headerImageView.image = UIImage()
        self.addSubview(headerImageView)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        
        // Stats
        var lastLead = self.trailingAnchor
        var names = ["views", "comments", "likes", "followers"]
        var values = [4130, 30, 12, 203]
        for i in 0...3 {
            let statView = StatView(position: .zero)
            statView.statName = names[i]
            statView.statValue = values[i]
            addSubview(statView)
            statView.translatesAutoresizingMaskIntoConstraints = false;
            statView.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -8).isActive = true
            statView.trailingAnchor.constraint(equalTo: lastLead, constant: 8).isActive = true
            statView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            statView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            
            lastLead = statView.leadingAnchor
            
            stats.append(statView)
        }
        
        
        // Controls
        self.addSubview(controlContainer)
        controlContainer.translatesAutoresizingMaskIntoConstraints = false;
        controlContainer.bottomAnchor.constraint(equalTo: stats[0].topAnchor, constant: 0).isActive = true
        controlContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        controlContainer.widthAnchor.constraint(equalToConstant: 140).isActive = true
        controlContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        // Summary
        self.addSubview(pageSummaryLabel)
        pageSummaryLabel.translatesAutoresizingMaskIntoConstraints = false;
        pageSummaryLabel.bottomAnchor.constraint(equalTo: controlContainer.topAnchor, constant: 0).isActive = true
        pageSummaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        pageSummaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        pageSummaryLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        // Name
        self.addSubview(pageTitleLabel)
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        pageTitleLabel.bottomAnchor.constraint(equalTo: pageSummaryLabel.topAnchor, constant: 20).isActive = true
        pageTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        pageTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        pageTitleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        
        
        
        
    }
    /// Label containingthe name of the project
    let pageTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title of the project"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor.clear
        lbl.numberOfLines = 3
        return lbl
    }()
    /// Label contianing the description of the project
    let pageSummaryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Descripiton of the project"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        return lbl
    }()
    /// The view aimed to contain the special controls
    var controlContainer = UIView()
    
    
    /// The image on the bacground of the header
    let headerImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.alpha = 0.6
        return img
    }()
    
    
    // Statitstics about the project
    internal var stats: [StatView] = []

    
    
}


class UserHeaderView: HackadayHeaderView {
    var nfollowers: Int = 0 {
        didSet {
            self.stats[0].statValue = nfollowers
        }
    }
    var nfolowing: Int = 0 {
        didSet {
            self.stats[1].statValue = nfolowing
        }
    }
    var nprojects: Int = 0 {
        didSet {
            self.stats[2].statValue = nprojects
        }
    }
    var nlikes: Int = 0 {
        didSet {
            self.stats[3].statValue = nlikes
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.statNames = ["followers", "wollowing", "projects", "likes"]
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

/**
 Header of a project page
 */
class ProjectHeaderView: HackadayHeaderView {
    var nviews: Int = 0 {
        didSet {
            self.stats[0].statValue = nviews
        }
    }
    var ncomments: Int = 0 {
        didSet {
            self.stats[1].statValue = ncomments
        }
    }
    var nlikes: Int = 0 {
        didSet {
            self.stats[2].statValue = nlikes
        }
    }
    var nfollowers: Int = 0 {
        didSet {
            self.stats[3].statValue = nfollowers
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.statNames = ["views", "comments", "skulls", "followers"]
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
