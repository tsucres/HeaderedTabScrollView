//
//  AllInOneDemoWithNavController.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 28/09/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit

class AllInOneDemoWithNavController: UINavigationController {
    init() {
        let demoViewController = DemoTableViewController(style: .plain)
        super.init(rootViewController: demoViewController)
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DemoTableViewController: UITableViewController {
    let demoTitles = ["Basic -  ACTabScrollView", "Basic - CAPSPageMenu", "Hackernews profile", "Hackaday example", "Custom animation"]
    let controllers: [UIViewController] = [BasicHeaderedACTabScrollViewController(), BasicHeaderedCAPSPageMenuViewController(), HNUserPageController(), HaDExampleViewController(), CustomAnimationViewController()]
    let cellId = "BasicCellId"
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(controllers[indexPath.row], animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return demoTitles.count
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell!.textLabel?.text = demoTitles[indexPath.row]
        
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

