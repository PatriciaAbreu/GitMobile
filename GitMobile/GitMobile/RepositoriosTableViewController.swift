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
    var carregamentoView:UIViewController!
    
    lazy var repositorios:Array<Repositorio> = {
        return RepositorioManager.sharedInstance.buscarRepositorio()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        outraView = self.storyboard!.instantiateViewControllerWithIdentifier("labelsViewController") as!UIViewController
//        
//        notificacao.addObserver(outraView, selector: "inserirRepositorio:", name: "novoRepositorio", object: nil)
        
        self.view.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
       
    }
    
    override func viewWillAppear(animated: Bool) {
        outraView = self.storyboard!.instantiateViewControllerWithIdentifier("labelsViewController") as!UIViewController
        
        notificacao.addObserver(outraView, selector: "inserirRepositorio:", name: "novoRepositorio", object: nil)

        self.tableView.reloadData()
        
    }
    @IBAction func logout(sender: AnyObject) {
        NSUserDefaults().setObject(nil, forKey: "usuario")
        RepositorioManager.sharedInstance.removerTodos()
        
        var viewLogin:UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("loginViewController") as! UIViewController
        self.presentViewController(viewLogin, animated: true, completion: { () -> Void in})

        
    }
    @IBAction func refresh(sender: AnyObject) {
        carregamentoView = self.storyboard?.instantiateViewControllerWithIdentifier("carregamento") as! UIViewController
        self.presentViewController(carregamentoView, animated: true, completion: nil)
        RepositorioManager.sharedInstance.removerTodos()
        RepositorioManager.sharedInstance.buscarRepositorio()
        let busca : Int = self.git.buscarRepositorio(NSUserDefaults().objectForKey("usuario") as! String)
        
        
        
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
}
