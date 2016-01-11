//
//  DetailViewController.swift
//  Custom Image Transition
//
//  Created by Anuj Verma on 1/6/16.
//  Copyright © 2016 Anuj Verma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    var imageDVC: UIImage!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        headerImage.image = imageDVC
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func dismissPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
