//
//  CustomSegue.swift
//  LoginApp
//
//  Created by serg on 4.01.2023.
//

import UIKit


class CustomSegue: UIStoryboardSegue {
    override func perform() {

        let src = self.source
        let dst = self.destination
        src.navigationController?.pushViewController(dst, animated: true)
    }
}
