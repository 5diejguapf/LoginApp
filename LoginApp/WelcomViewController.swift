//
//  WelcomViewController.swift
//  LoginApp
//
//  Created by serg on 4.01.2023.
//

import UIKit


final class WelcomeViewController: UIViewController {
    var username: String?
    
    @IBOutlet var welcomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let uname = username, !uname.isEmpty else {
            print("unautorised access!!!")
            return
        }
        
        welcomLabel.text = "Welcome, \(uname)!"
        
    }
    
}
