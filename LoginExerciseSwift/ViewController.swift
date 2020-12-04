//
//  ViewController.swift
//  LoginExerciseSwift
//
//  Created by esTechVMG on 27/11/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var storyboardTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnPressed(_ sender: Any) {
        if(!(passTxtField.text!.isEmpty &&  userTxtField.text!.isEmpty)){
            let Url = String(format: "https://qastusoft.com.es/apis/login2.php")
            guard let serviceUrl = URL(string: Url) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let bodyData = "user=\(userTxtField.text!)&pass=\(passTxtField.text!)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8);
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            if let code = dictionary["code"] as? Int {
                                var alertMessage:String?
                                switch code {
                                case 1:
                                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                                    DispatchQueue.main.async {
                                        let viewController:SuccessLoginController = storyboard.instantiateViewController(identifier: "LoginSuccesStoryboard")
                                        viewController.self.welcomeTxt = "Welcome \(self.userTxtField.text ?? "")"
                                        self.present(viewController, animated: true, completion: nil)
                                    }
                                    break
                                case -1:
                                    alertMessage="Faltan datos"
                                    break
                                case -2:
                                    alertMessage="Credenciales no válidas"
                                    break
                                case -3:
                                    alertMessage="Ciclo no valido"
                                    break
                                default:
                                    alertMessage="Ha habido un error inesperado. Vuelva a intentarlo mas tarde"
                                }
                                
                                if ((alertMessage?.isEmpty) != nil) {
                                    let alertController = UIAlertController.init(title: "Error", message: alertMessage, preferredStyle: .actionSheet)
                                    let ok = UIAlertAction.init(title: "OK", style: .default, handler:nil)
                                    alertController.addAction(ok)
                                    DispatchQueue.main.async {
                                        self.present(alertController, animated: true, completion:nil)
                                    }
                                        
                                    
                                    
                                }
                                    
                                
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func createAlert(alertMessage:String=""){
        let alertController = UIAlertController.init(title: "", message: alertMessage, preferredStyle: .actionSheet)
        let alertActionDAM = UIAlertAction.init(title: "DAM", style: .default, handler:{_ in
            self.storyboardTitle.text = "OK"
        })
        let alerActionVJ = UIAlertAction.init(title: "VJ", style: .default, handler: {_ in
            self.storyboardTitle.text = "Soy alumno de VJ"
        })
        alertController.addAction(alertActionDAM)
        alertController.addAction(alerActionVJ)
        self.present(alertController, animated: true, completion:nil)
    }
    
}



