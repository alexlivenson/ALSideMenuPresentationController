# ALSideMenuPresentationController
This controller slides out from the side. 

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
