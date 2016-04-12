//
//  LoginViewController.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/11/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

	@IBOutlet weak var txtLogin: UITextField!

	@IBOutlet weak var txtPassword: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func butLogin(sender: AnyObject) {

		PFUser.logInWithUsernameInBackground(self.txtLogin.text!, password: self.txtPassword.text!) { (user, error) in

			if error == nil {
				self.performSegueWithIdentifier("login", sender: nil)
			} else {
				print(error)
			}
		}
	}

	@IBAction func butCreateAccount(sender: AnyObject) {

		let user = PFUser()
		user.username = self.txtLogin.text
		user.email = self.txtLogin.text
		user.password = self.txtPassword.text
		user.signUpInBackgroundWithBlock { (didSignup, error) in

			if error == nil {
				self.performSegueWithIdentifier("login", sender: nil)
			} else {
				print(error)
			}
		}
	}
	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
}
