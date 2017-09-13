//
//  ALSideMenuPresentationController.swift
//  ALSideMenuPresentationController
//
//  Created by alex livenson on 6/27/17.
//  Copyright © 2017 alex livenson. All rights reserved.
//

import UIKit

open class ALSideMenuPresentationController: UIPresentationController {
    
    private lazy var chromeView: UIView = self.createChromeView()
    
    open var willDismissHandler: (() -> ())?
    open var didDismissHandler: (() -> ())?
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        guard let cv = containerView else {
            print("Container View is nil for presentation")
            return UIScreen.main.bounds
        }
        
        let bounds = cv.bounds
        return CGRect(
            x: 0,
            y: 0,
            width: bounds.width * 0.8,
            height: bounds.height
        )
    }
    
    override open func presentationTransitionWillBegin() {
        guard let cv = containerView else {
            print("Container View is nil for presentation")
            return
        }
        chromeView.frame = cv.bounds
        chromeView.alpha = 0
        cv.insertSubview(chromeView, at: 0)
        presentedViewController
            .transitionCoordinator?
            .animate(
                alongsideTransition: { [unowned self] _ in
                    self.chromeView.alpha = 1
                },
                completion: nil)
    }
    
    override open func dismissalTransitionWillBegin() {
        presentedViewController
            .transitionCoordinator?
            .animate(
                alongsideTransition: { [unowned self] _ in
                    self.chromeView.alpha = 0
                },
                completion: { [unowned self] _ in
                    self.chromeView.removeFromSuperview()
                })
    }
    
    @objc func dismiss() {
        willDismissHandler?()
        presentedViewController.dismiss(animated: true) { [weak self] in
            self?.didDismissHandler?()
        }        
    }
    
    private func createChromeView() -> UIView {
        let view = UIView()
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addGestureRecognizer(tapGest)
        return view
    }
}
