# ALSideMenuPresentationController
This controller slides out from the side. 
# Installation
### Carthage
Carthage is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with Homebrew using the following command:

```
$ brew update
$ brew install carthage
```
To integrate Alamofire into your Xcode project using Carthage, specify it in your Cartfile:
```
github "alexlivenson/ALExtensions" ~> 1.0
```
Run carthage update to build the framework and drag the built ALExtensions.framework into your Xcode project.

## How to use
```swift
import ALSideMenuPresentationController
...
extension SomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ALSideMenuPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ALSideMenuTransitionAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ALSideMenuTransitionAnimator(isPresenting: false)
    }
}
```

## TODO: Add gif and setup with cocoapods
