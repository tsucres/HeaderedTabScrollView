# HeaderedTabScrollView

<!-- Gifs -->

## Description



Crapy little UIKit control that add a scrollable header on top of an [ACTabScrollView](https://github.com/azurechen/ACTabScrollView). It's more a complete illustration of how to do it than a control to use "as is".


I needed that for [my project] and though it could be useful to other people too since I struggled a bit to make it work right.

The main idea of how this works is inspired by this [stackoverflow question](https://stackoverflow.com/questions/25374090/move-a-view-when-scrolling-in-uitableview).

## Installation

### Pod
Depending on which version (ACTabScrollView or PageMenu) you want to use, add one of the following line to your Podfile: 

`pod 'HeaderedTabScrollView/ACTabScrollView'`

or

`pod 'HeaderedTabScrollView/PageMenu'`

If you don't specify a subspec, the two versions will be installed.

Don't forget to `import HeaderedTabScrollView` wherever you need it.

**Note**: The [last pod release](https://github.com/PageMenu/PageMenu/releases/tag/2.0.0) of PageMenu isn't [the last version available](https://github.com/PageMenu/PageMenu/compare/2.0.0...master) on the github repo and doesn't include a [fix](https://github.com/PageMenu/PageMenu/commit/a6279a0070d79e5d28e8f1e4288ba4cef504402b) for a bug on the first subpage. If you experience this bug, you'll have to change the `CAPSPageMenu+UIConfiguration.swift` file to match [the fix](https://github.com/PageMenu/PageMenu/commit/a6279a0070d79e5d28e8f1e4288ba4cef504402b).

I know it's a bit crappy to do so but it's the easiest solution I can think of :/

### Manually

You'll need: 

- the `AbstractHeaderedTabScrollViewController.swift` file
- according to the version you want, either `HeaderedCAPSPageMenuViewController.swift` or `HeaderedACTabScrollViewController.swift` (or both)
- All the files needed by ACTabScrollView and/or PageMenu (those start respectively by `ACT` and `CAPS`)


Just copy those files in your project and you should be ready to go :)

## Basic Usage

You can use two classes to do the same thing, depending on whether you want to use a [ACTabScrollView](https://github.com/azurechen/ACTabScrollView) or a [PageMenu](https://github.com/PageMenu/PageMenu).


#### \w ACTabScrollView

First of all you have to subclass a `HeaderedACTabScrollViewController`. 

To complete the configuration, you have to set the header view and to configure the ACTabScrollView. The later is accessible throug the property `tabScrollView`.

The whole thing should look something like this: 

```swift

class BasicHeaderedACTabScrollViewController: HeaderedACTabScrollViewController, ACTabScrollViewDelegate,  ACTabScrollViewDataSource {

}
```

For more details and a concrete example, check the [`BasicHeaderedACTabScrollViewController.swift`](HeaderedTabScrollView/BasicHeaderedACTabScrollViewController.swift) file.

#### \w CAPSPageMenu

The process is basically the same as for an ACTabScrollView based controller. In this case you have to subclass a `HeaderedCAPSPageMenuViewController`.

As in the previous case, you have to do 2 things to complete the configuration of the controller: set the header view and configure the `CAPSPageMenu`


For more details and a concrete example, check the [`BasicHeaderedCAPSPageMenuViewController.swift`](HeaderedTabScrollView/BasicHeaderedCAPSPageMenuViewController.swift) file.




 
## Advanced customisation

### TabBar style

Since the ACTabScrollView/PageMenu is accessible through the `tabScrollView` property, you can customise its apparence as you would normally in any other situation. Just check the respective documentations (ACTabscrollView & PageMenu) for more informations.

### More header animations according to the vertical position

By default, there are 3 effects that are implemented: 

- the alpha of the navigation bar (to make it progressivelly appear as the tabScrollView is scrolled up);
- the y position of the header (to create a parallax effect);
- the alpha of the header (to make it disapear as the tabScrollView is scrolled up).

Those This is implemented in the `headerDidScroll` method: 

```swift
public func headerDidScroll(minY: CGFloat, maxY: CGFloat, currentY: CGFloat) {
	updateNavBarAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant)
	updateHeaderPositionAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant)
	updateHeaderAlphaAccordingToScrollPosition(minY: minY, maxY: maxY, currentY: tabTopConstraint!.constant
}
```

If you want to add other effects (that you create) or remove som of theme, just override this method.

## Examples


## Internal structure of the project


# TODO
- Add an effect (zoom, parallax) on the header when the subpage is pulled down.
- Support horizontal orientation
- Adapt for iPhone X (use Safe area)