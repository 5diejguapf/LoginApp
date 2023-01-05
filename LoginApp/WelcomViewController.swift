//
//  WelcomViewController.swift
//  LoginApp
//
//  Created by serg on 4.01.2023.
//

import UIKit


final class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomLabel: UILabel!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomLabel.text = "Welcome, \(username)!"
    }
}
