//
//  HaDExample.swift
//  HeaderedTabScrollView
//
//  Created by Stéphane Sercu on 9/07/17.
//  Copyright © 2017 Stéphane Sercu. All rights reserved.
//

import UIKit
import HeaderedTabScrollView
import ACTabScrollView

struct Constants {
    static let ControlsColor: UIColor = .white
    static let TabBackgroundColor: UIColor = #colorLiteral(red: 0.1529267132, green: 0.1529495716, blue: 0.1529162228, alpha: 1)
    static let SubPageBackgroundColor: UIColor = #colorLiteral(red: 0.09018597752, green: 0.09020193666, blue: 0.09017866105, alpha: 1)
}



class HaDExampleViewController: HeaderedACTabScrollViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource {
    let defaultTabIndex = 0 // First showed subpage is Description
    var contentViews: [UIView] = []
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = UserHeaderView()
        
        header.headerImageView.image = #imageLiteral(resourceName: "HaDHeader")
        header.pageTitle = MockupData.title
        header.pageSummary = MockupData.description
        
        self.headerView = header
        
        
        self.tabScrollView.tabSectionBackgroundColor = Constants.TabBackgroundColor
        self.tabScrollView.contentSectionBackgroundColor = Constants.SubPageBackgroundColor
        
        self.delegate = self
        self.dataSource = self
        
        for i in 0 ..< MockupData.subpagesContent.count {
            let vc = PlaceholderViewController()
            vc.placeholderContent = MockupData.subpagesContent[i]
            self.addSubPage(vc: vc)
            vc.scrollDelegateFunc = { [weak self] in self?.pleaseScroll($0) }
        }
        
        self.tabScrollView.defaultPage = 1
        
        self.navBarTitleColor = UIColor.white.withAlphaComponent(0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navBarItemsColor = Constants.ControlsColor
        self.navBarColor = Constants.TabBackgroundColor
        // Add the title to the navBar
        self.setNavBarTitle(title: MockupData.title)
        // Add the share btn
        self.setNavBarRightItems(items: [UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)])
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    /// Initialize each title for each page the project in the TabScrollView
    func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        let v = TabTitleView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        v.text = MockupData.subpagesTitles[index]
        return v
    }
    /// Initialize each page of the project
    func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return contentViews[index]
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {}
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {}
    
    func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
        return MockupData.subpagesTitles.count
    }
    
    
    /**
     Add the specified controller to the tabScrollView
     */
    func addSubPage(vc: UIViewController) {
        addChildViewController(vc)
        contentViews.append(vc.view)
    }
}


///A title for a tab in the TabScrollView.
class TabTitleView: UIView {
    /// The title of the tab
    var text: String = "text" {
        didSet {
            label.text = text
            label.sizeToFit() // resize the label to the size of its content
            self.frame.size = CGSize(width: label.frame.size.width+20, height: self.frame.size.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var alpha: CGFloat {
        didSet {
            if alpha == 1 {
                chageColor(color: Constants.ControlsColor)
            } else {
                chageColor(color: UIColor.white)
            }
        }
    }
    /// The label containing the title of the tab
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.thin)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        return lbl
    }()
    
    private func chageColor(color: UIColor) {
        UIView.transition(with: self.label, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.label.textColor = color
        }, completion: nil)
    }
}


struct MockupData {
    static let title = "Mockup title of a mockup header"
    static let description = "That's a mockup description for a mockup header"
    static let subpagesContent = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus lectus quis lectus accumsan rhoncus. Nam fermentum nec neque eu rutrum. Aenean vehicula ut erat id scelerisque. Mauris molestie egestas dolor, eget sodales ipsum accumsan ac. Nullam sit amet rutrum massa. Nam quis euismod justo. Nulla elementum, mi sed tempus vulputate, diam lorem hendrerit mauris, vel elementum sem dui eu purus. Fusce lectus enim, tempor id mollis sit amet, sodales sed arcu. Nunc vehicula rhoncus metus in facilisis. Nulla malesuada dui eget ante tempor sagittis. In nisi risus, fringilla sit amet vestibulum eu, euismod at enim. Fusce blandit lectus lacus, eu volutpat magna egestas et. Vestibulum finibus, purus eget eleifend pretium, lacus ipsum vehicula tortor, a porta massa dolor ut leo. Vivamus sit amet augue sed nisi placerat tincidunt tincidunt ac orci.\n\nPraesent faucibus dictum quam eu interdum. Suspendisse non purus at est efficitur porttitor sed posuere tellus. Nam interdum non ante eu molestie. Nunc at commodo dui. Etiam lorem est, aliquam consequat elementum at, cursus vitae augue. Cras dapibus, velit quis interdum tempus, sapien erat posuere elit, eget sagittis libero sapien in risus. Proin viverra rhoncus finibus. Aenean sollicitudin eget neque non malesuada. Duis sollicitudin metus ac mi placerat dapibus. Vivamus efficitur fringilla turpis, vitae imperdiet libero varius non. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin dapibus semper diam, vitae tincidunt odio elementum sed. Pellentesque tortor enim, pulvinar ac erat nec, facilisis venenatis elit. Pellentesque vel est iaculis, ornare risus in, egestas massa. Proin volutpat imperdiet porta. Fusce ac metus at orci euismod tincidunt in nec ante.\n\nNulla posuere lacinia egestas. Donec at urna vitae sem porta tempor. In tincidunt nisl at lectus posuere, in vehicula lectus egestas. Integer pulvinar lacinia elit, ut efficitur nisi. Duis velit dui, tincidunt at eros tristique, congue porta enim. Etiam aliquet nisl sed nunc auctor hendrerit. In sit amet risus feugiat, egestas neque ac, volutpat nulla.\n\nNulla eget cursus massa, eget malesuada tortor. Suspendisse blandit lorem sit amet ipsum convallis, ut feugiat nisi maximus. Maecenas in nisl nec justo semper efficitur. Phasellus vitae lacinia sem. Proin condimentum ultrices lectus quis sollicitudin. Morbi a tortor arcu. Morbi interdum massa venenatis felis malesuada porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "In id feugiat sem. Integer arcu est, ultrices ut ornare et, sodales nec mi. Quisque nec lacus turpis. Curabitur non ante quis velit placerat gravida ut at magna. Nullam convallis non massa in congue. Etiam libero felis, scelerisque sed sapien sit amet, sodales placerat leo. Donec sit amet arcu sed lorem tincidunt vestibulum.\n\nAliquam a lectus vel neque viverra ultrices sit amet non odio. Morbi efficitur malesuada erat, eu sollicitudin turpis tincidunt ac. Morbi ultricies ante at risus efficitur, quis vestibulum lacus volutpat. Praesent sit amet augue at turpis porta interdum vulputate ac diam. Nam aliquet leo odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum posuere commodo gravida. Maecenas venenatis est ut gravida auctor. Cras at urna semper, convallis diam eget, iaculis purus. Nam nunc libero, porttitor quis scelerisque non, mollis sit amet turpis. Duis tempus turpis quis arcu pulvinar, vitae congue eros auctor.\n\nPraesent pulvinar eleifend justo, ac maximus eros luctus ac. Donec vestibulum dignissim convallis. Donec ornare aliquet nibh. Duis vitae lorem congue, consequat nisl id, rutrum orci. Pellentesque dapibus est ac metus interdum ultrices. Etiam egestas mauris a risus facilisis porta. Maecenas bibendum semper aliquam.\n\nUt laoreet est quis gravida scelerisque. Suspendisse posuere, neque quis euismod vulputate, odio massa porttitor ante, a consequat mi erat eget lorem. Nullam massa eros, suscipit eget augue at, tristique vehicula sapien. Nulla at gravida nulla. Proin rhoncus tincidunt nibh et bibendum. Nullam rutrum tortor sapien, posuere ornare mauris mattis ut. Duis congue in ante sed vestibulum. Cras eu porttitor lacus. Phasellus pharetra lacus vel posuere bibendum. Proin interdum dui vel turpis posuere, non vulputate turpis suscipit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Donec et odio quis ante congue consectetur rutrum sed metus. Cras efficitur ac nisl et vestibulum. In enim urna, lacinia non nulla vitae, imperdiet efficitur tortor. Ut odio lectus, tincidunt sodales nunc nec, mollis ultricies dui. Sed commodo, purus et egestas maximus, tortor mauris sollicitudin ligula, quis lacinia urna erat in orci. Morbi mattis nisi mollis urna posuere lacinia. Suspendisse vulputate sit amet magna vel egestas. Morbi gravida tortor eget malesuada accumsan. Proin sed ultricies quam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse vitae nibh vehicula, accumsan sapien at, porta augue. Nullam consequat tellus quis diam ornare hendrerit. In ut scelerisque velit.","Integer maximus varius ex id facilisis. Maecenas et lacus tellus. Sed urna neque, euismod et luctus ac, sodales facilisis turpis. Integer vitae tristique mi, vitae convallis nisi. Morbi tellus tellus, tempor mattis augue at, convallis volutpat tortor. Maecenas sapien dolor, accumsan vel lectus a, tempor facilisis lorem. Duis auctor ligula quis tristique ornare. Etiam consequat fermentum urna, id aliquam ligula hendrerit at. Vivamus ut eros luctus, cursus massa ut, auctor dolor. Proin aliquam nisl urna, eu consequat felis consectetur et. Sed a turpis placerat, tempor risus ut, vehicula eros. Praesent pharetra, mauris id auctor tincidunt, magna elit volutpat risus, sed pellentesque erat purus et tortor. Sed luctus risus sodales enim suscipit, at iaculis arcu molestie. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam molestie augue in est placerat porttitor. Sed vitae libero tempus enim pretium sollicitudin vel vel eros.\n\nInteger eget turpis vitae neque pellentesque suscipit varius sed magna. Suspendisse vel dapibus nisi. Phasellus vel turpis ut tellus congue convallis. Fusce dignissim efficitur pellentesque. Curabitur eget leo et purus dapibus molestie. Ut lorem enim, tempor eget tincidunt ut, tempor a eros. Ut risus mi, consectetur et leo non, congue aliquet est. In mi velit, iaculis nec turpis id, luctus fermentum massa. Vestibulum volutpat augue sit amet nulla elementum, sit amet aliquet sapien facilisis. Suspendisse egestas erat eget eleifend tristique. Suspendisse non tempus tellus. Quisque vitae justo at leo cursus tristique vel id lectus. Fusce ac fringilla leo, vitae convallis nulla. Nunc auctor mockup arcu et molestie. Aenean ut enim mauris.\n\nSed sollicitudin maximus ex, sit amet ultrices lacus mattis sed. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla vel sapien pretium, mollis odio vitae, posuere neque. Duis a nulla velit. Quisque nec metus sed nisi luctus pulvinar eu vitae nunc. Sed tincidunt auctor tellus, tristique sollicitudin libero lobortis eget. Integer sollicitudin quam vel mauris luctus, nec efficitur ex condimentum. Donec tristique ac neque nec posuere. Phasellus dui est, tempor id vulputate in, euismod id libero. Donec ut efficitur quam, vitae eleifend metus. Praesent vulputate eros libero, id posuere ipsum suscipit sed. Fusce ut est non sapien aliquet ultrices in sit amet eros. Curabitur fermentum sapien vel fringilla pretium. Ut hendrerit pellentesque metus id rutrum.\n\nNunc nec lacinia velit. Nam id dolor maximus, congue dolor ut, sagittis quam. Vestibulum suscipit libero non nulla tincidunt bibendum. Nunc lorem urna, faucibus eget blandit non, condimentum eget felis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam non justo ante. Duis metus augue, accumsan imperdiet ligula sed, varius mattis purus.\n\nNunc lacinia libero nec dui faucibus, id eleifend massa feugiat. Fusce non iaculis libero, vel pretium ligula. Nullam non nulla sed urna imperdiet semper. Donec vel lorem quis lorem hendrerit posuere in vitae massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam hendrerit eu elit ac lobortis. Suspendisse diam sem, bibendum sed pellentesque eget, luctus sed metus. Aliquam ac semper enim. Fusce pretium sem ac tincidunt facilisis. Nam tincidunt magna sit amet luctus laoreet.\n\nNunc quis vestibulum ex, id egestas arcu. Phasellus vitae est a sapien egestas dapibus. Phasellus sed lectus arcu. Proin quam nulla, consectetur et mattis non, suscipit in urna. Curabitur non commodo eros. Sed rhoncus, diam sit amet laoreet efficitur, nisl ligula viverra erat, ut vehicula mauris quam non orci. Nullam nec aliquet erat, ac hendrerit erat. Suspendisse potenti. Aenean molestie dolor eu bibendum semper. Vestibulum ut purus ultrices, elementum sem sit amet, luctus nisi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque rutrum eros at ante pulvinar lacinia. Quisque vitae condimentum augue. Etiam viverra, arcu mollis vulputate pulvinar, erat nibh accumsan elit, non facilisis sapien purus vitae ligula. Pellentesque lacinia turpis a metus mollis maximus."]
    static let subpagesTitles = ["Spaghetti", "Guacamole", "Pizzaaa!", "IMayBeHungry"]
}



