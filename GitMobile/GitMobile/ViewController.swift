//
//  ViewController.swift
//  GitMobile
//
//  Created by Patricia de Abreu on 27/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    var git: GitManager = GitManager()
    let animation = CABasicAnimation(keyPath: "position")
    var nextView:UIViewController!
    var carregamentoView:UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.becomeFirstResponder()
        userTextField.placeholder = "                    Insert your GitUser here..."
        lblWelcome.text = "Welcome to GitMobile!"
        
        nextView = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
        var usuario = NSUserDefaults().objectForKey("usuario") as? String
        if usuario !=  nil && usuario != ""{
            // preenche textField com o nome do usuario
            // chama metodo do botao de logar
            self.presentViewController(nextView, animated: true, completion: nil)
            return;
        }
        
        
        UIImageView.animateWithDuration(2.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.img.center = CGPointMake(0, 0)
        }, completion: nil)
        
        
        UILabel.animateWithDuration(2.0, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.lblWelcome.center = CGPointMake(0, 50)
        }, completion: nil)
        
        UITextField.animateWithDuration(2.0, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.userTextField.center = CGPointMake(0, 50)
        }, completion: nil)
        
        
        UIButton.animateWithDuration(2.0, delay: 1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.btnLogin.center = CGPointMake(0, 50)
        }, completion: nil)
        

    }
    
    @IBAction func entradaUsuario(sender: AnyObject) {
        if userTextField.text == "" {
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(userTextField.center.x - 10, userTextField.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(userTextField.center.x + 10, userTextField.center.y))
            userTextField.layer.addAnimation(animation, forKey: "position")
        }else{
            NSUserDefaults().setObject(userTextField.text, forKey: "usuario")
            nextView = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
            carregamentoView = self.storyboard!.instantiateViewControllerWithIdentifier("carregamento") as! UIViewController
            self.presentViewController(self.carregamentoView, animated: true, completion: nil)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            atualizar()
            
        }
    }
    
    func atualizar(){

        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            
            RepositorioManager.sharedInstance.removerTodos()
            RepositorioManager.sharedInstance.buscarRepositorio()
            
            let busca : Int = self.git.buscarRepositorio(NSUserDefaults().objectForKey("usuario") as! String)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                // Verifica se existe usuario gravado localmente, se nao existe solicita os dados
                if busca == -1 {
                    
                    
                    let alerta: UIAlertController = UIAlertController(title: "Usuário não encontrado", message: "Digite seu usuário novamente", preferredStyle: .Alert)
                    
                    
                    let acao: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { action -> Void in })
                    
                    alerta.addAction(acao)
                    
                    self.presentViewController(alerta, animated: true, completion: nil)

                    self.view.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
                    self.img.hidden = false
                    self.userTextField.hidden = false
                    self.btnLogin.hidden = false
                    self.lblWelcome.hidden = false
                    
                    return;
                }
                else{
                    
                    self.presentViewController(self.nextView, animated: true, completion: nil)
                }
                
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                
            })
        })

    }
    
//    Em qualquer lugar que tocar na tela "some" com o teclado
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

