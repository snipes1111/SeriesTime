//
//  Animation Transition.swift
//  SerialTime
//
//  Created by user on 11/01/2023.
//

import Foundation
import UIKit

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    //    private var operation = UINavigationController.Operation.push
    
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? ViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? DetailViewController
        else {
            transitionContext.completeTransition(false)
            return
        }
        animateTransition(from: fromViewController, to: toViewController, with: transitionContext)
    }
}

extension TransitionManager: UINavigationControllerDelegate {
    
}

private extension TransitionManager {
    
    func animateTransition(from fromViewController: UIViewController, to toViewController: UIViewController, with context: UIViewControllerContextTransitioning) {
        //        switch operation {
        //        case .push:
        guard
            let seriesViewController = fromViewController as? ViewController,
            let detailSeriesViewController = toViewController as? DetailViewController
        else { return }
        
        presentViewController(detailSeriesViewController, from: seriesViewController, with: context)
        
        //        case .pop:
        //            guard
        //                let seriesViewController = toViewController as? ViewController,
        //                let detailSeriesViewController = fromViewController as? DetailViewController
        //            else { return }
        //
        //            dissmissViewController(detailSeriesViewController, to: seriesViewController)
        //
        //        default:
        //            break
        //        }
    }
    
    func presentViewController(_ toViewController: DetailViewController, from fromViewController: ViewController, with context: UIViewControllerContextTransitioning) {
        guard
            let seriesCell = fromViewController.selectedCell
        else { return }
        let seriesImageView = seriesCell.imageView
        let seriesDetailImage = toViewController.imageView
        
        toViewController.view.layoutIfNeeded()
        
        let containerView = context.containerView
        
        let snapShotContentView = UIView()
        
        snapShotContentView.backgroundColor = UIColor.detailVcBackgroundColor
        snapShotContentView.frame = containerView.convert(seriesCell.contentView.frame, from: seriesCell)
        snapShotContentView.layer.cornerRadius = seriesCell.contentView.layer.cornerRadius
        
        let snapShotSeriesView = UIView.roundAndShadowView()
        snapShotSeriesView.frame = containerView.convert(seriesImageView.frame, from: seriesCell)
        
        let snapShotSeriesImageView = UIImageView()
        snapShotSeriesImageView.clipsToBounds = true
        snapShotSeriesImageView.layer.cornerRadius = seriesImageView.layer.cornerRadius
        snapShotSeriesImageView.contentMode = seriesImageView.contentMode
        snapShotSeriesImageView.image = seriesImageView.image
        snapShotSeriesImageView.frame = containerView.convert(seriesImageView.frame, from: seriesCell)
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapShotContentView)
        containerView.addSubview(snapShotSeriesView)
        containerView.addSubview(snapShotSeriesImageView)
        
        toViewController.view.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            snapShotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
            snapShotSeriesView.frame = containerView.convert(seriesDetailImage.frame, from: seriesDetailImage)
            snapShotSeriesImageView.frame = containerView.convert(seriesDetailImage.frame, from: seriesDetailImage)
        }
        
        animator.addCompletion { position in
            toViewController.view.isHidden = false
            snapShotSeriesImageView.removeFromSuperview()
            snapShotContentView.removeFromSuperview()
            snapShotSeriesView.removeFromSuperview()
            context.completeTransition(position == .end)
        }
        
        animator.startAnimation()
    }
    
    //    func dissmissViewController(_ fromViewController: DetailViewController, to toViewController: ViewController) {
    //
    //    }
}


