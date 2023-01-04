//
//  ViewController.swift
//  LoginApp
//
//  Created by serg on 3.01.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let username = "USR1"
    private let password = "1234"

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
        welcomeVC.username = loginTF.text
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        loginTF.text = ""
        passwordTF.text = ""
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let username = loginTF.text, !username.isEmpty else {
            print("type login")
            return false
        }
        guard let password = passwordTF.text, !password.isEmpty else {
            print("type password")
            return false
        }
        if !trySingIn(username, password) {
            print("singin is false")
            wrongAuthAlert()
            passwordTF.text = ""
            return false
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super .touchesBegan(touches, with: event)
    }
    
    @IBAction func forgotLoginAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Your login is \(username)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func forgotPasswordAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Your password is \(password)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func trySingIn(_ username: String, _ password: String) -> Bool {
        self.username.elementsEqual(username) && self.password.elementsEqual(password)
    }
    
    private func wrongAuthAlert() {
        let alert = UIAlertController(
            title: "Invalid login or password!", message: "Please input correct login and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}

