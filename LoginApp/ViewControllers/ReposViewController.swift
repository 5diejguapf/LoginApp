//
//  ReposViewController.swift
//  LoginApp
//
//  Created by serg on 7.01.2023.
//

import UIKit

class ReposViewController: UIViewController {
    
    var repos: [Repo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var labels: [UILabel] = []
        for view in self.view.subviews {
            guard let stackView = view as? UIStackView else { continue }
            for childView in stackView.subviews {
                guard let label = childView as? UILabel else { continue }
                label.text = ""
                label.font = .systemFont(ofSize: 12)
                labels.append(label)
            }
        }
        for (label, repo) in zip(labels, repos) {
            label.text = repo.url
        }
    }
}
