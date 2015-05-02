//
//  ViewController.swift
//  GitMobile
//
//  Created by Patricia de Abreu on 27/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var git: GitManager = GitManager()
    let animation = CABasicAnimation(keyPath: "position")
    var nextView:UIViewController!
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.becomeFirstResponder()
        userTextField.placeholder = "                    Insert your GitUser here..."
        lblWelcome.text = "Welcome to GitMobile!"
        
//                activityIndicator.hidden = true
        
        //        labelMessage.hidden = true
    }
    
    @IBAction func entradaUsuario(sender: AnyObject) {
        
        //        activityIndicator.hidden = false
        //        labelMessage.hidden = false
        userTextField.hidden = true
        btnLogin.hidden = true
        lblWelcome.hidden = true
        //        activityIndicator.startAnimating()
        //        activityIndicator.hidesWhenStopped = true
        //        labelMessage.text = "Fazendo login..."
        
        if userTextField.text == "" {
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(userTextField.center.x - 10, userTextField.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(userTextField.center.x + 10, userTextField.center.y))
            userTextField.layer.addAnimation(animation, forKey: "position")
        }else{
            
            nextView = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
            
            
            
            var valida = git.buscarRepositorio(userTextField.text)
            if valida == -1{
                let alerta: UIAlertController = UIAlertController(title: "Usuário não encontrado", message: "Digite seu usuário novamente", preferredStyle: .ActionSheet)
                let acao: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { action -> Void in
                    
                    self.userTextField.hidden = false
                    self.btnLogin.hidden = false
                    
                })
                
                alerta.addAction(acao)
                
                self.presentViewController(alerta, animated: true, completion: nil)
                
            }else{
                
                nextView = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
                //
                //------------------ INICIO DA VIEW DE ESPERA
                
                //                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                
                //                dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
                //
                //                    dispatch_async(dispatch_get_main_queue(), {
                //
                //                        //                        self.activityIndicator.hidden = false
                //
                //                        //                        self.labelMessage.hidden = false
                //
                //                        //                        self.userTextField.hidden = true
                //
                //                        //                        self.btnLogin.hidden = true
                //
                //                        //                        self.activityIndicator.startAnimating()
                //
                //                        //                        self.activityIndicator.hidesWhenStopped = true
                //
                //                        //                        self.labelMessage.text = "Fazendo login..."
                //
                //                    })
                
                //Acao de login
                //
                //                    sleep(1)
                //
                //                    dispatch_async(dispatch_get_main_queue(), {
                //
                //                        NSUserDefaults().setObject(self.userTextField.text, forKey: "usuario")
                //
                //                        self.labelMessage.text = "Usuario logado\nCarregando dados..."
                //
                //                    })
                //
                //                    //Acao de carregar os dados
                //
                //                    sleep(2)
                //
                //                    dispatch_async(dispatch_get_main_queue(), {
                
                //                        self.labelMessage.text = "Dados carregandos... preparando aplicação"
                
                //                    })
                
                //prepara os dados para a proxima tela
                
                // chama a proxima tela
                //
                //                    println("FIM da Thread")
                //
                //                    dispatch_async(dispatch_get_main_queue(), {
                //
                //                        self.presentViewController(self.nextView, animated: true, completion: { () -> Void in})
                //
                //                        self.activityIndicator.stopAnimating()
                //
                //                    })
                //
                ////                })
                //
                //                println("Fim do ViewDidLoad")
                //
                //
                //                                var alertView: UIAlertView = UIAlertView(title: "Carregando...", message: nil, delegate: nil, cancelButtonTitle: nil)
                //
                //                                var activityIndicator: UIActivityIndicatorView! = UIActivityIndicatorView(frame: CGRectMake(50, 0, 35, 35)) as UIActivityIndicatorView
                //
                //                                activityIndicator.center = self.view.center
                //
                //                                activityIndicator.hidesWhenStopped = true
                //
                //                                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                //
                //                                activityIndicator.startAnimating()
                //
                //                                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                //
                //
                //
                //                                alertView.setValue(activityIndicator, forKey: "accessoryView")
                //
                //                                activityIndicator.startAnimating()
                //
                //
                //
                //                                alertView.show()
                //
                //
                //
                //                                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                //
                //                                dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
                //
                //                                    dispatch_async(dispatch_get_main_queue(), {
                //
                //                                        RepositorioManager.sharedInstance.removerTodos()
                //
                //                                        RepositorioManager.sharedInstance.buscarRepositorio()
                //
                //                                        dispatch_async(dispatch_get_main_queue(), {
                //
                //                             //               self.nextView.tableView.reloadData() ---- dar uma jeito para pegar a tableView
                //
                //                                            alertView.title = "Finalizado"
                //
                //                                            activityIndicator.stopAnimating()
                //
                //                                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                //
                //                                        })
                //
                //                                        sleep(1)
                //
                //                                        dispatch_async(dispatch_get_main_queue(), {
                //
                //                                            alertView.dismissWithClickedButtonIndex(-1, animated: true)
                //
                //                                        })
                //
                //
                //
                //                                    })
                //
                //
                //
                //                                })
                
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

