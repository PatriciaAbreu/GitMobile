//
//  RepositorioManager.swift
//  GitMobile
//
//  Created by Mariana Medeiro on 30/04/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class RepositorioManager {
    
    static let sharedInstance: RepositorioManager = RepositorioManager()
    static let entityName: String = "Repositorio"
    
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func novoRepositorio() ->Repositorio
    {
        
        return NSEntityDescription.insertNewObjectForEntityForName(RepositorioManager.entityName, inManagedObjectContext: managedContext) as! Repositorio
    }
    
    func salvarRepositorio() {
        
        var erro: NSError?
        managedContext.save(&erro)
        
        if let e = erro {
            println("Não foi possível salvar esse repositório. Erro: \(erro), \(erro!.userInfo)")
        }
    }
    
    func buscarRepositorio() ->Array<Repositorio> {
        
        let buscaRequest = NSFetchRequest(entityName: RepositorioManager.entityName)
        var erro: NSError?
        let buscaResultados = managedContext.executeFetchRequest(buscaRequest, error: &erro) as? [NSManagedObject]
        if let resultados = buscaResultados as? [Repositorio] {
            return resultados
        } else {
            println("Não foi possível buscar esse repositório. Erro: \(erro), \(erro!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return Array<Repositorio>()
    }
    
}
