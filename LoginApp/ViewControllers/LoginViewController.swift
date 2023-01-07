//
//  ViewController.swift
//  LoginApp
//
//  Created by serg on 3.01.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    private let user = User.getUser()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarController = segue.destination as? UITabBarController else { return }
        guard let tabBarRootChilds = tabBarController.viewControllers else { return }
        
        for view in tabBarRootChilds {
            if let welcomeVC = view as? WelcomeViewController {
                welcomeVC.username = user.userLogin
            } else if let infoView = view as? InfoViewController {
                infoView.userInfo = user.userInfo
            } else if let repoView = view as? ReposViewController {
                repoView.repos = user.userRepos
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        loginTF.text = ""
        passwordTF.text = ""
    }
    
    @IBAction func loginAction() {
        if !tryLogIn(login: loginTF.text, password: passwordTF.text) {
            showAlert(
                title: "Invalid login or password!",
                message: "Please input correct login and password",
                clearTextField: passwordTF
            )
            return
        }
        performSegue(withIdentifier: "showWelcomeScreen", sender: nil)
    }
    
    @IBAction func forgotLoginAlert() {
        showAlert(title: "Oops!", message: "Your login is \(user.userLogin)")
    }

    @IBAction func forgotPasswordAlert() {
        showAlert(title: "Oops!", message: "Your password is \(user.userPassword)", clearTextField: passwordTF)
    }
    
    private func showAlert(title: String, message: String, clearTextField: UITextField? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            clearTextField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func tryLogIn(login username: String?, password: String?) -> Bool {
        user.userLogin.elementsEqual(username ?? "") && user.userPassword.elementsEqual(password ?? "")
    }
}

