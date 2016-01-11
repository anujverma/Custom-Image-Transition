//
//  ViewController.swift
//  Custom Image Transition
//
//  Created by Anuj Verma on 1/6/16.
//  Copyright © 2016 Anuj Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool = true
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainCalendarImage: UIImageView!
    @IBOutlet weak var eventImage: UIImageView!
    
    var movingImageView: UIImageView!
    var originalSelectedImagePosition: CGRect!
    var endFrame: CGRect!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = mainCalendarImage.image!.size
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        
        var imageView = sender.view as! UIImageView
        eventImage = imageView
        
        originalSelectedImagePosition = eventImage.frame
        
        performSegueWithIdentifier("showDetail", sender: self)
        print("Image tapped")
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var destinationVC = segue.destinationViewController as! DetailViewController
//        destinationVC.imageDVC = eventImage.image
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationVC = segue.destinationViewController as! DetailViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
        destinationVC.imageDVC = eventImage.image
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        print("animating transition")
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        
        movingImageView = UIImageView(frame: eventImage.frame)
        movingImageView.image = eventImage.image
        movingImageView.contentMode = eventImage.contentMode
        movingImageView.clipsToBounds = eventImage.clipsToBounds
        
        let window = UIApplication.sharedApplication().keyWindow!
        window.addSubview(movingImageView)
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            let detailVC = toViewController as! DetailViewController
            let finalImageView = detailVC.headerImage
            let height = detailVC.headerImage.frame.height
            let width = detailVC.headerImage.frame.width
            endFrame = CGRect(x: 0, y: 0, width: width, height: height)
            
            let startFrame = containerView.convertRect(eventImage.frame, fromView: scrollView)
            movingImageView.frame = startFrame
            
            
//            finalImageView.hidden = true
            finalImageView.contentMode = .ScaleAspectFit
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                self.movingImageView.frame = self.endFrame

                UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
                    toViewController.view.alpha = 1
                    }, completion: nil)

                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                        self.movingImageView.removeFromSuperview()
//                        finalImageView.hidden = false
                    
            }
        } else {
            
            let detailVC = fromViewController as! DetailViewController
            let finalImageView = detailVC.headerImage
            
            movingImageView.frame = self.endFrame
            let startFrame = containerView.convertRect(eventImage.frame, fromView: scrollView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                self.movingImageView.frame = startFrame


                }) { (finished: Bool) -> Void in
                    self.movingImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                    
            }
        }
    }
    
}



