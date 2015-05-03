//
//  RepositoriosTableViewController.swift
//  GitMobile
//
//  Created by Mariana Medeiro on 28/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit

class RepositoriosTableViewController: UITableViewController, UITableViewDataSource {
    
    var git:GitManager = GitManager()
    let notificacao:NSNotificationCenter = NSNotificationCenter.defaultCenter()
    var outraView:UIViewController!
    
    lazy var repositorios:Array<Repositorio> = {
        return RepositorioManager.sharedInstance.buscarRepositorio()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        outraView = self.storyboard!.instantiateViewControllerWithIdentifier("labelsViewController") as!UIViewController
        notificacao.addObserver(outraView, selector: "inserirRepositorio:", name: "novoRepositorio", object: nil)
        
        self.view.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
        
        self.valida()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()

    }
    
    func valida(){
        var usuario = NSUserDefaults().objectForKey("usuario") as? String
        if usuario ==  "" || usuario == nil{
            let alerta: UIAlertController = UIAlertController(title: "Usuário invalido", message: "Digite seu usuário novamente", preferredStyle: .ActionSheet)
            let acao: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { action -> Void in
            })
            
            alerta.addAction(acao)
            
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        else{
            var alertView: UIAlertView = UIAlertView(title: "Carregando...", message: nil, delegate: nil, cancelButtonTitle: nil)
            
            var activityIndicator: UIActivityIndicatorView! = UIActivityIndicatorView(frame: CGRectMake(50, 0, 35, 35)) as UIActivityIndicatorView
            
            activityIndicator.center = self.view.center
            
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            
            
            alertView.setValue(activityIndicator, forKey: "accessoryView")
            
            activityIndicator.startAnimating()
            
            
            
            alertView.show()
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            
            dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if self.git.buscarRepositorio(NSUserDefaults().objectForKey("usuario") as! String) == -1{
                        let alerta: UIAlertController = UIAlertController(title: "Usuário não encontrado", message: "Digite seu usuário novamente", preferredStyle: .ActionSheet)
                        let acao: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { action -> Void in
                            
                        })
                        
                        alerta.addAction(acao)
                        
                        self.presentViewController(alerta, animated: true, completion: nil)
 
                    }
                    
                    RepositorioManager.sharedInstance.removerTodos()
                    RepositorioManager.sharedInstance.buscarRepositorio()

                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()

                        alertView.title = "Login feito!"
                        
                        activityIndicator.stopAnimating()
                        
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        
                    })
                    
                    sleep(1)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()

                        alertView.dismissWithClickedButtonIndex(-1, animated: true)
                        
                    })
                    
                    
                    
                })
                
                
                
            })

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println(repositorios.count)
        return repositorios.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let item:Repositorio = repositorios[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("reposCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = item.nomeRepositorio
        cell.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
        
        if item.numero == 0{
            cell.detailTextLabel?.text = "Sem Pull Request"
        }
        else{
            cell.detailTextLabel?.text = "Pull Request \(item.numero)"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = tableView.indexPathForSelectedRow()?.row
        
        var mensagem:NSDictionary = NSDictionary(object: row!, forKey: "mensagem")
        
        notificacao.postNotificationName("novoRepositorio", object: self, userInfo: mensagem as [NSObject: AnyObject])
        
        
        self.navigationController?.pushViewController(outraView, animated: true)
        
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
