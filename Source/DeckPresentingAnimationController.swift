//
//  DeckPresentingAnimationController.swift
//  DeckTransition
//
//  Created by Harshil Shah on 15/10/16.
//  Copyright © 2016 Harshil Shah. All rights reserved.
//

import UIKit

final class DeckPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Private variables
    
    private let duration: TimeInterval?
    private let customLargeScreenSize: Bool
    
    // MARK: - Initializers
    
    init(duration: TimeInterval?, customLargeScreenSize: Bool) {
        self.duration = duration
        self.customLargeScreenSize = customLargeScreenSize
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(presentedViewController.view)
        presentedViewController.view.frame = ManualLayout.presentFrame(availableWidth: containerView.bounds.width, height: containerView.bounds.height, y: containerView.bounds.height, customLargeScreenSize: customLargeScreenSize)
        
        let finalFrameForPresentedView = transitionContext.finalFrame(for: presentedViewController)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseOut,
            animations: {
                presentedViewController.view.frame = finalFrameForPresentedView
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration ?? Constants.defaultAnimationDuration
    }
    
}

