//
//  LabelsTableViewController.swift
//  GitMobile
//
//  Created by Mariana Medeiro on 28/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit

class LabelsTableViewController: UITableViewController, UITableViewDataSource {
    
    let notificacao: NSNotificationCenter = NSNotificationCenter.defaultCenter()
    var row:Int!
    var labels: Array<String>!
    
    lazy var repositorios:Array<Repositorio> = {
        return RepositorioManager.sharedInstance.buscarRepositorio()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var repositorio:Repositorio = repositorios[self.row]
        labels = repositorio.labels.componentsSeparatedByString(",")
        
        self.view.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
        
    }
    
  
    
    func inserirRepositorio(mensagem: NSNotification){
        let info = mensagem.userInfo as! Dictionary<String, AnyObject>
        
        let msg: AnyObject? = info ["mensagem"]
        
        row = msg as! Int
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! UITableViewCell

        cell.textLabel?.text = labels[indexPath.row]
        
        cell.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
        

        return cell
    }
}
