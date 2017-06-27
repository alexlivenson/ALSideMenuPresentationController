//
//  ALSideMenuTransitionAnimator.swift
//  ALSideMenuPresentationController
//
//  Created by alex livenson on 6/27/17.
//  Copyright © 2017 alex livenson. All rights reserved.
//

import UIKit

class ALSideMenuTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    private let duration = 0.3
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentationTransition(using: transitionContext)
        } else {
            animatePresentationTransition(using: transitionContext)
        }
    }
    
    private func animatePresentationTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            print("Unable to retrieve presenting view controller")
            return
        }
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        toVC.view.frame = finalFrame.offsetBy(dx: -bounds.width, dy: 0)
        containerView.addSubview(toVC.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: { 
                toVC.view.frame = finalFrame
            },
            completion: { finished in
                transitionContext.completeTransition(finished)
            })
    }
    
    private func animateDismissalTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            print("Unable to retrieve presenter view controller")
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseOut,
            animations: {
                fromVC.view.frame.origin.x = -containerView.frame.width
            },
            completion: { finished in
                transitionContext.completeTransition(finished)
            })
    }
}
