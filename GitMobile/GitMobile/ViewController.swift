//
//  ViewController.swift
//  GitMobile
//
//  Created by Patricia de Abreu on 27/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var git: GitManager = GitManager()
    let animation = CABasicAnimation(keyPath: "position")
    
    
    @IBOutlet weak var userTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            userTextField.placeholder = "Digite o nome de Usuário do Git..."
    }
    
    override func viewWillAppear(animated: Bool) {
            }
    
    @IBAction func entradaUsuario(sender: AnyObject) {
        
        if userTextField.text == "" {
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(userTextField.center.x - 10, userTextField.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(userTextField.center.x + 10, userTextField.center.y))
            userTextField.layer.addAnimation(animation, forKey: "position")
        }
        else{
            
            var valida = git.buscarRepositorio(userTextField.text)
            
            if valida == -1{
                
                let alerta: UIAlertController = UIAlertController(title: "Usuário não encontrado", message: "Digite seu usuário novamente", preferredStyle: .ActionSheet)
                
                let acao: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { action -> Void in
                    
                })
                
                alerta.addAction(acao)
                
                self.presentViewController(alerta, animated: true, completion: nil)
            }
            else{
                
                NSUserDefaults().setObject(userTextField.text, forKey: "usuario")
                
                var nextView:UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
                self.presentViewController(nextView, animated: true, completion: { () -> Void in})
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

