//
//  MainViewController.swift
//  forestTrail_Prototype01
//
//  Created by Ratzenböck Jakob on 22.04.21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var Routes: UIButton!
    @IBOutlet weak var Gallery: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func getToGallery(sender: Any?) {
        performSegue(withIdentifier: "getToGallery", sender: self)
    }
    
    func getToRoutes(sender: Any?) {
        performSegue(withIdentifier: "getToRoutes", sender: self)
    }


}
