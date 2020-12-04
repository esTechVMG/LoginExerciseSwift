//
//  SuccessLoginController.swift
//  LoginExerciseSwift
//
//  Created by esTechVMG on 28/11/20.
//

import UIKit
class SuccessLoginController : UIViewController{
    @IBOutlet weak var welcomeLabel: UILabel!
    var welcomeTxt:String?
    override func viewDidLoad() {
        welcomeLabel.text = welcomeTxt ?? "Welcome User"
    }
}
