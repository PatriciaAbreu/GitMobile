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
    var nextView:UIViewController!
    
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
                nextView = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
//------------------ INICIO DA VIEW DE ESPERA
//                var alertView: UIAlertView = UIAlertView(title: "Carregando...", message: nil, delegate: nil, cancelButtonTitle: nil)
//                var activityIndicator: UIActivityIndicatorView! = UIActivityIndicatorView(frame: CGRectMake(50, 0, 35, 35)) as UIActivityIndicatorView
//                activityIndicator.center = self.view.center
//                activityIndicator.hidesWhenStopped = true
//                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//                activityIndicator.startAnimating()
//                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//                
//                alertView.setValue(activityIndicator, forKey: "accessoryView")
//                activityIndicator.startAnimating()
//                
//                alertView.show()
//                
//                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//                dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
//                    dispatch_async(dispatch_get_main_queue(), {
//                        RepositorioManager.sharedInstance.removerTodos()
//                        RepositorioManager.sharedInstance.buscarRepositorio()
//                        dispatch_async(dispatch_get_main_queue(), {
//             //               self.nextView.tableView.reloadData() ---- dar uma jeito para pegar a tableView
//                            alertView.title = "Finalizado"
//                            activityIndicator.stopAnimating()
//                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//                        })
//                        sleep(1)
//                        dispatch_async(dispatch_get_main_queue(), {
//                            alertView.dismissWithClickedButtonIndex(-1, animated: true)
//                        })
//
//                    })
//                    
//                })
//------------------- FIM CODIGO DA VIEW DE ESPERA
                
                NSUserDefaults().setObject(userTextField.text, forKey: "usuario")
                self.presentViewController(nextView, animated: true, completion: { () -> Void in})
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

