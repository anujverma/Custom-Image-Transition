//
//  ViewController.swift
//  Custom Image Transition
//
//  Created by Anuj Verma on 1/6/16.
//  Copyright © 2016 Anuj Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainCalendarImage: UIImageView!
    @IBOutlet weak var eventImage: UIImageView!
    
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
        performSegueWithIdentifier("showDetail", sender: self)
        print("Image tapped")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! DetailViewController
        destinationVC.imageDVC = eventImage.image
    }
}

