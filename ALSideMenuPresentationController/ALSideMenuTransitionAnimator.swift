//
//  ALSideMenuTransitionAnimator.swift
//  ALSideMenuPresentationController
//
//  Created by alex livenson on 6/27/17.
//  Copyright © 2017 alex livenson. All rights reserved.
//

import UIKit

open class ALSideMenuTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    private let duration: TimeInterval
    
    public init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        self.duration = isPresenting ? 0.2 : 0.15
        super.init()
    }
    
    public init(isPresenting: Bool, duration: TimeInterval) {
        self.isPresenting = isPresenting
        self.duration = duration
        super.init()
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentationTransition(using: transitionContext)
        } else {
            animateDismissalTransition(using: transitionContext)
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
            options: .curveEaseOut,
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
