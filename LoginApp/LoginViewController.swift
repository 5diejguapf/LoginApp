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
    
    private let username = "USR1"
    private let password = "1234"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
        welcomeVC.username = loginTF.text!
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
        showAlert(title: "Oops!", message: "Your login is \(username)")
    }

    @IBAction func forgotPasswordAlert() {
        showAlert(title: "Oops!", message: "Your password is \(password)", clearTextField: passwordTF)
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
        self.username.elementsEqual(username ?? "") && self.password.elementsEqual(password ?? "")
    }
}

