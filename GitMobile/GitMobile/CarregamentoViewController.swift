//
//  CarregamentoViewController.swift
//  GitMobile
//
//  Created by Vivian Chiodo Dias on 04/05/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit

class CarregamentoViewController: UIViewController {
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var nextView:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextView = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as! UIViewController
        activityIndicator.hidden = true
        status.text = "Aguardando..."
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.activityIndicator.hidden = false
                self.activityIndicator.startAnimating()
                self.activityIndicator.hidesWhenStopped = true
                self.status.text = "Fazendo login..."
            })
            //Acao de login
            sleep(4)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.status.text = "Usuario logado\nCarregando dados..."
            })
            
            //Acao de carregar os dados
            sleep(3)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.status.text = "Dados carregandos... preparando aplicação"
            })
            
            //prepara os dados para a proxima tela
            // chama a proxima tela
            println("FIM da Thread")
            self.presentViewController(self.nextView, animated: true, completion: nil)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.activityIndicator.stopAnimating()
                
            })
            
        })
        println("Fim do ViewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
