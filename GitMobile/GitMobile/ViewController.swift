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
    
    @IBAction func entradaUsuario(sender: AnyObject) {
        
        if userTextField.text == "" {
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(userTextField.center.x - 10, userTextField.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(userTextField.center.x + 10, userTextField.center.y))
            userTextField.layer.addAnimation(animation, forKey: "position")
        }
        
        if NSUserDefaults().objectForKey("usuario") == nil{
            NSUserDefaults().setObject(userTextField.text, forKey: "usuario")
        }else{
            if ((NSUserDefaults().objectForKey("usuario")?.isEqual(userTextField.text)) != nil){
                
                NSUserDefaults().setObject(userTextField.text, forKey: "usuario")
                
                if RepositorioManager.sharedInstance.buscarRepositorio().count == 0{
                    git.buscarRepositorio(NSUserDefaults().objectForKey("usuario") as! String)
                }else{
//                    self.navigationController?.pushViewController(RepositoriosTableViewController(), animated: true)
                    var nextView:UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
                    self.presentViewController(nextView, animated: true, completion: { () -> Void in})
                }
            }else {
                NSUserDefaults().setObject(userTextField.text, forKey: "usuario")
                git.buscarRepositorio(NSUserDefaults().objectForKey("usuario") as! String)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

