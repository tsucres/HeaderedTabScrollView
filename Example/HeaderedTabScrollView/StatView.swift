//
//  StatView.swift
//  Hackadayv2
//
//  Created by Stéphane Sercu on 13/04/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit

/**
 The purpose of this view is to show a quantitative property.
 It's composed by the numerical value of the property and by its name.
 Those informations can be present in different visual styles, discribed 
 by the enum VisualStyle
 */
class StatView: UIView {
    static let defaultSize = CGSize(width: 70, height: 30)
    static let smallSize = CGSize(width: 40, height: 22)
    
    ///
    enum VisualStyle {
        case normal, small
    }
    
    /// The numerical value of the property
    var statValue: Int = 20000 {
        didSet {
            statLabel.text = makeHumanReadable(statValue)
        }
    }
    /// The name of the property
    var statName: String = "followers" {
        didSet {
            nameLabel.text = statName
        }
    }
    
    // The presentation style
    var apparance: VisualStyle = VisualStyle.normal {
        didSet {
            updateApparance()
        }
    }
    
    
    convenience init(position: CGPoint, apparance: VisualStyle = .normal) {
        if apparance == VisualStyle.small {
            self.init(frame: CGRect(origin: position, size: StatView.smallSize))
        } else {
            self.init(frame: CGRect(origin: position, size: StatView.defaultSize))
        }
        self.apparance = apparance;
        updateApparance()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        backgroundColor = UIColor.clear
        
        statLabel.text = makeHumanReadable(statValue)
        addSubview(statLabel)
        
        nameLabel.text = statName
        addSubview(nameLabel)
        
        updateApparance()
    }
    
    /**
     This method is called every time the apparance (visual style) is updated.
     It just applies the visal change.
     */
    func updateApparance() {
        if apparance == VisualStyle.small {
            self.frame = CGRect(origin: frame.origin, size: StatView.smallSize)
            statLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 13)
            nameLabel.frame = CGRect(x: 0, y: statLabel.frame.height - 2, width: self.frame.width, height: 11)
            statLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.bold)
            nameLabel.font = UIFont.systemFont(ofSize: 8, weight: UIFont.Weight.thin)
        } else {
            self.frame = CGRect(origin: frame.origin, size: StatView.defaultSize)
            statLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 22)
            nameLabel.frame = CGRect(x: 0, y: statLabel.frame.height - 4, width: self.frame.width, height: 12)
            statLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
            nameLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.thin)
        }
        
    }
    /**
     Converts a big number to a more readable string version of itself, using unit suffixes.
     ex: 10000000 -> 10M, 178903 -> 178k
     
     - parameters:
        - value: The number to convert
     - returns:
     The readable version (in string format)
     */
    func makeHumanReadable(_ value: Int) -> String {
        if (value < 1000) {return String(value)}
        let exp = Int(log(Double(value)) / log(1000))
        let pre = "kMGTPE"["kMGTPE".index("kMGTPE".startIndex, offsetBy: exp-1)]
        return String(format: "%.1f\(pre)", Double(value)/pow(1000.0, Double(exp)))
    }
    
    /// The label containing the value of the property
    private let statLabel:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        lbl.backgroundColor = UIColor.clear
        return lbl
    }()
    
    /// The label containing the name of the property
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.backgroundColor = UIColor.clear
        lbl.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.thin)
        return lbl
    }()
    
    
}
