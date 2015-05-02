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

    @IBAction func btnLogout(sender: AnyObject) {
        
        NSUserDefaults().setObject(nil, forKey: "usuario")
        RepositorioManager.sharedInstance.removerTodos()
        
        var viewLogin:UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("loginViewController") as! UIViewController
        self.presentViewController(viewLogin, animated: true, completion: { () -> Void in})
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outraView = self.storyboard!.instantiateViewControllerWithIdentifier("labelsViewController") as!UIViewController
        notificacao.addObserver(outraView, selector: "inserirRepositorio:", name: "novoRepositorio", object: nil)
        
        self.view.backgroundColor = UIColor(red: 110/255, green: 135/255, blue: 151/255, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        self.navigationController?.title = NSUserDefaults().objectForKey("usuario") as? String

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
