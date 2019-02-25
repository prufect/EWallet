//
//  PopAnimator.swift
//  KoreBank
//
//  Created by Prudhvi Gadiraju on 2/24/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.18
    var presenting = true
    var originalSize = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
  

        //toView.alpha = 0
        if presenting {
            containerView.addSubview(toView)
            containerView.bringSubviewToFront(toView)
            
            toView.transform = CGAffineTransform.init(scaleX: originalSize.width/containerView.frame.width, y: originalSize.height/containerView.frame.height)
            toView.center = CGPoint(x: originalSize.midX, y: originalSize.midY)
        } else {
            containerView.addSubview(toView)
            containerView.sendSubviewToBack(toView)
            fromView.layer.cornerRadius = 14
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            if self.presenting {
                toView.transform = CGAffineTransform.identity
                toView.center = CGPoint(x: containerView.center.x, y: containerView.center.y)
            } else {
                fromView.transform = CGAffineTransform.init(scaleX: self.originalSize.width/containerView.frame.width, y: self.originalSize.height/containerView.frame.height)
                fromView.center = CGPoint(x: self.originalSize.midX, y: self.originalSize.midY)
            }
            //toView.alpha = 1
        }) { (true) in
            transitionContext.completeTransition(true)
        }
    }
}
