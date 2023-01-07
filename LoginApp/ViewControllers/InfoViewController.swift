//
//  InfoViewController.swift
//  LoginApp
//
//  Created by serg on 7.01.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var userInfo: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userInfo = userInfo {
            labelInfo.text = userInfo.descripiton
            if let url = URL(string: userInfo.imageUrl) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        self.userImage.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
        }
    }
}
